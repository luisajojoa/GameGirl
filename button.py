from migen import *
from migen.genlib.cdc import MultiReg
from litex.soc.interconnect.csr import *
from litex.soc.interconnect.csr_eventmanager import *

class button_intr (Module, AutoCSR):
    def __init__(self,signal):
        ##Creando GPIOIn normal	
        self._in = CSRStatus(len(signal))
        self.specials += MultiReg(signal, self._in.status)

		#Agrgando el submodulo para poder interrumpir
        self.submodules.ev= EventManager()
        self.ev.zero = EventSourceProcess()  #Flanco de bajada

        #Agrenado el pending al arreglo de pendings
        self.comb += self.ev.zero.trigger.eq(signal)
