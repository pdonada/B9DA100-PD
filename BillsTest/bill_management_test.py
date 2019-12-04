import unittest

from bill_management import read_bills

class TestBillManagement(unittest.TestCase):
    
    def test_bill_management(self):
        bills = read_bills()
        self.assertEqual(20, len(bills))
        self.assertEqual('Electric Ireland', bills[0][0])
        self.assertEqual('credit', bills[19][6])

if __name__ == '__main__':
    unittest.main()    