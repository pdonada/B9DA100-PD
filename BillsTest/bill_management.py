

def read_bills():
    bills = []
    bills_file = open('bills.csv')
    for line in bills_file:
        words = []
        for word in line.split(','):
            word = word.strip()
            if word:
                words.append(word)
        print(words)
    return bills

def write_bills(bills):
    bill_file = open('bills.csv', 'w')
    for bill in bills:
        bill_file.write(', '.join(bill) + '\n')

def get_message():
    return 'Hello, Welcome to the Bill Management Company\n' + \
            '1: View Bills\n2: Insert a Bill\n3: Reports\n4: T&Cs\n5: Exit'

def get_report_menu():
    return 'Hello, Welcome to the Reports Menu\n' + \
            '1: Total per Year\n2: Bill per Year\n3: Bill per Date\n4: Highest Bill-Credit\n5: Highest Bill-Debit\n6: Number of Bills per Year\n7: Average Spent by Period\n8: Average Time Between Bills\n9: Exit'

def report_menu():
    print(get_report_menu())
    choice = input('You are on Reports Menu.\nPlease select a report(0 to return):')
    while choice != '9':
        if choice == '0':
            print(get_report_menu())
        elif choice == '1':
            print('Total per Year')
        elif choice == '2':
            print('Bill per Year')
        elif choice == '3':
            print('Bill per Date')
        elif choice == '4':
            print('Highest Bill-Credit')
        elif choice == '5':
            print('NHighest Bill-Debit')
        elif choice == '6':
            print('Number of Bills per Year')
        elif choice == '7':
            print('Average Spent by Period')
        elif choice == '8':
            print('Average Time Between Bills')
        choice = input('You are on Reports Menu.\nPlease select a report(0 to return):')
           
            
def view_bills(bills):
    bills = read_bills()
    for bill in bills:
        print(bill[0], bill[1], bill[2], bill[3], bill[4], bill[5], bill[6])            

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
      
def main():    
    bills = read_bills()
    display_menu()
    process_choice(bills)
    write_bills(bills)
    
    
if __name__ == '__main__':
    main()
