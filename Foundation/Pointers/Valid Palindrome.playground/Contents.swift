// MARK: - Most Optimal Solution & My approach as well
// Here instead of creating an array and then iterating over it, we are directly using String.Index to point at each Position in a String("Unicode Grapheme Cluster Index" what i like to call it) to directly iterate over it from the memory with O(1) Time complexity.
// Placing 2 such String.Indexers ("Unicode Grapheme Cluster Indexer" what i like to call it).
class Solution {
    // Time Complexity: O(n), Space Complexity: O(1)
    func isPalindrome(_ s: String) -> Bool {
        let str = s.lowercased()
        // Reasoning: same instinct as the encode/decode problem — read the
        // string in-place with String.Index instead of converting to an array,
        // avoiding the per-character memory overhead of a [Character] copy
        var left = str.startIndex
        // Working: endIndex is one-past-the-end, not a valid position —
        // step back once to land on the actual last character.
        var right = str.index(before: str.endIndex)
        
        // Working: drive the loop by the pointers meeting, not a fixed count —
        // some steps only move one pointer (skipping punctuation), so the
        // number of iterations isn't knowable in advance.
        while left < right {
            
            if !str[left].isLetter && !str[left].isNumber {
                // Reasoning: alphanumeric means letters AND digits count —
                // isLetter alone would wrongly skip digits too.
                left = str.index(after: left)
                continue
            }
            else if !str[right].isLetter && !str[right].isNumber {
                right = str.index(before: right)
                continue
            }
            else if str[left] == str[right] {
                left = str.index(after: left)
                right = str.index(before: right)
                continue
            }
            else {
                return false
            }
        }
        return true
    }
}
