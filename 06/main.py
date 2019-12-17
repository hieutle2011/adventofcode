import os


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


def travel(k, myMap):
    arr = []
    current = k
    com = 'COM'
    while current != com:
        direct = myMap[current]['direct']
        arr.append(direct)
        current = direct
    return arr


def moveCount(arr1, arr2):
    set1 = set(arr1)
    set2 = set(arr2)

    result = set1 ^ set2
    return len(result)


def parseInputFile(path):
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
