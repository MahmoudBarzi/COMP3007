//Name : Mahmoud Asadzadeh - Barzi
//Student Number : 100942882
import java.util.Arrays;
import java.util.Scanner;

public class comp3007_f18_100942882_a1_1{
	public String toLowerCase(String letter) {
		char character = letter.charAt(0);
		if(character >= 65 && character <=90) {//A = 65 & Z = 90 in ASCII 
			character = (char) ((character + 32));
		}
		String string = Character.toString(character);//cast it to a string
		return string;
	}
	public String toUpperCase(String letter) {
		char character = letter.charAt(0);
		if(character >= 97 && character <= 122) {//a = 97 & z = 122 in ASCII 
			character = (char) ((character - 32));
		}
		String string = Character.toString(character);
		return string;
	}
	public String toCamelCaseString(String string){
		int iterator = string.length()-1;
		if(iterator == 0) {
			return toUpperCase(string.substring(0,1));
		}
		else {
			String lowerCaseIt = toLowerCase(string.substring(iterator,iterator+1));
			String recursiveCall =toCamelCaseString(string.substring(0,iterator));
			return  recursiveCall + lowerCaseIt;
		}	
	}	
	public String toCamelCaseArray(String [] stringArray){
		int iterator = stringArray.length-1;
		if(iterator == 0) {
			String firstString = toCamelCaseString(stringArray[0]);//pick the first element in the  array of strings
			char firstCharacter = firstString.charAt(0);//pick the first character of the first element in the string
			//return the entire String in lower cases
			return toLowerCase(Character.toString(firstCharacter)) + firstString.substring(1);
		}
		else {
			String recursiveCall = toCamelCaseArray(Arrays.copyOfRange(stringArray,0,iterator--));
			String lowerCaseIt = toCamelCaseString(stringArray[stringArray.length-1]);
			return recursiveCall + lowerCaseIt;
		}
	}
	public boolean isUpperCase(char character) {//helper function check if its upper case
		if(character >= 65 && character <=90) {
			return true;
		}
		return false;	
	}
	public String toCombineTheCapitals(String string){
		int iterator = string.length()-1;
		if(iterator == 0) {
			if(isUpperCase(string.charAt(iterator))) {
				return Character.toString(string.charAt(iterator));
			}
			return "";
		}
		else {
			if(isUpperCase(string.charAt(iterator))){
				char theUpperCaseLetter = string.charAt(iterator);
				return toCombineTheCapitals(string.substring(0, iterator--)) + theUpperCaseLetter;
			}
			else {
				return toCombineTheCapitals(string.substring(0, iterator--));
			}
		}
	}
	public static void letTheProgramBegin(){
		Scanner readInput = new Scanner(System.in);// scan the input
		System.out.println("Please enter a phrase:");
		String string = readInput.nextLine();//pass it to a string
		if(string.length() == 0) {//check if its empty
			System.out.println("Invalid Input!");//throw a message
			letTheProgramBegin();//restart the program
		}
		else{
			String[] splittedString = string.split("\\s+");//split by spaces
			comp3007_f18_100942882_a1_1  obj = new comp3007_f18_100942882_a1_1();//make an object of the class
			String results = obj.toCombineTheCapitals(obj.toCamelCaseArray(splittedString));//call the object method with the array splittedString 
			System.out.println(results);
			System.out.println("Press enter to repeat this program or press any other key and then enter to end this program.");
		    String command = readInput.nextLine();//pass the result to a string
		    while(command!=null) {
		        if (command.isEmpty()){//if the user pressed enter 
		            letTheProgramBegin();//retstart the program
		        }
		        if (command.charAt(0)>= 0 || command.charAt(0)<= 127){//if the user enters a charatcer
			        	System.exit(0);//end the program
			    }
		        else {//any other possible case, end the program
		        		System.exit(0);
		        } 
		    }
		}	
	}
	public static void main(String[] args) {	
		letTheProgramBegin();
	}
}
