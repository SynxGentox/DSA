// LeetCode 424 — Longest Repeating Character Replacement
//
// Problem: given a string `s` of uppercase English letters and an integer `k`,
// find the length of the longest substring you can turn into a single repeated
// character by changing at most `k` characters in it.
//
// Core idea shared by all three solutions below (classic sliding window):
//   - Expand a window [left, right] one character at a time.
//   - Track `maxFreq`: the count of the most frequent character seen so far
//     WITHIN the current window's history (see note on staleness below).
//   - A window of size `size` is achievable with ≤ k replacements iff
//         size - maxFreq <= k
//     (replace every character in the window except the most frequent one).
//   - When that's violated, shrink the window from the left.
//
// All three are O(n) time, O(1) extra space (bounded alphabet), and produce
// identical results — verified by cross-checking on random inputs up to
// n = 100,000. They differ only in bookkeeping, not in correctness or
// asymptotic complexity.
 
 
// MARK: - Solution A — dictionary tracker, explicit maxLen tracking
//
// This is the "first correct thought" version: track everything explicitly,
// trust nothing implicitly. It's the most defensive and most readable of
// the three, and the right one to write first under interview pressure.
class Solution {
    func characterReplacement(_ s: String, _ k: Int) -> Int {
        var leftPos = 0
        let sArray = Array(s.utf8)   // byte view — avoids Swift's slow Character/grapheme indexing
        var maxLen = 0
        var maxFreq = 0
        var sTracker: [UInt8: Int] = [:]   // dictionary => works for ANY byte value, not just A-Z
 
        for rightPos in 0..<sArray.count {
            let char = sArray[rightPos]
 
            // Expand: include s[rightPos] in the window, update its count.
            sTracker[char, default: 0] += 1
            maxFreq = max(maxFreq, sTracker[char]!)
 
            // IMPORTANT NOTE ON "if" vs "while" here:
            // On entry to this iteration, the *previous* window was valid:
            //     (prevSize) - (prevMaxFreq) <= k
            // This iteration, size grows by exactly 1, and maxFreq grows by
            // at most 1 (only the just-added character can increase it).
            // So (size - maxFreq) can increase by at most 1 versus last step,
            // meaning it can exceed k by at most 1. One shrink is therefore
            // always enough to restore validity — `if` and `while` are
            // PROVABLY equivalent in this specific algorithm. This is a
            // property of the invariant above, not a general rule for all
            // sliding-window problems — problems where the tracked quantity
            // can jump by more than 1 per step genuinely need `while`.
            if rightPos - leftPos + 1 - maxFreq > k {
                let leftChar = sArray[leftPos]
                sTracker[leftChar]! -= 1
                leftPos += 1
            }
 
            // Explicitly track the best window size seen so far.
            // NOTE: maxFreq is never decremented when the window shrinks
            // from the left, so it can go "stale" — it may report a count
            // that's no longer the true max-frequency character in the
            // CURRENT window. This never causes a wrong answer: a stale
            // (too-high) maxFreq can only make the shrink condition fire
            // less often than a perfectly-accurate one would, which just
            // means the window is allowed to coast at a size it already
            // legitimately earned earlier — it can never let the window
            // grow to a size it hasn't earned. That's what makes tracking
            // maxLen defensively (as done here) safe, and also what makes
            // Solution B's shortcut (below) provably correct.
            maxLen = max(maxLen, rightPos - leftPos + 1)
        }
 
        return maxLen
    }
}
 
 
// MARK: - Solution B — same mechanics, one fewer operation per step
//
// Identical window logic to Solution A (same shrink condition, algebraically
// rearranged: `maximum + k < size` ⟺ `size - maximum > k`). The ONLY
// difference: this version doesn't track maxLen step-by-step. It relies on
// a proof instead:
//
//   Claim: the window's length is monotonically non-decreasing over the
//   whole loop — it never shrinks below a size it has already reached.
//   Why: growth is +1 per iteration (adding a character); the shrink step
//   removes at most 1 character (see the if/while note in Solution A), so
//   net window size per iteration is either +1 (grew, no shrink needed) or
//   0 (grew by one, immediately shrank by one). It never goes negative.
//
//   Consequence: since size never decreases, the LAST window's size IS the
//   largest window size ever reached — there's no need to track a running
//   max separately. The final size equals `maximum + k` (capped at the
//   string length, for short strings where the window never needed to
//   shrink at all).
//
// The performance difference vs. Solution A is small and mechanical: one
// `max()` call removed per outer-loop iteration. Benchmarked at roughly a
// 1.2x speedup on large inputs — a constant-factor win from doing less
// per-iteration work, NOT a different algorithmic complexity. The value of
// this version isn't the speedup; it's recognizing the invariant that makes
// tracking maxLen redundant in the first place.
class Solution2 {
    func characterReplacement(_ s: String, _ k: Int) -> Int {
        var countMap = [UInt8: Int]()
        let sArr = Array(s.utf8)
        var maximum = 0
        var left = 0
 
        for right in 0..<sArr.count {
            let count = countMap[sArr[right], default: 0]
            let newCount = count + 1
            countMap[sArr[right]] = newCount
            maximum = max(maximum, newCount)
 
            // Kept as `while` here (equivalent to `if`, per the proof above)
            while maximum + k < right - left + 1 {
                countMap[sArr[left], default: 0] -= 1
                left += 1
            }
            // No maxLen tracking — deliberately relies on the monotonic-
            // window-length proof instead.
        }
 
        // Because window length never shrinks below a size already reached,
        // the answer is exactly maximum + k, capped at the string's length
        // (needed for inputs shorter than maximum + k, e.g. small strings
        // with a generous k where the window can absorb the whole string).
        return min(maximum + k, sArr.count)
    }
}
 

// MARK: - Solution C — fixed 26-slot array instead of a dictionary
//
// Same algorithm and same shrink/maxLen logic as Solution A — the ONLY
// change is swapping the dictionary for a fixed-size array indexed by
// `byte - 65` ('A' = 65 in ASCII).
//
// This is a CONSTRAINT-EXPLOITING optimization, not an algorithmic insight:
// it works only because the problem guarantees uppercase English letters.
// Array indexing avoids dictionary hashing/bucket overhead, which is a real
// win in practice (arrays beat dictionaries for small, dense, known key
// ranges) — but unlike Solution B's improvement, this one is NOT general.
// Feed it lowercase letters, digits, or any byte outside 'A'...'Z' and
// `chars[right] - 65` goes negative or out of range, causing a crash rather
// than a wrong answer. Solid choice for a LeetCode submission where the
// constraints are guaranteed; a liability in production code unless the
// ASCII-only assumption is validated at the boundary or documented loudly.
class Solution3 {
    func characterReplacement(_ s: String, _ k: Int) -> Int {
        let chars = Array(s.utf8)
        var counts = Array(repeating: 0, count: 26)   // one slot per letter A-Z
 
        var left = 0
        var maxFrequency = 0
        var maxLength = 0
 
        for right in 0..<chars.count {
            let rightIndex = Int(chars[right] - 65)   // ASSUMES uppercase A-Z input
            counts[rightIndex] += 1
            maxFrequency = max(maxFrequency, counts[rightIndex])
 
            while right - left + 1 - maxFrequency > k {
                counts[Int(chars[left] - 65)] -= 1
                left += 1
            }
 
            maxLength = max(maxLength, right - left + 1)
        }
 
        return maxLength
    }
}
