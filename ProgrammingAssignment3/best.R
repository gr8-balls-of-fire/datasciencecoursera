best <- function(state, outcome) {
## Read outcome data
      hospital_perf <- (read.csv("outcome-of-care-measures.csv", colClasses = "character"))
      ## create oc as a valid outcome list
      oc<-c("heart attack","heart failure","pnemonia")
      ## create st as a valid state list
      st<-unique(c(read.csv("outcome-of-care-measures.csv",colClasses = "character")[,7]))
## Check that state and are valid
      ## check for arguments errors
      if (missing(state)){
            stop("Need to specify the state.")
      }else if (missing(outcome)) {
            stop("Need to specify the outcome.")
      }else if (!(outcome %in% oc)) {
            stop("invalid outcome")
      }else if (!(state %in% st)) {
            stop("invalid state")
      }else {
      ## Reduce the dataframe to only what we need - managing memory
      hospital_perf<-hospital_perf[hospital_perf$State == state,c(2, 7, 11, 17, 23)] 
      }
      ## Identify outcome use case for processing
      if (outcome == "heart attack") {
            ## Create the smaller set and remove columns of irrelevant outcomes
            hospital_perf <- hospital_perf[,c(1:3)]
            ## coerce intruduction os NA in place of "Not Available"s
            heart_attack <- suppressWarnings(cbind(hospital_perf[1],hospital_perf[2],sapply(hospital_perf[3],as.numeric)))
            ## remove NAs
            heart_attack <- heart_attack[complete.cases(heart_attack),]
            ## sort to find the best first on rate then on hospital name
            heart_attack <-heart_attack[order(heart_attack[3],heart_attack[1]),]
            best_hosp <- heart_attack[1,1]
            ## Return hospital name in that state with lowest 30-day death
            ## rate
            return(best_hosp)
            }else if (outcome == "heart failure") {
            ## Create the smaller set and remove columns of irrelevant outcomes
            hospital_perf <- hospital_perf[,c(1,2,4)]
            ## coerce intruduction os NA in place of "Not Available"s
            heart_failure <- suppressWarnings(cbind(hospital_perf[1],hospital_perf[2],sapply(hospital_perf[3],as.numeric)))
            ## remove NAs
            heart_failure <- heart_failure[complete.cases(heart_failure),]
            ## sort to find the best first on rate then on hospital name            
            heart_failure <-heart_failure[order(heart_failure[3],heart_failure[1]),]
            best_hosp <- heart_failure[1,1]
            ## Return hospital name in that state with lowest 30-day death
            ## rate
            return(best_hosp)
      }else if (outcome == "pnemonia") {
            ## Create the smaller set and remove columns of irrelevant outcomes
            hospital_perf <- hospital_perf[,c(1,2,5)]
            ## coerce intruduction os NA in place of "Not Available"s
            pnemonia <- suppressWarnings(cbind(hospital_perf[1],hospital_perf[2],sapply(hospital_perf[3],as.numeric)))
            ## remove NAs
            pnemonia <- pnemonia[complete.cases(pnemonia),]
            ## sort to find the best first on rate then on hospital name            
            pnemonia <-pnemonia[order(pnemonia[3],pnemonia[1]),]
            best_hosp <- pnemonia[1,1]
            ## Return hospital name in that state with lowest 30-day death
            ## rate
            return(best_hosp)
                  }else {
            stop("Unknown Error")
      }
      
      ## Return hospital name in that state with lowest 30-day death rate
      ## return(hospital_perf)
}