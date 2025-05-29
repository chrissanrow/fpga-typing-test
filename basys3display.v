`timescale 1ns / 1ps


module basys3display(
    input wire [3:0] digit_one,
    input wire [3:0] digit_two,
    input wire [3:0] digit_three,
    input wire [3:0] digit_four,
    input wire fast_clk,
    input wire one_en,
    input wire two_en,
    input wire three_en,
    input wire four_en,
    output reg [3:0] Anode_Activate,
    output reg [6:0] LED_out
    );
    
    reg[3:0] LED_BCD;
    
    reg [1:0] led_select = 0;
        
    always @(posedge fast_clk) begin
        if (led_select < 3)
            led_select <= led_select + 1;
        else
            led_select <= 0;
    end

    always @(*) begin
        if(led_select == 2'b00 && one_en) begin
            Anode_Activate = 4'b0111;
            // activate LED1 and Deactivate LED2, LED3, LED4
            LED_BCD = digit_one;
            // the first digit of the 16-bit number
        end
        else if(led_select == 2'b01 && two_en) begin
            Anode_Activate = 4'b1011;
            // activate LED2 and Deactivate LED1, LED3, LED4
            LED_BCD = digit_two;
            // the second digit of the 16-bit 
        end
        else if(led_select == 2'b10 && three_en) begin
            Anode_Activate = 4'b1101; 
            // activate LED3 and Deactivate LED2, LED1, LED4
            LED_BCD = digit_three;
            // the third digit of the 16-bit number
        end
        else if(led_select == 2'b11 && four_en) begin
            Anode_Activate = 4'b1110; 
            // activate LED4 and Deactivate LED2, LED3, LED1
            LED_BCD = digit_four;
            // the fourth digit of the 16-bit number
        end
        else begin // CHECK THIS
            // deactivate all LEDs
            Anode_Activate = 4'b1111; 
            LED_BCD = 4'b0000; // DEFAULT VALUE (only for stability purposes => won't be displayed)
        end
    end
    
    // Cathode patterns of the 7-segment LED display 
    always @(*)
    begin
        case(LED_BCD)
        4'b0000: LED_out = 7'b0000001; // "0"     
        4'b0001: LED_out = 7'b1001111; // "1" 
        4'b0010: LED_out = 7'b0010010; // "2" 
        4'b0011: LED_out = 7'b0000110; // "3" 
        4'b0100: LED_out = 7'b1001100; // "4" 
        4'b0101: LED_out = 7'b0100100; // "5" 
        4'b0110: LED_out = 7'b0100000; // "6" 
        4'b0111: LED_out = 7'b0001111; // "7" 
        4'b1000: LED_out = 7'b0000000; // "8"     
        4'b1001: LED_out = 7'b0000100; // "9" 
        default: LED_out = 7'b0000001; // "0"
        endcase
    end
    
endmodule
