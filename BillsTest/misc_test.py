def read_bills():
    return [[col.strip() for col in row.strip().split(',')]
             for row in open('bills.csv') if len(row) > 1]
    print(bills)
    bills_file.close() 
    