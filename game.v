`timescale 1ns / 1ps

module game(
    input wire clk, // master clock
    input wire one_hz_clk, // 1-Hz clock
    input [3:0] dec, // decoded input
    input wire button_pressed, // Bit indicating button press
    input wire [3:0] rand_one, // random digits
    input wire [3:0] rand_two,
    input wire [3:0] rand_three,
    input wire [3:0] rand_four,
    output reg one_en, // enable each digit
    output reg two_en,
    output reg three_en, 
    output reg four_en,
    output reg acc_one_en, // enable each digit for accuracy
    output reg acc_two_en,
    output reg acc_digit_one, // accuracy digits
    output reg acc_digit_two,
    output reg [3:0] digit_one, // value of each digit
    output reg [3:0] digit_two,
    output reg [3:0] digit_three,
    output reg [3:0] digit_four
    );
    
    // array to hold the 4-digit number of words
    reg [3:0] num_words [0:3];
    integer total_words;
    reg [1:0] mode = 2'b00; // 0 => selection mode, 1 => test mode, 2 => result mode

    // test metrics
    integer missed = 0;
    integer elapsed_time = 0;
    integer wpm = 0;
    integer accuracy = 0; // accuracy percentage

    // test word handling
    reg [3:0] curr_word [0:3]; // randomly generated 4-digit word
    integer completed = 0; // tracks number of sets that have been progressed
    integer completed_digits = 0; // tracks number of digits that have been completed
    integer current_digit; // current digit of the user

    // edge detection register for button_pressed
    reg button_pressed_last = 0;
    reg button_rising_edge;
    //assign button_rising_edge = button_pressed & ~button_pressed_last;
    
    initial begin
        num_words[3] = 4'b0000;
        num_words[2] = 4'b0000;
        num_words[1] = 4'b0000;
        num_words[0] = 4'b0000;
        one_en = 1;
        two_en = 1;
        three_en = 1;
        four_en = 1;
        acc_one_en = 0;
        acc_two_en = 0;
        current_digit = 3;
    end

    // MAIN GAME LOGIC
    always @(posedge clk) begin
        button_rising_edge <= button_pressed & ~button_pressed_last;
        button_pressed_last <= button_pressed;
        if (button_rising_edge) begin
            // if B is pressed, reset to mode screen
            if (dec == 4'b1011) begin
                if(mode == 2'b00) begin // if already in mode, reset num_words
                    num_words[3] = 4'b0000;
                    num_words[2] = 4'b0000;
                    num_words[1] = 4'b0000;
                    num_words[0] = 4'b0000;
                end
                else begin
                    mode <= 2'b00; // reset to select mode
                end

                // reset all game variables
                current_digit <= 3;
                completed_digits <= 0;
                completed <= 0;
                accuracy <= 0;
                acc_digit_one <= 0;
                acc_digit_two <= 0;
                missed <= 0;
                elapsed_time <= 0;
                one_en <= 1;
                two_en <= 1;
                three_en <= 1;
                acc_one_en <= 0;
                acc_two_en <= 0;
            end
            // SELECT MODE
            else if (mode == 2'b00) begin
                one_en <= 1;
                two_en <= 1;
                three_en <= 1;
                four_en <= 1;

                acc_one_en <= 0;
                acc_two_en <= 0;

                // if A is pressed => begin test
                if (dec == 4'b1010 &&
                    !(num_words[3] == 4'b0000 &&
                    num_words[2] == 4'b0000 &&
                    num_words[1] == 4'b0000 &&
                    num_words[0] == 4'b0000))
                begin
                    mode <= 2'b01;
                    current_digit <= 3;
                    missed <= 0;
                    elapsed_time <= 0;

                    acc_one_en <= 1;
                    acc_two_en <= 1;

                    total_words <= num_words[0] * 1000 + num_words[1] * 100 + num_words[2] * 10 + num_words[3];
                    curr_word[0] <= rand_four;
                    curr_word[1] <= rand_three;
                    curr_word[2] <= rand_two;
                    curr_word[3] <= rand_one;
                end
                else begin
                    num_words[3] <= num_words[2];
                    num_words[2] <= num_words[1];
                    num_words[1] <= num_words[0];
                    num_words[0] <= dec;
                end
            end
            // TEST MODE
            else if (mode == 2'b01) begin

                if (completed_digits != 0) begin
                    accuracy <= (completed_digits - missed) * 100 / completed_digits;
                end
                else begin
                    accuracy <= 0; // avoid division by zero
                end

                //FIXME: handle 100% accuracy
                if (accuracy >= 100) begin
                    acc_digit_one <= 4'b1010;
                    acc_digit_two <= 4'b1011;
                end
                else begin
                    acc_digit_two <= accuracy % 10; // ones place
                    acc_digit_one <= (accuracy % 100) - acc_digit_two; // tens place
                end

                if (dec == curr_word[current_digit]) begin
                    completed_digits <= completed_digits + 1;
                    // move to the next digit if there are any remaining
                    if (current_digit > 0) begin
                        current_digit <= current_digit - 1;
                        // disable completed digit
                        if (current_digit == 3) begin
                            one_en <= 0;
                        end
                        else if (current_digit == 2) begin
                            two_en <= 0;
                        end
                        else if (current_digit == 1) begin
                            three_en <= 0;
                        end
                    end
                    else begin
                        // if all digits are correct, generate new word
                        curr_word[0] <= rand_one;
                        curr_word[1] <= rand_two;
                        curr_word[2] <= rand_three;
                        curr_word[3] <= rand_four;

                        // re-enable digits
                        one_en <= 1;
                        two_en <= 1;
                        three_en <= 1;
                        current_digit <= 3;

                        completed <= completed + 1;
                        
                        if (completed >= total_words) begin
                            // TODO: handle completion of test
                            mode <= 2'b10;
                            wpm <= completed / (elapsed_time / 60);
                        end
                    end
                end
                else begin
                    // if the digit is incorrect, increment missed count
                    missed <= missed + 1;
                end
            end
            // RESULT MODE
            else if (mode == 2'b10) begin
                //display words per minute
                // FOR NOW, just use two digits for WPM
                one_en <= 0;
                two_en <= 0;
                three_en <= 1;
                four_en <= 1;
            end
        end
    end

    // ELAPSED TIME LOGIC
    always @(posedge one_hz_clk) begin
        if (mode == 2'b01) begin
            elapsed_time <= elapsed_time + 1;
        end
    end
    
    // DIGIT DISPLAY LOGIC
    always @(*) begin
        // SELECT MODE
        if (mode == 2'b00) begin
            digit_one = num_words[3];
            digit_two = num_words[2];
            digit_three = num_words[1];
            digit_four = num_words[0];
        end
        else if (mode == 2'b01) begin
            digit_one = curr_word[3];
            digit_two = curr_word[2];
            digit_three = curr_word[1];
            digit_four = curr_word[0];
        end
        else if (mode == 2'b10) begin
            // RESULT MODE
            digit_three = (wpm / 10) - (wpm % 10);
            digit_four = wpm % 10;
        end
    end
endmodule
