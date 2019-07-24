/**
 * CS 2110 Spring 2019 HW2
 * Part 2 - Coding with bases
 *
 * @author Christopher Messina (cmessina6)
 *
 * Global rules for this file:
 * - You may not use more than 2 conditionals per method. Conditionals are
 *   if-statements, else-if statements, or ternary expressions. The else block
 *   associated with an if-statement does not count toward this sum. Boolean
 *   expressions outside of if-statements, else-if statements and ternary
 *   expressions do not count toward this sum either.
 * - You may not use more than 2 looping constructs per method. Looping
 *   constructs include for loops, while loops and do-while loops.
 * - You may not use nested loops.
 * - You may not declare any file-level variables.
 * - You may not declare any objects, other than String in select methods.
 * - You may not use switch statements.
 * - You may not use the unsigned right shift operator (>>>)
 * - You may not write any helper methods, or call any other method from this or
 *   another file to implement any method.
 * - The only Java API methods you are allowed to invoke are:
 *     String.length()
 *     String.charAt()
 * - You may not invoke the above methods from string literals.
 *     Example: "12345".length()
 * - When concatenating numbers with Strings, you may only do so if the number
 *   is a single digit.
 *
 * Method-specific rules for this file:
 * - You may not use multiplication, division or modulus in any method, EXCEPT
 *   decimalStringToInt.
 * - You may declare exactly one String variable each in intToBinaryString, intToOctalString,
 *   and intToHexString.
 */
public class Bases
{
    /**
     * Convert a string containing ASCII characters (in binary) to an int.
     * You do not need to handle negative numbers. The Strings we will pass in will be
     * valid binary numbers, and able to fit in a 32-bit signed integer.
     *
     * Example: binaryStringToInt("111"); // => 7
     */
    public static int binaryStringToInt(String binary)
    {
        int decimalNum = 0;
        int i = 0;
        while (i < binary.length()) {
            if (binary.charAt(binary.length() - 1 - i) == '1') {
                decimalNum |= 1 << i;
            }
            i++;
        }
        return decimalNum;
    }

    /**
     * Convert a string containing ASCII characters (in decimal) to an int.
     * You do not need to handle negative numbers. The Strings we will pass in will be
     * valid decimal numbers, and able to fit in a 32-bit signed integer.
     *
     * Example: decimalStringToInt("123"); // => 123
     *
     * You may use multiplication, division, and modulus in this method.
     */
    public static int decimalStringToInt(String decimal)
    {
        int val = 0;
        int i = 0;
        while (i < decimal.length()) {
            val *=10;
            val += decimal.charAt(i) - '0';
            i++;
        }
        return val;
    }

    /**
     * Convert a string containing ASCII characters (in octal) to an int.
     * The input string will only contain the numbers 0-7. You do not need to handle
     * negative numbers. The strings we will pass in will be valid octal numbers, and
     * able to fit in a 32-bit signed integer.
     *
     * Example: octalStringToInt("17"); // => 15
     */
    public static int octalStringToInt(String octal)
    {
        int index = 0;
        int val = 0;
        int number;
        int i = octal.length() - 1;
        while (i > -1) {
            number = octal.charAt(i--) - '0';
            val += number << index;
            index += 3;

        }
        return val;
    }

    /**
     * Convert a string containing ASCII characters (in hex) to an int.
     * The input string will only contain numbers and uppercase letters A-F.
     * You do not need to handle negative numbers. The Strings we will pass in will be
     * valid hexadecimal numbers, and able to fit in a 32-bit signed integer.
     *
     * Example: hexStringToInt("A6"); // => 166
     */
    public static int hexStringToInt(String hex)
    {
        int index = 0;
        int val = 0;
        int i = hex.length() - 1;
        while (i > -1) {
            int number = hex.charAt(i) - '0';
            if (hex.charAt(i) > '9') {
                number -= 7;
            }
            i--;
            val += number << index;
            index += 4;
        }
        return val;
    }

    /**
     * Convert a int into a String containing ASCII characters (in binary).
     * You do not need to handle negative numbers.
     * The String returned should contain the minimum number of characters necessary to
     * represent the number that was passed in.
     *
     * Example: intToBinaryString(7); // => "111"
     *
     * You may declare one String variable in this method.
     */
    public static String intToBinaryString(int binary)
    {
        String str = "";
        if (binary == 0) {
            return "0";
        }

        while (binary > 0) {
            if ((binary & 1) == 1) {
                str = "1" + str;
            } else {
                str = "0" + str;
            }
            binary = binary >> 1;
        }
        return str;
    }

    /**
     * Convert a int into a String containing ASCII characters (in octal).
     * The output string should only contain numbrs 0-7.
     * Tou do not need to handle negative numbers.
     * The String returned should contain the minimum numbers of characters necessary to
     * represent the number that was passed in.
     *
     * Example: intToOctalString(17); // => "21"
     */
    public static String intToOctalString(int octal)
    {
        String str = "";

        while (octal >= 1) {
            str = (octal - ((octal >> 3) << 3)) + str;
            octal = octal >> 3;
        }

        if (str == "") {
            return "0";
        }

        return str;
    }

    /**
     * Convert a int into a String containing ASCII characters (in hexadecimal).
     * The output string should only contain numbers and uppercase letters A-F.
     * You do not need to handle negative numbers.
     * The String returned should contain the minimum number of characters necessary to
     * represent the number that was passed in.
     *
     * Example: intToHexString(166); // => "A6"
     *
     * You may declare one String variable in this method.
     */
    public static String intToHexString(int hex)
    {
        String str = "";

        while (hex >= 1) {
            int cleared = (hex >> 4) << 4;
            if ((hex - cleared) > 9) {
                str = (char) ((hex - cleared) + 55) + str;
            } else {
                str = (hex - cleared) + str;
            }

            hex = hex >> 4;
        }

        if (str == "") {
            return "0";
        }

        return str;
    }
}
