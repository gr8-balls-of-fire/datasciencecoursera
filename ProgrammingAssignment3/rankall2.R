rankall <- function(outcome, num = "best") {
      ## Read outcome data
      hospital_perf <- (read.csv("outcome-of-care-measures.csv", colClasses = "character"))
      ## create oc as a valid outcome list
      oc<-c("heart attack","heart failure","pnemonia")
      ## create st as a valid state list
      st<-unique(c(read.csv("outcome-of-care-measures.csv",colClasses = "character")[,7]))
      ## create the answer dataframe
      rank_hosp <- data.frame(hospital=NA, state=NA)

      ## Check that state is valid
      ## check for arguments errors
      if (missing(outcome)) {
            stop("Need to specify the outcome.")
      }else if (!(outcome %in% oc)) {
            stop("invalid outcome")
      }else {
            for (states in st){
                  ## Reduce the dataframe to only what we need - managing memory
                  hospital_state <- hospital_perf[hospital_perf$State == states, c(2, 7, 11, 17, 23)]
                  
                  ## Identify outcome use case for processingo
                  if (outcome == "heart attack") {
                        ## Create the smaller set and remove columns of irrelevant outcomes
                        hospital_state <- hospital_state[,c(1:3)]
                        ## coerce intruduction os NA in place of "Not Available"s
                        heart_attack <- suppressWarnings(cbind(hospital_state[1],hospital_state[2],sapply(hospital_state[3],as.numeric)))
                        ## remove NAs
                        heart_attack <- heart_attack[complete.cases(heart_attack),]
                        ## sort to find the best first on rate then on hospital name
                        heart_attack <-heart_attack[order(heart_attack[3],heart_attack[1]),]
                        ## Add the Rank Column to the dataframe
                        ranks <- c(1:nrow(heart_attack))
                        heart_attack <- cbind(heart_attack,ranks)
                        if (num == "best") {
                              num = 1
                        }else if (num == "worst"){
                              num = nrow(heart_attack)
                        } else {
                              num = as.numeric(num)
                        }
                        add_row <- c(states)
                        add_row <- c(unname(unlist(heart_attack[num,1])), add_row)
                        rank_hosp <- rbind(rank_hosp, add_row)
                        rank_hosp <- rank_hosp[2:length(rank_hosp),]
                        
                        ## Return hospital name in that state with the given rank 
                        ## 30-day death rate
                  }else if (outcome == "heart failure") {
                        ## Create the smaller set and remove columns of irrelevant outcomes
                        hospital_state <- hospital_perf[,c(1,2,4)]
                        ## coerce intruduction os NA in place of "Not Available"s
                        heart_failure <- suppressWarnings(cbind(hospital_state[1],hospital_state[2],sapply(hospital_state[3],as.numeric)))
                        ## remove NAs
                        heart_failure <- heart_failure[complete.cases(heart_failure),]
                        ## sort to find the best first on rate then on hospital name            
                        heart_failure <-heart_failure[order(heart_failure[3],heart_failure[1]),]
                        ## Add the Rank Column to the dataframe
                        ranks <- c(1:nrow(heart_failure))
                        heart_failure <- cbind(heart_failure,ranks)
                        if (num == "best") {
                              num = 1
                        }else if (num == "worst"){
                              num = nrow(heart_failure)
                        } else {
                              num = as.numeric(num)
                        }
                        add_row <- c(states)
                        add_row <- c(unname(unlist(heart_attack[num,1])), add_row)
                        rank_hosp <- rbind(rank_hosp, add_row)
                        rank_hosp <- rbind(rank_hosp, heart_failure[num,1:2])
                        rank_hosp <- rank_hosp[2:length(rank_hosp),]
                        
                        ## Return hospital name in that state with the given rank 
                        ## 30-day death rate
                  }else {
                        ## Create the smaller set and remove columns of irrelevant outcomes
                        hospital_state <- hospital_perf[,c(1,2,5)]
                        ## coerce intruduction os NA in place of "Not Available"s
                        pnemonia <- suppressWarnings(cbind(hospital_state[1],hospital_state[2],sapply(hospital_state[3],as.numeric)))
                        ## remove NAs
                        pnemonia <- pnemonia[complete.cases(pnemonia),]
                        ## sort to find the best first on rate then on hospital name            
                        pnemonia <-pnemonia[order(pnemonia[3],pnemonia[1]),]
                        ranks <- c(1:nrow(pnemonia))
                        pnemonia <- cbind(pnemonia,ranks)
                        if (num == "best") {
                              num = 1
                        }else if (num == "worst"){
                              num = nrow(pnemonia)
                        } else {
                              num = as.numeric(num)
                        }
                        add_row <- c(states)
                        add_row <- c(unname(unlist(heart_attack[num,1])), add_row)
                        rank_hosp <- rbind(rank_hosp, add_row)
                        rank_hosp <- rbind(rank_hosp, pnemonia[num,1:2])
                        rank_hosp <- rank_hosp[2:length(rank_hosp),]
                        ## Return hospital name in that state with the given rank 
                        ## 30-day death rate
                  }
            }
      }
##rank_hosp = rank_hosp[-1,]
return(rank_hosp)
##return(add_row)
}