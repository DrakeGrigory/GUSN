//iverilog -o Simulation/perceptron_tb perceptron_tb.v && vvp Simulation/perceptron_tb && gtkwave "Simulation/perceptron_tb.gtkw" --rcvar 'fontname_signals Monospace 15' --rcvar 'fontname_waves Monospace 12'
`timescale  1ns/1ps
`include "Design/perceptron.v"
`define tb_path "Simulation/perceptron_tb.vcd"

`define CROSS_VAL  {1'b1, 24'h15_11_51}
`define CIRCLE_VAL {1'b0, 24'h45_45_44}

`define CASE_FSM(st_val,jmp_val,code,state_name)\ 
st_val: begin \
    code\
state_name <= jmp_val; end 

module perceptron_tb();

reg [3:0] state_tb; 



reg [24:0] input_val_tb;
reg en_tb;
reg clk_tb;
wire ready_tb;
wire [1:0] out_tb;
perceptron perceptron_inst(
    .in(input_val_tb),
    .en(en_tb),
    .clk(clk_tb),
    .out(out_tb),
    .ready(ready_tb)
);


initial begin
    clk_tb = 0;
    state_tb = 0;
    en_tb = 0;
    forever begin
        #5 clk_tb = ~clk_tb;
    end
end

initial #10000 state_tb = 4'hF;


always @(negedge clk_tb) begin
    case (state_tb)
    0: begin
        {en_tb, input_val_tb} <= {1'd0,25'd0};
        state_tb <= state_tb + 1;
    end
    1: begin
        {en_tb, input_val_tb} <= {1'd1,`CIRCLE_VAL};
        if(ready_tb) state_tb <= state_tb + 1;
    end
    2: begin
        {en_tb, input_val_tb} <= {1'd1,`CROSS_VAL};
        if(ready_tb) state_tb <= state_tb + 1;
    end
    3: begin
        {en_tb, input_val_tb} <= {1'd1,`CIRCLE_VAL};
        if(ready_tb) state_tb <= state_tb + 1;
    end
    4: begin
        {en_tb, input_val_tb} <= {1'd1,`CROSS_VAL};
        if(ready_tb) state_tb <= state_tb + 1;
    end
    5: begin
        {en_tb, input_val_tb} <= {1'd1,`CROSS_VAL};
        if(ready_tb) state_tb <= state_tb + 1;
    end
    default: begin
       $finish();
    end
    endcase    

end







initial begin // file save
    $dumpfile(`tb_path);
    $dumpvars;
    $dumpon;
end
endmodule