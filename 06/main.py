import os


def parseInputFile(path):
    arr = []
    file = open(path)
    for line in file:
        item = line.split('\n')[0]
        arr.append(item)
    file.close()
    return arr


def main():
    path = os.getcwd() + '/06/input0.txt'
    arr = parseInputFile(path)

    orbitMap = {
        'COM': {
            'direct': None,
            'indirect': -1,
            'total': None
        }
    }

    restart = True

    initial = 'COM'
    while restart:
        for i in range(len(arr)):

            if arr[i].startswith(initial):
                items = arr[i].split(')')
                central = items[0]
                orbitObj = items[1]
                indirect = orbitMap[central]['indirect'] + 1
                data = {
                    'direct': central,
                    'indirect': indirect,
                    'total': indirect + 1
                }
                orbitMap[orbitObj] = data
                del arr[i]
                initial = orbitObj
                if len(arr[i]) == 0:
                    restart == False
                break
            else:
                print('else')
                pass
    print(len(orbitMap))


if __name__ == "__main__":
    main()
