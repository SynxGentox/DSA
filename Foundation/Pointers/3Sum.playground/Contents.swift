class Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var sortedNums = nums.sorted()
        var left = 0
        var right = sortedNums.count - 1
        var result: Set<[Int]> = []
        while left < right {
            for mid in (left+1)..<right {
                if nums[left] + nums[mid] + nums[right] == 0 {
                    let add: [Int] = [nums[left], nums[mid], nums[right]]
                    result.insert(add)
                }
            }
            right -= 1
        }
        return Array(result)
    }
}
