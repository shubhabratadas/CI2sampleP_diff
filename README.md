# CI2sampleP_diff
#The function calculates C.I. of pi1 and pi2, given pi1 - pi2 = delta (known), using asymptotic distribution of the CMLE.
# n1 = sample size from the first population -- it should be a positive integer
# n2 = sample size from the second population -- it should be a positive integer
# x1 = number of successes in the sample drawn from the first population -- it should be a nonnegative integer less than or equal to n1
# x2 = number of successes in the sample drawn from the second population -- it should be a nonnegative integer less than or equal to n2

# delta = pi1 - pi2 = difference in two population proportions.
# Index the populations such that delta is nonnegative 
# delta should be between 0 and 1 
#Examples:
CI_pi2_2prop_diff (100, 100, 0,  30, 1, 0.95)
CI_pi2_2prop_diff (45, 125, 35,  75, 0, 0.95) 
CI_pi2_2prop_diff (60, 60, 0,  30, 0.2, 0.95)
CI_pi2_2prop_diff (60, 60, 0,  30, 0.6, 0.95)
CI_pi2_2prop_diff (30, 30, 0,  60, 0.55, 0.95)
CI_pi2_2prop_diff (10, 50, 0,  30, 0.2, 0.95)
CI_pi2_2prop_diff (15, 50, 25,  75, 0.9, 0.95)

