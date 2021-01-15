getwd()

setwd("C:/Users/BaekSeungWoo/Desktop/projects/자연어처리로 카카오주가 예측하기")

revenue_posneg <- read.csv("실제 등락률과 긍부정 비율 최종 비교.csv")
model <- lm(rate~posneg, data = revenue_posneg)
summary(model)
plot(rate~posneg, data = revenue_posneg)

plot(model)
# R이 outlier라고 알려주는 44, 21, 41 삭제 후 다시 회귀분석

revenue_posnge_2 <- revenue_posneg[-c(44,21,41),]
revenue_posnge_2

model_2<-lm(rate~posneg, data = revenue_posnge_2)
summary(model_2)
plot(rate~posneg, data = revenue_posnge_2)
abline(model, col = "red")

plot(model_2)

# R이 outlier라고 알려준 51,38,39 추가적으로 제거


revenue_posnge_3 <- revenue_posneg[-c(44,21,41,51,38,59),]
model_3 <- lm(rate~posneg, data = revenue_posnge_3)
summary(model_3)

plot(rate~posneg, data = revenue_posnge_3)
abline(model_3, col = "red")
plot(model_3)

# 데이터의 약 10%를 outlier로 취급하여 적당한 모형 도출
# 가정 검정 실시
# 잔차검정
plot(model_3$residuals~model_3$fitted.values)
abline(h = 0 , col = "red")
# 점점 증가하는 형태도 아니고 적절한 잔차 모형을 보여주고 있다 
hist(model_3$residuals)
# 히스토그램에서 두 개의 봉우리가 존재하지 않고 한 쪽으로 심하게 치우치지 않은 형태를 보여주고있다
qqnorm(model_3$residuals)
qqline(model_3$residuals)
#정규 qq검정에서도 크게 문제될 만한 사안은 보이지 않는다.

acf(model_3$residuals)
pacf(model_3$residuals)
# 자기상관 문제를 확인 하는 acf 검정 pacf 검정 모두 이상이 없다

dwtest(model_3)
#더빈 왓슨 검정에서 p-value 가 0.05이상이므로 자기상관 문제가 발생하지 않는다.
