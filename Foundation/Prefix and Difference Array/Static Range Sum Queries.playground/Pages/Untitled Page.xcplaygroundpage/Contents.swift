class Solution {
    func main(_ n: Int, _ q: Int, _ arr: [Int], _ quaries: [[Int]]) {
        if arr.isEmpty {
            print("Input array is empty")
            return
        }
        print(arr)
        
        var pref: [Int] = [arr[0]]
        
        for i in 1..<n {
            pref.append(pref[i-1] + arr[i])
        }
        print(pref)
        
        var qurySum: [Int] = []
        
        for i in quaries {
            var currMaxSum = pref[n - 1]
            var outOfSum = 0
            if i[0] > 1 {
                outOfSum = pref[i[0] - 2]
            }
            if i[1] <= n {
                currMaxSum = pref[i[1] - 1]
            }
            qurySum.append(currMaxSum - outOfSum)
            
        }
        print(qurySum)
    }
}

// Test Case...
let n = 8
let q = 4
let arr = [3, 2, 4, 5, 1, 1, 5, 3]
let quaries = [[2,4], [5,6], [1,8], [3,3]]

Solution().main(n, q, arr, quaries)
