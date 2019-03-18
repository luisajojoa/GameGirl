from migen import *

from migen.genlib.io import CRG
from litex.soc.interconnect.csr import *
from litex.build.generic_platform import *
from litex.build.xilinx import XilinxPlatform

from litex.soc.integration.soc_core import *
from litex.soc.integration.builder import *
from litex.soc.cores import dna
from litex.soc.cores.spi import SPIMaster

from ios import Led
from button import button_intr

#
# platform
#

_io = [

    ("user_led",  0, Pins("H17"), IOStandard("LVCMOS33")),
    ("user_led",  1, Pins("K15"), IOStandard("LVCMOS33")),
    ("user_led",  2, Pins("J13"), IOStandard("LVCMOS33")),
    ("user_led",  3, Pins("N14"), IOStandard("LVCMOS33")),
   # ("user_led",  4, Pins("R18"), IOStandard("LVCMOS33")),
   # ("user_led",  5, Pins("V17"), IOStandard("LVCMOS33")),
   # ("user_led",  6, Pins("U17"), IOStandard("LVCMOS33")),
   # ("user_led",  7, Pins("U16"), IOStandard("LVCMOS33")),
   # ("user_led",  8, Pins("V16"), IOStandard("LVCMOS33")),
   # ("user_led",  9, Pins("T15"), IOStandard("LVCMOS33")),
   # ("user_led", 10, Pins("U14"), IOStandard("LVCMOS33")),
   # ("user_led", 11, Pins("T16"), IOStandard("LVCMOS33")),
   # ("user_led", 12, Pins("V15"), IOStandard("LVCMOS33")),
   # ("user_led", 13, Pins("V14"), IOStandard("LVCMOS33")),
   # ("user_led", 14, Pins("V12"), IOStandard("LVCMOS33")),
   # ("user_led", 15, Pins("V11"), IOStandard("LVCMOS33")),

	("user_btn", 0, Pins("P18"), IOStandard("LVCMOS33")),
	("user_btn", 1, Pins("M18"), IOStandard("LVCMOS33")),
	("user_btn", 2, Pins("P17"), IOStandard("LVCMOS33")),
	("user_btn", 3, Pins("M17"), IOStandard("LVCMOS33")),
	("user_btn", 4, Pins("N17"), IOStandard("LVCMOS33")),


	("clk100", 0, Pins("E3"), IOStandard("LVCMOS33")),

	("cpu_reset", 0, Pins("C12"), IOStandard("LVCMOS33")),

	("serial", 0,
		Subsignal("tx", Pins("D4")),	
		Subsignal("rx", Pins("C4")),
		IOStandard("LVCMOS33")	
	),

	("lcd_spi", 0,
		Subsignal("cs_n", Pins("K1")), #1
		Subsignal("clk", Pins("J2")), #3
		Subsignal("mosi", Pins("J3")), #8
		#        Subsignal("miso", Pins("F18")),
		IOStandard("LVCMOS33")
	),
	("lcd_rs",0,Pins("F6"), IOStandard("LVCMOS33")), #2
	("lcd_rst",0,Pins("E7"), IOStandard("LVCMOS33")), #7

	("GPO", 0, Pins("D14"), IOStandard("LVCMOS33")),#JA1
	("SD_spi", 0,
        Subsignal("clk", Pins("F16")),#JA2
        Subsignal("mosi", Pins("G16")),#JA3
        Subsignal("miso", Pins("H14")),#JA4
        IOStandard("LVCMOS33")
    )
]
"""
QUACHO						NEXYS 4 DDR
SIGNAL	IO	FPGA
SPICLK	05	P35		p78		E18
SDI		06	P33		p34		E17
RS		13	P30		P32		D18
RST		19	P29		P27		D17
CS		26	P26		P24		C17

CPUCLK		P126			E3			
CPURST		P87				C12
TX			P105			D4
RX			P101			C4

		xc6slx9-TQG144-2		xc7a100t-CSG324-1
"""

class Platform(XilinxPlatform):
    default_clk_name = "clk100"
    default_clk_period = 10

    def __init__(self):
        XilinxPlatform.__init__(self, "xc7a100t-CSG324-1", _io, toolchain="ise")

    def do_finalize(self, fragment):
        XilinxPlatform.do_finalize(self, fragment)


def csr_map_update(csr_map, csr_peripherals):
    csr_map.update(dict((n, v)
        for v, n in enumerate(csr_peripherals, start=max(csr_map.values()) + 1)))


#
# design
#

# create our platform (fpga interface)
platform = Platform()

# create our soc (fpga description)
class BaseSoC(SoCCore):
    # Peripherals CSR declaration
	csr_peripherals = [
		"dna",
		"leds",
		"buttons",
		"lcd",
		"SD",
		"GPO",
		"rs"
	]
	csr_map_update(SoCCore.csr_map, csr_peripherals)


    #Declaración de las interrupciones
	interrupt_map= {
		"buttons" : 4,
	}
	
	#Actualización del mapa de interrupciones
	interrupt_map.update(interrupt_map)    

    
	def __init__(self, platform):
		sys_clk_freq = int(100e6)
		# SoC with CPU
		SoCCore.__init__(self, platform,
			cpu_type="lm32",
			clk_freq=100e6,
			csr_data_width=32,
			ident="CPU Test SoC", ident_version=True,
			integrated_rom_size=0x8000,
			integrated_main_ram_size=35*1024)

        # Clock Reset Generation
		self.submodules.crg = CRG(platform.request("clk100"), ~platform.request("cpu_reset"))

		# FPGA identification
		self.submodules.dna = dna.DNA()

		# Led
		user_leds = Cat(*[platform.request("user_led", i) for i in range(4)])
		self.submodules.leds = Led(user_leds)
 
		#RS y RST LCD
		rs= platform.request("lcd_rs")
		self.submodules.rs= Led(rs)
		rst= platform.request("lcd_rst")
		rst=1

        # Buttons
		bttn= Cat(*[platform.request("user_btn",i) for i in range (5)])
		self.submodules.buttons = button_intr(bttn)

		#GPO
		self.submodules.GPO = Led(platform.request("GPO",0))
		#SD
		self.submodules.SD = SPIMaster(platform.request("SD_spi"))

		# LCD
		self.submodules.lcd = SPIMaster(platform.request("lcd_spi"))


soc = BaseSoC(platform)

builder = Builder(soc, output_dir="build", csr_csv="test/csr.csv")
builder.build()
