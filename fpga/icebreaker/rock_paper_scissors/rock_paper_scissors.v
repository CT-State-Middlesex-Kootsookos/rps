/* Small test design actuating all IO on the iCEBreaker dev board. */

module top (
	input  CLK,

	output LED1,
	output LED2,
	output LED3,
	output LED4,
	output LED5,

	input BTN_N,
	input BTN1,
	input BTN2,
	input BTN3,

	output LEDR_N,
	output LEDG_N,
);

	localparam ROCK = 1;
	localparam PAPER = 2;
	localparam SCISSORS = 3;

	localparam PERSON_WINS = 1; // RIGHT
	localparam COMPUTER_WINS = 2; // LEFT
	localparam TIE = 4; // Middle

	localparam LOG2DELAY = 200; /* 2162 Was 22; */
	localparam BIT_FOR_DELAY = 25;

	reg [LOG2DELAY-1:0] counter = 0;
	reg [1:0] person_choice;
	reg [1:0] computer_choice;
	reg [2:0] score_choice = 0;
	reg [2:0] score = 7;
	reg [0:0] score_set = 0;
	reg [0:0] start_value = 0;

	always @(posedge CLK) 
	begin
		counter <= counter + 1;
		if (BTN1 || BTN2 || BTN3)
		begin
			if (BTN1 && (person_choice == 0))
				person_choice = ROCK;
			if (BTN2 && (person_choice == 0))		
				person_choice = PAPER;
			if (BTN3 && (person_choice == 0))		
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
			if (counter[BIT_FOR_DELAY] != start_value)
			begin
				score_set = 0;
				score = 7;
				score_choice = 0;
				person_choice = 0;
			end
	end

	assign {LED1, LED2, LED3} = score;

endmodule
