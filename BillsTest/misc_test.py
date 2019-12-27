import pandas as pd

def read_bills():
    return [[col.strip() for col in row.strip().split(',')]
             for row in open('bills.csv', 'r') if len(row) > 1]

def report_TotalPerYear():
    bills = read_bills()
    df = pd.DataFrame(bills)
    df = df.rename(columns={0: 'Company', 1: 'Customer', 2: 'Year', 3: 'Month', 4: 'Day', 5: 'Total', 6: 'Type'})
    df['Total'] = pd.to_numeric(df['Total'])
    #test = pd.DataFrame(df.groupby(['Year', 'Type'], as_index = False).sum())#.pivot('Year', 'Type').rename(columns={'credit': 'Total Credited', 'debit': 'Total Debited'}))
    #test['Total'] = pd.to_numeric(test['Total'])
    billTotal = df.groupby(['Year', 'Type'], as_index = False).sum().pivot('Year', 'Type').rename(columns={'credit': 'Total Credited', 'debit': 'Total Debited'})    
    return billTotal
print(report_TotalPerYear())