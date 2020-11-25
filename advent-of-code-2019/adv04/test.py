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
        num = 113456  # double 1s
        valid = isValidNumber(num)
        self.assertEqual(valid, True)

        # the digits never decrease and all repeated digits are exactly
        # two digits long.
        num = 112233
        valid = isValidNumber(num)
        self.assertEqual(valid, True)

        # meets the criteria (even though 1 is repeated more than twice
        # it still contains a double 22)
        num = 111122
        valid = isValidNumber(num)
        self.assertEqual(valid, True)

    def test_invalid_number(self):
        num = 223450  # decreasing pair of 50
        valid = isValidNumber(num)
        self.assertEqual(valid, False)

        num = 123789  # no double
        valid = isValidNumber(num)
        self.assertEqual(valid, False)

        num = 123444  # the repeated 44 is part of a larger group of 444
        valid = isValidNumber(num)
        self.assertEqual(valid, False)

        num = 178477  # decreasing pair of 84
        valid = isValidNumber(num)
        self.assertEqual(valid, False)


if __name__ == '__main__':
    unittest.main()
