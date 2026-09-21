class Solution {
    func main(_ n: Int, _ x: Int, _ arr: [Int]) {
        var left = 0
        var right = 0
        var sum = 0
        var count = 0
        
        while right < n, left < n {
            if sum > x {
                sum -= arr[left]
            }
            else if sum == x {
                count += 1
                sum -= arr[left]
                left += 1
            }
            sum += arr[right]
            right += 1
        }
        print("final count: \(count)")
    }
}

Solution().main(5, 7, [2, 4, 1, 2, 7])
