transcript on
if ![file isdirectory verilog_libs] {
	file mkdir verilog_libs
}

vlib verilog_libs/altera_ver
vmap altera_ver ./verilog_libs/altera_ver
vlog -vlog01compat -work altera_ver {c:/intelfpga_lite/23.1std/quartus/eda/sim_lib/altera_primitives.v}

vlib verilog_libs/lpm_ver
vmap lpm_ver ./verilog_libs/lpm_ver
vlog -vlog01compat -work lpm_ver {c:/intelfpga_lite/23.1std/quartus/eda/sim_lib/220model.v}

vlib verilog_libs/sgate_ver
vmap sgate_ver ./verilog_libs/sgate_ver
vlog -vlog01compat -work sgate_ver {c:/intelfpga_lite/23.1std/quartus/eda/sim_lib/sgate.v}

vlib verilog_libs/altera_mf_ver
vmap altera_mf_ver ./verilog_libs/altera_mf_ver
vlog -vlog01compat -work altera_mf_ver {c:/intelfpga_lite/23.1std/quartus/eda/sim_lib/altera_mf.v}

vlib verilog_libs/altera_lnsim_ver
vmap altera_lnsim_ver ./verilog_libs/altera_lnsim_ver
vlog -sv -work altera_lnsim_ver {c:/intelfpga_lite/23.1std/quartus/eda/sim_lib/altera_lnsim.sv}

vlib verilog_libs/cyclonev_ver
vmap cyclonev_ver ./verilog_libs/cyclonev_ver
vlog -vlog01compat -work cyclonev_ver {c:/intelfpga_lite/23.1std/quartus/eda/sim_lib/mentor/cyclonev_atoms_ncrypt.v}
vlog -vlog01compat -work cyclonev_ver {c:/intelfpga_lite/23.1std/quartus/eda/sim_lib/mentor/cyclonev_hmi_atoms_ncrypt.v}
vlog -vlog01compat -work cyclonev_ver {c:/intelfpga_lite/23.1std/quartus/eda/sim_lib/cyclonev_atoms.v}

vlib verilog_libs/cyclonev_hssi_ver
vmap cyclonev_hssi_ver ./verilog_libs/cyclonev_hssi_ver
vlog -vlog01compat -work cyclonev_hssi_ver {c:/intelfpga_lite/23.1std/quartus/eda/sim_lib/mentor/cyclonev_hssi_atoms_ncrypt.v}
vlog -vlog01compat -work cyclonev_hssi_ver {c:/intelfpga_lite/23.1std/quartus/eda/sim_lib/cyclonev_hssi_atoms.v}

vlib verilog_libs/cyclonev_pcie_hip_ver
vmap cyclonev_pcie_hip_ver ./verilog_libs/cyclonev_pcie_hip_ver
vlog -vlog01compat -work cyclonev_pcie_hip_ver {c:/intelfpga_lite/23.1std/quartus/eda/sim_lib/mentor/cyclonev_pcie_hip_atoms_ncrypt.v}
vlog -vlog01compat -work cyclonev_pcie_hip_ver {c:/intelfpga_lite/23.1std/quartus/eda/sim_lib/cyclonev_pcie_hip_atoms.v}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog {C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog/DataMemory.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog {C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog/PCadder.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog {C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog/PC.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog {C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog/monocicle.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog {C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog/memory_register.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog {C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog/instruction_decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog {C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog/immediate_generator.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog {C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog/Control_Unit.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog {C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog/Branch_Unit.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog {C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog {C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog/mux_1.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog {C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog/mux_2.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog {C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog/ram.v}
vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog {C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog/instruction_memory.v}

vlog -vlog01compat -work work +incdir+C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog {C:/Users/valen/Escritorio/universidad/6semestre/ArquitecturadeComputadores/Monocicle_in_verilog/testbench_simulation.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  testbench_simulation

add wave *
view structure
view signals
run -all
