import os


def parseInputFile(path):
    file = open(path)
    for line in file:
        return line.split(',')


def makeOpCode(strCode, length=4):
    lenCode = len(strCode)
    if lenCode < length:
        return '0' * (length-lenCode) + strCode
    else:
        return strCode


def handleInput(input, opCodeIndex, progCodes):
    indexParam = opCodeIndex+1
    ptrParam = int(progCodes[indexParam])
    progCodes[ptrParam] = input


def handleOutput(opCodeIndex, progCodes):
    indexParam = opCodeIndex+1
    ptrParam = int(progCodes[indexParam])
    output = progCodes[ptrParam]
    return output


def handleParamOperation(fullCode, opCodeIndex, progCodes):

    indexA = opCodeIndex+1
    indexB = opCodeIndex+2
    indexResult = opCodeIndex+3
    ptrA = int(progCodes[indexA])
    ptrB = int(progCodes[indexB])
    ptrResult = int(progCodes[indexResult])

    opCode = fullCode[-2:]  # opcode: 1 or 2
    a_mode = int(fullCode[-3])
    b_mode = int(fullCode[-4])
    c_mode = CONST['mode']['position']

    # value of first argument
    if a_mode == CONST['mode']['position']:
        a_val = int(progCodes[ptrA])
    elif a_mode == CONST['mode']['immediate']:
        a_val = ptrA

    # value of second argument
    if b_mode == CONST['mode']['position']:
        b_val = int(progCodes[ptrB])
    elif b_mode == CONST['mode']['immediate']:
        b_val = ptrB

    # where to write result to
    if c_mode == CONST['mode']['position']:  # always true
        if opCode == CONST['plus']['code']:
            progCodes[ptrResult] = a_val + b_val
        elif opCode == CONST['mult']['code']:
            progCodes[ptrResult] = a_val * b_val
        return progCodes


# def process(input, index, progCodes):


CONST = {
    'plus': {
        'code': '01',
        'len': 4,
    },
    'mult': {
        'code': '02',
        'len': 4,
    },
    'input': {
        'code': '03',
        'len': 2,
    },
    'output': {
        'code': '04',
        'len': 2,
    },
    'halt': {
        'code': '99',
    },
    'mode': {
        'position': 0,
        'immediate': 1,
    }
}


def main():
    path = os.getcwd() + '/input.txt'
    progCodes = parseInputFile(path)
    length = len(progCodes)
    input = 1
    outputs = []

    index = 0
    while index < length:
        data = str(progCodes[index])
        fullcode = makeOpCode(data)
        opCode = fullcode[-2:]

        if opCode == CONST['halt']['code']:
            break

        elif opCode == CONST['input']['code']:
            handleInput(input, index, progCodes)
            index += CONST['input']['len']

        elif opCode == CONST['output']['code']:
            output = handleOutput(index, progCodes)
            outputs.append(output)
            index += CONST['output']['len']

        elif opCode == CONST['plus']['code']:
            progCodes = handleParamOperation(
                fullcode, index, progCodes)
            index += CONST['plus']['len']

        elif opCode == CONST['mult']['code']:
            progCodes = handleParamOperation(
                fullcode, index, progCodes)
            index += CONST['mult']['len']

    print(len(outputs))
    print(outputs[-1])  # 11933517


if __name__ == "__main__":
    main()
