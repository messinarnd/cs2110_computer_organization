/**
 * CS 2110 Spring 2019 HW2
 * Part 1 - Coding a bit vector
 *
 * @author Christopher Messina (cmessina6)
 *
 * Global rules for this file:
 * - Some of these functions must be completed in ONE statement. That means they should be
 *   of the form "return [...];", with a single semicolon. No partial credit will be
 *   awarded for any Method that isn't completed with one statement.
 *
 * - You may not use multiplication, division or modulus in any method.
 * - You may not use more than 2 conditionals per method, and you may only use
 *   them in select methods. Conditionals are if-statements, else-if statements,
 *   or ternary expressions. The else block associated with an if-statement does
 *   not count toward this sum. Boolean expressions outside of if-statements,
 *   else-if statements and ternary expressions do not count toward this sum
 *   either.
 * - You may not use looping constructs in most methods. Looping constructs
 *   include for loops, while loops and do-while loops. See below for exceptions
 * - In those methods that allow looping, you may not use more than 2 looping
 *   constructs, and they may not be nested.
 * - You may not declare any file-level variables.
 * - You may not declare any objects, other than String in select methods.
 * - You may not use switch statements.
 * - You may not use casting.
 * - You may not use the unsigned right shift operator (>>>)
 * - You may not write any helper methods, or call any other method from this
 *   file, another file, or the Java API to implement any method.
 * - You may only perform addition or subtraction with the number 1.
 *
 * Method-specific rules for this file:
 * - You may declare exactly one String variable, in toPaddedBinaryString only.
 * - Iteration may not be used in set, clear, toggle, isSet or isClear.
 * - Conditionals may not be used in set, clear, toggle, isSet, or isClear.
 */
public class BitVector
{
    /**
     * 32-bit data initialized to all zeros. Here is what you will be using to represent
     * the Bit Vector. Do not change its scope from private.
     */
    private int bits;

    /** You may not add any more fields to this class other than the given one. */

    /**
     * Sets the bit (sets to 1) pointed to by index.
     * You may not use iteration or conditionals in this method.
     * This function must be completed in ONE statement
     * @param index index of which bit to set.
     *        0 for the least significant bit (right most bit).
     *        31 for the most significant bit.
     */
    public void set(int index)
    {
        // Sets bits = bits OR (0..010..0) where the 1 is in the specified index
        // This sets the bit at that index to 1
        bits |= (1 << index);
    }

    /**
     * Clears the bit (sets to 0) pointed to by index.
     * You may not use iteration or conditionals in this method.
     * This function must be completed in ONE statement
     * @param index index of which bit to set.
     * 	      0 for the least significant bit (right most bit).
     * 	      31 for the most significant bit.
     */
    public void clear(int index)
    {
        // Sets bits = bits AND (1..101..1) where the 0 is in the specified index
        // This sets the bit at that index to 0 (first set to 00100 then negate all)
        bits &= ~(1 << index);
    }

    /**
     * Toggles the bit (sets to the opposite of its current value) pointed to by index.
     * You may not use iteration or conditionals in this method.
     * This function must be completed in ONE statement
     * @param index index of which bit to set.
     * 	      0 for the least significant bit (right most bit).
     * 	      31 for the most significant bit.
     */
    public void toggle(int index)
    {
        // XOR with (0..010..0) because..
        // for 0's: if bits has a 1, xor remains true; if bits has a 0, xor remains false
        // for the 1 (toggle): if bits has a 1, xor becomes false; if bits has a 0, xor becomes true
        bits ^= (1 << index);
    }

    /**
     * Returns true if the bit pointed to by index is currently set.
     * You may not use iteration or conditionals in this method.
     * This function must be completed in ONE statement
     * @param index index of which bit to check.
     * 	      0 for the least significant bit (right-most bit).
     * 	      31 for the most significant bit.
     * @return true if the bit is set, false if the bit is clear.
     *         If the index is out of range (index >= 32), then return false.
     */
    public boolean isSet(int index)
    {
        // AND with 0..010..0 to set everything to 0 except index if bits at index is 1
        // Why do we need to check the length? if it runs over would the extra bits not be ignored?
        return (bits & (1 << index)) != 0 && index < 32;
    }

    /**
     * Returns true if the bit pointed to by index is currently clear.
     * You may not use iteration or conditionals in this method.
     * This function must be completed in ONE statement
     * @param index index of which bit to check.
     * 	      0 for the least significant bit (right-most bit).
     * 	      31 for the most significant bit.
     * @return true if the bit is clear, false if the bit is set.
     *         If the index is out of range (index >= 32), then return true.
     *         ^^^^^^^ PLEASE READ THAT LINE ^^^^^^^
     */
    public boolean isClear(int index)
    {
        return !((bits & (1 << index)) != 0 && index < 32);
    }

    /**
     * Returns a string representation of this object.
     * Return a string with the binary representation of the bit vector.
     * You may use String concatenation (+) here.
     * You must return a 32-bit string representation.
     * i.e if the bits field was 2, then return "00000000000000000000000000000010"
     *
     * You may declare one String variable in this method.
     * You may use looping constructs in this method. See above for clarification
     * on this rule
     */
    public String toPaddedBinaryString()
    {
        String returnString = "";
        int i = 0;
        while (i < 32) {
//            System.out.println("IM LOoKING HERE: " + number);
//            System.out.println("i: " + i);
            if (((bits >> i) & 1) == 1) {
                returnString = "1" + returnString;
                i++;
            } else {
                returnString = "0" + returnString;
                i++;
            }
        }
        return returnString;
    }

    /**
     * Returns the number of bits currently set (=1) in this bit vector.
     * You may use the ++ operator to increment your counter. Remember that
     * the bit-vector is a 32 bit int.
     *
     * You may use looping constructs in this method. See above for clarification
     * on this rule
     */
    public int onesCount()
    {
        int i = 0;
        int count = 0;
        while (i < 32) {
            if (((bits >> i) & 1) == 1) {
                count++;
            }
            i++;
        }
        return count;
    }

    /**
     * Returns the number of bits currently clear (=0) in this bit vector.
     * You may use the ++ operator to increment your counter. Remember that
     * the bit-vector is a 32 bit int.
     *
     * You may use looping constructs in this method. See above for clarification
     * on this rule
     */
    public int zerosCount()
    {
        int i = 0;
        int count = 0;
        while (i < 32) {
            if (((bits >> i) & 1) == 0) {
                count++;
            }
            i++;
        }
        return count;
    }

    /**
     * Returns the "size" of this BitVector. The size of this bit vector is defined
     * to be the minimum number of bits that will represent all of the ones.
     * For example, the size of the bit vector 00010000 will be 5. The minimum
     * number of bits needed will always be 1.
     *
     * You may use looping constructs in this method. See above for clarification
     * on this rule
     */
    public int size()
    {
        // Look at this one again
        int min = 32;
        for (int i = 31; i > -1; i--) {
            if (min > 1) {
                if (!((bits & (1 << i)) == 0)) {
                    return min;
                }
                min--;
            }
        }
        return min;
    }
}
