// MARK: - Sliding Window(Fixed Size Window).

// MARK: - Sliding window sum comparison approach. Using While loop
// Time Complexity: O(n), Space Complexity: O(1)
class Solution {
    func findMaxAverage(_ nums: [Int], _ k: Int) -> Double {
        var left = 0
        var right = k - 1
        var sum = 0

        // Time Complexity: O(k)
        // Calculate size of first window
        for i in 0..<k {
            sum += nums[i]
        }
        var maxi = sum

        // Time Complexity: O(n-k)
        // Calculate Sum and Update Max if Sum > Max.
        /// Instead of recalculating Sum we subtract the previous element and add next element
        while right < nums.count-1 {
            right += 1
            sum = sum - nums[left] + nums[right]
            maxi = max(maxi, sum)
            // Increase left pointer by 1 after Sum calculation otherwise we would be subtracting upcomming left pointer element from Sum leading to wrong calculation and wrong output.
            left += 1
        }
        return Double(maxi)/Double(k)
    }
}


// MARK: Using For Loop
// This solution is consistently 1 - 2 ms faster as we are doing less work with for loop and for loop is more optimized by default as well.
// This solution also has better readability.
class Solution2 {
    func findMaxAverage(_ nums: [Int], _ k: Int) -> Double {
        var sum = 0

        for i in 0..<k {
            sum += nums[i]
        }

        var maxi = sum
        var left = 0

        for right in k..<nums.count {
            sum = sum - nums[left] + nums[right]
            left += 1
            maxi = max(maxi, sum)
        }

        return Double(maxi) / Double(k)
    }
}
