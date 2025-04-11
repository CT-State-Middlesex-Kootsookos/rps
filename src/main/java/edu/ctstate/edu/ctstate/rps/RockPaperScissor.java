package edu.ctstate.rps;

import java.util.*;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

public class RockPaperScissor {

	static private String resultsFile = "results_rps.map";
	static String userInitials = null;

	private static Map<String, Integer> map = new HashMap<String, Integer>();
	
			public static void writeObject(Object object, String name)
		{
			try {
				FileOutputStream fos = new FileOutputStream(name);
				ObjectOutputStream oos = new ObjectOutputStream(fos);
				oos.writeObject(object);
				oos.close();
			}
			catch (Exception ex) {
				System.err.println("Unable to serialize " + name + ": " + ex.getLocalizedMessage());
				ex.printStackTrace();
			}
		}
	
		public static boolean fileExists(String fileName)
		{
			File f = new File(fileName);
			return f.exists() && !f.isDirectory(); 
		}
	
		public static boolean isDirectory(String fileName)
		{
			File f = new File(fileName);
			return f.isDirectory(); 
		}
	
		public static Object readObject(String name)
		{
			Object theReadObject = null;
			try {
				FileInputStream fis = new FileInputStream(name);
				ObjectInputStream ois = new ObjectInputStream(fis);
				theReadObject =  ois.readObject();
	
				ois.close();
			}
			catch (Exception ex) {
				System.err.println("Unable to deserialize " + name + ": " + ex.getLocalizedMessage());
				ex.printStackTrace();
			}
	
			return theReadObject;
		}
	
		
		public static void main(String[] args) {
			boolean newUesr = true;
	
			// Read user results from file if it exists
			
			if (fileExists(resultsFile)) {
				map = (Map<String, Integer>) readObject(resultsFile);
				System.out.println("User results loaded from file: " + resultsFile);
			} else {
				System.out.println("No previous results found. Starting fresh.");
			}

			int max = -1;
			String highScorer = "";

			for (Map.Entry<String, Integer> entry : map.entrySet()) {
				System.out.println("User: " + entry.getKey() + ", Wins: " + entry.getValue());
				if (entry.getValue() > max) {
					max = entry.getValue();
					highScorer = entry.getKey();
				}
			}

			System.out.println("Highest scorer: " + highScorer + " with " + max + " wins.");
		
			Scanner scn = new Scanner(System.in);
			
			while(true) {

			int winsByUser = 0;
			if (map.containsKey(userInitials)) {
				System.out.println("Welcome back " + userInitials + "!");
				winsByUser = map.get(userInitials);
				System.out.println("You have " + winsByUser + " wins.");
			}
	
			while (userInitials == null)
			{
				if (newUesr)
				{
				//0. Enter user initials
					System.out.println("Enter your initials : ");
					userInitials = scn.nextLine();
					System.out.println("Welcome " + userInitials + "!");
					System.out.println();
					winsByUser = 0;
					newUesr = false;					
				}	
			}

				
			//1. RANDOMIZED COMPUTER MOVE
			
				// array of string containing available moves.
				String [] availableMoves = {"Rock", "Paper", "Scissors"};
			
				// using Random() function on indices of array so that it chooses a random move.
				String computerMove = availableMoves[new Random().nextInt(availableMoves.length)];
			
				System.out.println("Computer has chosen it's move.");
				System.out.println();
				System.out.println("Now it's your turn to choose. Good Luck!");
				System.out.println();
			
			//2. PLAYER MOVE
			
				//input
				String userMove;
			
				// loop until the user chooses the correct move
				while(true) {
					System.out.println("Please choose your move from these available moves : 'Rock' 'Paper' 'Scissors' ");
					System.out.println("Enter the move you chose : ");
					userMove = scn.nextLine();
				
					// checking if user's move is one of the available moves or not
					if(userMove.toLowerCase().equals("rock") 
					|| userMove.toLowerCase().equals("paper") 
					|| userMove.toLowerCase().equals("scissors")
					|| userMove.toLowerCase().equals("no"))
					{
						System.out.println();
						break;
					}
				
					// if user didn't enter a valid input
					System.out.println();
					System.out.println("Invalid Move!!");
					System.out.println("Please enter the move from the available moves only!");
					System.out.println();
				}
			
				//printing what computer chose
				System.out.println("Computer chose : " + computerMove);
			
			//3. COMPARING THE MOVES & DECIDING THE WINNER
			
				// checking for a tie
			
				if(userMove.toLowerCase().equals(computerMove.toLowerCase())) {
					System.out.println("Its a tie!");
				}
			
				//checking for all other moves possible
			
				else if(userMove.toLowerCase().equals("rock")) {
				
					if(computerMove.equals("Paper")) {
						System.out.println("Computer won!");
						System.out.println("Better luck next time!");
					} 
					else if(computerMove.equals("Scissors")) {
						System.out.println("You won!");
						System.out.println("Congratulations!");
						winsByUser += 1;
						map.put(userInitials, winsByUser);
					}
				}
			
				else if(userMove.toLowerCase().equals("paper")) {
				
					if(computerMove.equals("Rock")) {
						System.out.println("You won!");
						System.out.println("Congratulations!");
						winsByUser += 1;
						map.put(userInitials, winsByUser);
					} 
					else if(computerMove.equals("Scissors")) {
						System.out.println("Computer won!");
						System.out.println("Better luck next time!");
					}
				}
			
				else if(userMove.toLowerCase().equals("scissors")) {
				
					if(computerMove.equals("Paper")) {
						System.out.println("You won!");
						System.out.println("Congratulations!");
						winsByUser += 1;
						map.put(userInitials, winsByUser);
					} 
					else if(computerMove.equals("Rock")) {
						System.out.println("Computer won!");
						System.out.println("Better luck next time!");
					}
				}

				else if (userMove.toLowerCase().equals("no")) {
					System.out.println();
					System.out.println("*****************************************************************************");
					System.out.println();
					map.put(userInitials, winsByUser);
					writeObject(map, resultsFile);
					break;
				 
				}			
		}
	}
}
