// The Brute force solutiion is the easiest but has O(n^2) time complexity using nested loop

// MARK: My Solution with AI helping with pointing edge cases and syntax errors only.
class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dict: [Int: Int] = [:]
        dict.reserveCapacity(nums.count)
        
        for (i, num) in nums.enumerated() {
            if let j = dict[target - num] {
                return [j, i]
            }
            dict[num] = i
            // just add the element which is less than target as key and index of that num as value.
        }
        return []
    }
}
