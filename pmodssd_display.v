`timescale 1ns / 1ps


module ssd_display(
    input wire [3:0] digit_one,
    input wire [3:0] digit_two,
    input wire fast_clk,
    input wire one_en,
    input wire two_en,
    output reg [1:0] SSD_Anode_Activate, // 2-bit digit selection
    output reg [6:0] SSD_LED_out
    );
    
    reg[3:0] LED_BCD;
    
    reg led_select = 0;
        
    always @(posedge fast_clk) begin
        led_select <= ~led_select;
    end

    always @(*) begin
        if(led_select == 1'b0 && one_en) begin
            SSD_Anode_Activate = 4'b10;
            // activate LED1 and Deactivate LED2
            LED_BCD = digit_one;
        end
        else if(led_select == 1'b1 && two_en) begin
            SSD_Anode_Activate = 4'b01;
            // activate LED2 and Deactivate LED1
            LED_BCD = digit_two;
            // the second digit of the 16-bit 
        end
        else begin // CHECK THIS
            // deactivate all LEDs
            SSD_Anode_Activate = 4'b11; 
            LED_BCD = 4'b0000; // DEFAULT VALUE (only for stability purposes => won't be displayed)
        end
    end
    
    // Cathode patterns of the 7-segment LED display 
    always @(*)
    begin
        case(LED_BCD)
        4'b0000: SSD_LED_out = 7'b0000001; // "0"     
        4'b0001: SSD_LED_out = 7'b1001111; // "1" 
        4'b0010: SSD_LED_out = 7'b0010010; // "2" 
        4'b0011: SSD_LED_out = 7'b0000110; // "3" 
        4'b0100: SSD_LED_out = 7'b1001100; // "4" 
        4'b0101: SSD_LED_out = 7'b0100100; // "5" 
        4'b0110: SSD_LED_out = 7'b0100000; // "6" 
        4'b0111: SSD_LED_out = 7'b0001111; // "7" 
        4'b1000: SSD_LED_out = 7'b0000000; // "8"     
        4'b1001: SSD_LED_out = 7'b0000100; // "9" 
        4'b1010: SSD_LED_out = 7'b1001000; // "H"
        4'b1011: SSD_LED_out = 7'b1001110; // "I"
        default: SSD_LED_out = 7'b0000001; // "0"

        endcase
    end
    
endmodule
