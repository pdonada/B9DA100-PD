import pandas as pd
import datetime
import numpy as np

def read_bills():
    return [[col.strip() for col in row.strip().split(',')]
             for row in open('bills.csv', 'r') if len(row) > 1]

def view_bills(bills):
    bills = read_bills()
    df = pd.DataFrame(bills)
    df = df.rename(columns={0: 'Company', 1: 'Customer', 2: 'Year', 3: 'Month', 4: 'Day', 5: 'Total', 6: 'Type'})
    df1 = df.sort_values(by=['Company','Customer', 'Year', 'Month'])
    return df1.to_string(index = False)  

print(view_bills(view_bills))
