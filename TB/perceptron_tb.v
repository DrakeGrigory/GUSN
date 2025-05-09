//iverilog -o Simulation/perceptron_tb perceptron_tb.v && vvp Simulation/perceptron_tb && gtkwave "Simulation/perceptron_tb.gtkw" --rcvar 'fontname_signals Monospace 15' --rcvar 'fontname_waves Monospace 12'
`timescale  1ns/1ps
`include "Design/perceptron.v"
`define tb_path "Simulation/perceptron_tb.vcd"

`define CROSS_VAL  {1'b1, 24'h15_11_51}
`define CIRCLE_VAL {1'b0, 24'h45_45_44}

module perceptron_tb();

reg [24:0] input_val_tb;
reg en_tb;
reg clk_tb;
wire [1:0] out_tb;


perceptron perceptron_inst(
    .in(input_val_tb),
    .en(en_tb),
    .clk(clk_tb),
    .out(out_tb)
);


initial begin
    clk_tb = 0;
    forever begin
        #5 clk_tb = ~clk_tb;
    end
end

initial begin
en_tb = 0;
input_val_tb = 25'd0;


#10
en_tb = 1;
input_val_tb = `CIRCLE_VAL;

#243 input_val_tb = `CROSS_VAL;

#600 $finish;
end

initial begin // file save
    $dumpfile(`tb_path);
    $dumpvars;
    $dumpon;
end




endmodule