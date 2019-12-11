import os
import copy


class Point:
    def __init__(self, x_ord, y_ord):
        self.x = x_ord
        self.y = y_ord

    def get_manhatan_distance(self, point):
        return abs(self.x - point.x) + abs(self.y - point.y)

    def get_manhatan_distance_from_central(self):
        return abs(self.x) + abs(self.y)

    def isExist(self):
        if self.x == None or self.y == None:
            return False
        else:
            return True

    def nextPoint(self, command):
        x = 0
        y = 0
        code = command[0]
        step = int(command[1:])
        if code == 'R':
            x += step
        elif code == 'L':
            x -= step
        elif code == 'U':
            y += step
        elif code == 'D':
            y -= step
        return Point(self.x + x, self.y + y)


class Line:
    def __init__(self, ptA, ptB):
        min_x = 0
        min_y = 0
        max_x = 0
        max_y = 0
        if ptA.x == ptB.x:
            min_x = ptA.x
            max_x = ptA.x
            self.direction = 'VERTICAL'
            if ptA.y > ptB.y:
                min_y = ptB.y
                max_y = ptA.y
            else:
                min_y = ptA.y
                max_y = ptB.y
        elif ptA.y == ptB.y:
            min_y = ptA.y
            max_y = ptA.y
            self.direction = 'HORIZONTAL'
            if ptA.x > ptB.x:
                min_x = ptB.x
                max_x = ptA.x
            else:
                min_x = ptA.x
                max_x = ptB.x
        else:
            self.direction = 'DIAGONAL'

        self.min_x = min_x
        self.min_y = min_y
        self.max_x = max_x
        self.max_y = max_y

    def intersected_by(self, line):
        xP = None
        yP = None

        if self.direction != line.direction:
            if self.direction == 'VERTICAL':
                if self.min_x >= line.min_x and self.min_x <= line.max_x and line.min_y >= self.min_y and line.min_y <= self.max_y:
                    xP = self.min_x
                    yP = line.min_y
            elif self.direction == 'HORIZONTAL':
                if line.min_x >= self.min_x and line.min_x <= self.max_x and self.min_y >= line.min_y and self.min_y <= line.max_y:
                    xP = line.min_x
                    yP = self.min_y

        return Point(xP, yP)


def parseInputFile(path):
    file = open(path)
    wires = []
    for line in file:
        wire = line.replace('\n', '').split(',')
        wires.append(wire)
    return wires


def main():
    path = os.getcwd() + '/input.txt'
    wires = parseInputFile(path)

    centralPt = Point(0, 0)
    lines = []

    for wire in wires:
        sub_lines = []
        currentPt = copy.deepcopy(centralPt)
        for cmd in wire:
            nextPt = currentPt.nextPoint(cmd)
            line = Line(currentPt, nextPt)
            sub_lines.append(line)
            currentPt = nextPt
        lines.append(sub_lines)
    
    valid_points = []

    for line_0 in lines[0]:
        for line_1 in lines[1]:
            intersection = line_0.intersected_by(line_1)
            if intersection.isExist():
                valid_points.append(intersection)

    print('Number of cut points: {}'.format(len(valid_points))) # expect 49

    min_distance = 1000000 # abitrary big number
    for p in valid_points:
        distance = p.get_manhatan_distance_from_central()
        print('====distance {}, x {}, y {}'.format(distance, p.x, p.y))
        if distance != 0 and distance < min_distance:
            min_distance = distance
    
    print('Distance to closest point: {}'.format(min_distance)) # expect 860


if __name__ == "__main__":
    main()
