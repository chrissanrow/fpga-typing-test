`timescale 1ns / 1ps

module decoder(
    input clk,
    input [3:0] row,
    output reg [3:0] col,
    output reg [3:0] dec_out,
    output reg button_pressed
    );

    parameter SCAN_INTERVAL = 100_000;  // 1ms @ 100MHz
    parameter SAMPLE_DELAY = 2_000_000;     // 50us delay for row to settle

    reg [30:0] timer = 0;
    reg [1:0] col_select = 0;
    reg sampling = 0;
    reg [3:0] prev_row = 4'b1111;
    
    // Clock tick
    always @(posedge clk) begin
        timer <= timer + 1;
        
        if (!sampling && timer >= SCAN_INTERVAL) begin
            timer <= 0;
            col_select <= col_select + 1;
            sampling <= 1;
        end

        // Set active column based on col_select
        case (col_select)
            2'b00: col <= 4'b0111;
            2'b01: col <= 4'b1011;
            2'b10: col <= 4'b1101;
            2'b11: col <= 4'b1110;
        endcase
        
        
        // After delay, sample rows
        if (sampling && timer >= SAMPLE_DELAY) begin
            sampling <= 0;  // one-time sample per cycle
            //button_pressed <= 0;
            if (row != 4'b1111 && button_pressed == 0) begin
                button_pressed <= 1;
                case(col_select)
                    2'b00: begin
                        case(row)
                            4'b0111: dec_out <= 4'b0001;
                            4'b1011: dec_out <= 4'b0100;
                            4'b1101: dec_out <= 4'b0111;
                            4'b1110: dec_out <= 4'b0000;
                        endcase
                    end
                    2'b01: begin
                        case(row)
                            4'b0111: dec_out <= 4'b0010;
                            4'b1011: dec_out <= 4'b0101;
                            4'b1101: dec_out <= 4'b1000;
                            4'b1110: dec_out <= 4'b1111;
                        endcase
                    end
                    2'b10: begin
                        case(row)
                            4'b0111: dec_out <= 4'b0011;
                            4'b1011: dec_out <= 4'b0110;
                            4'b1101: dec_out <= 4'b1001;
                            4'b1110: dec_out <= 4'b1110;
                        endcase
                    end
                    2'b11: begin
                        case(row)
                            4'b0111: dec_out <= 4'b1010;
                            4'b1011: dec_out <= 4'b1011;
                            4'b1101: dec_out <= 4'b1100;
                            4'b1110: dec_out <= 4'b1101;
                        endcase
                    end
                endcase
            end
            
            if (row == 4'b1111 && button_pressed == 1) begin
                button_pressed <= 0;
                dec_out <= 4'b0001;
            end
        end
    end
endmodule
