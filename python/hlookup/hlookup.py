import pandas as pd

# define the source excel file's path
excelFile = 'test.xlsx'
# use pandas to read excel file
sourceData = pd.read_excel(excelFile)
# change column name into a list
columnName = list(sourceData.columns) 

# print all the list name
i = 1
while i < (len(columnName)+1):
    print ("列号：%s    列名：%s" %(i,columnName[i-1]))
    i+=1

# get user's choice (number) and print the name 
matchColumnNumber = int(float(input("请输入作为匹配的列号：")))
matchColumnNumber-=1 
print (columnName[matchColumnNumber])
fillColumnNumber = int(float(input("请输入需要填充的列号：")))
fillColumnNumber-=1
print (columnName[fillColumnNumber])

# print a cut-off line
#print ("\n\n================================\n\n================================\n\n")

# use isnull to judge the null data in sourcedata
NaNdf = sourceData.isnull()

i = 0
while i<len(NaNdf[columnName[fillColumnNumber]]):
    while (NaNdf[columnName[fillColumnNumber]].loc[i]):
        # print all the rows that have null data
        #print (dealingData.loc[i,[columnName[matchColumnNumber]]])
        j = 0
        while j < len(sourceData[columnName[matchColumnNumber]]):
            if (j!=i) and (sourceData.loc[i,columnName[matchColumnNumber]]==sourceData.loc[j,columnName[matchColumnNumber]]):
                sourceData.loc[i,columnName[fillColumnNumber]]=sourceData.loc[j,columnName[fillColumnNumber]]
            j+=1
        break
    i+=1
#print (sourceData)

sourceData.to_excel('result.xlsx',encoding = 'utf-8', index=None)
print ("处理后文件为当前目录下的result.xlsx")

