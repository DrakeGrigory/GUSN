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
    reg [$clog2(WIDTH):0] r_state_index;
    reg [1:0]             r_state_mac;
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
        r_state_index = 0;
    end

    always @(posedge clk && en) begin

        if(r_state_index == 0) begin
            r_accumulate <= 0;
            r_state_index <= r_state_index + 1; 

        end else if(r_state_index < WIDTH) begin
            r_accumulate <= r_accumulate + {3'b0,r_multiply};
            r_state_index <= r_state_index + 1; 

        end else if(r_state_index == WIDTH) begin
            r_accumulate <= r_accumulate + {3'b0,r_multiply};
            r_state_index <= 0; 

        end else begin
            r_accumulate <= 0;
            r_state_index <= 0;
        end
    end

    always @(*) begin
        r_multiply = (r_state_index < WIDTH) ? r_weights[r_state_index] & {2{in[r_state_index]}} : 0;
        ready = (r_state_index == WIDTH-1) ? 1:0;
        if      ((r_accumulate == `CROSS_SUM_VAL)  && (ready))    out = 2'b10;
        else if ((r_accumulate == `CIRCLE_SUM_VAL) && (ready))    out = 2'b01;
        else                                                      out = 2'b00;
    end
endmodule