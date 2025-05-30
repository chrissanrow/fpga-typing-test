`timescale 1ns / 1ps

module hw_test(
        input wire clk,
        input wire [3:0] rows, // PmodJB pins 10 to 7
        output wire [3:0] cols,
        output wire [3:0] Anode_Activate,
        output wire [6:0] LED_out
    );
    
    wire one_hz_clk, fast_clk;
    
    clock_divider cd_inst (
        .clk(clk),
        .one_hz_clk(one_hz_clk),
        .fast_clk(fast_clk)
    );
  
    wire [3:0] dec_out;
    wire button_pressed;
        
    decoder dec_inst (
        .clk(clk),
        .row(rows),
        .col(cols),
        .dec_out(dec_out),
        .button_pressed(button_pressed)
    );
    
    wire [3:0] rand_one, rand_two, rand_three, rand_four;
    
    random_gen rg_inst(
        .clk(clk),
        .rand_one(rand_one),
        .rand_two(rand_two),
        .rand_three(rand_three),
        .rand_four(rand_four)
    );
    
    reg one_en, two_en, three_en, four_en;
    initial begin
        one_en <= 1;
        two_en <= 1;
        three_en <= 1;
        four_en <= 1;
    end
    
    basys3display disp_inst(
        .digit_one(button_pressed),
        .digit_two(button_pressed),
        .digit_three(button_pressed),
        .digit_four(dec_out),
        .fast_clk(fast_clk),
        .one_en(one_en),
        .two_en(two_en),
        .three_en(three_en),
        .four_en(four_en),
        .Anode_Activate(Anode_Activate),
        .LED_out(LED_out)
    );
    
endmodule
