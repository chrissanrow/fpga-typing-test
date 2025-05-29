`timescale 1ns / 1ps

module tb_decoder();

    reg clk_100MHz;
    reg [3:0] row;
    wire [3:0] col;
    wire [3:0] dec_out;
    wire button_pressed;

    // Instantiate the decoder
    decoder uut (
        .clk_100MHz(clk_100MHz),
        .row(row),
        .col(col),
        .dec_out(dec_out),
        .button_pressed(button_pressed)
    );

    // Clock generation
    always #5 clk_100MHz = ~clk_100MHz; // 100 MHz clock

    initial begin
        clk_100MHz = 0;
        row = 4'b1111; // No key pressed
        #20;

        row = 4'b0111; #20; // Key pressed in row 1
        row = 4'b1011; #20; // Key pressed in row 2
        row = 4'b1101; #20; // Key pressed in row 3
        row = 4'b1110; #20; // Key pressed in row 4
        
        $stop; // End simulation
    end

endmodule