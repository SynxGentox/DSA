import UIKit

class Concatenation {
    func getConcatenated(nums: [Int]) -> [Int] {
        return Array(repeating: nums, count: 2).flatMap { $0 }
    }
}
