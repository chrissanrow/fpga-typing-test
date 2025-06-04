`timescale 1ns / 1ps


module ssd_display(
    input wire [3:0] digit_one,
    input wire [3:0] digit_two,
    input wire fast_clk,
    input wire one_en,
    input wire two_en,
    output reg SSD_Anode_Activate, // 2-bit digit selection
    output reg [6:0] SSD_LED_out
    );
    
    reg[3:0] LED_BCD;
    
    reg led_select = 0;
        
    always @(posedge fast_clk) begin
        led_select <= ~led_select;
    end

    always @(*) begin
        if(led_select == 1'b0 && one_en) begin
            SSD_Anode_Activate = 0;
            // activate LED1 and Deactivate LED2
            LED_BCD = digit_one;
        end
        else if(led_select == 1'b1 && two_en) begin
            SSD_Anode_Activate = 1;
            // activate LED2 and Deactivate LED1
            LED_BCD = digit_two;
            // the second digit of the 16-bit 
        end
        else begin
            SSD_Anode_Activate = led_select;
            LED_BCD = 4'b1111; // DEFAULT TO SINGLE DASH
        end
    end
    
    // Cathode patterns of the 7-segment LED display 
    always @(*)
    begin
        case(LED_BCD)
        //gcbafed
        4'b0000: SSD_LED_out = 7'b0111111; // "0"     
        4'b0001: SSD_LED_out = 7'b0110000; // "1" 
        4'b0010: SSD_LED_out = 7'b1011011; // "2" 
        4'b0011: SSD_LED_out = 7'b1111001; // "3" 
        4'b0100: SSD_LED_out = 7'b1110100; // "4" 
        4'b0101: SSD_LED_out = 7'b1101101; // "5" 
        4'b0110: SSD_LED_out = 7'b1101111; // "6" 
        4'b0111: SSD_LED_out = 7'b0111000; // "7" 
        4'b1000: SSD_LED_out = 7'b1111111; // "8"     
        4'b1001: SSD_LED_out = 7'b1111101; // "9" 
        4'b1010: SSD_LED_out = 7'b1111110; // "A"
        default: SSD_LED_out = 7'b1000000; // "-"

        endcase
    end
    
endmodule
