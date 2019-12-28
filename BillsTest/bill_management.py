import pandas as pd
import datetime

###read the file
def read_bills():
    return [[col.strip() for col in row.strip().split(',')]
             for row in open('bills.csv', 'r') if len(row) > 1]

###write on the file
def write_bills(bills):
    bill_file = open('bills.csv', 'w')
    for bill in bills:
        bill_file.write(', '.join(bill) + '\n')

###insert new rows       
def insertBills(insCompany, insCustomer, insDate, insTotal, insType):
    bills = read_bills()
    if insType.upper() == 'C': 
        insType = 'credit' 
    elif insType.upper() == 'D':
        insType = 'debit'    
    bills.append([insCompany, insCustomer
                  , str(datetime.datetime.strptime(insDate, '%Y-%m-%d').date().year)
                  , str(datetime.datetime.strptime(insDate, '%Y-%m-%d').date().month)
                  , str(datetime.datetime.strptime(insDate, '%Y-%m-%d').date().day)              
                  , str(insTotal)
                  , insType])
    return write_bills(bills)
        

###menu message
def get_message():
    return 'Hello, Welcome to the Bill Management Company\n' + \
            '1: View Bills\n2: Insert a Bill\n3: Reports\n4: T&Cs\n5: Exit'

###reports menu
def get_report_menu():
    return 'Hello, Welcome to the Reports Menu\n' + \
            '1: Total per Year\n2: Most Popular Company\n3: Bills Order by Date\n4: Highest Bill-Credit/Debit\n5: Highest Bill-Debit\n6: Number of Bills per Year\n7: Average Spent by Period\n8: Average Time Between Bills\n9: Exit'

###reports menu options
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
            print('Please, use optioin 4')
        elif choice == '6':
            report_TotalBillsPerCompany()
        elif choice == '7':
            print(report_AveragePerPeriod())
        elif choice == '8':
            report_AverageTime()
        choice = input('You are on Reports Menu.\nPlease select a report(0 to return):')

###list bills                      
def view_bills(bills):
    bills = read_bills()
    for bill in bills:
        #print(bill[0], bill[1], bill[2], bill[3], bill[4], bill[5], bill[6])            
        print(*bill)
      
###open main menu
def display_menu(): 
    print(get_message())

###main menu options    
def process_choice(bills):
    choice = input('Your are on Main Menu.\nPlease enter an option(0 to return):')
    while choice != '5':
        if choice == '0':
            display_menu()
        elif choice == '1':
            view_bills(view_bills)
        elif choice == '2':
            inputCompany  = input('Please enter the company name: ', )
            inputCustomer = input('Please enter the customer name: ', )
            inputDate     = inputDateTest('Please enter the bill date (yyyy-mm-dd): ', )
            inputTotal    = inputTotalTest('Please enter the total value: ')
            inputType     = inputTypeTest('Please enter the bill type (C=Credit or D=Debit): ' )
            insertBills(inputCompany, inputCustomer, inputDate, inputTotal, inputType)
        elif choice == '3':
            report_menu()
        elif choice == '4':
            print('The terms of the billing management company')
        choice = input('Your are on Main Menu.\nPlease enter an option(0 to return):')

###Verify date input to check acceptable format
def inputDateTest(dateValue):
    while True:
        dateTest = input(dateValue)
        try:
            datetime.datetime.strptime(dateTest, '%Y-%m-%d')
        except ValueError:
            print('The date {} is invalid'.format(dateTest))
            continue
        break
    return dateTest

###Verify total input to check acceptable format
def inputTotalTest(totalValue):
    while True:
        val = input(totalValue)
        try:
            val = float(val)
        except ValueError:
            print('The value is invalid ',val)
            continue
        break
    return val
      
###Verify type input to check acceptable format
def inputTypeTest(typeValue):
    while True:
        val = input(typeValue)
        try:
            if val.upper() not in ('C', 'D'):
                print('Please, enter C for Credit or D for Debit')
                continue
        except ValueError:
            print('Please, enter C for Credit or D for Debit')
        break
    return val
            
###report Item 3.Provide a report that lists years, total credited and total debited, 
###e.g., the output will look like the following:
def report_TotalPerYear():
    bills = read_bills()
    df = pd.DataFrame(bills)
    df = df.rename(columns={0: 'Company', 1: 'Customer', 2: 'Year', 3: 'Month', 4: 'Day', 5: 'Total', 6: 'Type'})
    df['Total'] = pd.to_numeric(df['Total'])
    billTotal = df.groupby(['Year', 'Type'], as_index = False).sum().pivot('Year', 'Type').rename(columns={'credit': 'Total Credited', 'debit': 'Total Debited'})    
    return billTotal

###report Item 4.Provide a report that shows the most popular utility company.  
###The most popular utility company is the one with the most bills against that provider.  
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

###report Item 5.Provide a report that shows the bills in date order.
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

###report item 6.Provide another report that displays the highest amount 
###for a bill that is a credit, and one for a debit.    
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
    
###report item 7.Provide a report to indicate how successful the company is.  
###This should display the total number of bills
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

###report item 8.Provide a report to calculate the average spent per 
###period of time (month/year) that can be entered by the user.
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

###report item 9.Provide a report to calculate the average time between bills.
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
