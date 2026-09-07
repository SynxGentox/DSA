class Solution {
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        var left = 0
        var right = numbers.count - 1
        
        while numbers[left] < target {
            var mid = (left + right)/2
            var find = target - numbers[left]
            
            if numbers[mid] > find {
                right = mid - 1
            }
            else if numbers[mid] < find {
                left = mid + 1
            }
            else if numbers[mid] == find && numbers[mid] != numbers[left] {
                return [left, mid]
            }
        }
        return []
    }
}
