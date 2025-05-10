#! /bin/bash
choice=$1
design_foldername="Design"
TB_foldername="TB"
simulation_foldername="Simulation"
filename="perceptron"
filename_tb="${filename}_tb"

py_filename="main"
py_foldername="Translator"


if [[ "$choice" == "tb" ]]; then
    clear
    echo "====================================================================
                LAUNCHING TEST BENCH COMPILATION:
    ====================================================================="

    rm "${simulation_foldername}"/"${filename_tb}".o
    rm "${simulation_foldername}"/"${filename_tb}".vcd
    iverilog -o "${simulation_foldername}"/"${filename_tb}".o "${TB_foldername}"/"${filename_tb}.sv"
    vvp "${simulation_foldername}"/"${filename_tb}".o
    gtkwave "${simulation_foldername}"/"${filename_tb}.gtkw" --rcvar 'fontname_signals Monospace 15' --rcvar 'fontname_waves Monospace 12'
fi


if [[ "$choice"=="py" ]]; then
    py "${py_foldername}"\\"${py_filename}".py
fi
