// MARK: - Sorting squence count Approach.
// Time Complexity: O(nlogn), Space Complexity: O(n)

// Approach:
/// In this approach we sort the input data, iterate over it check if see any seqence by checking if previous element is exactly 1 less or next is exactly 1 more than the current one. we count the sequence length using 'current += 1' and if sequence interupts we update the current max sequence length and reset the current sequence length count.
// This solution is fairly fast specially on Leetcode and for input with almost no dublicate its nearly same as has solution being only 9% slower.
class Solution1 {
    func longestConsecutive(_ nums: [Int]) -> Int {
        if nums.isEmpty { return 0 }
        
        let sortedNums = nums.sorted()
        
        var maxi = 1
        var current = 1
        
        for i in 1..<sortedNums.count {
            if sortedNums[i] == sortedNums[i - 1] {
                continue
            }
            
            if sortedNums[i] == sortedNums[i - 1] + 1 {
                current += 1
                continue
            }
            maxi = max(maxi, current)
            current = 1
        }
        
        maxi = max(maxi, current)
        return maxi
    }
}



// MARK: - HashSet Approach.
// Time Complexity: O(n), Space Complexity: O(n)

// Approach
/// We change th given input to Set type to remove dublicates, Iterate over the set and check for current element's previous if it true then we continue bcz if current element has a previous elmenet then current one isnt the root, when there is no previous then we know its the root and we run the while loop to sequence length for all next elements. Once we have updated the updated sequence length we check if max sequence length count needs to be updated or not.
// The most optimal solution, Its 9% faster than sorting approach for massive unique input and upto 8x faster than sorting for massive input containing dublicates with 1.9x less memory usage.
class Solution2 {
    func longestConsecutive(_ nums: [Int]) -> Int {
        let numbers = Set(nums)
        var longest = 0
        
        for num in numbers {
            if !numbers.contains(num - 1) {
                var current = num
                var length = 1
                
                while numbers.contains(current + 1) {
                    current += 1
                    length += 1
                    
                }
                
                longest = max(longest, length)
            }
        }
        
        return longest
    }
}
