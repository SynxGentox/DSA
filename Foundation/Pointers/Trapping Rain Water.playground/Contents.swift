// MARK: - Two Pointers: squeezing the array from both ends toward the center.
// In this solution we track the tallest wall seen so far from each side and
// let the shorter of the two confirmed walls decide how much water a column holds.
// We never need to know what's ahead in the array — only the max already seen —
// which is what makes a single pass sufficient.
class Solution {
    // Time Complexity: O(n), Space Complexity: O(1)
    func trap(_ height: [Int]) -> Int {
        // Reasoning: need at least 3 bars to form a container — anything smaller
        // can't trap water, so we bail out immediately rather than run a pointless loop.
        guard height.count >= 3 else { return 0 }

        var left = 0
        var right = height.count - 1

        // Reasoning: leftMax/rightMax are the tallest walls *confirmed* on each
        // side so far — not the global max. That's the whole trick: we don't need
        // the global max, only a wall we've already proven is real.
        var leftMax = height[left]
        var rightMax = height[right]

        var water = 0

        // Working: left and right start at the outer edges and step inward every
        // iteration. Exactly one of them moves per loop — never both — which is
        // what prevents double-counting the same column from two directions.
        while left < right {
            // Reasoning: if leftMax is the smaller of the two confirmed walls,
            // then the water level at the left pointer is bottlenecked by leftMax
            // no matter what's sitting in the unexplored middle of the array.
            // That's true even if there's a taller building we haven't seen yet —
            // it can never lower the water below leftMax's ceiling.
            if leftMax < rightMax {
                left += 1
                // Working: update leftMax only if this bar is taller — it can
                // only grow, never shrink, as we move inward.
                leftMax = max(leftMax, height[left])
                // Working: water above this single column is simply the wall
                // height minus the column's own height. No array, no stored chunk.
                water += leftMax - height[left]
            } else {
                right -= 1
                rightMax = max(rightMax, height[right])
                water += rightMax - height[right]
            }
        }
        return water
    }
}

// APPROACH (pseudocode only — not the official solution, kept for reference)
// Dual-incremental chunk scan, meeting in the middle.
// Correct, O(n) time, O(1) space if implemented with running sum/count
// instead of storing a `depths` array. NOT chosen as official solution
// because it carries real edge-case risk at the collision point
// (equal-height walls, odd-length middle index) that two-pointer avoids entirely.

/*
func trapAlt(height):
    // ---- left-to-right state ----
    leftMax = 0
    leftSum = 0        // running sum of pending depths (NOT an array)
    leftCount = 0       // running count of pending depths
    left = 0

    // ---- right-to-left state (mirrored) ----
    rightMax = 0
    rightSum = 0
    rightCount = 0
    right = height.count - 1

    water = 0

    while left < right:
        // advance whichever side has the smaller confirmed max —
        // this is the piece that prevents overlapping/double-counted chunks
        if leftMax <= rightMax:
            curr = height[left]
            if curr >= leftMax and leftCount == 0:
                leftMax = curr                      // new wall found, no pending chunk to close
            else if curr >= leftMax and leftCount != 0:
                limit = leftMax * leftCount
                water += limit - leftSum             // close the chunk
                leftMax = curr
                leftSum = 0
                leftCount = 0
            else:
                leftSum += curr
                leftCount += 1
            left += 1
        else:
            // mirrored logic for the right side
            curr = height[right]
            if curr >= rightMax and rightCount == 0:
                rightMax = curr
            else if curr >= rightMax and rightCount != 0:
                limit = rightMax * rightCount
                water += limit - rightSum
                rightMax = curr
                rightSum = 0
                rightCount = 0
            else:
                rightSum += curr
                rightCount += 1
            right -= 1

    // pointers have met/crossed — resolve whatever's still pending on either side
    if leftCount > 0 or rightCount > 0:
        finalMax = min(leftMax, rightMax)
        combinedSum = leftSum + rightSum
        combinedCount = leftCount + rightCount
        water += (finalMax * combinedCount) - combinedSum

    return water
*/
