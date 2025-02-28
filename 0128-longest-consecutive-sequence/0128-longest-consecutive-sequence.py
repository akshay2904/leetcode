class Solution(object):
    def longestConsecutive(self, nums):
        numsets = set(nums)  
        longest = 0
        
        for n in numsets:  
            if (n - 1) not in numsets:  
                length = 1
                while (n + length) in numsets:  
                    length += 1
                longest = max(longest, length)
        
        return longest
