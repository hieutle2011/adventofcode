import os


class Planet:
    def __init__(self, central):
        self.central = central
        self.total = 0

    def count(self):
        curPlanet = self.central
        while curPlanet is not None:
            self.total += 1
            curPlanet = curPlanet.central


def makeMap(arr):
    newMap = {}
    for i in range(len(arr)):
        items = arr[i].split(')')
        central = items[0]
        orbitObj = items[1]
        newMap[orbitObj] = central
    return newMap


def parseMap(inMap):
    count = 0
    outMap = {}
    for k, v in inMap.items():
        total = 1
        central = v
        while central != 'COM':
            total += 1
            central = inMap[central]

        direct = v

        innerMap = {
            'direct': direct,
            'total': total
        }
        outMap[k] = innerMap
        count += total
    return outMap, count


def parseInputFile(path):
    arr = []
    file = open(path)
    for line in file:
        item = line.split('\n')[0]
        arr.append(item)
    file.close()
    return arr


def main():
    path = os.getcwd() + '/input1.txt'
    arr = parseInputFile(path)

    myMap = makeMap(arr)
    _, count = parseMap(myMap)

    print(count)  # 142915


if __name__ == "__main__":
    main()
