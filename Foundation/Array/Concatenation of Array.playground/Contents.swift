import UIKit

// Standard Concatenation i.e. to concatenate only 2 times
class StandardConcatenation {
    func getConcatenation(nums: [Int]) -> [Int] {
        var arr = nums
        arr += arr
        /* arr.append(contentsOf: arr) */
        return arr
    }
}

// If Problem asks to Concatenate T times
class TConcatenation {
    func getConcatenated(nums: [Int], times: Int) -> [Int] {
        return Array(repeating: nums, count: times).flatMap { $0 }
    }
}

class TConcatenationOtherWay {
    func getConcatenation(nums: [Int], times: Int) -> [Int] {
        var ans: [Int] = []
        
        ans.reserveCapacity(nums.count * times)
        
        for _ in 0..<times {
            ans.append(contentsOf: nums)
        }
        return ans
    }
}
