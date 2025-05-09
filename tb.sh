#! /bin/bash
design_foldername="Design"
TB_foldername="TB"
simulation_foldername="Simulation"
filename="perceptron"
filename_tb="${filename}_tb"

clear
echo "====================================================================
              LAUNCHING TEST BENCH COMPILATION:
====================================================================="

rm "${simulation_foldername}"/"${filename_tb}".o
rm "${simulation_foldername}"/"${filename_tb}".vcd
iverilog -o "${simulation_foldername}"/"${filename_tb}".o "${TB_foldername}"/"${filename_tb}.v"
vvp "${simulation_foldername}"/"${filename_tb}".o
gtkwave "${simulation_foldername}"/"${filename_tb}.gtkw" --rcvar 'fontname_signals Monospace 15' --rcvar 'fontname_waves Monospace 12'