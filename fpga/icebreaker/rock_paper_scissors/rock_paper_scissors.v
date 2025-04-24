/* Small test design actuating all IO on the iCEBreaker dev board. */

module top (
	input  CLK,

	output LED1,
	output LED2,
	output LED3,
	output LED4,
	output LED5,

	input BTN1,
	input BTN2,
	input BTN3,

	input P1A1,
	input P1A2,
	input P1A3,

	output P1A10,
	output P1A9,
	output P1A8
);

	localparam ROCK = 1;
	localparam PAPER = 2;
	localparam SCISSORS = 3;

	localparam PERSON_WINS = 1; // RIGHT
	localparam COMPUTER_WINS = 2; // LEFT
	localparam TIE = 4; // Middle

	localparam LOG2DELAY = 200; /* 2162 Was 22; */
	localparam BIT_FOR_DELAY = 26;

	reg [LOG2DELAY-1:0] counter = 0;
	reg [1:0] person_choice;
	reg [1:0] computer_choice;
	reg [2:0] score_choice = TIE;
	reg [2:0] score = TIE;
	reg [2:0] led_flashing = PERSON_WINS;
	reg [0:0] score_set = 0;
	reg [0:0] start_value = 0;
	reg [0:0] flash_leds = 1;
	reg [0:0] button_rock = 0;
	reg [0:0] button_paper = 0;
	reg [0:0] button_scissors = 0;

	always @(posedge CLK) 
	begin
		counter <= counter + 1;

		button_rock = BTN1 || !P1A1;
		button_paper = BTN2 || !P1A2;
		button_scissors = BTN3 || !P1A3;

		if (button_rock || button_paper || button_scissors)
		begin
			flash_leds = 0;
			if (button_rock && (person_choice == 0))
				person_choice = ROCK;
			if (button_paper && (person_choice == 0))		
				person_choice = PAPER;
			if (button_scissors && (person_choice == 0))		
				person_choice = SCISSORS;

			if (score_set == 0)
			begin
				score_set = 1;
				computer_choice = counter[1:0];
				if (computer_choice == 0)
					computer_choice = PAPER;

				if (person_choice == computer_choice)
					score_choice = TIE;

				if ((person_choice == ROCK) && (computer_choice == SCISSORS))
					score_choice =  PERSON_WINS;
				if ((person_choice == ROCK) && (computer_choice == PAPER))
					score_choice =  COMPUTER_WINS;

				if ((person_choice == PAPER) && (computer_choice == SCISSORS))
					score_choice =  COMPUTER_WINS;
				if ((person_choice == PAPER) && (computer_choice == ROCK))
					score_choice =  PERSON_WINS;

				if ((person_choice == SCISSORS) && (computer_choice == PAPER))
					score_choice =  PERSON_WINS;
				if ((person_choice == SCISSORS) && (computer_choice == ROCK))
					score_choice =  COMPUTER_WINS;

				score = score_choice;
				start_value = counter[BIT_FOR_DELAY];
			end
		end
		else
			begin
				if (counter[BIT_FOR_DELAY] != start_value)
				begin
					score_set = 0;
					score_choice = 0;
					person_choice = 0;
					flash_leds = 1;
				end
			end
		if (flash_leds)
		begin
			if (counter[BIT_FOR_DELAY-5])
				led_flashing = TIE;
			else
				led_flashing = COMPUTER_WINS | PERSON_WINS;
								
			score = led_flashing;
		end
	end

	assign {LED1, LED2, LED3} = score;
	assign {P1A10, P1A9, P1A8} = score;

endmodule
