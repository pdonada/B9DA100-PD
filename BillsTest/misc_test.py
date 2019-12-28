import pandas as pd
import datetime
import numpy as np

def read_bills():
    return [[col.strip() for col in row.strip().split(',')]
             for row in open('bills.csv', 'r') if len(row) > 1]

def report_HighestBill():
    bills = read_bills()
    df = pd.DataFrame(bills)
    df = df.rename(columns={0: 'Company', 1: 'Customer', 2: 'Year', 3: 'Month', 4: 'Day', 5: 'Total', 6: 'Type'})    
    df['Total'] = pd.to_numeric(df['Total'])   
    creditValues = (df[(df['Type']  == 'credit')])
    debitValues = (df[(df['Type']  == 'debit')])        
    creditMax = creditValues[creditValues['Total']==creditValues['Total'].max()]
    debitMax = debitValues[debitValues['Total']==debitValues['Total'].max()]
    print(creditMax.to_string(index=False),'\n') 
    print(debitMax.to_string(index=False))  

    
print(report_HighestBill())
