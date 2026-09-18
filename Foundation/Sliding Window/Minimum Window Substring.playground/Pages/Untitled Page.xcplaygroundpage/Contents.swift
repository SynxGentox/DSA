// MARK: - Minimum Window Substring — Approach
// MARK: - Idea
// We need to find the smallest contiguous substring of s that contains all characters of t with the required frequencies. Instead of processing every character of s equally, we can focus only on characters that are present in t.

// MARK: - Algorithm
// Convert s and t to UTF-8 arrays for efficient iteration.
// Build a frequency map for t: the key is the character and the value is the number of times that character is required.
// Traverse s and record the indices of only those characters that occur in t. This allows the left pointer to jump directly between relevant characters instead of moving through irrelevant characters.
// Use a sliding window over the recorded relevant indices. Start left and right at the beginning of the recorded-index array. Add the character at right to the current window’s frequency map. Once the current window contains all required character frequencies, record its actual s indices as a candidate answer.
// Shrink the window from the left. Move left to the next relevant character, update the current frequency map, and continue shrinking while the window still satisfies all requirements. This allows us to find the smallest valid window ending at the current right.
// Continue moving right until all relevant positions have been processed.
// Return the substring corresponding to the smallest recorded range.

// MARK: - Required Data Structures
// sArr: UTF-8 representation of s
// tArr: UTF-8 representation of t
// freqMapT: required frequency of each character in t
// recordSInd: indices in s containing characters relevant to t
// currWindow: frequency of relevant characters in the current window
// Variables to track the current window and the smallest valid range

// MARK: - Complexity
// Time: O(n + m)
// n = length of s
// m = length of t
// Each relevant position is processed a constant number of times.
// Space: O(n + m) in the worst case
// UTF-8 arrays + recorded relevant indices + frequency maps.

// MARK: - Core Insight
// Ignore characters that can never contribute to satisfying t, and slide the window only across relevant positions while maintaining their frequencies.

// MARK: - Snail-Sliding Window
class Solution {
    func minWindow(_ s: String, _ t: String) -> String {
        // Early exit for obviously false cases
        if t.isEmpty || s.isEmpty || t.count > s.count {
            return ""
        }

        let sArr = Array(s.utf8)
        let tArr = Array(t.utf8)

        // FreqMap for string T.
        var freqMapT: [UInt8: Int] = [:]

        // Creating FreqMap for string T
        for char in tArr {
            freqMapT[char, default: 0] += 1
        }

        // Store only positions(index) of s containing characters required by t
        var recordSInd: [Int] = []

        // Storing index of characters known by t
        for i in 0..<sArr.count {
            if freqMapT[sArr[i]] != nil {
                recordSInd.append(i)
            }
        }

        let uniqueInT = freqMapT.count
        // Early exit if s desn't have any or less than number of Unique Characters seen in t.
        if recordSInd.isEmpty || recordSInd.count < uniqueInT {
            return ""
        }

        // Current running sliding window
        var currWindow: [UInt8: Int] = [:]

        var left = 0
        var right = 0

        var formed = 0
        
        // Additional properties to store smallest range of index.
        var bestStart = 0
        /// Using Int.max to always be true at the first iteration.
        var bestEnd = Int.max

        // Loop until right reaches last required character.
        while right < recordSInd.count {

            // Storing Index of Required characters by iterating over the index of Recoreded Index.
            let rightPos = recordSInd[right]
            // Storing Currently Required Character(UTF-8).
            let char = sArr[rightPos]

            // Filling up Current Freq-Window to match the FreqMapT
            currWindow[char, default: 0] += 1

            // If Freq of Requied character matches freqMapT's character freq, increment formed by 1. so, it will have exactly same number of Unique Characters in both FreqMaps at max.
            if currWindow[char] == freqMapT[char] {
                formed += 1
            }

            // Runs only when currWindow satisfies FreqMapT.
            while formed == uniqueInT {

                // Storing Index of left most available character yet available in currWindow from recordSInd
                let leftPos = recordSInd[left]

                // Looking for smaller and smaller randge of index to get smallest window
                if rightPos - leftPos < bestEnd - bestStart {
                    bestStart = leftPos
                    bestEnd = rightPos
                }

                // Storing the left most character itself
                let leftChar = sArr[leftPos]
                // Reducing freq of left most character in currWindow to move on and look for next smaller subString
                currWindow[leftChar]! -= 1

                // If freq of current element in currWindow is less than required freq in freqMapT
                if currWindow[leftChar]! < freqMapT[leftChar]! {
                    formed -= 1
                }

                left += 1
            }

            right += 1
        }

        if bestEnd == Int.max {
            return ""
        }

        return String(decoding: sArr[bestStart...bestEnd], as: UTF8.self)
    }
}
