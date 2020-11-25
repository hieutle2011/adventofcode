import os


def makeMap(arr: list) -> map:
    """Make a new map from list of code"""
    newMap: map = {}
    for i in range(len(arr)):
        items: list = arr[i].split(')')
        central: str = items[0]
        orbitObj: str = items[1]
        newMap[orbitObj] = central
    return newMap


def parseMap(inMap: map) -> (map, int):
    """Return new map and the number of all direct and indirect steps
    within map
    """
    count: int = 0
    outMap: map = {}
    for k, v in inMap.items():
        total: int = 1
        central: str = v
        while central != 'COM':
            total += 1
            central = inMap[central]

        direct: str = v

        innerMap: map = {
            'direct': direct,
            'total': total
        }
        outMap[k] = innerMap
        count += total
    return outMap, count


def travel(k: str, myMap: map) -> list:
    """Return list of objects between the object k and the object 'COM'"""
    arr = []
    current = k
    com = 'COM'
    while current != com:
        direct = myMap[current]['direct']
        arr.append(direct)
        current = direct
    return arr


def moveCount(arr1: list, arr2: list) -> int:
    """Number of moves calculated as full outer join of 2 list"""
    set1 = set(arr1)
    set2 = set(arr2)

    result = set1 ^ set2
    return len(result)


def parseInputFile(path: str) -> list:
    arr = []
    file = open(path)
    for line in file:
        item = line.split('\n')[0]
        arr.append(item)
    file.close()
    return arr


def main():
    path = os.getcwd() + '/input0.txt'
    arr = parseInputFile(path)

    myMap = makeMap(arr)
    newMap, count = parseMap(myMap)

    print(count)  # 142915

    you = 'YOU'
    san = 'SAN'

    your_arr = travel(you, newMap)
    sans_arr = travel(san, newMap)

    move = moveCount(your_arr, sans_arr)
    print(move)  # 283


if __name__ == "__main__":
    main()
