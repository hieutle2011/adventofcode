import unittest
import os
from main import Planet, makeMap, parseInputFile, parseMap, travel, moveCount


class TestPlanetMethods(unittest.TestCase):
    def test_init(self):
        com = Planet(None)
        self.assertEqual(com.central, None)
        self.assertEqual(com.total, 0)

        b_planet = Planet(com)
        self.assertEqual(b_planet.central, com)
        self.assertEqual(b_planet.total, 0)

        b_planet.count()
        self.assertEqual(b_planet.total, 1)

        c_planet = Planet(b_planet)
        self.assertEqual(c_planet.central, b_planet)
        self.assertEqual(c_planet.total, 0)

        c_planet.count()
        self.assertEqual(c_planet.total, 2)


class TestMakeMap(unittest.TestCase):
    def test_makeMap(self):
        arr = ['COM)B', 'B)C']
        myMap = makeMap(arr)
        self.assertEqual(len(myMap), 2)
        isB = 'B' in myMap
        self.assertEqual(isB, True)

        path = os.getcwd() + '/input0.txt'
        arr = parseInputFile(path)
        myMap = makeMap(arr)
        self.assertEqual(len(myMap), 11)

        path = os.getcwd() + '/input1.txt'
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
        path = os.getcwd() + '/input0.txt'
        arr = parseInputFile(path)
        myMap = makeMap(arr)
        newMap, count = parseMap(myMap)

        self.assertEqual(len(newMap), 11)
        self.assertEqual(count, 42)
        self.assertEqual(newMap['H']['total'], 3)

    def test_parse_map_input1(self):
        path = os.getcwd() + '/input1.txt'
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

        yours = newMap[you]['direct']
        sans = newMap[san]['direct']

        self.assertEqual(yours, 'K')
        self.assertEqual(sans, 'I')

        your_arr = travel(yours, newMap)
        self.assertEqual(your_arr, ['J', 'E', 'D', 'C', 'B', 'COM'])

        sans_arr = travel(sans, newMap)
        self.assertEqual(sans_arr, ['D', 'C', 'B', 'COM'])


class TestMove(unittest.TestCase):
    def test_move(self):
        arr1 = ['J', 'E', 'D', 'C', 'B', 'COM']
        arr2 = ['D', 'C', 'B', 'COM']

        move = moveCount(arr1, arr2)
        self.assertEqual(move, 4)

    def test_move_02(self):
        you = 'YOU'
        san = 'SAN'
        path = os.getcwd() + '/input2.txt'
        arr = parseInputFile(path)
        myMap = makeMap(arr)
        newMap, _ = parseMap(myMap)

        yours = newMap[you]['direct']
        sans = newMap[san]['direct']

        your_arr = travel(yours, newMap)
        sans_arr = travel(sans, newMap)

        move = moveCount(your_arr, sans_arr)
        self.assertEqual(move, 4)

    def test_move_01(self):
        you = 'YOU'
        san = 'SAN'
        path = os.getcwd() + '/input1.txt'
        arr = parseInputFile(path)
        myMap = makeMap(arr)
        newMap, _ = parseMap(myMap)

        self.assertEqual(len(newMap), 1013)

        yours = newMap[you]['direct']
        sans = newMap[san]['direct']

        your_arr = travel(yours, newMap)
        sans_arr = travel(sans, newMap)

        move = moveCount(your_arr, sans_arr)
        self.assertEqual(move, 211)
