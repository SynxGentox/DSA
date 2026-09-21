class Solution {
    func main() {
        var arr = [2,5,3,7]
        var pref: [Int] = [arr[0]]
        
        for i in 1..<arr.count {
            pref.append(pref[i-1] + arr[i])
        }
        print(pref)
        
        // sum of range 1...3
        
        var sum = pref[3] - pref[1 - 1]
        print(sum)
        
        var arr1 = [0,0,0,0,0]
        var diff = 3
        arr1[1] += diff
        arr1[3 + 1] -= diff
        var pref1: [Int] = [arr1[0]]
        
        for i in 1..<arr1.count {
            pref1.append(pref1[i-1] + arr1[i])
        }
        print(pref1)
    }
}

Solution().main()
