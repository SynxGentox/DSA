// MARK: - Two Pointer Approach
// Iterating both pointers left and right by checking the sum if sum is greater than target than move right otherwise left
// We return index with + 1 on both since question askes for +1 index.
// Time Complexity: O(n), Space Complexit: O(1)
class Solution {
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        var left = 0
        var right = numbers.count - 1
        
        while left < right {
            var sum = numbers[left] + numbers[right]
            if sum == target {
                return [left + 1, right + 1]
            }
            else if sum > target {
                right -= 1
            }
            else {
                left += 1
            }
        }
        return []
    }
}

// MARK: - Another approach can be Shrinking Boundary Bianry Search.
// we simply iterate over left and right and shrink the boundary each iteraiton and on each iteration we can do Binary search , searching for the remining number(target - left) to complete the sum to match target.
