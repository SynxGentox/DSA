class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        guard s.count > 1 else { return s.count }
        
        var sTracker: [Character: String.Index] = [:]
        sTracker.reserveCapacity(s.count)
        
        var left = s.startIndex
        var right = left
        var maxLen = 0
        var count = 0
        
        while right < s.endIndex {
            let char = s[right]
            if let seen = sTracker[char], seen >= left {
                left = s.index(after: seen)
                count = 0
            }
            sTracker[char] = right
            maxLen = max(maxLen, (s.distance(from: left, to: right) + 1))
            right = s.index(after: right)
            count += 1
        }
        return maxLen
    }
}
