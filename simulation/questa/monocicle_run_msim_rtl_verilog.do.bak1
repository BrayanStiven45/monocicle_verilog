transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6\ semestre/Arquitectura\ de\ Computadores/Monocicle\ in\ verilog {C:/Users/valen/Escritorio/universidad/6 semestre/Arquitectura de Computadores/Monocicle in verilog/PCadder.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6\ semestre/Arquitectura\ de\ Computadores/Monocicle\ in\ verilog {C:/Users/valen/Escritorio/universidad/6 semestre/Arquitectura de Computadores/Monocicle in verilog/PC.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6\ semestre/Arquitectura\ de\ Computadores/Monocicle\ in\ verilog {C:/Users/valen/Escritorio/universidad/6 semestre/Arquitectura de Computadores/Monocicle in verilog/monocicle.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6\ semestre/Arquitectura\ de\ Computadores/Monocicle\ in\ verilog {C:/Users/valen/Escritorio/universidad/6 semestre/Arquitectura de Computadores/Monocicle in verilog/memory_register.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6\ semestre/Arquitectura\ de\ Computadores/Monocicle\ in\ verilog {C:/Users/valen/Escritorio/universidad/6 semestre/Arquitectura de Computadores/Monocicle in verilog/instruction_decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6\ semestre/Arquitectura\ de\ Computadores/Monocicle\ in\ verilog {C:/Users/valen/Escritorio/universidad/6 semestre/Arquitectura de Computadores/Monocicle in verilog/immediate_generator.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6\ semestre/Arquitectura\ de\ Computadores/Monocicle\ in\ verilog {C:/Users/valen/Escritorio/universidad/6 semestre/Arquitectura de Computadores/Monocicle in verilog/Control_Unit.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6\ semestre/Arquitectura\ de\ Computadores/Monocicle\ in\ verilog {C:/Users/valen/Escritorio/universidad/6 semestre/Arquitectura de Computadores/Monocicle in verilog/Branch_Unit.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6\ semestre/Arquitectura\ de\ Computadores/Monocicle\ in\ verilog {C:/Users/valen/Escritorio/universidad/6 semestre/Arquitectura de Computadores/Monocicle in verilog/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6\ semestre/Arquitectura\ de\ Computadores/Monocicle\ in\ verilog {C:/Users/valen/Escritorio/universidad/6 semestre/Arquitectura de Computadores/Monocicle in verilog/mux_1.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6\ semestre/Arquitectura\ de\ Computadores/Monocicle\ in\ verilog {C:/Users/valen/Escritorio/universidad/6 semestre/Arquitectura de Computadores/Monocicle in verilog/mux_2.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6\ semestre/Arquitectura\ de\ Computadores/Monocicle\ in\ verilog {C:/Users/valen/Escritorio/universidad/6 semestre/Arquitectura de Computadores/Monocicle in verilog/hex_to_7seg.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6\ semestre/Arquitectura\ de\ Computadores/Monocicle\ in\ verilog {C:/Users/valen/Escritorio/universidad/6 semestre/Arquitectura de Computadores/Monocicle in verilog/pc_display.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6\ semestre/Arquitectura\ de\ Computadores/Monocicle\ in\ verilog {C:/Users/valen/Escritorio/universidad/6 semestre/Arquitectura de Computadores/Monocicle in verilog/DataMemory_2.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6\ semestre/Arquitectura\ de\ Computadores/Monocicle\ in\ verilog {C:/Users/valen/Escritorio/universidad/6 semestre/Arquitectura de Computadores/Monocicle in verilog/ram.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6\ semestre/Arquitectura\ de\ Computadores/Monocicle\ in\ verilog {C:/Users/valen/Escritorio/universidad/6 semestre/Arquitectura de Computadores/Monocicle in verilog/instruction_memory.v}

vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6\ semestre/Arquitectura\ de\ Computadores/Monocicle\ in\ verilog {C:/Users/valen/Escritorio/universidad/6 semestre/Arquitectura de Computadores/Monocicle in verilog/testbench_simulation.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  testbench_simulation

add wave *
view structure
view signals
run -all
