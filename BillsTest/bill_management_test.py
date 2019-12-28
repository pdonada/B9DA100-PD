import unittest

from bill_management import read_bills, write_bills, get_message, report_HighestBill, report_TotalPerYear, report_PopularUtilCompany, report_BillsDateOrder, report_TotalBillsPerCompany, report_AveragePerPeriod, report_AverageTime, insertBills, view_bills

class TestBillManagement(unittest.TestCase):
    
    def test_read_bills(self):
        bills = read_bills()
        self.assertEqual(20, len(bills))
        self.assertEqual('Electric Ireland', bills[0][0])
        self.assertEqual('credit', bills[19][6])
        
    def test_write_bills(self):
        bills = read_bills()
        write_bills(bills)
        bills = read_bills()
        self.assertEqual(20, len(bills))
        self.assertEqual('Electric Ireland', bills[0][0])
        self.assertEqual('credit', bills[19][6])
        
    def test_getmessage_bills(self):
        self.assertEqual('Hello, Welcome to the Bill Management Company\n' + \
                         '1: View Bills\n2: Insert a Bill\n3: Reports\n4: T&Cs\n5: Exit',
                         get_message())
    
    def test_report_HighestBill(self): 
        totalBills = report_HighestBill()     
        self.assertEqual('          Company    Customer  Year Month Day  Total    Type\n Electric Ireland  John Smyth  2019    05  12  81.58  credit', totalBills)
    
    def test_report_TotalPerYear(self):
        totalBills = report_TotalPerYear()
        self.assertEqual('2016', totalBills.index[0])
        self.assertEqual(5.0, totalBills['Total']['Total Credited'][0])
        self.assertEqual(167.52, round(totalBills['Total']['Total Debited'][0],2))
    
    def test_report_PopularUtilCompany(self):
        totalBills = report_PopularUtilCompany() 
        self.assertEqual('The most popular company was: Energia', totalBills)
        
    def test_report_BillsDateOrder(self): 
        totalBills = report_BillsDateOrder()
        self.assertEqual('Energia 2016 debit', str(totalBills['Company'][1] + ' ' + totalBills['Year'][1] + ' ' + totalBills['Type'][1]))

    def test_report_TotalBillsPerCompany(self):
        totalBills = report_TotalBillsPerCompany()
        self.assertEqual((8, 'Energia'), totalBills)

    def test_report_AveragePerPeriod(self):
        totalBills = report_AveragePerPeriod()
        self.assertEqual('debit  2016-11    22.50', totalBills[26:49])
     
    def test_report_AverageTime(self):
        totalBills = report_AverageTime()
        self.assertEqual( 60.21, totalBills)
    
    def test_zinsertBills(self):     
        insertBills('Zara', 'Molly Mallone', '2020-01-01', 324.48, 'D')
        totalBills = view_bills()
        self.assertEqual('Zara  Molly Mallone  2020     1   1  324.48   debit' , totalBills[1378:1429])

if __name__ == '__main__':
    unittest.main()    