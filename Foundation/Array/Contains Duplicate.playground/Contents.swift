import UIKit

// MARK: 1st SOLUTION
// One Liner, consistent, declarative(easy to know what its doing) but always takes maxium Space i.e. O(n)
/// Time Complexity: O(n), Space Complexity: O(n)
class Solution {
    func containsDuplicate(_ nums: [Int]) -> Bool {
        if nums.count < 2 { return false }
        return Set(nums).count != nums.count
    }
}

// MARK: 2nd SOLUTION
// Not quite expressive, less Consistent, Can be quite faster in cases with quicky dublicate encounter cases otherwise it does more work
/// Time Complexity: O(n), Space Complexity: O(n) extra
class Duplicate {
    func containsDuplicate(_ nums: [Int]) -> Bool {
        var numsSet: Set<Int> = []
        numsSet.reserveCapacity(nums.count)
        
        for n in nums {
            if !numsSet.insert(n).inserted {
                return true
            }
        }
        return false
    }
    
    // using minimum Capacity
    func containsDuplicate2(_ nums: [Int]) -> Bool {
        var numSet: Set<Int> = Set(minimumCapacity: nums.count)
        
        for n in nums {
            if !numSet.insert(n).inserted {
                return true
            }
        }
        return false
    }
    
    /* At the base hardware level minimumCapacity and reserveCapacity does same thing i.e. pre-allocate RAM.
     IN Depth
      - minimumCapacity: An Initializer, allocates memory the moment DataCollection type is born. always takes extra space
      - reserveCapacity: A Method, allocates.
     
     NOTE: - You only use minimumCapacity or reserveCapacity when you guarantee you are going to fill the collection.
      - Hash Tables suffer from Hash Collisions if they get too crowded. A Set never wants to be 100% full.
    */
}

// better version of 2nd solution

