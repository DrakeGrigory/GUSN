//iverilog -o Simulation/perceptron_tb perceptron_tb.v && vvp Simulation/perceptron_tb && gtkwave "Simulation/perceptron_tb.gtkw" --rcvar 'fontname_signals Monospace 15' --rcvar 'fontname_waves Monospace 12'
`timescale  1ns/1ps
`include "Design/perceptron.v"
`define TB_PATH "Simulation/perceptron_tb.vcd"
`define MAX_SIM_TIME #30000



`define CROSS_VAL  {1'b1, 24'h15_11_51}
`define CIRCLE_VAL {1'b0, 24'h45_45_44}

`define CASE_FSM(en,input_val) {en_dut, input_val_dut} <= {en,input_val}; `NEXT_STATE 

`define NEXT_STATE  if(ready_dut && r_state_change_delay > 5) begin\
                        state_tb <= state_tb + 1;\
                        r_state_change_delay <= 0;\
                    end


module perceptron_tb();
    localparam width = 25;
    reg [3:0] state_tb; 
    reg clk_tb;
    reg [$clog2(width*4)-1:0] r_state_change_delay;
//     string symbol1 = "Nothing";
// always @(*) begin
//     case(out_dut)
//     0: symbol = "Nothing";
//     1: symbol = "Circle";
//     2: symbol = "Cross";
//     3: symbol = "NA";
//     endcase
// end



    reg [24:0] input_val_dut;
    reg en_dut;
    reg clk_dut;
    wire ready_dut;
    wire [1:0] out_dut;
    perceptron #(.WIDTH(width), .WEIGHTS(4)) perceptron_inst(
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
    initial begin   // clk of tb
        forever begin
            #10 clk_tb = ~clk_tb;
        end
    end
    always @(posedge clk_tb) begin //clk of dut
        clk_dut <= ~clk_dut;
        r_state_change_delay <= r_state_change_delay+1; //prevents premature change of fsm
    end


    always @(posedge clk_tb) begin
        case (state_tb)
        0: begin
            {en_dut, input_val_dut} <= {1'd0,25'd0};

            state_tb <= state_tb + 1;
        end
        1: begin `CASE_FSM(1'd1,`CIRCLE_VAL); end
        2: begin `CASE_FSM(1'd1,`CROSS_VAL ); end
        3: begin `CASE_FSM(1'd1,`CROSS_VAL ); end
        4: begin `CASE_FSM(1'd1,`CIRCLE_VAL); end
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


    initial `MAX_SIM_TIME state_tb = 4'hF; //finishes similation by going to the default state of FSM TB

    initial begin // file save
        $dumpfile(`TB_PATH);
        $dumpvars;
        $dumpon;
    end
endmodule