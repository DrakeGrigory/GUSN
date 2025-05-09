`define R_STATE r_state - 1

module perceptron #(parameter WIDTH = 25, OPTIONS = 2) (
    input [WIDTH-1:0] in,
    input en,
    input clk,
    output reg [1:0] out
);

    integer i;
    reg [$clog2(WIDTH):0] r_accumulate;
    reg [$clog2(WIDTH):0] r_state;
    reg [1:0]             r_multiply;
    reg [1:0]             r_weights [0:WIDTH-1];


    initial begin
        for (i=0; i<WIDTH; i = i+1) begin
            case (i)
            0,4,12,20,24: r_weights[i] = 2'b10;
            2,10,14,22:   r_weights[i] = 2'b01;
            default:      r_weights[i] = 2'b00;
            endcase 
        end 
        i = 0;
        r_state = 0;
    end

    always @( posedge clk) begin

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

    //
    //    for (i=0; i<WIDTH; i = i+1)
    //        r_multiply <= r_weights[i] & {2{in[i]}};
    //       r_accumulate <= r_accumulate + {3'b0,r_multiply}; //loop not working, stuck at single

    always @(*) begin
        if (r_accumulate == 10)      out = 2'b10;
        else if (r_accumulate == 4)  out = 2'b01;
        else                         out = 2'b00;
    end
endmodule