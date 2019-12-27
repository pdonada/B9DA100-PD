import pandas as pd

def read_bills():
    return [[col.strip() for col in row.strip().split(',')]
             for row in open('bills.csv', 'r') if len(row) > 1]

def report_BillsDateOrder():
    bills = read_bills()
    
    df = pd.DataFrame(bills)
    dateComp = []
    for bill in bills:
        dateStr = bill[2]+'-' + bill[3]+'-' + bill[4]
        dateComp.append(dateStr)  
    df['dateComp'] = dateComp
        #dateDate = datetime.strptime(dateComp, '%Y %m %d')
        #cazzo = []
        #cazzo.append(dateDate)
    df = df.rename(columns={0: 'Company', 1: 'Customer', 2: 'Year', 3: 'Month', 4: 'Day', 5: 'Total', 6: 'Type'})    
    df1 = df.sort_values(by=['dateComp'])
    #print(df1[['Company', 'Customer', 'Year', 'Month', 'Day', 'Total', 'Type']])
    return df1[['Company', 'Customer', 'Year', 'Month', 'Day', 'Total', 'Type']]
        
#print(report_BillsDateOrder()) 
print(report_BillsDateOrder().to_string(index=False))