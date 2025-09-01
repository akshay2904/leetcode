class Solution:
    def sortArrayByParityII(self, nums: list[int]) -> list[int]:
        n = len(nums)
        i, j = 0, 1  # even and odd indices
        
        while i < n and j < n:
            if nums[i] % 2 == 0:
                i += 2
            elif nums[j] % 2 == 1:
                j += 2
            else:
                # swap wrong even at even index with wrong odd at odd index
                nums[i], nums[j] = nums[j], nums[i]
                i += 2
                j += 2
        
        return nums
