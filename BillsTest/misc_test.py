

def read_bills():
    return [[col.strip() for col in row.strip().split(',')]
             for row in open('bills.csv', 'r') if len(row) > 1]

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



print(report_TotalBillsPerCompany())