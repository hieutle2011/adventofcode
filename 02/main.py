import os
import copy


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
    path = os.getcwd() + '/input.txt'
    program_codes = parseInputFile(path)
    EXPECT = 19690720

    for noun in range(0, 100):
        for verb in range(0, 100):
            # reload program codes into memory
            memory = copy.deepcopy(program_codes)

            # restore the gravity assist program
            memory[1] = noun
            memory[2] = verb

            opCodeIndexes = getOpCodeIndex(len(memory))
            for index in opCodeIndexes:
                opCode = memory[index]
                if opCode == HALT_CODE:
                    break
                elif opCode == PLUS_CODE or opCode == MULTIPLY_CODE:
                    memory = handleOperation(opCode, index, memory)
                else:
                    pass

            if memory[0] == EXPECT:
                print(noun, verb)
                print(memory[0])
                break


if __name__ == "__main__":
    main()
