class Solution {
    func trap(_ height: [Int]) -> Int {
        var x = 10
        for i in 0..<x {
            x = 4
        }
    }
}

///
//   func trap {
/// var max1 = 0
/// var depths: [Int] = []
/// var distance = 0
/// var water = 0
/// var limit = 0
/// if curr >= max1 && distance == 0 { max1 = curr }
/// if curr >= max1 && distance != 0 { limit = max1 * distance, water += limit - sum(of: distance) }    // reset all at this point
/// else if max1 > curr { depths.append(curr), disatance += 1 }     // no matter if d == 0 or != 0
/// if limit = 0, index == (n.count - 1), depth.count >= 3 { trap( [depth] ) }
///
