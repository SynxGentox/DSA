// MARK: - Optimal Solution using prefix and postfix product
// Time Complexity: O(n), Space Complexity: O(1) extraSpace (output array doesnt counts)

// This solution uses product of prefixes and postfixes
// Prefix Product calculation: from 0 to n.    (current element *  current product iterating form 0 to n)
// Postfix Product calculation: from n to 0    (current element *  current product iterating form n to 0)
/// E.g. - [1, 2, 3, 4],
/// Prefix Product: [1, 2, 6, 24] = -->(1*1, 2*1, 3*2, 4*6)
/// Postfix Product: [24, 24, 12, 4] = (1*24, 2*12, 3*4, 4*1)<--
// Once we have Prefix and Postfix product arrays, we can product the current element's prefix value from prefix product array with postfix value from postfix product array.
// Suppose current element's index in given array = i, then product except self = (PrefixProdArray[i-1] * PostfixProdArray[i+1])
// This calculation will give use the product of all elements except self.

class Solution {
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        var arr: [Int] = Array(repeating: 1, count: nums.count)
        var prefix = 1
        var postfix = 1
        
        // Since we were asked to solve it in O(1) extraSpace, we skipped the prefix and postfix array and directly product the values directly into the array and incrementing to next value.
        for i in 0..<nums.count {
            // Producting with new array's current value since the prefix of 1st element would be 1 by default.
            arr[i] *= prefix
            // Producting the prefix value with current element from given array to change the prefix value for next iteration.
            prefix *= nums[i]
        }
        for i in stride(from: nums.count - 1, through: 0, by: -1) {
            // Producting with new array's current value since the postfix of last element would be 1 by default.
            arr[i] *= postfix
            // Producting the postfix value with current element from given array to change the postfix value for next iteration.
            postfix *= nums[i]
        }
        return arr
    }
}
