#problem 1
#only works on numbers 6+
Problem_1 <- function(N){
  set5 <- seq(5,(N-1), by=5)
  if(length(set5) > 3){
    set5 <- set5[-seq(3,length(set5), by=3)]}
  set <- c(seq(3,(N-1), by=3), set5)
  return(sum(set))
}
Problem_1(100)

#Problem_2
#always censors at 4million
Problem_2 <- function(N){
  n1 <- 1
  n2 <- 2
  holder <- vector("numeric", N)
  holder[1:2] <- c(n1,n2)
  for(i in 3:N){
    if(n1+n2 > 4000000){
      break()
    }else{
      holder[i] <- n1+n2
    }
    n1 <- n2
    n2 <- holder[i]
  }
  index <- holder%%2
  return(sum(holder[!index]))
}
Problem_2(33)


#Problem_3
#N>=1
N <- 25
Problem_3 <- function(N){
  factor <- N
  i <- 5
  Solved <- FALSE
  
  while(Solved == FALSE){
    if(factor%%i == 0){
      factor <- factor/i
      i <- 2
      next()
    }else if(i >= factor%/%2){
      Solved <- TRUE
      next()
    }
    i <- i+1
  }
  if(factor == 1){
    return("No Primes")
  }else{return(factor)}
}
Problem_3(600851475143)

#Problem_4
#N>=1 (other numbers are impossible)
Problem_4 <- function(N){
  maxint <- as.numeric(paste0(rep(9,N), collapse=""))
  minint <- as.numeric(paste0(1, paste0(rep(0,N-1), collapse=""),collapse=""))
  maxnum <- maxint*maxint
  pal <- Spinner(maxnum)
  solution <- vector("numeric",0)
  while(length(solution) == 0){
    for(i in maxint:minint){
      if(pal%%i == 0){
        if(pal/i<maxint+1 &&   pal/i>minint-1){
          solution <- pal
          break()
        }
        break()
      }else if(pal/i > i-1){
        break()
      }
      i <- i-1
    }
    pal <- Spinner(pal)
    if(pal == as.numeric(paste0(rep(9,2*N), collapse=""))){
      print("no solution!")
      break()
    }
  }
  return(solution)
}
Spinner <- function(Int){
  spin <- as.numeric(unlist(strsplit(as.character(Int),"")))
  N <- length(spin)/2
  for(i in N:1){
    if(spin[i] == 0){
      spin[i] <- 9
    }else{
      spin[i] <- spin[i]-1
      break()
    }
  }
  pal <- as.numeric(paste0(spin[c(1:N,N:1)], collapse=""))
  return(pal)
}           
Problem_4(3)

#Problem_5
#N>=3
Problem_5 <- function(N){
  PrimeFactors <- sapply(2:N,GetPrimeFactors)
#convert to dedupliacted form of facortization
  Dedup <- table(PrimeFactors[1])
  for(i in 1:(length(PrimeFactors)-1)){
    add <- table(PrimeFactors[[i+1]])
    for(j in seq_along(add)){
      if(names(add[j]) %in% names(Dedup)){#factor not present
        check <- which(names(Dedup) == names(add[j]))
        if(Dedup[check] < add[j]){#not enough of a factor present
          Dedup[check] <- add[j]
        }
      }else{Dedup <- c(Dedup,add[j])}
    }
  }
#convert table to vector and get product
  Dedup <- data.frame(value=(as.numeric(names(Dedup))), freq=(Dedup))
  MasterPrimeFactorization <- rep(Dedup$value, Dedup$freq)
  return(prod(MasterPrimeFactorization))
}
GetPrimeFactors <- function(N){
  #Remove 1
  if(N==1){
    warning("N cannot equal 1")
    return(1)
  }
  
  #Set up loop variables
  Prime <- 1
  Factor <- vector("list", 0)
  Solution <- FALSE
  index <- 0
  
  while(Solution == FALSE){
    index <- index + 1
    
    #Get a prime divisor
    found <- FALSE
    if(Prime != 1 && Prime != 2){#if not first three primes
      while(found == FALSE){#increase prime until prime found
        Prime <- Prime + 1
        if(all(Prime%%(2:(Prime-1))!=0)){
          found <- TRUE
        }
      }
    }else{Prime <- Prime + 1}#if first three primes
    found <- FALSE
    
    if(N%%Prime==0){#Test whether prime factor
      if(Prime == N){#original input number was prime
        return(N)
      }
      N <- N/Prime
      Factor[index] <- Prime
      Max <- ceiling(N%/%2)
      if(any(N%%(2:Max)==0)==TRUE && N!=2 && N!=3){#if the result is not prime
        Prime <- 1
        next()
      }else{ #if the results was prime
        Factor[index+1] <- N
        Solution <- TRUE
      }
    }
  }
  return(unlist(Factor))
}
Problem_5(20)

#Problem_6
#All N
Problem_6 <- function(N){
  SqS <- (N*(N+1)*(2*N+1))/6
  SSq <- (N*(N+1)/2)^2
  return(SSq-SqS)
}
Problem_6(100)

#Problem_7
Problem_7 <- function(N){
  found <- FALSE
  Prime <- 1
  for(i in 1:N){
    
    if(Prime != 1 && Prime != 2){#if not first three primes
      
      
      while(found == FALSE){#increase prime until prime found
        Prime <- Prime + 2
        if(all(Prime%%(2:(Prime-1))!=0)){
          found <- TRUE
        }
      }
      
      
    }else{Prime <- Prime + 1}#if first three primes
    
    
    
    found <- FALSE
    
  }
  print(Prime)
}
Problem_7(5000)
#N*log(N)+N*(log(log(N))-1)
#the above was not great :/