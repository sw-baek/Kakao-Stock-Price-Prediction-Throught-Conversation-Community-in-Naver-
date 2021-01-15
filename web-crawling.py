from selenium import webdriver
import time
import pandas as pd
from tqdm import tqdm
#종목코드 입력
company_code = str(input("종목코드를 입력하세요: "))

driver = webdriver.Chrome("C:/Users/Larry Baek/Desktop/python/chromedriver_win32/chromedriver.exe")


date_list = []
conversation_list = []
len(date_list)
len(conversation_list)
for i in tqdm(range(581,1000)):
    a=driver.get("https://finance.naver.com/item/board.nhn?code="+company_code+"&page="+str(i))
    time.sleep(1)
    
    for date in range(3,26) :
        if date == 8 or date ==14 or date ==20:
            continue
        crawling_date=driver.find_element_by_xpath("/html/body/div[3]/div[1]/div[2]/div[1]/div[2]/table[1]/tbody/tr["+str(date)+"]/td[1]/span").text        
        try:
            driver.find_element_by_xpath("/html/body/div[3]/div[1]/div[2]/div[1]/div[2]/table[1]/tbody/tr["+str(date)+"]/td[2]/a").click()
            crawling_title=driver.find_element_by_xpath("/html/body/div[3]/div[1]/div[2]/div[1]/div[2]/table[1]/tbody/tr[1]/th[1]/strong").text
            driver.back()
            date_list.append(crawling_date)
            conversation_list.append(crawling_title)
        except:
            pass
            
        

df = {'날짜':date_list,
      '토론':conversation_list}
stock_conversation = pd.DataFrame(df)
stock_conversation.to_csv('C:/Users/Larry Baek/Desktop/Rhufs/samsung_stock_coversation_10.csv', encoding ='UTF-16')