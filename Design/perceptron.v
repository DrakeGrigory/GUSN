`define R_STATE r_state - 1
`define CIRCLE_SUM_VAL 4
`define CROSS_SUM_VAL 11

module perceptron #(parameter WIDTH = 25, OPTIONS = 2) (
    input [WIDTH-1:0] in,
    input en,
    input clk,
    output reg [1:0] out,
    output reg ready
);

    integer i;
    reg [$clog2(WIDTH):0] r_accumulate;
    reg [$clog2(WIDTH):0] r_state;
    reg [1:0]             r_multiply;
    reg [1:0]             r_weights [0:WIDTH-1];


    initial begin
        for (i=0; i<WIDTH; i = i+1) begin
            case (i)
            12:           r_weights[i] = 2'b11;
            0,4,20,24:    r_weights[i] = 2'b10; //CROSS WEIGHTS
            //2,10,14,22:   r_weights[i] = 2'b01; //CIRCLE WEIGHTS
            default:      r_weights[i] = 2'b00; //NEUTRAL
            endcase 
        end 
        i = 0;
        r_state = 0;
    end

    always @(posedge clk && en) begin

        if(r_state == 0) begin
            r_multiply <= r_weights[0] & {2{in[0]}}; //using AND since it gives same results as *
            r_accumulate = 0;

        end else if(`R_STATE < WIDTH) begin
            r_accumulate <= r_accumulate + {3'b0,r_multiply}; 
            r_multiply <= r_weights[`R_STATE] & {2{in[`R_STATE]}}; //using AND since it gives same results as *

        end else if(`R_STATE == WIDTH) begin
            r_accumulate <= r_accumulate + {3'b0,r_multiply}; 

        end else begin
            r_multiply   <= 0;
            r_accumulate <= r_accumulate;
        end

        if(r_state < WIDTH)
            r_state <= r_state + 1;
        else
            r_state <= 0;
        

    end


    always @(*) begin
        ready = (r_state == WIDTH) ? 1:0;
        if      ((r_accumulate == `CROSS_SUM_VAL)  && (ready))    out = 2'b10;
        else if ((r_accumulate == `CIRCLE_SUM_VAL) && (ready))    out = 2'b01;
        else                                                                 out = 2'b00;
    end
endmodule