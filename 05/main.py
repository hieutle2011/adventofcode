import os
import copy


def parseInputFile(path):
    file = open(path)
    for line in file:
        return [int(i) for i in line.split(',')]


def handleIO():
    pass


def handleOperation(opCode, opCodeIndex, progCodes):
    # param opCode: string '1002'
    # param opCodeIndex: int
    # param progCodes: list
    
    # CBADE
    #  1002,4,3,4
    indexA = opCodeIndex+1
    indexB = opCodeIndex+2
    indexResult = opCodeIndex+3
    ptrA = progCodes[indexA]
    ptrB = progCodes[indexB]
    ptrResult = progCodes[indexResult]

    de = int(opCode[-2:]) # opcode: 1 or 2
    a_mode, b_mode, c_mode = int(opCode[-3]), int(opCode[-4]), POSITION_MODE
    # a, b, c = progCodes[indexA], progCodes[indexB], progCodes[indexResult]
    
    # value of first argument
    if a_mode == POSITION_MODE:
        a_val = progCodes[ptrA]
    elif a_mode == IMMEDIATE_MODE:
        a_val = ptrA

    # value of second argument
    if b_mode == POSITION_MODE:
        b_val = progCodes[ptrB]
    elif b_mode == IMMEDIATE_MODE:
        b_val = ptrB

    # where to write result to
    if c_mode == POSITION_MODE: # always true
        if de == PLUS_CODE:
            progCodes[ptrResult] = a_val + b_val
        elif de == MULTIPLY_CODE:
            progCodes[ptrResult] = a_val * b_val
        return progCodes


PLUS_CODE = 1
MULTIPLY_CODE = 2
HALT_CODE = 99

POSITION_MODE = 0
IMMEDIATE_MODE = 1


def main():
    path = os.getcwd() + '/input.txt'
    program_codes = parseInputFile(path)
    EXPECT = 19690720

    # for noun in range(0, 100):
    #     for verb in range(0, 100):
    #         # reload program codes into memory
    #         memory = copy.deepcopy(program_codes)

    #         # restore the gravity assist program
    #         memory[1] = noun
    #         memory[2] = verb

    #         opCodeIndexes = getOpCodeIndex(len(memory))
    #         for index in opCodeIndexes:
    #             opCode = memory[index]
    #             if opCode == HALT_CODE:
    #                 break
    #             elif opCode == PLUS_CODE or opCode == MULTIPLY_CODE:
    #                 memory = handleOperation(opCode, index, memory)
    #             else:
    #                 pass

    #         if memory[0] == EXPECT:
    #             print(noun, verb)
    #             print(memory[0])
    #             exit() # stop program immedietly


if __name__ == "__main__":
    main()
