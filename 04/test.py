import unittest
from main import Adjacent, isValidNumber


class TestAdjescantMethods(unittest.TestCase):
    def test_valid(self):
        str1, str2 = '1', '1'
        adj = Adjacent(str1, str2)
        valid = adj.isValid()
        self.assertEqual(valid, True)

        str1, str2 = '1', '3'
        adj = Adjacent(str1, str2)
        valid = adj.isValid()
        self.assertEqual(valid, True)

    def test_invalid(self):
        str1, str2 = '5', '0'
        adj = Adjacent(str1, str2)
        valid = adj.isValid()
        self.assertEqual(valid, False)

    def test_is_double_false(self):
        str1, str2 = '5', '0'
        adj = Adjacent(str1, str2)
        valid = adj.isDouble()
        self.assertEqual(valid, False)

    def test_is_double_True(self):
        str1, str2 = '0', '0'
        adj = Adjacent(str1, str2)
        valid = adj.isDouble()
        self.assertEqual(valid, True)


class TestNumbers(unittest.TestCase):
    def test_invalid_digit_number(self):
        valid = isValidNumber(1)
        self.assertEqual(valid, False)

        valid = isValidNumber(1234567)
        self.assertEqual(valid, False)

    def test_valid_digit_number(self):
        valid = isValidNumber(113456)
        self.assertEqual(valid, True)

    def test_valid_number(self):
        num = 111123  # double 11, never decreases
        valid = isValidNumber(num)
        self.assertEqual(valid, True)

        num = 111111  # double 11, never decreases
        valid = isValidNumber(num)
        self.assertEqual(valid, True)

    def test_invalid_number(self):
        num = 223450  # decreasing pair of 50
        valid = isValidNumber(num)
        self.assertEqual(valid, False)

        num = 123789  # no double
        valid = isValidNumber(num)
        self.assertEqual(valid, False)


if __name__ == '__main__':
    unittest.main()
