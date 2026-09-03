// MARK: - Optimal Solutions to get top K most frequent elements.
// This question requires sorting, we used Bucket Sort here.
/// Bucket Sort: See "Array Doubts and Depth Concepts" file for Algorithm.


//MARK: - This solution uses early exit. This soltuion is theoretically better.
class Solution {
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var freqMap: [Int: Int] = [:]
        var mapper: [[Int]] = Array(repeating: [], count: nums.count + 1)
        
        for num in nums {
            freqMap[num, default: 0] += 1
        }
        
        for (key, value) in freqMap {
            mapper[value].append(key)
        }
        
        var arr: [Int] = []
        for n in stride(from: mapper.count - 1, through: 0, by: -1) {
            arr.append(contentsOf: mapper[n])
            
            if arr.count >= k {
                return Array(arr.suffix(k))
            }
        }
        return arr
    }
}


//MARK: - This solution uses inbuilt flatMap function to flatten the sub-Arrays into a sinle array.
class Solution1 {
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var freqMap: [Int: Int] = [:]
        var mapper: [[Int]] = Array(repeating: [], count: nums.count + 1)
        
        for num in nums {
            freqMap[num, default: 0] += 1
        }
        
        for (key, value) in freqMap {
            mapper[value].append(key)
        }
        return Array(mapper.flatMap { $0 }.suffix(k))
    }
}

