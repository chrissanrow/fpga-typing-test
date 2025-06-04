`timescale 1ns / 1ps

module typing_test_top(
        input wire clk,
        input wire [3:0] rows, // PmodJB pins 10 to 7
        output wire [3:0] cols,
        output wire [3:0] Anode_Activate,
        output wire [6:0] LED_out,
        output wire SSD_Anode_Activate,
        output wire [6:0] SSD_LED_out
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
    
    wire one_en, two_en, three_en, four_en;
    wire [3:0] digit_one, digit_two, digit_three, digit_four;
    wire acc_one_en, acc_two_en;
    wire [3:0] acc_digit_one, acc_digit_two;
    
    game game_inst(
        .clk(clk),
        .one_hz_clk(one_hz_clk),
        .dec(dec_out),
        .button_pressed(button_pressed),
        .rand_one(rand_one),
        .rand_two(rand_two),
        .rand_three(rand_three),
        .rand_four(rand_four),
        .one_en(one_en),
        .two_en(two_en),
        .three_en(three_en),
        .four_en(four_en),
        .acc_one_en(acc_one_en),
        .acc_two_en(acc_two_en),
        .acc_digit_one(acc_digit_one),
        .acc_digit_two(acc_digit_two),
        .digit_one(digit_one),
        .digit_two(digit_two),
        .digit_three(digit_three),
        .digit_four(digit_four)
    );
    
    basys3display disp_inst(
        .digit_one(digit_one),
        .digit_two(digit_two),
        .digit_three(digit_three),
        .digit_four(digit_four),
        .fast_clk(fast_clk),
        .one_en(one_en),
        .two_en(two_en),
        .three_en(three_en),
        .four_en(four_en),
        .Anode_Activate(Anode_Activate),
        .LED_out(LED_out)
    );

    ssd_display ssd_inst(
        .digit_one(acc_digit_one),
        .digit_two(acc_digit_two),
        .fast_clk(fast_clk),
        .one_en(acc_one_en),
        .two_en(acc_two_en),
        .SSD_Anode_Activate(SSD_Anode_Activate),
        .SSD_LED_out(SSD_LED_out)
    );
    
endmodule
