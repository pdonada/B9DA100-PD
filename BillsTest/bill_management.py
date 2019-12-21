

def read_bills():
    bills = []
    bills_file = open('bills.csv')
    for line in bills_file:
        bills.append(line.strip().split(','))
        bills[-1][-1] = bills[-1][-1].strip()
    return bills

def write_bills(bills):
    bill_file = open('bills.csv', 'w')
    for bill in bills:
        bill_file.write(', '.join(bill) + '\n')

def get_message():
    return 'Hello, Welcome to the Bill Management Company\n' + \
            '1: View Bills\n2: Insert a Bill\n3: Reports\n4: T&Cs\n5: Exit'
            
def view_bills(bills):
    bills = read_bills()
    for bill in bills:
        print(bill[0], bill[1], bill[2], bill[3], bill[4], bill[5], bill[6])            

def display_menu(): 
    print(get_message())
    
def process_choice(bills):
    choice = input('Please enter an option:')
    while choice != '5':
        if choice == '1':
            view_bills(view_bills)
        elif choice == '4':
            print('The terms of the billing management company')
        choice = input('Plese enter an option:')
      
def main():
    bills = read_bills()
    display_menu()
    process_choice(bills)
    write_bills(bills)
    
if __name__ == '__main__':
    main()
