# The function CI_pi2_2prop_diff calculates C.I. of pi1 and pi2,
# given pi1 - pi2 = delta (known), using asymptotic distribution of the CMLE.
# To find the restricted MLE This code requires/calls p2_mle_delta function

# n1 = sample size from the first population -- it should be a positive integer
# n2 = sample size from the second population -- it should be a positive integer
# x1 = number of successes in the sample drawn from the first population -- it should be a nonnegative integer less than or equal to n1
# x2 = number of successes in the sample drawn from the second population -- it should be a nonnegative integer less than or equal to n2

# delta = pi1 - pi2 = difference in two population proportions.
# Index the populations such that delta is nonnegative 
# delta should be between 0 and 1 


logL<- function (x1,n1,x2,n2, p2, delta) {
  p1 <-  p2 + delta
  
  sum <- 0
  if ( (x1 > 0) & (p1 >0) ) { sum <- sum + x1 * log(p1) }
  if ( (n1 - x1 > 0) & (1-p1 >0) ) {  sum <-  sum + (n1 - x1) * log(1-p1) }
  if ( (x2 > 0) & (p2 > 0) ) { sum <- sum + x2 * log(p2) }
  if ( (n2 - x2 > 0) & ( 1-p2 >0) )  { sum <- sum  + (n2 - x2) * log(1-p2) }
  if ( (x1 > 0) & (p1 == 0) ) { sum <- -10^10 }
  if ( (n1 - x1 > 0) & (1- p1 == 0) ) {  sum <- -10^10 }
  if ( (x2 > 0) & (p2 == 0) ) { sum <- -10^10 }
  if ( (n2 - x2 > 0) & ( 1-p2  == 0) )  { sum <- -10^10  }
  
  return(sum)
  
}


CI_pi2_2prop_diff <- function (x1,n1,x2,n2, delta, conf) {
  
  alpha <- 1 - conf
  Z <- qnorm(1- alpha/2)
  Z1 <- qnorm(1- alpha)
  
  
  p2 <- p2_mle_delta(x1,n1,x2,n2,delta)$p2
  p1 <- p2 + delta
  
  l_ml <- logL(x1,n1,x2,n2, p2, delta)
  l1 <- l_ml - 0.5 * Z^2
  l2 <- l_ml - 0.5 * Z1^2
  
  if (p2==0) {
    U1 <- 1 - delta
    U2 <- p2
    v <- logL(x1,n1,x2,n2, U1, delta)
    while (v < l2 )
    {	#begin while loop 1
      U1 <- (U1+U2)/2
      v <- logL(x1,n1,x2,n2, U1, delta)
    }	#end while loop 1
    
    lower <- 0
    upper <- U1
    
  }
  
  
  if (p2== 1 - delta) {
    U1 <- 0
    U2 <- p2
    v <- logL(x1,n1,x2,n2, U1, delta)
    while (v < l2 )
    {	#begin while loop 1
      U1 <- (U1+U2)/2
      v <- logL(x1,n1,x2,n2, U1, delta)
    }	#end while loop 1
    
    lower <- U1
    upper <- 1- delta
    
  }
  
  if ((p2 > 0) & (p2 < 1 - delta))
  {
    U1 <- 1 - delta
    U2 <- p2
    v <- logL(x1,n1,x2,n2, U1, delta)
    while (v < l1 )
    {	#begin while loop 1
      U1 <- (U1+U2)/2
      v <- logL(x1,n1,x2,n2, U1, delta)
    }	#end while loop 1
    
    L1 <- 0
    L2 <- p2
    v <- logL(x1,n1,x2,n2, L1, delta)
    while (v < l1 )
    {	#begin while loop 1
      L1 <- (L1+L2)/2
      v <- logL(x1,n1,x2,n2, L1, delta)
    }	#end while loop 1
    
    lower <- L1
    upper <- U1
  }
  
  out <- list(lower.limit.pi2 = lower, upper.limit.pi2 = upper,  mle.pi2=p2 ,
              lower.limit.pi1 = lower + delta, upper.limit.pi2 = upper + delta ,  mle.pi1=p1 )
  
  
  return(out)
}

