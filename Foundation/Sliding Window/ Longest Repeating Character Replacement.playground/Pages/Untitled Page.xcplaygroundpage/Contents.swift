

class Solution {
    func characterReplacement(_ s: String, _ k: Int) -> Int {
        var leftPos = 0
        var sIndex = s.startIndex
        var maxLen = 0
        var sTracker: [Character: Int] = [:]
        var maxFreq = 0
        
        for rightPos in 0..<s.count {
            let char = s[sIndex]
            
            sTracker[char, default: 0] += 1
            maxFreq = max(maxFreq, sTracker[char]!)
            
            while rightPos - leftPos + 1 - maxFreq > k {
                let leftChar = s[s.index(s.startIndex, offsetBy: leftPos)]
                sTracker[leftChar]! -= 1
                leftPos += 1
            }
            maxLen = max(maxLen, rightPos - leftPos + 1)
            sIndex = s.index(after: sIndex)
        }
        return maxLen
    }
}
