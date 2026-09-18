// True: if string 2 contains string 1 or not and string 2 should have string 1 in series without any break.
class Solution {
    func checkInclusion(_ s1: String, _ s2: String) -> Bool {
        if s1.count > s2.count {
            return false
        }
        
        // Complexity Variables: s1 - m, s2 - n
        
        // UInt8 array for true O(1) lookups and no overhead.
        /// Not very memeory friendly but its fast significantly.
        var s1Arr = Array(s1.utf8)      // Space Complexity: O(m)
        var s2Arr = Array(s2.utf8)      // Space Complexity: O(n)
        
        var windowSize = s1Arr.count
        
        var window: [UInt8: Int] = [:]          // Current Sliding Window.
        var freqMap: [UInt8: Int] = [:]         // FreqMap of s1
        
        // Building FreqMap of s1
        /// Time Complexity: O(m)
        for i in 0..<s1Arr.count {
            freqMap[s1Arr[i], default: 0] += 1
        }
        
        // Time Complexity: O(n)
        for right in 0..<s2Arr.count {
            // Adding current Elements in Current window
            window[s2Arr[right], default: 0] += 1
            
            // It will run right from the next element after first window size as Right is an index and index operates from 0 to n - 1.
            if right >= windowSize {
                let leftChar = s2Arr[right - windowSize]
                window[leftChar]! -= 1
                
                // checks if element is no longer of use and has 0 freq, Removes it.
                if window[leftChar]! == 0 {
                    window[leftChar] = nil
                }
            }
            
            // Checks the s1 to be existing in s2 by checkeing the current window which is running in s2 with s1's freqMap.
            if window == freqMap {
                return true
            }
        }
        return false
    }
}
