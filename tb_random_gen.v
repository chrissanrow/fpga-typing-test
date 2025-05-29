`timescale 1ns / 1ps

module tb_random_gen;
    //INPUTS
    reg clk;
    
    //OUTPUTS
    wire [3:0] rand_one;
    wire [3:0] rand_two;
    wire [3:0] rand_three;
    wire [3:0] rand_four;
    
    // random generator module
    random_gen uut (
        .clk(clk),
        .rand_one(rand_one),
        .rand_two(rand_two),
        .rand_three(rand_three),
        .rand_four(rand_four)
    );
    
    // generate clock signal
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        #1000000
        $stop;
    end
endmodule
