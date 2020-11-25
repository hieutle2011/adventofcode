import unittest
from main import makeOpCode


class TestMakeOpCode(unittest.TestCase):
    def test_1_digit(self):
        opCode = '1'
        res = makeOpCode(opCode)
        self.assertEqual(res, '0001')
        self.assertEqual(res[-1], '1')
        self.assertEqual(res[-2], '0')
        self.assertEqual(res[-3], '0')
        self.assertEqual(res[-4], '0')

    def test_2_digit(self):
        opCode = '11'
        res = makeOpCode(opCode)
        self.assertEqual(res, '0011')
        self.assertEqual(res[-1], '1')
        self.assertEqual(res[-2], '1')
        self.assertEqual(res[-3], '0')
        self.assertEqual(res[-4], '0')

    def test_3_digit(self):
        opCode = '102'
        res = makeOpCode(opCode)
        self.assertEqual(res, '0102')
        self.assertEqual(res[-1], '2')
        self.assertEqual(res[-2], '0')
        self.assertEqual(res[-3], '1')
        self.assertEqual(res[-4], '0')

    def test_4_digit(self):
        opCode = '1002'
        res = makeOpCode(opCode)
        self.assertEqual(res, '1002')
        self.assertEqual(res[-1], '2')
        self.assertEqual(res[-2], '0')
        self.assertEqual(res[-3], '0')
        self.assertEqual(res[-4], '1')
