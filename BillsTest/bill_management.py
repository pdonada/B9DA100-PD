import pandas as pd
import datetime
import numpy as np


def read_bills():
    return [[col.strip() for col in row.strip().split(',')]
             for row in open('bills.csv', 'r') if len(row) > 1]

def write_bills(bills):
    bill_file = open('bills.csv', 'w')
    for bill in bills:
        bill_file.write(', '.join(bill) + '\n')

def get_message():
    return 'Hello, Welcome to the Bill Management Company\n' + \
            '1: View Bills\n2: Insert a Bill\n3: Reports\n4: T&Cs\n5: Exit'

def get_report_menu():
    return 'Hello, Welcome to the Reports Menu\n' + \
            '1: Total per Year\n2: Bill per Year\n3: Bill per Date\n4: Highest Bill-Credit/Debit3\n5: Highest Bill-Debit\n6: Number of Bills per Year\n7: Average Spent by Period\n8: Average Time Between Bills\n9: Exit'

def report_menu():
    print(get_report_menu())
    choice = input('You are on Reports Menu.\nPlease select a report(0 to return):')
    while choice != '9':
        if choice == '0':
            print(get_report_menu())
        elif choice == '1':
            print(report_TotalPerYear())
        elif choice == '2':
            print(report_PopularUtilCompany())
        elif choice == '3':
            print(report_BillsDateOrder().to_string(index=False))
        elif choice == '4':
            report_HighestBill()
        elif choice == '5':
            print('Sorry, this report is not working')
        elif choice == '6':
            report_TotalBillsPerCompany()
        elif choice == '7':
            print(report_AveragePerPeriod())
        elif choice == '8':
            report_AverageTime()
        choice = input('You are on Reports Menu.\nPlease select a report(0 to return):')
                      
def view_bills(bills):
    bills = read_bills()
    for bill in bills:
        #print(bill[0], bill[1], bill[2], bill[3], bill[4], bill[5], bill[6])            
        print(*bill)
        
def display_menu(): 
    print(get_message())
    
def process_choice(bills):
    choice = input('Your are on Main Menu.\nPlease enter an option(0 to return):')
    while choice != '5':
        if choice == '0':
            display_menu()
        elif choice == '1':
            view_bills(view_bills)
        elif choice == '2':
            write_bills(bills)
        elif choice == '3':
            report_menu()
        elif choice == '4':
            print('The terms of the billing management company')
        choice = input('Your are on Main Menu.\nPlease enter an option(0 to return):')

def report_TotalPerYear():
    bills = read_bills()
    df = pd.DataFrame(bills)
    df = df.rename(columns={0: 'Company', 1: 'Customer', 2: 'Year', 3: 'Month', 4: 'Day', 5: 'Total', 6: 'Type'})
    df['Total'] = pd.to_numeric(df['Total'])
    billTotal = df.groupby(['Year', 'Type'], as_index = False).sum().pivot('Year', 'Type').rename(columns={'credit': 'Total Credited', 'debit': 'Total Debited'})    
    return billTotal
  
def report_PopularUtilCompany():
    bills = read_bills()
    company = {}
    for i in bills:
        if i[0] in company:
            company[i[0]] += 1
        else:
            company[i[0]] = 1
    #company = sorted(company.items())
    company = sorted(company, key=company.get, reverse=True)
    return 'The most popular company was: ' + company[0]

def report_BillsDateOrder():
    bills = read_bills()
    df = pd.DataFrame(bills)
    dateComp = []
    for bill in bills:
        dateStr = bill[2]+'-' + bill[3]+'-' + bill[4]
        dateComp.append(dateStr)  
    df['dateComp'] = dateComp
    df = df.rename(columns={0: 'Company', 1: 'Customer', 2: 'Year', 3: 'Month', 4: 'Day', 5: 'Total', 6: 'Type'})    
    df1 = df.sort_values(by=['dateComp'])
    return df1[['Company', 'Customer', 'Year', 'Month', 'Day', 'Total', 'Type']]
    
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

def report_TotalBillsPerCompany():
    bills = read_bills()
    company = {}
    for i in bills:
        if i[0] in company:
            company[i[0]] += 1
        else:
            company[i[0]] = 1
    companyDict = company
    companySort = sorted(company, key=company.get, reverse=True)
    companyCount = companyDict[companySort[0]]    
    print('The most popular company was: ' + str(companySort[0]) + str(' with total of ') + str(companyCount) + str(' bills'))

def report_AveragePerPeriod():
    bills = read_bills()
    df = pd.DataFrame(bills)
    dateComp = []
    for bill in bills:
        dateStr = bill[2]+'-' + bill[3]
        dateComp.append(dateStr)  
    df['dateComp'] = dateComp
    df = df.rename(columns={0: 'Company', 1: 'Customer', 2: 'Year', 3: 'Month', 4: 'Day', 5: 'Total', 6: 'Type'})    
    df['Total'] = pd.to_numeric(df['Total'])
    averGroup = df.groupby(['Type', 'dateComp'])['Total'].mean().reset_index()
    averBill = averGroup[averGroup['Type']=='debit']
    averBill = averBill.rename(columns = {'Type': 'Type', 'dateComp': 'Period', 'Total': 'Average'})
    return averBill

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
    message = 'The average time between bills is(in days): '
    print( str(message), caz2)
    
def main():    
    bills = read_bills()
    display_menu()
    process_choice(bills)
    write_bills(bills)
    
    
if __name__ == '__main__':
    main()
