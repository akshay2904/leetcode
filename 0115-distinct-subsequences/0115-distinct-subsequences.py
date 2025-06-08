class Solution(object):
    def numDistinct(self, s, t):
        m, n = len(s), len(t)
        
        # Create a DP table with (m+1) x (n+1)
        dp = [[0] * (n + 1) for _ in range(m + 1)]
        
        # An empty string t can be formed by any prefix of s
        for i in range(m + 1):
            dp[i][0] = 1
        
        # Fill the DP table
        for i in range(1, m + 1):
            for j in range(1, n + 1):
                if s[i - 1] == t[j - 1]:
                    dp[i][j] = dp[i - 1][j - 1] + dp[i - 1][j]
                else:
                    dp[i][j] = dp[i - 1][j]
        
        return dp[m][n]

        """
        :type s: str
        :type t: str
        :rtype: int
        """
        