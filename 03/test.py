import unittest
from main import Point, Line


class TestPointMethods(unittest.TestCase):
    def test_new_point(self):
        new = Point(3, 3)
        self.assertEqual(new.x, 3)
        self.assertEqual(new.y, 3)
        self.assertEqual(new.isExist(), True)

    def test_new_point_null(self):
        new = Point(None, 3)
        self.assertEqual(new.x, None)
        self.assertEqual(new.y, 3)
        self.assertEqual(new.isExist(), False)

    def test_distance_from_central(self):
        new = Point(-3, -3)
        self.assertIs(type(new.x), int)
        self.assertEqual(new.get_manhatan_distance_from_central(), 6)

    def test_distance_from_point(self):
        pA = Point(1, 1)
        pB = Point(3, 3)
        self.assertEqual(pA.get_manhatan_distance(pB), 4)

    def test_nextPoint_with_0_0(self):
        centralPoint = Point(0, 0)
        nxPoint = centralPoint.nextPoint('R8')
        self.assertEqual(nxPoint.x, 8)
        self.assertEqual(nxPoint.y, 0)

        nxPoint = centralPoint.nextPoint('U5')
        self.assertEqual(nxPoint.x, 0)
        self.assertEqual(nxPoint.y, 5)

        nxPoint = centralPoint.nextPoint('L8')
        self.assertEqual(nxPoint.x, -8)
        self.assertEqual(nxPoint.y, 0)

        nxPoint = centralPoint.nextPoint('D5')
        self.assertEqual(nxPoint.x, 0)
        self.assertEqual(nxPoint.y, -5)

    def test_nextPoint_with_custom_point(self):
        nxPoint = Point(8, 0).nextPoint('R1')
        self.assertEqual(nxPoint.x, 9)
        self.assertEqual(nxPoint.y, 0)

class TestLineMethods(unittest.TestCase):
    def test_new_line_horizontal(self):
        line = Line(Point(3,5), Point(8,5))
        self.assertEqual(line.direction, 'HORIZONTAL')
        self.assertEqual(line.min_x, 3)
        self.assertEqual(line.max_x, 8)
        self.assertEqual(line.min_y, 5)
        self.assertEqual(line.max_y, 5)
        
    def test_new_line_vertical(self):
        line = Line(Point(10,3), Point(10,10))
        self.assertEqual(line.direction, 'VERTICAL')
        self.assertEqual(line.min_x, 10)
        self.assertEqual(line.max_x, 10)
        self.assertEqual(line.min_y, 3)
        self.assertEqual(line.max_y, 10)

    def test_un_cut_lines(self):
        hor = Line(Point(3,5), Point(8,5))
        ver = Line(Point(10,3), Point(10,10))
        cut_point = hor.intersected_by(ver)
        self.assertEqual(cut_point.isExist(), False)

    def test_cut_lines(self):
        hor = Line(Point(3,5), Point(8,5))
        ver = Line(Point(6,3), Point(6,10))
        cut_point = hor.intersected_by(ver)
        self.assertEqual(cut_point.isExist(), True)
        self.assertEqual(cut_point.x, 6)
        self.assertEqual(cut_point.y, 5)

if __name__ == '__main__':
    unittest.main()
