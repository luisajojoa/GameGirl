/* Machine-generated using LiteX gen */
module top(
	output reg serial_tx,
	input serial_rx,
	input clk100,
	input cpu_reset,
	output lcd_rs,
	input lcd_rst,
	input user_btn0,
	input user_btn1,
	input user_btn2,
	input user_btn3,
	input user_btn4,
	output GPO0,
	inout SD_spi_clk,
	inout SD_spi_mosi,
	input SD_spi_miso,
	inout lcd_spi_cs_n,
	inout lcd_spi_clk,
	inout lcd_spi_mosi
);

wire ctrl_reset_reset_re;
wire ctrl_reset_reset_r;
reg ctrl_reset_reset_w = 1'd0;
reg [31:0] ctrl_storage_full = 32'd305419896;
wire [31:0] ctrl_storage;
reg ctrl_re = 1'd0;
wire [31:0] ctrl_bus_errors_status;
wire ctrl_reset;
wire ctrl_bus_error;
reg [31:0] ctrl_bus_errors = 32'd0;
wire lm32_reset;
wire [29:0] lm32_ibus_adr;
wire [31:0] lm32_ibus_dat_w;
wire [31:0] lm32_ibus_dat_r;
wire [3:0] lm32_ibus_sel;
wire lm32_ibus_cyc;
wire lm32_ibus_stb;
wire lm32_ibus_ack;
wire lm32_ibus_we;
wire [2:0] lm32_ibus_cti;
wire [1:0] lm32_ibus_bte;
wire lm32_ibus_err;
wire [29:0] lm32_dbus_adr;
wire [31:0] lm32_dbus_dat_w;
wire [31:0] lm32_dbus_dat_r;
wire [3:0] lm32_dbus_sel;
wire lm32_dbus_cyc;
wire lm32_dbus_stb;
wire lm32_dbus_ack;
wire lm32_dbus_we;
wire [2:0] lm32_dbus_cti;
wire [1:0] lm32_dbus_bte;
wire lm32_dbus_err;
reg [31:0] lm32_interrupt = 32'd0;
wire [31:0] lm32_i_adr_o;
wire [31:0] lm32_d_adr_o;
wire [29:0] rom_bus_adr;
wire [31:0] rom_bus_dat_w;
wire [31:0] rom_bus_dat_r;
wire [3:0] rom_bus_sel;
wire rom_bus_cyc;
wire rom_bus_stb;
reg rom_bus_ack = 1'd0;
wire rom_bus_we;
wire [2:0] rom_bus_cti;
wire [1:0] rom_bus_bte;
reg rom_bus_err = 1'd0;
wire [12:0] rom_adr;
wire [31:0] rom_dat_r;
wire [29:0] sram_bus_adr0;
wire [31:0] sram_bus_dat_w0;
wire [31:0] sram_bus_dat_r0;
wire [3:0] sram_bus_sel;
wire sram_bus_cyc;
wire sram_bus_stb;
reg sram_bus_ack = 1'd0;
wire sram_bus_we0;
wire [2:0] sram_bus_cti;
wire [1:0] sram_bus_bte;
reg sram_bus_err = 1'd0;
wire [9:0] sram_adr;
wire [31:0] sram_dat_r;
reg [3:0] sram_we = 4'd0;
wire [31:0] sram_dat_w;
wire [29:0] main_ram_bus_adr;
wire [31:0] main_ram_bus_dat_w;
wire [31:0] main_ram_bus_dat_r;
wire [3:0] main_ram_bus_sel;
wire main_ram_bus_cyc;
wire main_ram_bus_stb;
reg main_ram_bus_ack = 1'd0;
wire main_ram_bus_we;
wire [2:0] main_ram_bus_cti;
wire [1:0] main_ram_bus_bte;
reg main_ram_bus_err = 1'd0;
wire [13:0] main_ram_adr;
wire [31:0] main_ram_dat_r;
reg [3:0] main_ram_we = 4'd0;
wire [31:0] main_ram_dat_w;
reg [13:0] interface_adr = 14'd0;
reg interface_we = 1'd0;
reg [31:0] interface_dat_w = 32'd0;
wire [31:0] interface_dat_r;
wire [29:0] bus_wishbone_adr;
wire [31:0] bus_wishbone_dat_w;
reg [31:0] bus_wishbone_dat_r = 32'd0;
wire [3:0] bus_wishbone_sel;
wire bus_wishbone_cyc;
wire bus_wishbone_stb;
reg bus_wishbone_ack = 1'd0;
wire bus_wishbone_we;
wire [2:0] bus_wishbone_cti;
wire [1:0] bus_wishbone_bte;
reg bus_wishbone_err = 1'd0;
reg [1:0] counter = 2'd0;
reg [31:0] uart_phy_storage_full = 32'd4947802;
wire [31:0] uart_phy_storage;
reg uart_phy_re = 1'd0;
wire uart_phy_sink_valid;
reg uart_phy_sink_ready = 1'd0;
wire uart_phy_sink_first;
wire uart_phy_sink_last;
wire [7:0] uart_phy_sink_payload_data;
reg uart_phy_uart_clk_txen = 1'd0;
reg [31:0] uart_phy_phase_accumulator_tx = 32'd0;
reg [7:0] uart_phy_tx_reg = 8'd0;
reg [3:0] uart_phy_tx_bitcount = 4'd0;
reg uart_phy_tx_busy = 1'd0;
reg uart_phy_source_valid = 1'd0;
wire uart_phy_source_ready;
reg uart_phy_source_first = 1'd0;
reg uart_phy_source_last = 1'd0;
reg [7:0] uart_phy_source_payload_data = 8'd0;
reg uart_phy_uart_clk_rxen = 1'd0;
reg [31:0] uart_phy_phase_accumulator_rx = 32'd0;
wire uart_phy_rx;
reg uart_phy_rx_r = 1'd0;
reg [7:0] uart_phy_rx_reg = 8'd0;
reg [3:0] uart_phy_rx_bitcount = 4'd0;
reg uart_phy_rx_busy = 1'd0;
wire uart_rxtx_re;
wire [7:0] uart_rxtx_r;
wire [7:0] uart_rxtx_w;
wire uart_txfull_status;
wire uart_rxempty_status;
wire uart_irq;
wire uart_tx_status;
reg uart_tx_pending = 1'd0;
wire uart_tx_trigger;
reg uart_tx_clear = 1'd0;
reg uart_tx_old_trigger = 1'd0;
wire uart_rx_status;
reg uart_rx_pending = 1'd0;
wire uart_rx_trigger;
reg uart_rx_clear = 1'd0;
reg uart_rx_old_trigger = 1'd0;
wire uart_eventmanager_status_re;
wire [1:0] uart_eventmanager_status_r;
reg [1:0] uart_eventmanager_status_w = 2'd0;
wire uart_eventmanager_pending_re;
wire [1:0] uart_eventmanager_pending_r;
reg [1:0] uart_eventmanager_pending_w = 2'd0;
reg [1:0] uart_eventmanager_storage_full = 2'd0;
wire [1:0] uart_eventmanager_storage;
reg uart_eventmanager_re = 1'd0;
wire uart_tx_fifo_sink_valid;
wire uart_tx_fifo_sink_ready;
reg uart_tx_fifo_sink_first = 1'd0;
reg uart_tx_fifo_sink_last = 1'd0;
wire [7:0] uart_tx_fifo_sink_payload_data;
wire uart_tx_fifo_source_valid;
wire uart_tx_fifo_source_ready;
wire uart_tx_fifo_source_first;
wire uart_tx_fifo_source_last;
wire [7:0] uart_tx_fifo_source_payload_data;
wire uart_tx_fifo_re;
reg uart_tx_fifo_readable = 1'd0;
wire uart_tx_fifo_syncfifo_we;
wire uart_tx_fifo_syncfifo_writable;
wire uart_tx_fifo_syncfifo_re;
wire uart_tx_fifo_syncfifo_readable;
wire [9:0] uart_tx_fifo_syncfifo_din;
wire [9:0] uart_tx_fifo_syncfifo_dout;
reg [4:0] uart_tx_fifo_level0 = 5'd0;
reg uart_tx_fifo_replace = 1'd0;
reg [3:0] uart_tx_fifo_produce = 4'd0;
reg [3:0] uart_tx_fifo_consume = 4'd0;
reg [3:0] uart_tx_fifo_wrport_adr = 4'd0;
wire [9:0] uart_tx_fifo_wrport_dat_r;
wire uart_tx_fifo_wrport_we;
wire [9:0] uart_tx_fifo_wrport_dat_w;
wire uart_tx_fifo_do_read;
wire [3:0] uart_tx_fifo_rdport_adr;
wire [9:0] uart_tx_fifo_rdport_dat_r;
wire uart_tx_fifo_rdport_re;
wire [4:0] uart_tx_fifo_level1;
wire [7:0] uart_tx_fifo_fifo_in_payload_data;
wire uart_tx_fifo_fifo_in_first;
wire uart_tx_fifo_fifo_in_last;
wire [7:0] uart_tx_fifo_fifo_out_payload_data;
wire uart_tx_fifo_fifo_out_first;
wire uart_tx_fifo_fifo_out_last;
wire uart_rx_fifo_sink_valid;
wire uart_rx_fifo_sink_ready;
wire uart_rx_fifo_sink_first;
wire uart_rx_fifo_sink_last;
wire [7:0] uart_rx_fifo_sink_payload_data;
wire uart_rx_fifo_source_valid;
wire uart_rx_fifo_source_ready;
wire uart_rx_fifo_source_first;
wire uart_rx_fifo_source_last;
wire [7:0] uart_rx_fifo_source_payload_data;
wire uart_rx_fifo_re;
reg uart_rx_fifo_readable = 1'd0;
wire uart_rx_fifo_syncfifo_we;
wire uart_rx_fifo_syncfifo_writable;
wire uart_rx_fifo_syncfifo_re;
wire uart_rx_fifo_syncfifo_readable;
wire [9:0] uart_rx_fifo_syncfifo_din;
wire [9:0] uart_rx_fifo_syncfifo_dout;
reg [4:0] uart_rx_fifo_level0 = 5'd0;
reg uart_rx_fifo_replace = 1'd0;
reg [3:0] uart_rx_fifo_produce = 4'd0;
reg [3:0] uart_rx_fifo_consume = 4'd0;
reg [3:0] uart_rx_fifo_wrport_adr = 4'd0;
wire [9:0] uart_rx_fifo_wrport_dat_r;
wire uart_rx_fifo_wrport_we;
wire [9:0] uart_rx_fifo_wrport_dat_w;
wire uart_rx_fifo_do_read;
wire [3:0] uart_rx_fifo_rdport_adr;
wire [9:0] uart_rx_fifo_rdport_dat_r;
wire uart_rx_fifo_rdport_re;
wire [4:0] uart_rx_fifo_level1;
wire [7:0] uart_rx_fifo_fifo_in_payload_data;
wire uart_rx_fifo_fifo_in_first;
wire uart_rx_fifo_fifo_in_last;
wire [7:0] uart_rx_fifo_fifo_out_payload_data;
wire uart_rx_fifo_fifo_out_first;
wire uart_rx_fifo_fifo_out_last;
reg uart_reset = 1'd0;
reg [31:0] timer0_load_storage_full = 32'd0;
wire [31:0] timer0_load_storage;
reg timer0_load_re = 1'd0;
reg [31:0] timer0_reload_storage_full = 32'd0;
wire [31:0] timer0_reload_storage;
reg timer0_reload_re = 1'd0;
reg timer0_en_storage_full = 1'd0;
wire timer0_en_storage;
reg timer0_en_re = 1'd0;
wire timer0_update_value_re;
wire timer0_update_value_r;
reg timer0_update_value_w = 1'd0;
reg [31:0] timer0_value_status = 32'd0;
wire timer0_irq;
wire timer0_zero_status;
reg timer0_zero_pending = 1'd0;
wire timer0_zero_trigger;
reg timer0_zero_clear = 1'd0;
reg timer0_zero_old_trigger = 1'd0;
wire timer0_eventmanager_status_re;
wire timer0_eventmanager_status_r;
wire timer0_eventmanager_status_w;
wire timer0_eventmanager_pending_re;
wire timer0_eventmanager_pending_r;
wire timer0_eventmanager_pending_w;
reg timer0_eventmanager_storage_full = 1'd0;
wire timer0_eventmanager_storage;
reg timer0_eventmanager_re = 1'd0;
reg [31:0] timer0_value = 32'd0;
wire sys_clk;
wire sys_rst;
wire por_clk;
reg int_rst = 1'd1;
reg [56:0] status = 57'd0;
wire do_1;
reg [6:0] cnt = 7'd0;
reg rs_storage_full = 1'd0;
wire rs_storage;
reg rs_re = 1'd0;
wire [4:0] in_status;
reg [7:0] dir_status = 8'd0;
wire irq;
wire one_status;
reg one_pending = 1'd0;
wire one_trigger;
reg one_clear = 1'd0;
reg one_old_trigger = 1'd0;
wire zero_status;
reg zero_pending = 1'd0;
wire zero_trigger;
reg zero_clear = 1'd0;
reg zero_old_trigger = 1'd0;
wire two_status;
reg two_pending = 1'd0;
wire two_trigger;
reg two_clear = 1'd0;
reg two_old_trigger = 1'd0;
wire three_status;
reg three_pending = 1'd0;
wire three_trigger;
reg three_clear = 1'd0;
reg three_old_trigger = 1'd0;
wire four_status;
reg four_pending = 1'd0;
wire four_trigger;
reg four_clear = 1'd0;
reg four_old_trigger = 1'd0;
reg GPO_storage_full = 1'd0;
wire GPO_storage;
reg GPO_re = 1'd0;
wire SD_config_offline;
wire [1:0] SD_config_padding0;
wire SD_config_cs_polarity;
wire SD_config_clk_polarity;
wire SD_config_clk_phase;
wire SD_config_lsb_first;
wire SD_config_half_duplex;
wire [7:0] SD_config_padding1;
wire [7:0] SD_config_div_write;
wire [7:0] SD_config_div_read;
wire [15:0] SD_xfer_cs;
wire [5:0] SD_xfer_write_length;
wire [1:0] SD_xfer_padding0;
wire [5:0] SD_xfer_read_length;
wire [1:0] SD_xfer_padding1;
wire SD_start;
reg SD_active = 1'd0;
reg SD_pending0 = 1'd0;
wire [31:0] SD_mosi_data;
wire [31:0] SD_miso_data;
reg [7:0] SD_machine_load = 8'd0;
wire SD_machine_bias0;
wire SD_machine_edge;
reg SD_machine_clk = 1'd1;
reg [7:0] SD_machine_cnt = 8'd0;
reg SD_machine_bias1 = 1'd0;
wire SD_machine_zero;
wire SD_machine_cg_ce;
reg [31:0] SD_machine_data = 32'd0;
wire SD_machine_o;
wire SD_machine_i;
wire SD_machine_lsb;
reg SD_machine_shift = 1'd0;
reg SD_machine_sample = 1'd0;
wire SD_machine_reg_ce;
reg [5:0] SD_machine_n_read = 6'd0;
reg [5:0] SD_machine_n_write = 6'd0;
wire SD_machine_read;
wire SD_machine_write;
wire SD_machine_done0;
wire SD_machine_bits_ce;
wire [7:0] SD_machine_div_write;
wire [7:0] SD_machine_div_read;
wire SD_machine_clk_phase;
wire SD_machine_start;
wire SD_machine_cs;
wire SD_machine_oe;
wire SD_machine_done1;
wire SD_machine_fsm_ce;
reg SD_machine_write0 = 1'd0;
reg SD_machine_fsm_is_ongoing0 = 1'd0;
reg SD_machine_fsm_is_ongoing1 = 1'd0;
reg SD_pending1 = 1'd0;
reg [15:0] SD_cs = 16'd0;
reg [31:0] SD_data_read = 32'd0;
reg [31:0] SD_data_write = 32'd0;
wire SD_cs_n;
wire SD_cs_n_t_o;
wire SD_cs_n_t_oe;
wire SD_cs_n_t_i;
wire SD_clk_t_o;
wire SD_clk_t_oe;
wire SD_clk_t_i;
wire SD_mosi_t_o;
wire SD_mosi_t_oe;
wire SD_mosi_t_i;
reg [31:0] SD_config_storage_full = 32'd0;
wire [31:0] SD_config_storage;
reg SD_config_re = 1'd0;
reg [31:0] SD_xfer_storage_full = 32'd0;
wire [31:0] SD_xfer_storage;
reg SD_xfer_re = 1'd0;
wire SD_start_re;
wire SD_start_r;
reg SD_start_w = 1'd0;
wire SD_active_status;
wire SD_pending_status;
reg [31:0] SD_mosi_data_storage_full = 32'd0;
wire [31:0] SD_mosi_data_storage;
reg SD_mosi_data_re = 1'd0;
wire [31:0] SD_miso_data_status;
wire lcd_config_offline;
wire [1:0] lcd_config_padding0;
wire lcd_config_cs_polarity;
wire lcd_config_clk_polarity;
wire lcd_config_clk_phase;
wire lcd_config_lsb_first;
wire lcd_config_half_duplex;
wire [7:0] lcd_config_padding1;
wire [7:0] lcd_config_div_write;
wire [7:0] lcd_config_div_read;
wire [15:0] lcd_xfer_cs;
wire [5:0] lcd_xfer_write_length;
wire [1:0] lcd_xfer_padding0;
wire [5:0] lcd_xfer_read_length;
wire [1:0] lcd_xfer_padding1;
wire lcd_start;
reg lcd_active = 1'd0;
reg lcd_pending0 = 1'd0;
wire [31:0] lcd_mosi_data;
wire [31:0] lcd_miso_data;
reg [7:0] lcd_machine_load = 8'd0;
wire lcd_machine_bias0;
wire lcd_machine_edge;
reg lcd_machine_clk = 1'd1;
reg [7:0] lcd_machine_cnt = 8'd0;
reg lcd_machine_bias1 = 1'd0;
wire lcd_machine_zero;
wire lcd_machine_cg_ce;
reg [31:0] lcd_machine_data = 32'd0;
wire lcd_machine_o;
wire lcd_machine_i;
wire lcd_machine_lsb;
reg lcd_machine_shift = 1'd0;
reg lcd_machine_sample = 1'd0;
wire lcd_machine_reg_ce;
reg [5:0] lcd_machine_n_read = 6'd0;
reg [5:0] lcd_machine_n_write = 6'd0;
wire lcd_machine_read;
wire lcd_machine_write;
wire lcd_machine_done0;
wire lcd_machine_bits_ce;
wire [7:0] lcd_machine_div_write;
wire [7:0] lcd_machine_div_read;
wire lcd_machine_clk_phase;
wire lcd_machine_start;
wire lcd_machine_cs;
wire lcd_machine_oe;
wire lcd_machine_done1;
wire lcd_machine_fsm_ce;
reg lcd_machine_write0 = 1'd0;
reg lcd_machine_fsm_is_ongoing0 = 1'd0;
reg lcd_machine_fsm_is_ongoing1 = 1'd0;
reg lcd_pending1 = 1'd0;
reg [15:0] lcd_cs = 16'd0;
reg [31:0] lcd_data_read = 32'd0;
reg [31:0] lcd_data_write = 32'd0;
wire lcd_cs_n_t_o;
wire lcd_cs_n_t_oe;
wire lcd_cs_n_t_i;
wire lcd_clk_t_o;
wire lcd_clk_t_oe;
wire lcd_clk_t_i;
wire lcd_mosi_t_o;
wire lcd_mosi_t_oe;
wire lcd_mosi_t_i;
reg [31:0] lcd_config_storage_full = 32'd0;
wire [31:0] lcd_config_storage;
reg lcd_config_re = 1'd0;
reg [31:0] lcd_xfer_storage_full = 32'd0;
wire [31:0] lcd_xfer_storage;
reg lcd_xfer_re = 1'd0;
wire lcd_start_re;
wire lcd_start_r;
reg lcd_start_w = 1'd0;
wire lcd_active_status;
wire lcd_pending_status;
reg [31:0] lcd_mosi_data_storage_full = 32'd0;
wire [31:0] lcd_mosi_data_storage;
reg lcd_mosi_data_re = 1'd0;
wire [31:0] lcd_miso_data_status;
wire status_re;
wire [4:0] status_r;
reg [4:0] status_w = 5'd0;
wire pending_re;
wire [4:0] pending_r;
reg [4:0] pending_w = 5'd0;
reg [4:0] storage_full = 5'd0;
wire [4:0] storage;
reg re = 1'd0;
reg [1:0] spimaster0_state = 2'd0;
reg [1:0] spimaster0_next_state = 2'd0;
reg [1:0] spimaster1_state = 2'd0;
reg [1:0] spimaster1_next_state = 2'd0;
wire [29:0] shared_adr;
wire [31:0] shared_dat_w;
reg [31:0] shared_dat_r = 32'd0;
wire [3:0] shared_sel;
wire shared_cyc;
wire shared_stb;
reg shared_ack = 1'd0;
wire shared_we;
wire [2:0] shared_cti;
wire [1:0] shared_bte;
wire shared_err;
wire [1:0] request;
reg grant = 1'd0;
reg [3:0] slave_sel = 4'd0;
reg [3:0] slave_sel_r = 4'd0;
reg error = 1'd0;
wire wait_1;
wire done;
reg [19:0] count = 20'd1000000;
wire [13:0] interface0_bank_bus_adr;
wire interface0_bank_bus_we;
wire [31:0] interface0_bank_bus_dat_w;
reg [31:0] interface0_bank_bus_dat_r = 32'd0;
wire csrbank0_out0_re;
wire csrbank0_out0_r;
wire csrbank0_out0_w;
wire csrbank0_sel;
wire [13:0] interface1_bank_bus_adr;
wire interface1_bank_bus_we;
wire [31:0] interface1_bank_bus_dat_w;
reg [31:0] interface1_bank_bus_dat_r = 32'd0;
wire csrbank1_config0_re;
wire [31:0] csrbank1_config0_r;
wire [31:0] csrbank1_config0_w;
wire csrbank1_xfer0_re;
wire [31:0] csrbank1_xfer0_r;
wire [31:0] csrbank1_xfer0_w;
wire csrbank1_active_re;
wire csrbank1_active_r;
wire csrbank1_active_w;
wire csrbank1_pending_re;
wire csrbank1_pending_r;
wire csrbank1_pending_w;
wire csrbank1_mosi_data0_re;
wire [31:0] csrbank1_mosi_data0_r;
wire [31:0] csrbank1_mosi_data0_w;
wire csrbank1_miso_data_re;
wire [31:0] csrbank1_miso_data_r;
wire [31:0] csrbank1_miso_data_w;
wire csrbank1_sel;
wire [13:0] interface2_bank_bus_adr;
wire interface2_bank_bus_we;
wire [31:0] interface2_bank_bus_dat_w;
reg [31:0] interface2_bank_bus_dat_r = 32'd0;
wire csrbank2_in_re;
wire [4:0] csrbank2_in_r;
wire [4:0] csrbank2_in_w;
wire csrbank2_dir_re;
wire [7:0] csrbank2_dir_r;
wire [7:0] csrbank2_dir_w;
wire csrbank2_ev_enable0_re;
wire [4:0] csrbank2_ev_enable0_r;
wire [4:0] csrbank2_ev_enable0_w;
wire csrbank2_sel;
wire [13:0] interface3_bank_bus_adr;
wire interface3_bank_bus_we;
wire [31:0] interface3_bank_bus_dat_w;
reg [31:0] interface3_bank_bus_dat_r = 32'd0;
wire csrbank3_scratch0_re;
wire [31:0] csrbank3_scratch0_r;
wire [31:0] csrbank3_scratch0_w;
wire csrbank3_bus_errors_re;
wire [31:0] csrbank3_bus_errors_r;
wire [31:0] csrbank3_bus_errors_w;
wire csrbank3_sel;
wire [13:0] interface4_bank_bus_adr;
wire interface4_bank_bus_we;
wire [31:0] interface4_bank_bus_dat_w;
reg [31:0] interface4_bank_bus_dat_r = 32'd0;
wire csrbank4_id1_re;
wire [24:0] csrbank4_id1_r;
wire [24:0] csrbank4_id1_w;
wire csrbank4_id0_re;
wire [31:0] csrbank4_id0_r;
wire [31:0] csrbank4_id0_w;
wire csrbank4_sel;
wire [13:0] sram_bus_adr1;
wire sram_bus_we1;
wire [31:0] sram_bus_dat_w1;
reg [31:0] sram_bus_dat_r1 = 32'd0;
wire [5:0] adr;
wire [7:0] dat_r;
wire sel;
reg sel_r = 1'd0;
wire [13:0] interface5_bank_bus_adr;
wire interface5_bank_bus_we;
wire [31:0] interface5_bank_bus_dat_w;
reg [31:0] interface5_bank_bus_dat_r = 32'd0;
wire csrbank5_config0_re;
wire [31:0] csrbank5_config0_r;
wire [31:0] csrbank5_config0_w;
wire csrbank5_xfer0_re;
wire [31:0] csrbank5_xfer0_r;
wire [31:0] csrbank5_xfer0_w;
wire csrbank5_active_re;
wire csrbank5_active_r;
wire csrbank5_active_w;
wire csrbank5_pending_re;
wire csrbank5_pending_r;
wire csrbank5_pending_w;
wire csrbank5_mosi_data0_re;
wire [31:0] csrbank5_mosi_data0_r;
wire [31:0] csrbank5_mosi_data0_w;
wire csrbank5_miso_data_re;
wire [31:0] csrbank5_miso_data_r;
wire [31:0] csrbank5_miso_data_w;
wire csrbank5_sel;
wire [13:0] interface6_bank_bus_adr;
wire interface6_bank_bus_we;
wire [31:0] interface6_bank_bus_dat_w;
reg [31:0] interface6_bank_bus_dat_r = 32'd0;
wire csrbank6_out0_re;
wire csrbank6_out0_r;
wire csrbank6_out0_w;
wire csrbank6_sel;
wire [13:0] interface7_bank_bus_adr;
wire interface7_bank_bus_we;
wire [31:0] interface7_bank_bus_dat_w;
reg [31:0] interface7_bank_bus_dat_r = 32'd0;
wire csrbank7_load0_re;
wire [31:0] csrbank7_load0_r;
wire [31:0] csrbank7_load0_w;
wire csrbank7_reload0_re;
wire [31:0] csrbank7_reload0_r;
wire [31:0] csrbank7_reload0_w;
wire csrbank7_en0_re;
wire csrbank7_en0_r;
wire csrbank7_en0_w;
wire csrbank7_value_re;
wire [31:0] csrbank7_value_r;
wire [31:0] csrbank7_value_w;
wire csrbank7_ev_enable0_re;
wire csrbank7_ev_enable0_r;
wire csrbank7_ev_enable0_w;
wire csrbank7_sel;
wire [13:0] interface8_bank_bus_adr;
wire interface8_bank_bus_we;
wire [31:0] interface8_bank_bus_dat_w;
reg [31:0] interface8_bank_bus_dat_r = 32'd0;
wire csrbank8_txfull_re;
wire csrbank8_txfull_r;
wire csrbank8_txfull_w;
wire csrbank8_rxempty_re;
wire csrbank8_rxempty_r;
wire csrbank8_rxempty_w;
wire csrbank8_ev_enable0_re;
wire [1:0] csrbank8_ev_enable0_r;
wire [1:0] csrbank8_ev_enable0_w;
wire csrbank8_sel;
wire [13:0] interface9_bank_bus_adr;
wire interface9_bank_bus_we;
wire [31:0] interface9_bank_bus_dat_w;
reg [31:0] interface9_bank_bus_dat_r = 32'd0;
wire csrbank9_tuning_word0_re;
wire [31:0] csrbank9_tuning_word0_r;
wire [31:0] csrbank9_tuning_word0_w;
wire csrbank9_sel;
wire [4:0] slice_proxy0;
wire [4:0] slice_proxy1;
wire [4:0] slice_proxy2;
wire [4:0] slice_proxy3;
wire [4:0] slice_proxy4;
reg [29:0] array_muxed0 = 30'd0;
reg [31:0] array_muxed1 = 32'd0;
reg [3:0] array_muxed2 = 4'd0;
reg array_muxed3 = 1'd0;
reg array_muxed4 = 1'd0;
reg array_muxed5 = 1'd0;
reg [2:0] array_muxed6 = 3'd0;
reg [1:0] array_muxed7 = 2'd0;
(* register_balancing = "no", shreg_extract = "no" *) reg xilinxmultiregimpl0_regs0 = 1'd0;
(* register_balancing = "no", shreg_extract = "no" *) reg xilinxmultiregimpl0_regs1 = 1'd0;
(* register_balancing = "no", shreg_extract = "no" *) reg [4:0] xilinxmultiregimpl1_regs0 = 5'd0;
(* register_balancing = "no", shreg_extract = "no" *) reg [4:0] xilinxmultiregimpl1_regs1 = 5'd0;
wire xilinxmultiregimpl1;

assign lm32_reset = ctrl_reset;
assign ctrl_bus_error = error;
always @(*) begin
	lm32_interrupt <= 32'd0;
	lm32_interrupt[1] <= timer0_irq;
	lm32_interrupt[2] <= uart_irq;
	lm32_interrupt[4] <= irq;
end
assign ctrl_reset = ctrl_reset_reset_re;
assign ctrl_bus_errors_status = ctrl_bus_errors;
assign lm32_ibus_adr = lm32_i_adr_o[31:2];
assign lm32_dbus_adr = lm32_d_adr_o[31:2];
assign rom_adr = rom_bus_adr[12:0];
assign rom_bus_dat_r = rom_dat_r;
always @(*) begin
	sram_we <= 4'd0;
	sram_we[0] <= (((sram_bus_cyc & sram_bus_stb) & sram_bus_we0) & sram_bus_sel[0]);
	sram_we[1] <= (((sram_bus_cyc & sram_bus_stb) & sram_bus_we0) & sram_bus_sel[1]);
	sram_we[2] <= (((sram_bus_cyc & sram_bus_stb) & sram_bus_we0) & sram_bus_sel[2]);
	sram_we[3] <= (((sram_bus_cyc & sram_bus_stb) & sram_bus_we0) & sram_bus_sel[3]);
end
assign sram_adr = sram_bus_adr0[9:0];
assign sram_bus_dat_r0 = sram_dat_r;
assign sram_dat_w = sram_bus_dat_w0;
always @(*) begin
	main_ram_we <= 4'd0;
	main_ram_we[0] <= (((main_ram_bus_cyc & main_ram_bus_stb) & main_ram_bus_we) & main_ram_bus_sel[0]);
	main_ram_we[1] <= (((main_ram_bus_cyc & main_ram_bus_stb) & main_ram_bus_we) & main_ram_bus_sel[1]);
	main_ram_we[2] <= (((main_ram_bus_cyc & main_ram_bus_stb) & main_ram_bus_we) & main_ram_bus_sel[2]);
	main_ram_we[3] <= (((main_ram_bus_cyc & main_ram_bus_stb) & main_ram_bus_we) & main_ram_bus_sel[3]);
end
assign main_ram_adr = main_ram_bus_adr[13:0];
assign main_ram_bus_dat_r = main_ram_dat_r;
assign main_ram_dat_w = main_ram_bus_dat_w;
assign uart_tx_fifo_sink_valid = uart_rxtx_re;
assign uart_tx_fifo_sink_payload_data = uart_rxtx_r;
assign uart_txfull_status = (~uart_tx_fifo_sink_ready);
assign uart_phy_sink_valid = uart_tx_fifo_source_valid;
assign uart_tx_fifo_source_ready = uart_phy_sink_ready;
assign uart_phy_sink_first = uart_tx_fifo_source_first;
assign uart_phy_sink_last = uart_tx_fifo_source_last;
assign uart_phy_sink_payload_data = uart_tx_fifo_source_payload_data;
assign uart_tx_trigger = (~uart_tx_fifo_sink_ready);
assign uart_rx_fifo_sink_valid = uart_phy_source_valid;
assign uart_phy_source_ready = uart_rx_fifo_sink_ready;
assign uart_rx_fifo_sink_first = uart_phy_source_first;
assign uart_rx_fifo_sink_last = uart_phy_source_last;
assign uart_rx_fifo_sink_payload_data = uart_phy_source_payload_data;
assign uart_rxempty_status = (~uart_rx_fifo_source_valid);
assign uart_rxtx_w = uart_rx_fifo_source_payload_data;
assign uart_rx_fifo_source_ready = uart_rx_clear;
assign uart_rx_trigger = (~uart_rx_fifo_source_valid);
always @(*) begin
	uart_tx_clear <= 1'd0;
	if ((uart_eventmanager_pending_re & uart_eventmanager_pending_r[0])) begin
		uart_tx_clear <= 1'd1;
	end
end
always @(*) begin
	uart_eventmanager_status_w <= 2'd0;
	uart_eventmanager_status_w[0] <= uart_tx_status;
	uart_eventmanager_status_w[1] <= uart_rx_status;
end
always @(*) begin
	uart_rx_clear <= 1'd0;
	if ((uart_eventmanager_pending_re & uart_eventmanager_pending_r[1])) begin
		uart_rx_clear <= 1'd1;
	end
end
always @(*) begin
	uart_eventmanager_pending_w <= 2'd0;
	uart_eventmanager_pending_w[0] <= uart_tx_pending;
	uart_eventmanager_pending_w[1] <= uart_rx_pending;
end
assign uart_irq = ((uart_eventmanager_pending_w[0] & uart_eventmanager_storage[0]) | (uart_eventmanager_pending_w[1] & uart_eventmanager_storage[1]));
assign uart_tx_status = uart_tx_trigger;
assign uart_rx_status = uart_rx_trigger;
assign uart_tx_fifo_syncfifo_din = {uart_tx_fifo_fifo_in_last, uart_tx_fifo_fifo_in_first, uart_tx_fifo_fifo_in_payload_data};
assign {uart_tx_fifo_fifo_out_last, uart_tx_fifo_fifo_out_first, uart_tx_fifo_fifo_out_payload_data} = uart_tx_fifo_syncfifo_dout;
assign uart_tx_fifo_sink_ready = uart_tx_fifo_syncfifo_writable;
assign uart_tx_fifo_syncfifo_we = uart_tx_fifo_sink_valid;
assign uart_tx_fifo_fifo_in_first = uart_tx_fifo_sink_first;
assign uart_tx_fifo_fifo_in_last = uart_tx_fifo_sink_last;
assign uart_tx_fifo_fifo_in_payload_data = uart_tx_fifo_sink_payload_data;
assign uart_tx_fifo_source_valid = uart_tx_fifo_readable;
assign uart_tx_fifo_source_first = uart_tx_fifo_fifo_out_first;
assign uart_tx_fifo_source_last = uart_tx_fifo_fifo_out_last;
assign uart_tx_fifo_source_payload_data = uart_tx_fifo_fifo_out_payload_data;
assign uart_tx_fifo_re = uart_tx_fifo_source_ready;
assign uart_tx_fifo_syncfifo_re = (uart_tx_fifo_syncfifo_readable & ((~uart_tx_fifo_readable) | uart_tx_fifo_re));
assign uart_tx_fifo_level1 = (uart_tx_fifo_level0 + uart_tx_fifo_readable);
always @(*) begin
	uart_tx_fifo_wrport_adr <= 4'd0;
	if (uart_tx_fifo_replace) begin
		uart_tx_fifo_wrport_adr <= (uart_tx_fifo_produce - 1'd1);
	end else begin
		uart_tx_fifo_wrport_adr <= uart_tx_fifo_produce;
	end
end
assign uart_tx_fifo_wrport_dat_w = uart_tx_fifo_syncfifo_din;
assign uart_tx_fifo_wrport_we = (uart_tx_fifo_syncfifo_we & (uart_tx_fifo_syncfifo_writable | uart_tx_fifo_replace));
assign uart_tx_fifo_do_read = (uart_tx_fifo_syncfifo_readable & uart_tx_fifo_syncfifo_re);
assign uart_tx_fifo_rdport_adr = uart_tx_fifo_consume;
assign uart_tx_fifo_syncfifo_dout = uart_tx_fifo_rdport_dat_r;
assign uart_tx_fifo_rdport_re = uart_tx_fifo_do_read;
assign uart_tx_fifo_syncfifo_writable = (uart_tx_fifo_level0 != 5'd16);
assign uart_tx_fifo_syncfifo_readable = (uart_tx_fifo_level0 != 1'd0);
assign uart_rx_fifo_syncfifo_din = {uart_rx_fifo_fifo_in_last, uart_rx_fifo_fifo_in_first, uart_rx_fifo_fifo_in_payload_data};
assign {uart_rx_fifo_fifo_out_last, uart_rx_fifo_fifo_out_first, uart_rx_fifo_fifo_out_payload_data} = uart_rx_fifo_syncfifo_dout;
assign uart_rx_fifo_sink_ready = uart_rx_fifo_syncfifo_writable;
assign uart_rx_fifo_syncfifo_we = uart_rx_fifo_sink_valid;
assign uart_rx_fifo_fifo_in_first = uart_rx_fifo_sink_first;
assign uart_rx_fifo_fifo_in_last = uart_rx_fifo_sink_last;
assign uart_rx_fifo_fifo_in_payload_data = uart_rx_fifo_sink_payload_data;
assign uart_rx_fifo_source_valid = uart_rx_fifo_readable;
assign uart_rx_fifo_source_first = uart_rx_fifo_fifo_out_first;
assign uart_rx_fifo_source_last = uart_rx_fifo_fifo_out_last;
assign uart_rx_fifo_source_payload_data = uart_rx_fifo_fifo_out_payload_data;
assign uart_rx_fifo_re = uart_rx_fifo_source_ready;
assign uart_rx_fifo_syncfifo_re = (uart_rx_fifo_syncfifo_readable & ((~uart_rx_fifo_readable) | uart_rx_fifo_re));
assign uart_rx_fifo_level1 = (uart_rx_fifo_level0 + uart_rx_fifo_readable);
always @(*) begin
	uart_rx_fifo_wrport_adr <= 4'd0;
	if (uart_rx_fifo_replace) begin
		uart_rx_fifo_wrport_adr <= (uart_rx_fifo_produce - 1'd1);
	end else begin
		uart_rx_fifo_wrport_adr <= uart_rx_fifo_produce;
	end
end
assign uart_rx_fifo_wrport_dat_w = uart_rx_fifo_syncfifo_din;
assign uart_rx_fifo_wrport_we = (uart_rx_fifo_syncfifo_we & (uart_rx_fifo_syncfifo_writable | uart_rx_fifo_replace));
assign uart_rx_fifo_do_read = (uart_rx_fifo_syncfifo_readable & uart_rx_fifo_syncfifo_re);
assign uart_rx_fifo_rdport_adr = uart_rx_fifo_consume;
assign uart_rx_fifo_syncfifo_dout = uart_rx_fifo_rdport_dat_r;
assign uart_rx_fifo_rdport_re = uart_rx_fifo_do_read;
assign uart_rx_fifo_syncfifo_writable = (uart_rx_fifo_level0 != 5'd16);
assign uart_rx_fifo_syncfifo_readable = (uart_rx_fifo_level0 != 1'd0);
assign timer0_zero_trigger = (timer0_value != 1'd0);
assign timer0_eventmanager_status_w = timer0_zero_status;
always @(*) begin
	timer0_zero_clear <= 1'd0;
	if ((timer0_eventmanager_pending_re & timer0_eventmanager_pending_r)) begin
		timer0_zero_clear <= 1'd1;
	end
end
assign timer0_eventmanager_pending_w = timer0_zero_pending;
assign timer0_irq = (timer0_eventmanager_pending_w & timer0_eventmanager_storage);
assign timer0_zero_status = timer0_zero_trigger;
assign sys_clk = clk100;
assign por_clk = clk100;
assign sys_rst = int_rst;
assign lcd_rs = rs_storage;
assign zero_trigger = slice_proxy0[0];
assign one_trigger = slice_proxy1[1];
assign two_trigger = slice_proxy2[2];
assign three_trigger = slice_proxy3[3];
assign four_trigger = slice_proxy4[4];
always @(*) begin
	one_clear <= 1'd0;
	if ((pending_re & pending_r[0])) begin
		one_clear <= 1'd1;
	end
end
always @(*) begin
	zero_clear <= 1'd0;
	if ((pending_re & pending_r[1])) begin
		zero_clear <= 1'd1;
	end
end
always @(*) begin
	two_clear <= 1'd0;
	if ((pending_re & pending_r[2])) begin
		two_clear <= 1'd1;
	end
end
always @(*) begin
	three_clear <= 1'd0;
	if ((pending_re & pending_r[3])) begin
		three_clear <= 1'd1;
	end
end
always @(*) begin
	status_w <= 5'd0;
	status_w[0] <= one_status;
	status_w[1] <= zero_status;
	status_w[2] <= two_status;
	status_w[3] <= three_status;
	status_w[4] <= four_status;
end
always @(*) begin
	four_clear <= 1'd0;
	if ((pending_re & pending_r[4])) begin
		four_clear <= 1'd1;
	end
end
always @(*) begin
	pending_w <= 5'd0;
	pending_w[0] <= one_pending;
	pending_w[1] <= zero_pending;
	pending_w[2] <= two_pending;
	pending_w[3] <= three_pending;
	pending_w[4] <= four_pending;
end
assign irq = (((((pending_w[0] & storage[0]) | (pending_w[1] & storage[1])) | (pending_w[2] & storage[2])) | (pending_w[3] & storage[3])) | (pending_w[4] & storage[4]));
assign one_status = one_trigger;
assign zero_status = zero_trigger;
assign two_status = two_trigger;
assign three_status = three_trigger;
assign four_status = four_trigger;
assign GPO0 = GPO_storage;
assign {SD_config_div_read, SD_config_div_write, SD_config_padding1, SD_config_half_duplex, SD_config_lsb_first, SD_config_clk_phase, SD_config_clk_polarity, SD_config_cs_polarity, SD_config_padding0, SD_config_offline} = SD_config_storage;
assign {SD_xfer_padding1, SD_xfer_read_length, SD_xfer_padding0, SD_xfer_write_length, SD_xfer_cs} = SD_xfer_storage;
assign SD_start = (SD_start_re & SD_start_r);
assign SD_active_status = SD_active;
assign SD_pending_status = SD_pending0;
assign SD_mosi_data = SD_mosi_data_storage;
assign SD_miso_data_status = SD_miso_data;
assign SD_miso_data = SD_data_read;
assign SD_machine_start = (SD_pending1 & ((~SD_machine_cs) | SD_machine_done1));
assign SD_machine_clk_phase = SD_config_clk_phase;
assign SD_machine_lsb = SD_config_lsb_first;
assign SD_machine_div_write = SD_config_div_write;
assign SD_machine_div_read = SD_config_div_read;
assign SD_cs_n_t_oe = (~SD_config_offline);
assign SD_cs_n_t_o = ((SD_cs & {16{SD_machine_cs}}) ^ {16{(~SD_config_cs_polarity)}});
assign SD_clk_t_oe = (~SD_config_offline);
assign SD_clk_t_o = ((SD_machine_clk & SD_machine_cs) ^ SD_config_clk_polarity);
assign SD_mosi_t_oe = (((~SD_config_offline) & SD_machine_cs) & (SD_machine_oe | (~SD_config_half_duplex)));
assign SD_mosi_t_o = SD_machine_o;
assign SD_machine_i = (SD_config_half_duplex ? SD_mosi_t_i : SD_spi_miso);
assign SD_machine_cg_ce = ((SD_machine_start | SD_machine_cs) | (~SD_machine_edge));
always @(*) begin
	SD_machine_load <= 8'd0;
	if ((SD_machine_write | (~SD_machine_read))) begin
		SD_machine_load <= SD_machine_div_write;
	end else begin
		SD_machine_load <= SD_machine_div_read;
	end
end
assign SD_machine_bias0 = SD_machine_clk_phase;
assign SD_machine_fsm_ce = SD_machine_edge;
assign SD_machine_cs = (~SD_machine_fsm_is_ongoing0);
assign SD_machine_reg_ce = SD_machine_edge;
assign SD_machine_bits_ce = (SD_machine_edge & SD_machine_sample);
assign SD_machine_done1 = ((SD_machine_edge & SD_machine_done0) & SD_machine_fsm_is_ongoing1);
assign SD_machine_oe = (SD_machine_write0 | SD_machine_write);
assign SD_machine_zero = (SD_machine_cnt == 1'd0);
assign SD_machine_edge = (SD_machine_zero & (~SD_machine_bias1));
assign SD_machine_o = (SD_machine_lsb ? SD_machine_data[0] : SD_machine_data[31]);
assign SD_machine_write = (SD_machine_n_write != 1'd0);
assign SD_machine_read = (SD_machine_n_read != 1'd0);
assign SD_machine_done0 = (~(SD_machine_write | SD_machine_read));
always @(*) begin
	SD_machine_fsm_is_ongoing1 <= 1'd0;
	spimaster0_next_state <= 2'd0;
	SD_machine_shift <= 1'd0;
	SD_machine_fsm_is_ongoing0 <= 1'd0;
	SD_machine_sample <= 1'd0;
	spimaster0_next_state <= spimaster0_state;
	case (spimaster0_state)
		1'd1: begin
			SD_machine_sample <= 1'd1;
			spimaster0_next_state <= 2'd2;
		end
		2'd2: begin
			if ((SD_machine_done0 & (~SD_machine_start))) begin
				if (SD_machine_clk_phase) begin
					spimaster0_next_state <= 1'd0;
				end else begin
					spimaster0_next_state <= 2'd3;
				end
			end else begin
				SD_machine_shift <= (~SD_machine_start);
				spimaster0_next_state <= 1'd1;
			end
			SD_machine_fsm_is_ongoing1 <= 1'd1;
		end
		2'd3: begin
			if (SD_machine_done0) begin
				spimaster0_next_state <= 1'd0;
			end else begin
				spimaster0_next_state <= 1'd1;
			end
		end
		default: begin
			if (SD_machine_start) begin
				if (SD_machine_clk_phase) begin
					spimaster0_next_state <= 2'd3;
				end else begin
					spimaster0_next_state <= 1'd1;
				end
			end
			SD_machine_fsm_is_ongoing0 <= 1'd1;
		end
	endcase
end
assign {lcd_config_div_read, lcd_config_div_write, lcd_config_padding1, lcd_config_half_duplex, lcd_config_lsb_first, lcd_config_clk_phase, lcd_config_clk_polarity, lcd_config_cs_polarity, lcd_config_padding0, lcd_config_offline} = lcd_config_storage;
assign {lcd_xfer_padding1, lcd_xfer_read_length, lcd_xfer_padding0, lcd_xfer_write_length, lcd_xfer_cs} = lcd_xfer_storage;
assign lcd_start = (lcd_start_re & lcd_start_r);
assign lcd_active_status = lcd_active;
assign lcd_pending_status = lcd_pending0;
assign lcd_mosi_data = lcd_mosi_data_storage;
assign lcd_miso_data_status = lcd_miso_data;
assign lcd_miso_data = lcd_data_read;
assign lcd_machine_start = (lcd_pending1 & ((~lcd_machine_cs) | lcd_machine_done1));
assign lcd_machine_clk_phase = lcd_config_clk_phase;
assign lcd_machine_lsb = lcd_config_lsb_first;
assign lcd_machine_div_write = lcd_config_div_write;
assign lcd_machine_div_read = lcd_config_div_read;
assign lcd_cs_n_t_oe = (~lcd_config_offline);
assign lcd_cs_n_t_o = ((lcd_cs & {16{lcd_machine_cs}}) ^ {16{(~lcd_config_cs_polarity)}});
assign lcd_clk_t_oe = (~lcd_config_offline);
assign lcd_clk_t_o = ((lcd_machine_clk & lcd_machine_cs) ^ lcd_config_clk_polarity);
assign lcd_mosi_t_oe = (((~lcd_config_offline) & lcd_machine_cs) & (lcd_machine_oe | (~lcd_config_half_duplex)));
assign lcd_mosi_t_o = lcd_machine_o;
assign lcd_machine_i = (lcd_config_half_duplex ? lcd_mosi_t_i : lcd_mosi_t_i);
assign lcd_machine_cg_ce = ((lcd_machine_start | lcd_machine_cs) | (~lcd_machine_edge));
always @(*) begin
	lcd_machine_load <= 8'd0;
	if ((lcd_machine_write | (~lcd_machine_read))) begin
		lcd_machine_load <= lcd_machine_div_write;
	end else begin
		lcd_machine_load <= lcd_machine_div_read;
	end
end
assign lcd_machine_bias0 = lcd_machine_clk_phase;
assign lcd_machine_fsm_ce = lcd_machine_edge;
assign lcd_machine_cs = (~lcd_machine_fsm_is_ongoing0);
assign lcd_machine_reg_ce = lcd_machine_edge;
assign lcd_machine_bits_ce = (lcd_machine_edge & lcd_machine_sample);
assign lcd_machine_done1 = ((lcd_machine_edge & lcd_machine_done0) & lcd_machine_fsm_is_ongoing1);
assign lcd_machine_oe = (lcd_machine_write0 | lcd_machine_write);
assign lcd_machine_zero = (lcd_machine_cnt == 1'd0);
assign lcd_machine_edge = (lcd_machine_zero & (~lcd_machine_bias1));
assign lcd_machine_o = (lcd_machine_lsb ? lcd_machine_data[0] : lcd_machine_data[31]);
assign lcd_machine_write = (lcd_machine_n_write != 1'd0);
assign lcd_machine_read = (lcd_machine_n_read != 1'd0);
assign lcd_machine_done0 = (~(lcd_machine_write | lcd_machine_read));
always @(*) begin
	lcd_machine_shift <= 1'd0;
	lcd_machine_fsm_is_ongoing0 <= 1'd0;
	spimaster1_next_state <= 2'd0;
	lcd_machine_sample <= 1'd0;
	lcd_machine_fsm_is_ongoing1 <= 1'd0;
	spimaster1_next_state <= spimaster1_state;
	case (spimaster1_state)
		1'd1: begin
			lcd_machine_sample <= 1'd1;
			spimaster1_next_state <= 2'd2;
		end
		2'd2: begin
			if ((lcd_machine_done0 & (~lcd_machine_start))) begin
				if (lcd_machine_clk_phase) begin
					spimaster1_next_state <= 1'd0;
				end else begin
					spimaster1_next_state <= 2'd3;
				end
			end else begin
				lcd_machine_shift <= (~lcd_machine_start);
				spimaster1_next_state <= 1'd1;
			end
			lcd_machine_fsm_is_ongoing1 <= 1'd1;
		end
		2'd3: begin
			if (lcd_machine_done0) begin
				spimaster1_next_state <= 1'd0;
			end else begin
				spimaster1_next_state <= 1'd1;
			end
		end
		default: begin
			if (lcd_machine_start) begin
				if (lcd_machine_clk_phase) begin
					spimaster1_next_state <= 2'd3;
				end else begin
					spimaster1_next_state <= 1'd1;
				end
			end
			lcd_machine_fsm_is_ongoing0 <= 1'd1;
		end
	endcase
end
assign shared_adr = array_muxed0;
assign shared_dat_w = array_muxed1;
assign shared_sel = array_muxed2;
assign shared_cyc = array_muxed3;
assign shared_stb = array_muxed4;
assign shared_we = array_muxed5;
assign shared_cti = array_muxed6;
assign shared_bte = array_muxed7;
assign lm32_ibus_dat_r = shared_dat_r;
assign lm32_dbus_dat_r = shared_dat_r;
assign lm32_ibus_ack = (shared_ack & (grant == 1'd0));
assign lm32_dbus_ack = (shared_ack & (grant == 1'd1));
assign lm32_ibus_err = (shared_err & (grant == 1'd0));
assign lm32_dbus_err = (shared_err & (grant == 1'd1));
assign request = {lm32_dbus_cyc, lm32_ibus_cyc};
always @(*) begin
	slave_sel <= 4'd0;
	slave_sel[0] <= (shared_adr[28:26] == 1'd0);
	slave_sel[1] <= (shared_adr[28:26] == 1'd1);
	slave_sel[2] <= (shared_adr[28:26] == 3'd4);
	slave_sel[3] <= (shared_adr[28:26] == 3'd6);
end
assign rom_bus_adr = shared_adr;
assign rom_bus_dat_w = shared_dat_w;
assign rom_bus_sel = shared_sel;
assign rom_bus_stb = shared_stb;
assign rom_bus_we = shared_we;
assign rom_bus_cti = shared_cti;
assign rom_bus_bte = shared_bte;
assign sram_bus_adr0 = shared_adr;
assign sram_bus_dat_w0 = shared_dat_w;
assign sram_bus_sel = shared_sel;
assign sram_bus_stb = shared_stb;
assign sram_bus_we0 = shared_we;
assign sram_bus_cti = shared_cti;
assign sram_bus_bte = shared_bte;
assign main_ram_bus_adr = shared_adr;
assign main_ram_bus_dat_w = shared_dat_w;
assign main_ram_bus_sel = shared_sel;
assign main_ram_bus_stb = shared_stb;
assign main_ram_bus_we = shared_we;
assign main_ram_bus_cti = shared_cti;
assign main_ram_bus_bte = shared_bte;
assign bus_wishbone_adr = shared_adr;
assign bus_wishbone_dat_w = shared_dat_w;
assign bus_wishbone_sel = shared_sel;
assign bus_wishbone_stb = shared_stb;
assign bus_wishbone_we = shared_we;
assign bus_wishbone_cti = shared_cti;
assign bus_wishbone_bte = shared_bte;
assign rom_bus_cyc = (shared_cyc & slave_sel[0]);
assign sram_bus_cyc = (shared_cyc & slave_sel[1]);
assign main_ram_bus_cyc = (shared_cyc & slave_sel[2]);
assign bus_wishbone_cyc = (shared_cyc & slave_sel[3]);
assign shared_err = (((rom_bus_err | sram_bus_err) | main_ram_bus_err) | bus_wishbone_err);
assign wait_1 = ((shared_stb & shared_cyc) & (~shared_ack));
always @(*) begin
	error <= 1'd0;
	shared_dat_r <= 32'd0;
	shared_ack <= 1'd0;
	shared_ack <= (((rom_bus_ack | sram_bus_ack) | main_ram_bus_ack) | bus_wishbone_ack);
	shared_dat_r <= (((({32{slave_sel_r[0]}} & rom_bus_dat_r) | ({32{slave_sel_r[1]}} & sram_bus_dat_r0)) | ({32{slave_sel_r[2]}} & main_ram_bus_dat_r)) | ({32{slave_sel_r[3]}} & bus_wishbone_dat_r));
	if (done) begin
		shared_dat_r <= 32'd4294967295;
		shared_ack <= 1'd1;
		error <= 1'd1;
	end
end
assign done = (count == 1'd0);
assign csrbank0_sel = (interface0_bank_bus_adr[13:9] == 4'd12);
assign csrbank0_out0_r = interface0_bank_bus_dat_w[0];
assign csrbank0_out0_re = ((csrbank0_sel & interface0_bank_bus_we) & (interface0_bank_bus_adr[0] == 1'd0));
assign GPO_storage = GPO_storage_full;
assign csrbank0_out0_w = GPO_storage_full;
assign csrbank1_sel = (interface1_bank_bus_adr[13:9] == 4'd11);
assign csrbank1_config0_r = interface1_bank_bus_dat_w[31:0];
assign csrbank1_config0_re = ((csrbank1_sel & interface1_bank_bus_we) & (interface1_bank_bus_adr[2:0] == 1'd0));
assign csrbank1_xfer0_r = interface1_bank_bus_dat_w[31:0];
assign csrbank1_xfer0_re = ((csrbank1_sel & interface1_bank_bus_we) & (interface1_bank_bus_adr[2:0] == 1'd1));
assign SD_start_r = interface1_bank_bus_dat_w[0];
assign SD_start_re = ((csrbank1_sel & interface1_bank_bus_we) & (interface1_bank_bus_adr[2:0] == 2'd2));
assign csrbank1_active_r = interface1_bank_bus_dat_w[0];
assign csrbank1_active_re = ((csrbank1_sel & interface1_bank_bus_we) & (interface1_bank_bus_adr[2:0] == 2'd3));
assign csrbank1_pending_r = interface1_bank_bus_dat_w[0];
assign csrbank1_pending_re = ((csrbank1_sel & interface1_bank_bus_we) & (interface1_bank_bus_adr[2:0] == 3'd4));
assign csrbank1_mosi_data0_r = interface1_bank_bus_dat_w[31:0];
assign csrbank1_mosi_data0_re = ((csrbank1_sel & interface1_bank_bus_we) & (interface1_bank_bus_adr[2:0] == 3'd5));
assign csrbank1_miso_data_r = interface1_bank_bus_dat_w[31:0];
assign csrbank1_miso_data_re = ((csrbank1_sel & interface1_bank_bus_we) & (interface1_bank_bus_adr[2:0] == 3'd6));
assign SD_config_storage = SD_config_storage_full[31:0];
assign csrbank1_config0_w = SD_config_storage_full[31:0];
assign SD_xfer_storage = SD_xfer_storage_full[31:0];
assign csrbank1_xfer0_w = SD_xfer_storage_full[31:0];
assign csrbank1_active_w = SD_active_status;
assign csrbank1_pending_w = SD_pending_status;
assign SD_mosi_data_storage = SD_mosi_data_storage_full[31:0];
assign csrbank1_mosi_data0_w = SD_mosi_data_storage_full[31:0];
assign csrbank1_miso_data_w = SD_miso_data_status[31:0];
assign csrbank2_sel = (interface2_bank_bus_adr[13:9] == 4'd9);
assign csrbank2_in_r = interface2_bank_bus_dat_w[4:0];
assign csrbank2_in_re = ((csrbank2_sel & interface2_bank_bus_we) & (interface2_bank_bus_adr[2:0] == 1'd0));
assign csrbank2_dir_r = interface2_bank_bus_dat_w[7:0];
assign csrbank2_dir_re = ((csrbank2_sel & interface2_bank_bus_we) & (interface2_bank_bus_adr[2:0] == 1'd1));
assign status_r = interface2_bank_bus_dat_w[4:0];
assign status_re = ((csrbank2_sel & interface2_bank_bus_we) & (interface2_bank_bus_adr[2:0] == 2'd2));
assign pending_r = interface2_bank_bus_dat_w[4:0];
assign pending_re = ((csrbank2_sel & interface2_bank_bus_we) & (interface2_bank_bus_adr[2:0] == 2'd3));
assign csrbank2_ev_enable0_r = interface2_bank_bus_dat_w[4:0];
assign csrbank2_ev_enable0_re = ((csrbank2_sel & interface2_bank_bus_we) & (interface2_bank_bus_adr[2:0] == 3'd4));
assign csrbank2_in_w = in_status[4:0];
assign csrbank2_dir_w = dir_status[7:0];
assign storage = storage_full[4:0];
assign csrbank2_ev_enable0_w = storage_full[4:0];
assign csrbank3_sel = (interface3_bank_bus_adr[13:9] == 1'd0);
assign ctrl_reset_reset_r = interface3_bank_bus_dat_w[0];
assign ctrl_reset_reset_re = ((csrbank3_sel & interface3_bank_bus_we) & (interface3_bank_bus_adr[1:0] == 1'd0));
assign csrbank3_scratch0_r = interface3_bank_bus_dat_w[31:0];
assign csrbank3_scratch0_re = ((csrbank3_sel & interface3_bank_bus_we) & (interface3_bank_bus_adr[1:0] == 1'd1));
assign csrbank3_bus_errors_r = interface3_bank_bus_dat_w[31:0];
assign csrbank3_bus_errors_re = ((csrbank3_sel & interface3_bank_bus_we) & (interface3_bank_bus_adr[1:0] == 2'd2));
assign ctrl_storage = ctrl_storage_full[31:0];
assign csrbank3_scratch0_w = ctrl_storage_full[31:0];
assign csrbank3_bus_errors_w = ctrl_bus_errors_status[31:0];
assign csrbank4_sel = (interface4_bank_bus_adr[13:9] == 4'd8);
assign csrbank4_id1_r = interface4_bank_bus_dat_w[24:0];
assign csrbank4_id1_re = ((csrbank4_sel & interface4_bank_bus_we) & (interface4_bank_bus_adr[0] == 1'd0));
assign csrbank4_id0_r = interface4_bank_bus_dat_w[31:0];
assign csrbank4_id0_re = ((csrbank4_sel & interface4_bank_bus_we) & (interface4_bank_bus_adr[0] == 1'd1));
assign csrbank4_id1_w = status[56:32];
assign csrbank4_id0_w = status[31:0];
assign sel = (sram_bus_adr1[13:9] == 3'd4);
always @(*) begin
	sram_bus_dat_r1 <= 32'd0;
	if (sel_r) begin
		sram_bus_dat_r1 <= dat_r;
	end
end
assign adr = sram_bus_adr1[5:0];
assign csrbank5_sel = (interface5_bank_bus_adr[13:9] == 4'd10);
assign csrbank5_config0_r = interface5_bank_bus_dat_w[31:0];
assign csrbank5_config0_re = ((csrbank5_sel & interface5_bank_bus_we) & (interface5_bank_bus_adr[2:0] == 1'd0));
assign csrbank5_xfer0_r = interface5_bank_bus_dat_w[31:0];
assign csrbank5_xfer0_re = ((csrbank5_sel & interface5_bank_bus_we) & (interface5_bank_bus_adr[2:0] == 1'd1));
assign lcd_start_r = interface5_bank_bus_dat_w[0];
assign lcd_start_re = ((csrbank5_sel & interface5_bank_bus_we) & (interface5_bank_bus_adr[2:0] == 2'd2));
assign csrbank5_active_r = interface5_bank_bus_dat_w[0];
assign csrbank5_active_re = ((csrbank5_sel & interface5_bank_bus_we) & (interface5_bank_bus_adr[2:0] == 2'd3));
assign csrbank5_pending_r = interface5_bank_bus_dat_w[0];
assign csrbank5_pending_re = ((csrbank5_sel & interface5_bank_bus_we) & (interface5_bank_bus_adr[2:0] == 3'd4));
assign csrbank5_mosi_data0_r = interface5_bank_bus_dat_w[31:0];
assign csrbank5_mosi_data0_re = ((csrbank5_sel & interface5_bank_bus_we) & (interface5_bank_bus_adr[2:0] == 3'd5));
assign csrbank5_miso_data_r = interface5_bank_bus_dat_w[31:0];
assign csrbank5_miso_data_re = ((csrbank5_sel & interface5_bank_bus_we) & (interface5_bank_bus_adr[2:0] == 3'd6));
assign lcd_config_storage = lcd_config_storage_full[31:0];
assign csrbank5_config0_w = lcd_config_storage_full[31:0];
assign lcd_xfer_storage = lcd_xfer_storage_full[31:0];
assign csrbank5_xfer0_w = lcd_xfer_storage_full[31:0];
assign csrbank5_active_w = lcd_active_status;
assign csrbank5_pending_w = lcd_pending_status;
assign lcd_mosi_data_storage = lcd_mosi_data_storage_full[31:0];
assign csrbank5_mosi_data0_w = lcd_mosi_data_storage_full[31:0];
assign csrbank5_miso_data_w = lcd_miso_data_status[31:0];
assign csrbank6_sel = (interface6_bank_bus_adr[13:9] == 4'd13);
assign csrbank6_out0_r = interface6_bank_bus_dat_w[0];
assign csrbank6_out0_re = ((csrbank6_sel & interface6_bank_bus_we) & (interface6_bank_bus_adr[0] == 1'd0));
assign rs_storage = rs_storage_full;
assign csrbank6_out0_w = rs_storage_full;
assign csrbank7_sel = (interface7_bank_bus_adr[13:9] == 3'd5);
assign csrbank7_load0_r = interface7_bank_bus_dat_w[31:0];
assign csrbank7_load0_re = ((csrbank7_sel & interface7_bank_bus_we) & (interface7_bank_bus_adr[2:0] == 1'd0));
assign csrbank7_reload0_r = interface7_bank_bus_dat_w[31:0];
assign csrbank7_reload0_re = ((csrbank7_sel & interface7_bank_bus_we) & (interface7_bank_bus_adr[2:0] == 1'd1));
assign csrbank7_en0_r = interface7_bank_bus_dat_w[0];
assign csrbank7_en0_re = ((csrbank7_sel & interface7_bank_bus_we) & (interface7_bank_bus_adr[2:0] == 2'd2));
assign timer0_update_value_r = interface7_bank_bus_dat_w[0];
assign timer0_update_value_re = ((csrbank7_sel & interface7_bank_bus_we) & (interface7_bank_bus_adr[2:0] == 2'd3));
assign csrbank7_value_r = interface7_bank_bus_dat_w[31:0];
assign csrbank7_value_re = ((csrbank7_sel & interface7_bank_bus_we) & (interface7_bank_bus_adr[2:0] == 3'd4));
assign timer0_eventmanager_status_r = interface7_bank_bus_dat_w[0];
assign timer0_eventmanager_status_re = ((csrbank7_sel & interface7_bank_bus_we) & (interface7_bank_bus_adr[2:0] == 3'd5));
assign timer0_eventmanager_pending_r = interface7_bank_bus_dat_w[0];
assign timer0_eventmanager_pending_re = ((csrbank7_sel & interface7_bank_bus_we) & (interface7_bank_bus_adr[2:0] == 3'd6));
assign csrbank7_ev_enable0_r = interface7_bank_bus_dat_w[0];
assign csrbank7_ev_enable0_re = ((csrbank7_sel & interface7_bank_bus_we) & (interface7_bank_bus_adr[2:0] == 3'd7));
assign timer0_load_storage = timer0_load_storage_full[31:0];
assign csrbank7_load0_w = timer0_load_storage_full[31:0];
assign timer0_reload_storage = timer0_reload_storage_full[31:0];
assign csrbank7_reload0_w = timer0_reload_storage_full[31:0];
assign timer0_en_storage = timer0_en_storage_full;
assign csrbank7_en0_w = timer0_en_storage_full;
assign csrbank7_value_w = timer0_value_status[31:0];
assign timer0_eventmanager_storage = timer0_eventmanager_storage_full;
assign csrbank7_ev_enable0_w = timer0_eventmanager_storage_full;
assign csrbank8_sel = (interface8_bank_bus_adr[13:9] == 2'd3);
assign uart_rxtx_r = interface8_bank_bus_dat_w[7:0];
assign uart_rxtx_re = ((csrbank8_sel & interface8_bank_bus_we) & (interface8_bank_bus_adr[2:0] == 1'd0));
assign csrbank8_txfull_r = interface8_bank_bus_dat_w[0];
assign csrbank8_txfull_re = ((csrbank8_sel & interface8_bank_bus_we) & (interface8_bank_bus_adr[2:0] == 1'd1));
assign csrbank8_rxempty_r = interface8_bank_bus_dat_w[0];
assign csrbank8_rxempty_re = ((csrbank8_sel & interface8_bank_bus_we) & (interface8_bank_bus_adr[2:0] == 2'd2));
assign uart_eventmanager_status_r = interface8_bank_bus_dat_w[1:0];
assign uart_eventmanager_status_re = ((csrbank8_sel & interface8_bank_bus_we) & (interface8_bank_bus_adr[2:0] == 2'd3));
assign uart_eventmanager_pending_r = interface8_bank_bus_dat_w[1:0];
assign uart_eventmanager_pending_re = ((csrbank8_sel & interface8_bank_bus_we) & (interface8_bank_bus_adr[2:0] == 3'd4));
assign csrbank8_ev_enable0_r = interface8_bank_bus_dat_w[1:0];
assign csrbank8_ev_enable0_re = ((csrbank8_sel & interface8_bank_bus_we) & (interface8_bank_bus_adr[2:0] == 3'd5));
assign csrbank8_txfull_w = uart_txfull_status;
assign csrbank8_rxempty_w = uart_rxempty_status;
assign uart_eventmanager_storage = uart_eventmanager_storage_full[1:0];
assign csrbank8_ev_enable0_w = uart_eventmanager_storage_full[1:0];
assign csrbank9_sel = (interface9_bank_bus_adr[13:9] == 2'd2);
assign csrbank9_tuning_word0_r = interface9_bank_bus_dat_w[31:0];
assign csrbank9_tuning_word0_re = ((csrbank9_sel & interface9_bank_bus_we) & (interface9_bank_bus_adr[0] == 1'd0));
assign uart_phy_storage = uart_phy_storage_full[31:0];
assign csrbank9_tuning_word0_w = uart_phy_storage_full[31:0];
assign interface0_bank_bus_adr = interface_adr;
assign interface1_bank_bus_adr = interface_adr;
assign interface2_bank_bus_adr = interface_adr;
assign interface3_bank_bus_adr = interface_adr;
assign interface4_bank_bus_adr = interface_adr;
assign interface5_bank_bus_adr = interface_adr;
assign interface6_bank_bus_adr = interface_adr;
assign interface7_bank_bus_adr = interface_adr;
assign interface8_bank_bus_adr = interface_adr;
assign interface9_bank_bus_adr = interface_adr;
assign sram_bus_adr1 = interface_adr;
assign interface0_bank_bus_we = interface_we;
assign interface1_bank_bus_we = interface_we;
assign interface2_bank_bus_we = interface_we;
assign interface3_bank_bus_we = interface_we;
assign interface4_bank_bus_we = interface_we;
assign interface5_bank_bus_we = interface_we;
assign interface6_bank_bus_we = interface_we;
assign interface7_bank_bus_we = interface_we;
assign interface8_bank_bus_we = interface_we;
assign interface9_bank_bus_we = interface_we;
assign sram_bus_we1 = interface_we;
assign interface0_bank_bus_dat_w = interface_dat_w;
assign interface1_bank_bus_dat_w = interface_dat_w;
assign interface2_bank_bus_dat_w = interface_dat_w;
assign interface3_bank_bus_dat_w = interface_dat_w;
assign interface4_bank_bus_dat_w = interface_dat_w;
assign interface5_bank_bus_dat_w = interface_dat_w;
assign interface6_bank_bus_dat_w = interface_dat_w;
assign interface7_bank_bus_dat_w = interface_dat_w;
assign interface8_bank_bus_dat_w = interface_dat_w;
assign interface9_bank_bus_dat_w = interface_dat_w;
assign sram_bus_dat_w1 = interface_dat_w;
assign interface_dat_r = ((((((((((interface0_bank_bus_dat_r | interface1_bank_bus_dat_r) | interface2_bank_bus_dat_r) | interface3_bank_bus_dat_r) | interface4_bank_bus_dat_r) | interface5_bank_bus_dat_r) | interface6_bank_bus_dat_r) | interface7_bank_bus_dat_r) | interface8_bank_bus_dat_r) | interface9_bank_bus_dat_r) | sram_bus_dat_r1);
assign slice_proxy0 = {user_btn4, user_btn3, user_btn2, user_btn1, user_btn0};
assign slice_proxy1 = {user_btn4, user_btn3, user_btn2, user_btn1, user_btn0};
assign slice_proxy2 = {user_btn4, user_btn3, user_btn2, user_btn1, user_btn0};
assign slice_proxy3 = {user_btn4, user_btn3, user_btn2, user_btn1, user_btn0};
assign slice_proxy4 = {user_btn4, user_btn3, user_btn2, user_btn1, user_btn0};
always @(*) begin
	array_muxed0 <= 30'd0;
	case (grant)
		1'd0: begin
			array_muxed0 <= lm32_ibus_adr;
		end
		default: begin
			array_muxed0 <= lm32_dbus_adr;
		end
	endcase
end
always @(*) begin
	array_muxed1 <= 32'd0;
	case (grant)
		1'd0: begin
			array_muxed1 <= lm32_ibus_dat_w;
		end
		default: begin
			array_muxed1 <= lm32_dbus_dat_w;
		end
	endcase
end
always @(*) begin
	array_muxed2 <= 4'd0;
	case (grant)
		1'd0: begin
			array_muxed2 <= lm32_ibus_sel;
		end
		default: begin
			array_muxed2 <= lm32_dbus_sel;
		end
	endcase
end
always @(*) begin
	array_muxed3 <= 1'd0;
	case (grant)
		1'd0: begin
			array_muxed3 <= lm32_ibus_cyc;
		end
		default: begin
			array_muxed3 <= lm32_dbus_cyc;
		end
	endcase
end
always @(*) begin
	array_muxed4 <= 1'd0;
	case (grant)
		1'd0: begin
			array_muxed4 <= lm32_ibus_stb;
		end
		default: begin
			array_muxed4 <= lm32_dbus_stb;
		end
	endcase
end
always @(*) begin
	array_muxed5 <= 1'd0;
	case (grant)
		1'd0: begin
			array_muxed5 <= lm32_ibus_we;
		end
		default: begin
			array_muxed5 <= lm32_dbus_we;
		end
	endcase
end
always @(*) begin
	array_muxed6 <= 3'd0;
	case (grant)
		1'd0: begin
			array_muxed6 <= lm32_ibus_cti;
		end
		default: begin
			array_muxed6 <= lm32_dbus_cti;
		end
	endcase
end
always @(*) begin
	array_muxed7 <= 2'd0;
	case (grant)
		1'd0: begin
			array_muxed7 <= lm32_ibus_bte;
		end
		default: begin
			array_muxed7 <= lm32_dbus_bte;
		end
	endcase
end
assign uart_phy_rx = xilinxmultiregimpl0_regs1;
assign in_status = xilinxmultiregimpl1_regs1;
assign xilinxmultiregimpl1 = {user_btn4, user_btn3, user_btn2, user_btn1, user_btn0};

always @(posedge por_clk) begin
	int_rst <= (~cpu_reset);
end

always @(posedge sys_clk) begin
	if ((ctrl_bus_errors != 32'd4294967295)) begin
		if (ctrl_bus_error) begin
			ctrl_bus_errors <= (ctrl_bus_errors + 1'd1);
		end
	end
	rom_bus_ack <= 1'd0;
	if (((rom_bus_cyc & rom_bus_stb) & (~rom_bus_ack))) begin
		rom_bus_ack <= 1'd1;
	end
	sram_bus_ack <= 1'd0;
	if (((sram_bus_cyc & sram_bus_stb) & (~sram_bus_ack))) begin
		sram_bus_ack <= 1'd1;
	end
	main_ram_bus_ack <= 1'd0;
	if (((main_ram_bus_cyc & main_ram_bus_stb) & (~main_ram_bus_ack))) begin
		main_ram_bus_ack <= 1'd1;
	end
	interface_we <= 1'd0;
	interface_dat_w <= bus_wishbone_dat_w;
	interface_adr <= bus_wishbone_adr;
	bus_wishbone_dat_r <= interface_dat_r;
	if ((counter == 1'd1)) begin
		interface_we <= bus_wishbone_we;
	end
	if ((counter == 2'd2)) begin
		bus_wishbone_ack <= 1'd1;
	end
	if ((counter == 2'd3)) begin
		bus_wishbone_ack <= 1'd0;
	end
	if ((counter != 1'd0)) begin
		counter <= (counter + 1'd1);
	end else begin
		if ((bus_wishbone_cyc & bus_wishbone_stb)) begin
			counter <= 1'd1;
		end
	end
	uart_phy_sink_ready <= 1'd0;
	if (((uart_phy_sink_valid & (~uart_phy_tx_busy)) & (~uart_phy_sink_ready))) begin
		uart_phy_tx_reg <= uart_phy_sink_payload_data;
		uart_phy_tx_bitcount <= 1'd0;
		uart_phy_tx_busy <= 1'd1;
		serial_tx <= 1'd0;
	end else begin
		if ((uart_phy_uart_clk_txen & uart_phy_tx_busy)) begin
			uart_phy_tx_bitcount <= (uart_phy_tx_bitcount + 1'd1);
			if ((uart_phy_tx_bitcount == 4'd8)) begin
				serial_tx <= 1'd1;
			end else begin
				if ((uart_phy_tx_bitcount == 4'd9)) begin
					serial_tx <= 1'd1;
					uart_phy_tx_busy <= 1'd0;
					uart_phy_sink_ready <= 1'd1;
				end else begin
					serial_tx <= uart_phy_tx_reg[0];
					uart_phy_tx_reg <= {1'd0, uart_phy_tx_reg[7:1]};
				end
			end
		end
	end
	if (uart_phy_tx_busy) begin
		{uart_phy_uart_clk_txen, uart_phy_phase_accumulator_tx} <= (uart_phy_phase_accumulator_tx + uart_phy_storage);
	end else begin
		{uart_phy_uart_clk_txen, uart_phy_phase_accumulator_tx} <= 1'd0;
	end
	uart_phy_source_valid <= 1'd0;
	uart_phy_rx_r <= uart_phy_rx;
	if ((~uart_phy_rx_busy)) begin
		if (((~uart_phy_rx) & uart_phy_rx_r)) begin
			uart_phy_rx_busy <= 1'd1;
			uart_phy_rx_bitcount <= 1'd0;
		end
	end else begin
		if (uart_phy_uart_clk_rxen) begin
			uart_phy_rx_bitcount <= (uart_phy_rx_bitcount + 1'd1);
			if ((uart_phy_rx_bitcount == 1'd0)) begin
				if (uart_phy_rx) begin
					uart_phy_rx_busy <= 1'd0;
				end
			end else begin
				if ((uart_phy_rx_bitcount == 4'd9)) begin
					uart_phy_rx_busy <= 1'd0;
					if (uart_phy_rx) begin
						uart_phy_source_payload_data <= uart_phy_rx_reg;
						uart_phy_source_valid <= 1'd1;
					end
				end else begin
					uart_phy_rx_reg <= {uart_phy_rx, uart_phy_rx_reg[7:1]};
				end
			end
		end
	end
	if (uart_phy_rx_busy) begin
		{uart_phy_uart_clk_rxen, uart_phy_phase_accumulator_rx} <= (uart_phy_phase_accumulator_rx + uart_phy_storage);
	end else begin
		{uart_phy_uart_clk_rxen, uart_phy_phase_accumulator_rx} <= 32'd2147483648;
	end
	if (uart_tx_clear) begin
		uart_tx_pending <= 1'd0;
	end
	uart_tx_old_trigger <= uart_tx_trigger;
	if (((~uart_tx_trigger) & uart_tx_old_trigger)) begin
		uart_tx_pending <= 1'd1;
	end
	if (uart_rx_clear) begin
		uart_rx_pending <= 1'd0;
	end
	uart_rx_old_trigger <= uart_rx_trigger;
	if (((~uart_rx_trigger) & uart_rx_old_trigger)) begin
		uart_rx_pending <= 1'd1;
	end
	if (uart_tx_fifo_syncfifo_re) begin
		uart_tx_fifo_readable <= 1'd1;
	end else begin
		if (uart_tx_fifo_re) begin
			uart_tx_fifo_readable <= 1'd0;
		end
	end
	if (((uart_tx_fifo_syncfifo_we & uart_tx_fifo_syncfifo_writable) & (~uart_tx_fifo_replace))) begin
		uart_tx_fifo_produce <= (uart_tx_fifo_produce + 1'd1);
	end
	if (uart_tx_fifo_do_read) begin
		uart_tx_fifo_consume <= (uart_tx_fifo_consume + 1'd1);
	end
	if (((uart_tx_fifo_syncfifo_we & uart_tx_fifo_syncfifo_writable) & (~uart_tx_fifo_replace))) begin
		if ((~uart_tx_fifo_do_read)) begin
			uart_tx_fifo_level0 <= (uart_tx_fifo_level0 + 1'd1);
		end
	end else begin
		if (uart_tx_fifo_do_read) begin
			uart_tx_fifo_level0 <= (uart_tx_fifo_level0 - 1'd1);
		end
	end
	if (uart_rx_fifo_syncfifo_re) begin
		uart_rx_fifo_readable <= 1'd1;
	end else begin
		if (uart_rx_fifo_re) begin
			uart_rx_fifo_readable <= 1'd0;
		end
	end
	if (((uart_rx_fifo_syncfifo_we & uart_rx_fifo_syncfifo_writable) & (~uart_rx_fifo_replace))) begin
		uart_rx_fifo_produce <= (uart_rx_fifo_produce + 1'd1);
	end
	if (uart_rx_fifo_do_read) begin
		uart_rx_fifo_consume <= (uart_rx_fifo_consume + 1'd1);
	end
	if (((uart_rx_fifo_syncfifo_we & uart_rx_fifo_syncfifo_writable) & (~uart_rx_fifo_replace))) begin
		if ((~uart_rx_fifo_do_read)) begin
			uart_rx_fifo_level0 <= (uart_rx_fifo_level0 + 1'd1);
		end
	end else begin
		if (uart_rx_fifo_do_read) begin
			uart_rx_fifo_level0 <= (uart_rx_fifo_level0 - 1'd1);
		end
	end
	if (uart_reset) begin
		uart_tx_pending <= 1'd0;
		uart_tx_old_trigger <= 1'd0;
		uart_rx_pending <= 1'd0;
		uart_rx_old_trigger <= 1'd0;
		uart_tx_fifo_readable <= 1'd0;
		uart_tx_fifo_level0 <= 5'd0;
		uart_tx_fifo_produce <= 4'd0;
		uart_tx_fifo_consume <= 4'd0;
		uart_rx_fifo_readable <= 1'd0;
		uart_rx_fifo_level0 <= 5'd0;
		uart_rx_fifo_produce <= 4'd0;
		uart_rx_fifo_consume <= 4'd0;
	end
	if (timer0_en_storage) begin
		if ((timer0_value == 1'd0)) begin
			timer0_value <= timer0_reload_storage;
		end else begin
			timer0_value <= (timer0_value - 1'd1);
		end
	end else begin
		timer0_value <= timer0_load_storage;
	end
	if (timer0_update_value_re) begin
		timer0_value_status <= timer0_value;
	end
	if (timer0_zero_clear) begin
		timer0_zero_pending <= 1'd0;
	end
	timer0_zero_old_trigger <= timer0_zero_trigger;
	if (((~timer0_zero_trigger) & timer0_zero_old_trigger)) begin
		timer0_zero_pending <= 1'd1;
	end
	if ((cnt < 7'd114)) begin
		cnt <= (cnt + 1'd1);
		if (cnt[0]) begin
			status <= {status, do_1};
		end
	end
	if (one_clear) begin
		one_pending <= 1'd0;
	end
	one_old_trigger <= one_trigger;
	if (((~one_trigger) & one_old_trigger)) begin
		one_pending <= 1'd1;
	end
	if (zero_clear) begin
		zero_pending <= 1'd0;
	end
	zero_old_trigger <= zero_trigger;
	if (((~zero_trigger) & zero_old_trigger)) begin
		zero_pending <= 1'd1;
	end
	if (two_clear) begin
		two_pending <= 1'd0;
	end
	two_old_trigger <= two_trigger;
	if (((~two_trigger) & two_old_trigger)) begin
		two_pending <= 1'd1;
	end
	if (three_clear) begin
		three_pending <= 1'd0;
	end
	three_old_trigger <= three_trigger;
	if (((~three_trigger) & three_old_trigger)) begin
		three_pending <= 1'd1;
	end
	if (four_clear) begin
		four_pending <= 1'd0;
	end
	four_old_trigger <= four_trigger;
	if (((~four_trigger) & four_old_trigger)) begin
		four_pending <= 1'd1;
	end
	if (SD_machine_done1) begin
		SD_data_read <= SD_machine_data;
	end
	if (SD_machine_start) begin
		SD_cs <= SD_xfer_cs;
		SD_machine_n_write <= SD_xfer_write_length;
		SD_machine_n_read <= SD_xfer_read_length;
		SD_machine_data <= SD_data_write;
		SD_pending1 <= 1'd0;
	end
	if (SD_start) begin
		SD_data_write <= SD_mosi_data;
		SD_pending1 <= 1'd1;
	end
	SD_active <= SD_machine_cs;
	SD_pending0 <= SD_pending1;
	if ((SD_machine_edge & SD_machine_shift)) begin
		SD_machine_write0 <= SD_machine_write;
	end
	if (SD_machine_cg_ce) begin
		if (SD_machine_zero) begin
			SD_machine_bias1 <= 1'd0;
		end else begin
			SD_machine_cnt <= (SD_machine_cnt - 1'd1);
		end
		if (SD_machine_edge) begin
			SD_machine_cnt <= SD_machine_load[7:1];
			SD_machine_bias1 <= (SD_machine_load[0] & (SD_machine_clk ^ SD_machine_bias0));
			SD_machine_clk <= (~SD_machine_clk);
		end
	end
	if (SD_machine_reg_ce) begin
		if (SD_machine_lsb) begin
			if (SD_machine_shift) begin
				SD_machine_data[30:0] <= SD_machine_data[31:1];
			end
			if (SD_machine_sample) begin
				SD_machine_data[0] <= SD_machine_i;
			end
		end else begin
			if (SD_machine_shift) begin
				SD_machine_data[31:1] <= SD_machine_data[30:0];
			end
			if (SD_machine_sample) begin
				SD_machine_data[0] <= SD_machine_i;
			end
		end
	end
	if (SD_machine_bits_ce) begin
		if (SD_machine_write) begin
			SD_machine_n_write <= (SD_machine_n_write - 1'd1);
		end else begin
			if (SD_machine_read) begin
				SD_machine_n_read <= (SD_machine_n_read - 1'd1);
			end
		end
	end
	if (SD_machine_fsm_ce) begin
		spimaster0_state <= spimaster0_next_state;
	end
	if (lcd_machine_done1) begin
		lcd_data_read <= lcd_machine_data;
	end
	if (lcd_machine_start) begin
		lcd_cs <= lcd_xfer_cs;
		lcd_machine_n_write <= lcd_xfer_write_length;
		lcd_machine_n_read <= lcd_xfer_read_length;
		lcd_machine_data <= lcd_data_write;
		lcd_pending1 <= 1'd0;
	end
	if (lcd_start) begin
		lcd_data_write <= lcd_mosi_data;
		lcd_pending1 <= 1'd1;
	end
	lcd_active <= lcd_machine_cs;
	lcd_pending0 <= lcd_pending1;
	if ((lcd_machine_edge & lcd_machine_shift)) begin
		lcd_machine_write0 <= lcd_machine_write;
	end
	if (lcd_machine_cg_ce) begin
		if (lcd_machine_zero) begin
			lcd_machine_bias1 <= 1'd0;
		end else begin
			lcd_machine_cnt <= (lcd_machine_cnt - 1'd1);
		end
		if (lcd_machine_edge) begin
			lcd_machine_cnt <= lcd_machine_load[7:1];
			lcd_machine_bias1 <= (lcd_machine_load[0] & (lcd_machine_clk ^ lcd_machine_bias0));
			lcd_machine_clk <= (~lcd_machine_clk);
		end
	end
	if (lcd_machine_reg_ce) begin
		if (lcd_machine_lsb) begin
			if (lcd_machine_shift) begin
				lcd_machine_data[30:0] <= lcd_machine_data[31:1];
			end
			if (lcd_machine_sample) begin
				lcd_machine_data[0] <= lcd_machine_i;
			end
		end else begin
			if (lcd_machine_shift) begin
				lcd_machine_data[31:1] <= lcd_machine_data[30:0];
			end
			if (lcd_machine_sample) begin
				lcd_machine_data[0] <= lcd_machine_i;
			end
		end
	end
	if (lcd_machine_bits_ce) begin
		if (lcd_machine_write) begin
			lcd_machine_n_write <= (lcd_machine_n_write - 1'd1);
		end else begin
			if (lcd_machine_read) begin
				lcd_machine_n_read <= (lcd_machine_n_read - 1'd1);
			end
		end
	end
	if (lcd_machine_fsm_ce) begin
		spimaster1_state <= spimaster1_next_state;
	end
	case (grant)
		1'd0: begin
			if ((~request[0])) begin
				if (request[1]) begin
					grant <= 1'd1;
				end
			end
		end
		1'd1: begin
			if ((~request[1])) begin
				if (request[0]) begin
					grant <= 1'd0;
				end
			end
		end
	endcase
	slave_sel_r <= slave_sel;
	if (wait_1) begin
		if ((~done)) begin
			count <= (count - 1'd1);
		end
	end else begin
		count <= 20'd1000000;
	end
	interface0_bank_bus_dat_r <= 1'd0;
	if (csrbank0_sel) begin
		case (interface0_bank_bus_adr[0])
			1'd0: begin
				interface0_bank_bus_dat_r <= csrbank0_out0_w;
			end
		endcase
	end
	if (csrbank0_out0_re) begin
		GPO_storage_full <= csrbank0_out0_r;
	end
	GPO_re <= csrbank0_out0_re;
	interface1_bank_bus_dat_r <= 1'd0;
	if (csrbank1_sel) begin
		case (interface1_bank_bus_adr[2:0])
			1'd0: begin
				interface1_bank_bus_dat_r <= csrbank1_config0_w;
			end
			1'd1: begin
				interface1_bank_bus_dat_r <= csrbank1_xfer0_w;
			end
			2'd2: begin
				interface1_bank_bus_dat_r <= SD_start_w;
			end
			2'd3: begin
				interface1_bank_bus_dat_r <= csrbank1_active_w;
			end
			3'd4: begin
				interface1_bank_bus_dat_r <= csrbank1_pending_w;
			end
			3'd5: begin
				interface1_bank_bus_dat_r <= csrbank1_mosi_data0_w;
			end
			3'd6: begin
				interface1_bank_bus_dat_r <= csrbank1_miso_data_w;
			end
		endcase
	end
	if (csrbank1_config0_re) begin
		SD_config_storage_full[31:0] <= csrbank1_config0_r;
	end
	SD_config_re <= csrbank1_config0_re;
	if (csrbank1_xfer0_re) begin
		SD_xfer_storage_full[31:0] <= csrbank1_xfer0_r;
	end
	SD_xfer_re <= csrbank1_xfer0_re;
	if (csrbank1_mosi_data0_re) begin
		SD_mosi_data_storage_full[31:0] <= csrbank1_mosi_data0_r;
	end
	SD_mosi_data_re <= csrbank1_mosi_data0_re;
	interface2_bank_bus_dat_r <= 1'd0;
	if (csrbank2_sel) begin
		case (interface2_bank_bus_adr[2:0])
			1'd0: begin
				interface2_bank_bus_dat_r <= csrbank2_in_w;
			end
			1'd1: begin
				interface2_bank_bus_dat_r <= csrbank2_dir_w;
			end
			2'd2: begin
				interface2_bank_bus_dat_r <= status_w;
			end
			2'd3: begin
				interface2_bank_bus_dat_r <= pending_w;
			end
			3'd4: begin
				interface2_bank_bus_dat_r <= csrbank2_ev_enable0_w;
			end
		endcase
	end
	if (csrbank2_ev_enable0_re) begin
		storage_full[4:0] <= csrbank2_ev_enable0_r;
	end
	re <= csrbank2_ev_enable0_re;
	interface3_bank_bus_dat_r <= 1'd0;
	if (csrbank3_sel) begin
		case (interface3_bank_bus_adr[1:0])
			1'd0: begin
				interface3_bank_bus_dat_r <= ctrl_reset_reset_w;
			end
			1'd1: begin
				interface3_bank_bus_dat_r <= csrbank3_scratch0_w;
			end
			2'd2: begin
				interface3_bank_bus_dat_r <= csrbank3_bus_errors_w;
			end
		endcase
	end
	if (csrbank3_scratch0_re) begin
		ctrl_storage_full[31:0] <= csrbank3_scratch0_r;
	end
	ctrl_re <= csrbank3_scratch0_re;
	interface4_bank_bus_dat_r <= 1'd0;
	if (csrbank4_sel) begin
		case (interface4_bank_bus_adr[0])
			1'd0: begin
				interface4_bank_bus_dat_r <= csrbank4_id1_w;
			end
			1'd1: begin
				interface4_bank_bus_dat_r <= csrbank4_id0_w;
			end
		endcase
	end
	sel_r <= sel;
	interface5_bank_bus_dat_r <= 1'd0;
	if (csrbank5_sel) begin
		case (interface5_bank_bus_adr[2:0])
			1'd0: begin
				interface5_bank_bus_dat_r <= csrbank5_config0_w;
			end
			1'd1: begin
				interface5_bank_bus_dat_r <= csrbank5_xfer0_w;
			end
			2'd2: begin
				interface5_bank_bus_dat_r <= lcd_start_w;
			end
			2'd3: begin
				interface5_bank_bus_dat_r <= csrbank5_active_w;
			end
			3'd4: begin
				interface5_bank_bus_dat_r <= csrbank5_pending_w;
			end
			3'd5: begin
				interface5_bank_bus_dat_r <= csrbank5_mosi_data0_w;
			end
			3'd6: begin
				interface5_bank_bus_dat_r <= csrbank5_miso_data_w;
			end
		endcase
	end
	if (csrbank5_config0_re) begin
		lcd_config_storage_full[31:0] <= csrbank5_config0_r;
	end
	lcd_config_re <= csrbank5_config0_re;
	if (csrbank5_xfer0_re) begin
		lcd_xfer_storage_full[31:0] <= csrbank5_xfer0_r;
	end
	lcd_xfer_re <= csrbank5_xfer0_re;
	if (csrbank5_mosi_data0_re) begin
		lcd_mosi_data_storage_full[31:0] <= csrbank5_mosi_data0_r;
	end
	lcd_mosi_data_re <= csrbank5_mosi_data0_re;
	interface6_bank_bus_dat_r <= 1'd0;
	if (csrbank6_sel) begin
		case (interface6_bank_bus_adr[0])
			1'd0: begin
				interface6_bank_bus_dat_r <= csrbank6_out0_w;
			end
		endcase
	end
	if (csrbank6_out0_re) begin
		rs_storage_full <= csrbank6_out0_r;
	end
	rs_re <= csrbank6_out0_re;
	interface7_bank_bus_dat_r <= 1'd0;
	if (csrbank7_sel) begin
		case (interface7_bank_bus_adr[2:0])
			1'd0: begin
				interface7_bank_bus_dat_r <= csrbank7_load0_w;
			end
			1'd1: begin
				interface7_bank_bus_dat_r <= csrbank7_reload0_w;
			end
			2'd2: begin
				interface7_bank_bus_dat_r <= csrbank7_en0_w;
			end
			2'd3: begin
				interface7_bank_bus_dat_r <= timer0_update_value_w;
			end
			3'd4: begin
				interface7_bank_bus_dat_r <= csrbank7_value_w;
			end
			3'd5: begin
				interface7_bank_bus_dat_r <= timer0_eventmanager_status_w;
			end
			3'd6: begin
				interface7_bank_bus_dat_r <= timer0_eventmanager_pending_w;
			end
			3'd7: begin
				interface7_bank_bus_dat_r <= csrbank7_ev_enable0_w;
			end
		endcase
	end
	if (csrbank7_load0_re) begin
		timer0_load_storage_full[31:0] <= csrbank7_load0_r;
	end
	timer0_load_re <= csrbank7_load0_re;
	if (csrbank7_reload0_re) begin
		timer0_reload_storage_full[31:0] <= csrbank7_reload0_r;
	end
	timer0_reload_re <= csrbank7_reload0_re;
	if (csrbank7_en0_re) begin
		timer0_en_storage_full <= csrbank7_en0_r;
	end
	timer0_en_re <= csrbank7_en0_re;
	if (csrbank7_ev_enable0_re) begin
		timer0_eventmanager_storage_full <= csrbank7_ev_enable0_r;
	end
	timer0_eventmanager_re <= csrbank7_ev_enable0_re;
	interface8_bank_bus_dat_r <= 1'd0;
	if (csrbank8_sel) begin
		case (interface8_bank_bus_adr[2:0])
			1'd0: begin
				interface8_bank_bus_dat_r <= uart_rxtx_w;
			end
			1'd1: begin
				interface8_bank_bus_dat_r <= csrbank8_txfull_w;
			end
			2'd2: begin
				interface8_bank_bus_dat_r <= csrbank8_rxempty_w;
			end
			2'd3: begin
				interface8_bank_bus_dat_r <= uart_eventmanager_status_w;
			end
			3'd4: begin
				interface8_bank_bus_dat_r <= uart_eventmanager_pending_w;
			end
			3'd5: begin
				interface8_bank_bus_dat_r <= csrbank8_ev_enable0_w;
			end
		endcase
	end
	if (csrbank8_ev_enable0_re) begin
		uart_eventmanager_storage_full[1:0] <= csrbank8_ev_enable0_r;
	end
	uart_eventmanager_re <= csrbank8_ev_enable0_re;
	interface9_bank_bus_dat_r <= 1'd0;
	if (csrbank9_sel) begin
		case (interface9_bank_bus_adr[0])
			1'd0: begin
				interface9_bank_bus_dat_r <= csrbank9_tuning_word0_w;
			end
		endcase
	end
	if (csrbank9_tuning_word0_re) begin
		uart_phy_storage_full[31:0] <= csrbank9_tuning_word0_r;
	end
	uart_phy_re <= csrbank9_tuning_word0_re;
	if (sys_rst) begin
		ctrl_storage_full <= 32'd305419896;
		ctrl_re <= 1'd0;
		ctrl_bus_errors <= 32'd0;
		rom_bus_ack <= 1'd0;
		sram_bus_ack <= 1'd0;
		main_ram_bus_ack <= 1'd0;
		interface_adr <= 14'd0;
		interface_we <= 1'd0;
		interface_dat_w <= 32'd0;
		bus_wishbone_dat_r <= 32'd0;
		bus_wishbone_ack <= 1'd0;
		counter <= 2'd0;
		serial_tx <= 1'd1;
		uart_phy_storage_full <= 32'd4947802;
		uart_phy_re <= 1'd0;
		uart_phy_sink_ready <= 1'd0;
		uart_phy_uart_clk_txen <= 1'd0;
		uart_phy_phase_accumulator_tx <= 32'd0;
		uart_phy_tx_reg <= 8'd0;
		uart_phy_tx_bitcount <= 4'd0;
		uart_phy_tx_busy <= 1'd0;
		uart_phy_source_valid <= 1'd0;
		uart_phy_source_payload_data <= 8'd0;
		uart_phy_uart_clk_rxen <= 1'd0;
		uart_phy_phase_accumulator_rx <= 32'd0;
		uart_phy_rx_r <= 1'd0;
		uart_phy_rx_reg <= 8'd0;
		uart_phy_rx_bitcount <= 4'd0;
		uart_phy_rx_busy <= 1'd0;
		uart_tx_pending <= 1'd0;
		uart_tx_old_trigger <= 1'd0;
		uart_rx_pending <= 1'd0;
		uart_rx_old_trigger <= 1'd0;
		uart_eventmanager_storage_full <= 2'd0;
		uart_eventmanager_re <= 1'd0;
		uart_tx_fifo_readable <= 1'd0;
		uart_tx_fifo_level0 <= 5'd0;
		uart_tx_fifo_produce <= 4'd0;
		uart_tx_fifo_consume <= 4'd0;
		uart_rx_fifo_readable <= 1'd0;
		uart_rx_fifo_level0 <= 5'd0;
		uart_rx_fifo_produce <= 4'd0;
		uart_rx_fifo_consume <= 4'd0;
		timer0_load_storage_full <= 32'd0;
		timer0_load_re <= 1'd0;
		timer0_reload_storage_full <= 32'd0;
		timer0_reload_re <= 1'd0;
		timer0_en_storage_full <= 1'd0;
		timer0_en_re <= 1'd0;
		timer0_value_status <= 32'd0;
		timer0_zero_pending <= 1'd0;
		timer0_zero_old_trigger <= 1'd0;
		timer0_eventmanager_storage_full <= 1'd0;
		timer0_eventmanager_re <= 1'd0;
		timer0_value <= 32'd0;
		status <= 57'd0;
		cnt <= 7'd0;
		rs_storage_full <= 1'd0;
		rs_re <= 1'd0;
		one_pending <= 1'd0;
		one_old_trigger <= 1'd0;
		zero_pending <= 1'd0;
		zero_old_trigger <= 1'd0;
		two_pending <= 1'd0;
		two_old_trigger <= 1'd0;
		three_pending <= 1'd0;
		three_old_trigger <= 1'd0;
		four_pending <= 1'd0;
		four_old_trigger <= 1'd0;
		GPO_storage_full <= 1'd0;
		GPO_re <= 1'd0;
		SD_active <= 1'd0;
		SD_pending0 <= 1'd0;
		SD_machine_clk <= 1'd1;
		SD_machine_cnt <= 8'd0;
		SD_machine_bias1 <= 1'd0;
		SD_machine_data <= 32'd0;
		SD_machine_n_read <= 6'd0;
		SD_machine_n_write <= 6'd0;
		SD_machine_write0 <= 1'd0;
		SD_pending1 <= 1'd0;
		SD_cs <= 16'd0;
		SD_data_read <= 32'd0;
		SD_data_write <= 32'd0;
		SD_config_storage_full <= 32'd0;
		SD_config_re <= 1'd0;
		SD_xfer_storage_full <= 32'd0;
		SD_xfer_re <= 1'd0;
		SD_mosi_data_storage_full <= 32'd0;
		SD_mosi_data_re <= 1'd0;
		lcd_active <= 1'd0;
		lcd_pending0 <= 1'd0;
		lcd_machine_clk <= 1'd1;
		lcd_machine_cnt <= 8'd0;
		lcd_machine_bias1 <= 1'd0;
		lcd_machine_data <= 32'd0;
		lcd_machine_n_read <= 6'd0;
		lcd_machine_n_write <= 6'd0;
		lcd_machine_write0 <= 1'd0;
		lcd_pending1 <= 1'd0;
		lcd_cs <= 16'd0;
		lcd_data_read <= 32'd0;
		lcd_data_write <= 32'd0;
		lcd_config_storage_full <= 32'd0;
		lcd_config_re <= 1'd0;
		lcd_xfer_storage_full <= 32'd0;
		lcd_xfer_re <= 1'd0;
		lcd_mosi_data_storage_full <= 32'd0;
		lcd_mosi_data_re <= 1'd0;
		storage_full <= 5'd0;
		re <= 1'd0;
		spimaster0_state <= 2'd0;
		spimaster1_state <= 2'd0;
		grant <= 1'd0;
		slave_sel_r <= 4'd0;
		count <= 20'd1000000;
		interface0_bank_bus_dat_r <= 32'd0;
		interface1_bank_bus_dat_r <= 32'd0;
		interface2_bank_bus_dat_r <= 32'd0;
		interface3_bank_bus_dat_r <= 32'd0;
		interface4_bank_bus_dat_r <= 32'd0;
		sel_r <= 1'd0;
		interface5_bank_bus_dat_r <= 32'd0;
		interface6_bank_bus_dat_r <= 32'd0;
		interface7_bank_bus_dat_r <= 32'd0;
		interface8_bank_bus_dat_r <= 32'd0;
		interface9_bank_bus_dat_r <= 32'd0;
	end
	xilinxmultiregimpl0_regs0 <= serial_rx;
	xilinxmultiregimpl0_regs1 <= xilinxmultiregimpl0_regs0;
	xilinxmultiregimpl1_regs0 <= {user_btn4, user_btn3, user_btn2, user_btn1, user_btn0};
	xilinxmultiregimpl1_regs1 <= xilinxmultiregimpl1_regs0;
end

lm32_cpu #(
	.eba_reset(32'h00000000)
) lm32_cpu (
	.D_ACK_I(lm32_dbus_ack),
	.D_DAT_I(lm32_dbus_dat_r),
	.D_ERR_I(lm32_dbus_err),
	.D_RTY_I(1'd0),
	.I_ACK_I(lm32_ibus_ack),
	.I_DAT_I(lm32_ibus_dat_r),
	.I_ERR_I(lm32_ibus_err),
	.I_RTY_I(1'd0),
	.clk_i(sys_clk),
	.interrupt(lm32_interrupt),
	.rst_i((sys_rst | lm32_reset)),
	.D_ADR_O(lm32_d_adr_o),
	.D_BTE_O(lm32_dbus_bte),
	.D_CTI_O(lm32_dbus_cti),
	.D_CYC_O(lm32_dbus_cyc),
	.D_DAT_O(lm32_dbus_dat_w),
	.D_SEL_O(lm32_dbus_sel),
	.D_STB_O(lm32_dbus_stb),
	.D_WE_O(lm32_dbus_we),
	.I_ADR_O(lm32_i_adr_o),
	.I_BTE_O(lm32_ibus_bte),
	.I_CTI_O(lm32_ibus_cti),
	.I_CYC_O(lm32_ibus_cyc),
	.I_DAT_O(lm32_ibus_dat_w),
	.I_SEL_O(lm32_ibus_sel),
	.I_STB_O(lm32_ibus_stb),
	.I_WE_O(lm32_ibus_we)
);

reg [31:0] mem[0:8191];
reg [12:0] memadr;
always @(posedge sys_clk) begin
	memadr <= rom_adr;
end

assign rom_dat_r = mem[memadr];

initial begin
	$readmemh("mem.init", mem);
end

reg [31:0] mem_1[0:1023];
reg [9:0] memadr_1;
always @(posedge sys_clk) begin
	if (sram_we[0])
		mem_1[sram_adr][7:0] <= sram_dat_w[7:0];
	if (sram_we[1])
		mem_1[sram_adr][15:8] <= sram_dat_w[15:8];
	if (sram_we[2])
		mem_1[sram_adr][23:16] <= sram_dat_w[23:16];
	if (sram_we[3])
		mem_1[sram_adr][31:24] <= sram_dat_w[31:24];
	memadr_1 <= sram_adr;
end

assign sram_dat_r = mem_1[memadr_1];

reg [31:0] mem_2[0:8959];
reg [13:0] memadr_2;
always @(posedge sys_clk) begin
	if (main_ram_we[0])
		mem_2[main_ram_adr][7:0] <= main_ram_dat_w[7:0];
	if (main_ram_we[1])
		mem_2[main_ram_adr][15:8] <= main_ram_dat_w[15:8];
	if (main_ram_we[2])
		mem_2[main_ram_adr][23:16] <= main_ram_dat_w[23:16];
	if (main_ram_we[3])
		mem_2[main_ram_adr][31:24] <= main_ram_dat_w[31:24];
	memadr_2 <= main_ram_adr;
end

assign main_ram_dat_r = mem_2[memadr_2];

initial begin
	$readmemh("mem_2.init", mem_2);
end

reg [9:0] storage_1[0:15];
reg [9:0] memdat;
reg [9:0] memdat_1;
always @(posedge sys_clk) begin
	if (uart_tx_fifo_wrport_we)
		storage_1[uart_tx_fifo_wrport_adr] <= uart_tx_fifo_wrport_dat_w;
	memdat <= storage_1[uart_tx_fifo_wrport_adr];
end

always @(posedge sys_clk) begin
	if (uart_tx_fifo_rdport_re)
		memdat_1 <= storage_1[uart_tx_fifo_rdport_adr];
end

assign uart_tx_fifo_wrport_dat_r = memdat;
assign uart_tx_fifo_rdport_dat_r = memdat_1;

reg [9:0] storage_2[0:15];
reg [9:0] memdat_2;
reg [9:0] memdat_3;
always @(posedge sys_clk) begin
	if (uart_rx_fifo_wrport_we)
		storage_2[uart_rx_fifo_wrport_adr] <= uart_rx_fifo_wrport_dat_w;
	memdat_2 <= storage_2[uart_rx_fifo_wrport_adr];
end

always @(posedge sys_clk) begin
	if (uart_rx_fifo_rdport_re)
		memdat_3 <= storage_2[uart_rx_fifo_rdport_adr];
end

assign uart_rx_fifo_wrport_dat_r = memdat_2;
assign uart_rx_fifo_rdport_dat_r = memdat_3;

reg [7:0] mem_3[0:32];
reg [5:0] memadr_3;
always @(posedge sys_clk) begin
	memadr_3 <= adr;
end

assign dat_r = mem_3[memadr_3];

initial begin
	$readmemh("mem_3.init", mem_3);
end

DNA_PORT DNA_PORT(
	.CLK(cnt[0]),
	.DIN(status[56]),
	.READ((cnt < 2'd2)),
	.SHIFT(1'd1),
	.DOUT(do_1)
);

assign SD_cs_n = SD_cs_n_t_oe ? SD_cs_n_t_o : 1'bz;
assign SD_cs_n_t_i = SD_cs_n;

assign SD_spi_clk = SD_clk_t_oe ? SD_clk_t_o : 1'bz;
assign SD_clk_t_i = SD_spi_clk;

assign SD_spi_mosi = SD_mosi_t_oe ? SD_mosi_t_o : 1'bz;
assign SD_mosi_t_i = SD_spi_mosi;

assign lcd_spi_cs_n = lcd_cs_n_t_oe ? lcd_cs_n_t_o : 1'bz;
assign lcd_cs_n_t_i = lcd_spi_cs_n;

assign lcd_spi_clk = lcd_clk_t_oe ? lcd_clk_t_o : 1'bz;
assign lcd_clk_t_i = lcd_spi_clk;

assign lcd_spi_mosi = lcd_mosi_t_oe ? lcd_mosi_t_o : 1'bz;
assign lcd_mosi_t_i = lcd_spi_mosi;

endmodule
