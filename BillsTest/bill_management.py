

def read_bills():
    bills = []
    bills_file = open('bills.csv')
    for line in bills_file:
        bills.append(line.strip().split(','))
        bills[-1][-1] = bills[-1][-1].strip()
    return bills

def view_bills(bills):
    bills = read_bills()
    for bill in bills:
        print(bill[0], bill[1], bill[2], bill[3], bill[4], bill[5], bill[6])            

def display_menu(): 
    print('Hello, Welcome to the Bill Managment Company')
    print(' 1. View Bills:\n 2. Insert a Bill\n 3. Reports\n 4. T&Cs\n 5. Exit\n')
    
def process_choice(bills):
    choice = input('Please enter an option:')
    while choice != '5':
        if choice == '1':
            view_bills(view_bills)
        elif choice == '4':
            print('The terms of the billing management company')
        choice = input('Plese enter an option:')

def write_bills(bills):
    pass
        
def main():
    bills = read_bills()
    display_menu()
    process_choice(bills)
    write_bills(bills)
    
if __name__ == '__main__':
    main()
