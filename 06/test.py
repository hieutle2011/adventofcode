import unittest
import os
from main import Planet, makeMap, parseInputFile, parseMap


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