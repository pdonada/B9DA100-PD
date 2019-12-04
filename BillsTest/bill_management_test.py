import unittest

class TestBillManagement(unittest.TestCase):
    
    def test_bill_management(self):
        bills = read_bills()
        self.assertEquals(20, len(bills))
        self.assertEquals('Vodafone', bills[0][0])
        self.assertEquals('credit', bills[16][6])
    