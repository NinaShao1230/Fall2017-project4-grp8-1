data_train <- read.csv("~/Downloads/data_sample/eachmovie_sample/moive_train.csv")
data_train<-as.data.frame(data_train[,-1])
data_train[is.na(data_train)] <- 0
rownames(data_train)<-data_train[,1]
data_train<-as.data.frame(data_train[,-1])
colnames(data_train)<-1:ncol(data_train)

#--------------------Read Test Dataset -----------------------------
test<-read.csv("~/Downloads/data_sample/eachmovie_sample/moive_test_train_new.csv", header=TRUE)
rownames(test)<-test[,1]
test<-test[,-1]
test[is.na(test)]<-0

data_test<-rep(NA,nrow(test))
for (i in 1:6){
  dat_test<-test
  dat_test[dat_test==i]<-1
  dat_test[dat_test!=i]<-0
  data_test<-cbind(data_test,dat_test)
}
data_test<-data_test[,-1]

#-------------------load EM results -----------------------------
load("/Users/ninashao/Downloads/data_sample/eachmovie_sample/gamma_em_result_9.RData")
load("/Users/ninashao/Downloads/data_sample/eachmovie_sample/mu_em_result_9.RData")


r<-prediction(gamma_em_result,mu_em_result,test,data_test,9)
#--------------------Prediction -----------------------------
prediction<- function(gamma,mu,matrixtest,matrixk,c){
  gamma<-gamma_em_result
  mu<-mu_em_result
  matrixtest<-test
  # matrixk<-data_test
  matrixk<-data_test
  c<-9
  theta<-NULL
  N<-nrow(data_train)
  for (i in 1:c){
    gamma_c<-gamma[((i-1)*6+1):(6*i),]
    gamma_c<-as.vector(t(gamma_c))
    gamma_c<-matrix(rep(gamma_c,each=N),nrow=N)
    Di<-matrixk*gamma_c
    theta_i<-apply(Di,1,function(x){return(prod(x[x>0]))})
    names(theta_i)<-NULL
    theta<-rbind(theta,theta_i)
    print(i)
  }
  
  # Calcualte lower 
  mu_repeat<-matrix(rep(mu,each=N),nrow=N)
  prodre<-t(mu_repeat)*theta
  sum<-colSums(prodre, na.rm=TRUE) 
  lower<-matrix(rep(sum,each=ncol(matrixtest)),ncol=ncol(matrixtest),byrow=TRUE)
  
  # upper
  matrixsum<-matrix(rep(0,5055*1619),ncol=1619,nrow=5055)
  pp<-NULL
  for (i in 1:k){
    data<-as.matrix(matrixtest)
    data[data != i]<-0
    data[data == i]<-1 
    
    for (j in 1:c){
      mu_iter<-mu[j]
      theta_iter<-theta[j,]
      theta_iter<-matrix(rep(t(theta_iter),each=ncol(matrixtest)),ncol=ncol(matrixtest),byrow = TRUE)
      gamma_iter<-gamma[(6*(j-1)+i),]
      gamma_me<-matrix(rep(gamma_iter,each=N),nrow=N)
      prob<-data*gamma_me
      prob<-mu_iter*prob
      prob<-prob*theta_iter
      matrixsum<-matrixsum+prob
      pp_k<-matrixsum/lower
      pp_k<-t(as.vector(t(pp_k)))
      print(j)
    }# end of c interation
    pp<-rbind(pp,pp_k)
    print(i)
  }# end of k interation
  mm<-apply(pp, 2, which.max)
  result<-matrix(mm,ncol=ncol(matrixtest),byrow=TRUE)
  return(result)
}# end of fcn
write.csv(result,file="~/output/predict.csv")



######compare predict with true values
predict<-read.csv("~/output/predict.csv",header = TRUE)
d_test<-test
d_test[d_test!=0]<-1
result_update<-predict*d_test
a<-mean(as.matrix(abs(result_update-test)))
a
