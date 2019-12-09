def parseInputFile(path):
    file = open(path)
    for line in file:
        return line.split(',')


def getOpCodeIndex(array_length):
    return [int(i) for i in range(0, array_length, 4)]


def main():
    PLUS_CODE = 1
    MULTIPLY_CODE = 2
    HALT_CODE = 99
    program_codes = parseInputFile('./input.txt')
    opCodeIndexes = getOpCodeIndex(len(program_codes))
    # print(opCodeIndexes)
    for index in opCodeIndexes:
        opCode = int(program_codes[index])

        if opCode == HALT_CODE:
            print('HALT_CODE')
            break
        elif opCode == PLUS_CODE:
            print('PLUS_CODE')
            # TODO handle plus
            pass
        elif opCode == MULTIPLY_CODE:
            print('MULTIPLY_CODE')
            # TODO handle multiply
            pass
        else:
            print('Something went wrong!')
            pass

    print(program_codes[0])

if __name__ == "__main__":
    main()
