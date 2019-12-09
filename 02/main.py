def parseInputFile(path):
    file = open(path)
    for line in file:
        return [int(i) for i in line.split(',')]


def getOpCodeIndex(array_length):
    return [int(i) for i in range(0, array_length, 4)]


def handleOperation(opCode, opCodeIndex, progCodes):
    indexA = opCodeIndex+1
    indexB = opCodeIndex+2
    indexResult = opCodeIndex+3
    ptrA = progCodes[indexA]
    ptrB = progCodes[indexB]
    ptrResult = progCodes[indexResult]
    a = progCodes[ptrA]
    b = progCodes[ptrB]
    if opCode == PLUS_CODE:
        progCodes[ptrResult] = a + b
    elif opCode == MULTIPLY_CODE:
        progCodes[ptrResult] = a * b
    return progCodes
     

PLUS_CODE = 1
MULTIPLY_CODE = 2
HALT_CODE = 99


def main():
    program_codes = parseInputFile('./input.txt')
    # restore the gravity assist program
    program_codes[1] = 12
    program_codes[2] = 2

    opCodeIndexes = getOpCodeIndex(len(program_codes))
    for index in opCodeIndexes:
        opCode = program_codes[index]
        if opCode == HALT_CODE:
            break
        elif opCode == PLUS_CODE or opCode == MULTIPLY_CODE:
            program_codes = handleOperation(opCode, index, program_codes)
        else:
            pass

    print(program_codes[0])

if __name__ == "__main__":
    main()
