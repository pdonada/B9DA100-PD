import datetime
import pandas as pd
import numpy as np

def read_bills():
    return [[col.strip() for col in row.strip().split(',')]
             for row in open('bills.csv', 'r') if len(row) > 1]

def report_AverageTime():
    bills = read_bills()
    sortedBills = sorted(bills, key=lambda caz:(caz[2], caz[3], caz[4]))
    billsqtd = 0
    datemin = None
    billsdif = 0 
    datemax = None   
    for bill in sortedBills:
        dateCalc = datetime.datetime.strptime( bill[2]+'-'+bill[3]+'-'+bill[4], '%Y-%m-%d')        
        if billsqtd == 0:
            datemin = dateCalc.date()
            datemax = None
        else:        
            datemax = datemin   
            datemin = dateCalc.date()    
            billsdif = billsdif + (datemin - datemax).days        
        billsqtd = billsqtd + 1           
    caz2 = round(billsdif/(billsqtd-1), 2)
    return caz2


        
    
print(report_AverageTime())