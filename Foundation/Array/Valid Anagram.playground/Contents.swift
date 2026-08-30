

// MARK: - Defensibel and the most micro-optimized solution.
// My and Neetcode with AI fixes and improvements.
class Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else {
            return false
        }
        if s.isEmpty {
            return true
        }
        var hashMap: [Character: Int] = [:]
        hashMap.reserveCapacity(s.count)
        
        for char in s {
            hashMap[char, default: 0] += 1
        }
        for char in t {
            hashMap[char, default: 0] -= 1
        }
        return hashMap.values.allSatisfy { $0 == 0 }
    }
}

// MARK: - LeetCode, Question Constraints Specific Solution but unsafe.
class Solution2 {
    func isAnagram(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else { return false }
    
    return getAsciArray(s: s) == getAsciArray(s: t)
}

func getAsciArray(s: String) -> [Int] {
    var arra: [Int] = Array.init(repeating: 0, count: 26)
    
    for item in s.utf8 {
        arra[Int(item) - 97] += 1
    }
    return arra
}
}
