// MARK: - HashMap Solution (General and Fairly Fast)
// Time Complexity: O(n), Space Complexity: O(1)
/// Space Complexity:  This solution is O(1) in space complexity as it doesnt scales with output increase, for input that are in english the HashMap can only extend to 26 letters for each Case.
/// Time Complexity: This is a True O(n) time scaling solution, however it has heavy hashing and probing Overhead.

// Working:
/// This solution uses HashMap to keep track of dublicates and to iterate of String we are using String.Index bcz direct iteration over string has O(n) time scaling Look-up , while we can convert String to Array but would mean O(n) space.
/// String.Index to iterate over String, left and right pointer to keep track of length


class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        // Early exit for string with length < 1.
        guard s.count > 1 else { return s.count }
        // HashMap to keep track of dublicates.
        var lastSeen: [Character: Int] = [:]
        lastSeen.reserveCapacity(s.count) 
        
        // left and right pointer to keep the track of the length using a sliding window.
        var leftPos = 0
        var rightPos = 0
        // right - String.Index to iterate over String in O(1) time and O(1) space complexity.
        var rightIdx = s.startIndex
        var maxLen = 0
        
        while rightIdx < s.endIndex {
            let char = s[rightIdx]
            
            // If we locate a dublicates we update Left pointer to next element of the last element seen.
            if let seenPos = lastSeen[char], seenPos >= leftPos {
                leftPos = seenPos + 1
            }
            
            // updating the saved previous String.Index of character 'char' to new right pointer which is holding the index values
            lastSeen[char] = rightPos
            
            // updaing the maxLen, length of longest non-repeating subString.
            maxLen = max(maxLen, rightPos - leftPos + 1)
            
            // updating the right String.Index to next String.Index of it.
            /// It can have more than O(1) time scaling as we cant pre determine the length of grapheme cluster. it can only be determined after operating over it grapheme cluster.
            rightIdx = s.index(after: rightIdx)
            
            // incrementing the right pointer by 1
            rightPos += 1
        }
        return maxLen
    }
}


// MARK: - Array Solution (Fixed Sized Array, Constraints biased)
// Time Complexity: O(n), Space Complexity: O(n)
class Solution2 {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        // Converting String to UInt8(character's ascii value) character code Array.
        // Space Complexity: O(n)
        let chars = Array(s.utf8)

        // Creating an Array of size 128 according to the input(numbers and english characters) ascii value range
        /// This array has the size of range which covers every possible distince character's  ascii value.
        /// E.g. - a -> 97(ascii value), so at 97th index in this array we will be storing the position of a appeared in the given string and updating it to latest if repeated.
        var lastSeen = Array(repeating: -1, count: 128)
        var left = 0
        var maxLength = 0

        // Iterating over the length of given string.
        /// we shouldn't directly iterate over the char array as we need 'right' which is the position of characters to store in 'lastSeen' array.
        for right in 0..<chars.count {
            // Storing ascii value of characters as int
            let char = Int(chars[right])

            // Checking for any preexisting value in lastSeen array at index-ascii value of character.
            /// we are comparing it to left instead of -1 as dublicate value will also be above -1 and won't be detected.
            if lastSeen[char] >= left {
                
                // Proceeding the left to just to the next value's index.
                left = lastSeen[char] + 1
            }

            // Updating the stored value to the last seen index in string
            lastSeen[char] = right

            // Updating the maxLength to max length between maxLength and current non repeating subString.
            maxLength = max(maxLength, right - left + 1)
        }
        return maxLength
    }
}
