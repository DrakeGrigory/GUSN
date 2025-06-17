`timescale  1ns/1ps
`include "Design/perceptron.v"
`define TB_PATH "Simulation/perceptron_tb.vcd"
`define MAX_SIM_TIME #30000



`define CROSS_SUM_VAL 11
`define CROSS_VAL  {1'b1, 24'h15_11_51}
`define CROSS_OUT_VAL 3

`define CIRCLE_SUM_VAL 4
`define CIRCLE_VAL {1'b0, 24'h45_45_44}
`define CIRCLE_OUT_VAL 2

//--------------------------------------------------------------------------------------

//I decided to train with define usage
//Obviously task is a better option.
`define CASE_FSM(en,input_val) \
                    {en_dut, input_val_dut} <= {en,input_val};

`define DISPLAY(val) \
                    if(ready_dut && r_state_change_delay > delay_val/2)\
                        if     (val == `CIRCLE_VAL) $display("At FSM STATE %0d: [out= %0d | %0d]   [acc= %0d | %0d]   ",state_tb,out_dut,`CIRCLE_OUT_VAL,acc_dut,`CIRCLE_SUM_VAL);\
                        else if(val == `CROSS_VAL ) $display("At FSM STATE %0d: [out= %0d | %0d]   [acc= %0d | %0d]   ",state_tb,out_dut,`CROSS_OUT_VAL ,acc_dut,`CROSS_SUM_VAL );\
                        else                        $display("At FSM STATE %0d: BAD INPUT");
                            

// YES, number 5 is arbitrary
`define NEXT_STATE \
                    if(ready_dut && r_state_change_delay > 5) begin\
                        state_tb <= state_tb + 1;\
                        r_state_change_delay <= 0;\
                    end




module perceptron_tb();
    localparam set_size = 20;
    localparam width = 25;
    localparam width_size = $clog2(width);
    localparam delay_val = width*4;
    reg [5:0] state_tb; 
    reg clk_tb;
    reg [$clog2(delay_val)-1:0] r_state_change_delay;
    reg [width-1:0] input_val_tb;
    reg [7:0] prev_result;
    reg [27:0] memory_set_extened [set_size-1:0];
    reg [width-1:0] memory_set [set_size-1:0];
    integer i;


    reg [width-1:0] input_val_dut;
    reg en_dut;
    reg clk_dut;
    wire ready_dut;
    wire [1:0] out_dut;
    wire [width_size-1:0] acc_dut;

    
    perceptron #(.WIDTH(width), .WEIGHTS(4)) perceptron_inst(
        .in(input_val_dut),
        .en(en_dut),
        .clk(clk_dut),
        .acc(acc_dut),
        .out(out_dut),
        .ready(ready_dut)
    );


    initial begin
        clk_tb = 0;
        state_tb = 0;
        en_dut = 0;
        clk_dut = 0;
        r_state_change_delay = 0;

        $readmemh("DataSet/data_set.hex",memory_set_extened,0,set_size-1);
        for(i=0; i<set_size; i=i+1) begin
            $display("Memory[%0d]:       %h",i,memory_set_extened[i]);
            memory_set[i] = memory_set_extened[i];
            $display("Memory_trunc[%0d]: %h",i,memory_set[i]);
        end

    end
    initial begin   // clk of tb
        forever begin
            #10 clk_tb = ~clk_tb;
        end
    end
    always @(posedge clk_tb) begin //clk of dut
        clk_dut <= ~clk_dut;
        r_state_change_delay <= r_state_change_delay+1; //prevents premature change of fsm
        if(out_dut==2'b11)
            prev_result <= 8'd88;
        else if(out_dut==2'b10)
            prev_result <= 8'd75;
    end


    always @(posedge clk_tb) begin
        case (state_tb)
            0: begin
                {en_dut, input_val_dut} <= {1'd0,25'd0};
                $display(" ======= DISPLAYING DATA =======");
                state_tb <= state_tb + 1;
                i=0;
               
            end
            //1: begin input_val_tb <=`CIRCLE_VAL;   `CASE_FSM(1'd1,input_val_tb);   `DISPLAY(input_val_tb)   `NEXT_STATE  end
            1:  begin input_val_tb <=memory_set[0];  `CASE_FSM(1'd1,input_val_tb);   `DISPLAY(input_val_tb)   `NEXT_STATE  end
            2:  begin input_val_tb <=memory_set[1];  `CASE_FSM(1'd1,input_val_tb);   `DISPLAY(input_val_tb)   `NEXT_STATE  end
            3:  begin input_val_tb <=memory_set[2];  `CASE_FSM(1'd1,input_val_tb);   `DISPLAY(input_val_tb)   `NEXT_STATE  end
            4:  begin input_val_tb <=memory_set[3];  `CASE_FSM(1'd1,input_val_tb);   `DISPLAY(input_val_tb)   `NEXT_STATE  end
            5:  begin input_val_tb <=memory_set[4];  `CASE_FSM(1'd1,input_val_tb);   `DISPLAY(input_val_tb)   `NEXT_STATE  end
            6:  begin input_val_tb <=memory_set[5];  `CASE_FSM(1'd1,input_val_tb);   `DISPLAY(input_val_tb)   `NEXT_STATE  end
            7:  begin input_val_tb <=memory_set[6];  `CASE_FSM(1'd1,input_val_tb);   `DISPLAY(input_val_tb)   `NEXT_STATE  end
            8:  begin input_val_tb <=memory_set[7];  `CASE_FSM(1'd1,input_val_tb);   `DISPLAY(input_val_tb)   `NEXT_STATE  end
            9:  begin input_val_tb <=memory_set[8];  `CASE_FSM(1'd1,input_val_tb);   `DISPLAY(input_val_tb)   `NEXT_STATE  end
            10: begin input_val_tb <=memory_set[9];  `CASE_FSM(1'd1,input_val_tb);   `DISPLAY(input_val_tb)   `NEXT_STATE  end
            11: begin input_val_tb <=memory_set[10];  `CASE_FSM(1'd1,input_val_tb);   `DISPLAY(input_val_tb)   `NEXT_STATE  end
            12: begin input_val_tb <=memory_set[11];  `CASE_FSM(1'd1,input_val_tb);   `DISPLAY(input_val_tb)   `NEXT_STATE  end
            13: begin input_val_tb <=memory_set[12];  `CASE_FSM(1'd1,input_val_tb);   `DISPLAY(input_val_tb)   `NEXT_STATE  end
            14: begin input_val_tb <=memory_set[13];  `CASE_FSM(1'd1,input_val_tb);   `DISPLAY(input_val_tb)   `NEXT_STATE  end
            15: begin input_val_tb <=memory_set[14];  `CASE_FSM(1'd1,input_val_tb);   `DISPLAY(input_val_tb)   `NEXT_STATE  end
            16: begin input_val_tb <=memory_set[15];  `CASE_FSM(1'd1,input_val_tb);   `DISPLAY(input_val_tb)   `NEXT_STATE  end
            17: begin input_val_tb <=memory_set[16];  `CASE_FSM(1'd1,input_val_tb);   `DISPLAY(input_val_tb)   `NEXT_STATE  end
            18: begin input_val_tb <=memory_set[17];  `CASE_FSM(1'd1,input_val_tb);   `DISPLAY(input_val_tb)   `NEXT_STATE  end
            19: begin input_val_tb <=memory_set[18];  `CASE_FSM(1'd1,input_val_tb);   `DISPLAY(input_val_tb)   `NEXT_STATE  end
            20: begin input_val_tb <=memory_set[19];  `CASE_FSM(1'd1,input_val_tb);   `DISPLAY(input_val_tb)   `NEXT_STATE  end
            //    {en_dut, input_val_dut} <= {1'd1,`CROSS_VAL};
            //    `NEXT_STATE
            //end
            21: begin
                $display(" ========== FINISHING ==========");
                #3000;
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