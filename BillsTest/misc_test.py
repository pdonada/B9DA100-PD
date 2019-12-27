

def read_bills():
    return [[col.strip() for col in row.strip().split(',')]
             for row in open('bills.csv', 'r') if len(row) > 1]

def report_HighestBill():
    bills = read_bills()
    df = pd.DataFrame(bills)
    df[5] = pd.to_numeric(df[5])   
    creditValues = (df[(df[6]  == 'credit')])
    debitValues = (df[(df[6]  == 'debit')])    
    creditMax = creditValues.max()
    debitMax = debitValues.max()
    columnsName = ['Company', 'Customer', 'Year', 'Month', 'Day', 'Total', 'Type']
    print(*columnsName, '\n', *creditMax,'\n', *debitMax)
    #print('Highest Credit Bill:\n', *columnsName,'\n', *creditMax)
    #print('Highest Debit Bill:\n', *columnsName,'\n',*debitMax) 

    
    
print(report_HighestBill())