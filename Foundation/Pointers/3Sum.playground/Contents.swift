class Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var number = nums.sorted()
        var result: [[Int]] = []
        var mid = 0
        var right = 0

        guard number.count >= 3 else { return result }

        for left in 0..<(number.count-2) {
            if number[left] > 0 {
                break
            }
            // Skipping dublicated
            if left > 0 && number[left] == number[left-1] {
                continue
            }
            
            mid = left + 1
            right = number.count - 1
            
            while mid < right {
                let sum = number[left] + number[mid] + number[right]
                
                if sum == 0 {
                    result.append([number[left], number[mid], number[right]])
                    // Skipping dublicate
                    while mid < right && number[mid] == number[mid+1] {
                        mid += 1
                    }
                    while mid < right && number[right] == number[right-1] {
                        right -= 1
                    }
                    
                    mid += 1
                    right -= 1
                }
                else if sum < 0 {
                    mid += 1
                }
                else {
                    right -= 1
                }
            }
        }
        return result
    }
}
