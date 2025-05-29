`timescale 1ns / 1ps

module random_gen(
    input wire clk,
    output reg [3:0] rand_one, 
    output reg [3:0] rand_two,
    output reg [3:0] rand_three,
    output reg [3:0] rand_four
);

    reg [15:0] random = 16'hACE1;
    reg [3:0] count; //to keep track of the shifts

    always @(posedge clk) begin
        // LFSR bitwise update (shifts bits, creating new pseudo-random values)
        random <= {random[14:0], random[15] ^ random[13] ^ random[12] ^ random[10]};

        // extract four random digits (mod 10 to ensure b/w 0-9)
        rand_one <= random[3:0] % 10;
        rand_two <= random[7:4] % 10;
        rand_three <= random[11:8] % 10;
        rand_four <= random[15:12] % 10;
    end

endmodule
