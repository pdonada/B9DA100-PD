

def read_bills():
    bills = []
    bills_file = open('bills.csv')
    for line in bills_file:
        bills.append(line.strip().split(','))
        bills[-1][-1] = bills[-1][-1].strip()
    return bills