//iverilog -o Simulation/perceptron_tb perceptron_tb.v && vvp Simulation/perceptron_tb && gtkwave "Simulation/perceptron_tb.gtkw" --rcvar 'fontname_signals Monospace 15' --rcvar 'fontname_waves Monospace 12'
`timescale  1ns/1ps
`include "Design/perceptron.v"
`define TB_PATH "Simulation/perceptron_tb.vcd"
`define MAX_SIM_TIME #30000

`define CROSS_VAL  {1'b1, 24'h15_11_51}
`define CIRCLE_VAL {1'b0, 24'h45_45_44}

`define CASE_FSM(st_val,jmp_val,code,state_name)\ 
st_val: begin \
    code\
state_name <= jmp_val; end 

`define NEXT_STATE  if(ready_dut && r_state_change_delay > 5) begin\
                        state_tb <= state_tb + 1;\
                        r_state_change_delay <= 0;\
                    end


module perceptron_tb();

reg [3:0] state_tb; 
reg clk_tb;
reg [6:0] r_state_change_delay;


reg [24:0] input_val_dut;
reg en_dut;
reg clk_dut;
wire ready_dut;
wire [1:0] out_dut;
perceptron perceptron_inst(
    .in(input_val_dut),
    .en(en_dut),
    .clk(clk_dut),
    .out(out_dut),
    .ready(ready_dut)
);


initial begin
    clk_tb = 0;
    state_tb = 0;
    en_dut = 0;
    clk_dut = 0;
    r_state_change_delay = 0;
end
initial begin  
    forever begin
        #10 clk_tb = ~clk_tb;
    end
end
always @(posedge clk_tb) begin
    clk_dut <= ~clk_dut;
    r_state_change_delay <= r_state_change_delay+1;
end



initial `MAX_SIM_TIME state_tb = 4'hF;


always @(posedge clk_tb) begin
    case (state_tb)
    0: begin
        {en_dut, input_val_dut} <= {1'd0,25'd0};

        state_tb <= state_tb + 1;
    end
    1: begin
        {en_dut, input_val_dut} <= {1'd1,`CIRCLE_VAL};
        
        `NEXT_STATE
    end
    2: begin
        {en_dut, input_val_dut} <= {1'd1,`CROSS_VAL};

        `NEXT_STATE
    end
    3: begin
        {en_dut, input_val_dut} <= {1'd1,`CIRCLE_VAL};

        `NEXT_STATE
    end
    4: begin
        {en_dut, input_val_dut} <= {1'd1,`CROSS_VAL};

        `NEXT_STATE
    end
    5: begin
        {en_dut, input_val_dut} <= {1'd1,`CROSS_VAL};
        
        `NEXT_STATE
    end
    default: begin
        #30
       $finish();
    end
    endcase    

end







initial begin // file save
    $dumpfile(`TB_PATH);
    $dumpvars;
    $dumpon;
end
endmodule