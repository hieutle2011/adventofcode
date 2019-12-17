import unittest
import os
from main import makeMap, parseInputFile, parseMap, travel, moveCount


class TestMakeMap(unittest.TestCase):
    def test_makeMap(self):
        arr = ['COM)B', 'B)C']
        myMap = makeMap(arr)
        self.assertEqual(len(myMap), 2)
        isB = 'B' in myMap
        self.assertEqual(isB, True)

        path = os.getcwd() + '/input1.txt'
        arr = parseInputFile(path)
        myMap = makeMap(arr)
        self.assertEqual(len(myMap), 11)

        path = os.getcwd() + '/input0.txt'
        arr = parseInputFile(path)
        myMap = makeMap(arr)
        self.assertEqual(len(myMap), 1013)

    def test_item(self):
        arr = ['COM)B', 'B)C']
        myMap = makeMap(arr)
        expect = {
            'B': 'COM',
            'C': 'B'
        }
        self.assertEqual(myMap, expect)


class TestParseMap(unittest.TestCase):
    def test_parse_map(self):
        myMap = {'B': 'COM', 'C': 'B'}
        newMap, count = parseMap(myMap)
        expect = {
            'B': {
                'direct': 'COM',
                'total': 1
            },
            'C': {
                'direct': 'B',
                'total': 2
            }
        }
        self.assertEqual(newMap, expect)
        self.assertEqual(count, 3)

    def test_parse_map_input0(self):
        path = os.getcwd() + '/input1.txt'
        arr = parseInputFile(path)
        myMap = makeMap(arr)
        newMap, count = parseMap(myMap)

        self.assertEqual(len(newMap), 11)
        self.assertEqual(count, 42)
        self.assertEqual(newMap['H']['total'], 3)

    def test_parse_map_input1(self):
        path = os.getcwd() + '/input0.txt'
        arr = parseInputFile(path)
        myMap = makeMap(arr)
        newMap, count = parseMap(myMap)

        self.assertEqual(len(newMap), 1013)
        self.assertEqual(count, 142915)


class TestTravel(unittest.TestCase):
    def test_travel(self):
        you = 'YOU'
        san = 'SAN'

        path = os.getcwd() + '/input2.txt'
        arr = parseInputFile(path)
        myMap = makeMap(arr)
        newMap, _ = parseMap(myMap)

        your_arr = travel(you, newMap)
        self.assertEqual(your_arr, ['K', 'J', 'E', 'D', 'C', 'B', 'COM'])

        sans_arr = travel(san, newMap)
        self.assertEqual(sans_arr, ['I', 'D', 'C', 'B', 'COM'])


class TestMove(unittest.TestCase):
    def test_move(self):
        arr1 = ['K', 'J', 'E', 'D', 'C', 'B', 'COM']
        arr2 = ['I', 'D', 'C', 'B', 'COM']

        move = moveCount(arr1, arr2)
        self.assertEqual(move, 4)

    def test_move_02(self):
        you = 'YOU'
        san = 'SAN'
        path = os.getcwd() + '/input2.txt'
        arr = parseInputFile(path)
        myMap = makeMap(arr)
        newMap, _ = parseMap(myMap)

        your_arr = travel(you, newMap)
        sans_arr = travel(san, newMap)

        move = moveCount(your_arr, sans_arr)
        self.assertEqual(move, 4)

    def test_move_01(self):
        you = 'YOU'
        san = 'SAN'
        path = os.getcwd() + '/input0.txt'
        arr = parseInputFile(path)
        myMap = makeMap(arr)
        newMap, _ = parseMap(myMap)

        self.assertEqual(len(newMap), 1013)

        your_arr = travel(you, newMap)
        sans_arr = travel(san, newMap)

        move = moveCount(your_arr, sans_arr)
        self.assertEqual(move, 283)


class TestSet(unittest.TestCase):
    def test_set(self):
        arr1 = ['a', 'b', 'c']
        arr2 = ['a', 'b', 'c', 'd']

        s1 = set(arr1)
        s2 = set(arr2)

        diff = s1 ^ s2
        self.assertEqual(diff, {'d'})
