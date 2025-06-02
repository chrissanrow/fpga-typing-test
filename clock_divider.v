`timescale 1ns / 1ps

module clock_divider(
    input wire clk,
    output reg one_hz_clk = 0,
    output reg fast_clk = 0,
    output reg slower_clk = 0
);
    reg [26:0] counter1 = 0;
    reg [18:0] counterFast = 0;
    reg [25:0] counterSlow = 0;

    // one_hz_clk:
    always @(posedge clk) begin
        if (counter1 >= 100_000_000 - 1) begin
            counter1 <= 0;
            one_hz_clk <= 1;
        end else begin
            counter1 <= counter1 + 1;
            one_hz_clk <= 0;
        end
    end

    // fast_clk:
    always @(posedge clk) begin
        if (counterFast >= 5_000 - 1) begin
            counterFast <= 0;
            fast_clk <= ~fast_clk;
        end else begin
            counterFast <= counterFast + 1;
        end
    end
    
    // fast_clk:
    always @(posedge clk) begin
        if (counterSlow >= 25_000_000 - 1) begin
            counterSlow <= 0;
            slower_clk <= ~slower_clk;
        end else begin
            counterSlow <= counterSlow + 1;
        end
    end
endmodule