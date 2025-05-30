module hw_decoder(
    input wire clk,
    input wire [3:0] rows, 
    output wire [3:0] cols, 
    output wire [3:0] decoded_output, // Debugging output
    output wire button_led // Button press indicator
);

    wire [3:0] dec_out;
    wire button_pressed;

    decoder dec_inst (
        .clk_100MHz(clk),
        .row(rows),
        .col(cols),
        .dec_out(dec_out),
        .button_pressed(button_pressed)
    );

    assign decoded_output = dec_out; // Map to LEDs for easy debugging
    assign button_led = button_pressed; // LED ON when button is detected

endmodule