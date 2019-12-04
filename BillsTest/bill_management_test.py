import unittest

from bill_management import read_bills, write_bills, get_message

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

if __name__ == '__main__':
    unittest.main()    