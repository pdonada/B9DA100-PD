def read_bills():
    return [[col.strip() for col in row.strip().split(',')]
             for row in open('bills.csv', 'r') if len(row) > 1]

def PopularUtilCompany():
    bills = read_bills()
    company = {}
    for i in bills:
        if i[0] in company:
            company[i[0]] += 1
        else:
            company[i[0]] = 1
    #company = sorted(company.items())
    company = sorted(company, key=company.get, reverse=True)
    #return company[0]
    return 'The most popular company was: ' + company[0]
    #for w in sorted(company, key=company.get, reverse=True):
     #   print(w, company[w])
    
    
print(PopularUtilCompany()) 