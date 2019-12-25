import unittest
from main import phase_generator, amply


class TestPhaseGenerator(unittest.TestCase):
    def test_1_digit(self):
        expect = [(0, 1), (1, 0)]
        self.assertEqual(phase_generator(0, 1), expect)

        expect = [(3, 4), (4, 3)]
        self.assertEqual(phase_generator(3, 4), expect)


class TestAmply(unittest.TestCase):
    def test_exp_1(self):
        fname = "/example_1.txt"
        phase = [4, 3, 2, 1, 0]
        self.assertEqual(amply(fname, phase), 43210)

    def test_exp_2(self):
        fname = "/example_2.txt"
        phase = [0, 1, 2, 3, 4]
        self.assertEqual(amply(fname, phase), 54321)

    def test_exp_3(self):
        fname = "/example_3.txt"
        phase = [1, 0, 4, 3, 2]
        self.assertEqual(amply(fname, phase), 65210)
