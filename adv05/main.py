import os


def parseInputFile(path):
    file = open(path, 'r')
    for line in file:
        file.close()
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


def handleOutput(fullCode, opCodeIndex, progCodes):
    indexParam = opCodeIndex+1
    a_mode = int(fullCode[-3])
    ptrParam = int(progCodes[indexParam])

    if a_mode == CONST['mode']['position']:
        output = progCodes[ptrParam]
    elif a_mode == CONST['mode']['immediate']:
        output = ptrParam
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

    inst_pointer = 0
    # where to write result to
    if c_mode == CONST['mode']['position']:  # always true
        if opCode == CONST['plus']['code']:
            progCodes[ptrResult] = a_val + b_val
        elif opCode == CONST['mult']['code']:
            progCodes[ptrResult] = a_val * b_val
        elif opCode == CONST['jit']['code']:
            if a_val != 0:
                inst_pointer = b_val
            pass
        elif opCode == CONST['jif']['code']:
            if a_val == 0:
                inst_pointer = b_val
            pass
        elif opCode == CONST['lt']['code']:
            if a_val < b_val:
                progCodes[ptrResult] = 1
            else:
                progCodes[ptrResult] = 0
        elif opCode == CONST['eq']['code']:
            if a_val == b_val:
                progCodes[ptrResult] = 1
            else:
                progCodes[ptrResult] = 0

    return progCodes, inst_pointer


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
    'jit': {
        'code': '05',
        'len': 3,
    },
    'jif': {
        'code': '06',
        'len': 3,
    },
    'lt': {
        'code': '07',
        'len': 4,
    },
    'eq': {
        'code': '08',
        'len': 4,
    },
    'halt': {
        'code': '99',
    },
    'mode': {
        'position': 0,
        'immediate': 1,
    }
}


def processIntcode(path: str, inputs: list) -> list:
    """Take the path of the software program, and the array input values.
    Return the list of outputs generated from the Intcode computer
    """
    progCodes = parseInputFile(path)
    length = len(progCodes)
    outputs = []
    in_index = 0
    ins_pointer = 0

    while ins_pointer < length:
        instruction = str(progCodes[ins_pointer])
        fullcode = makeOpCode(instruction)
        opCode = fullcode[-2:]

        if opCode == CONST['halt']['code']:
            break

        # IO operation
        elif opCode == CONST['input']['code']:

            this_input = inputs[in_index]
            handleInput(this_input, ins_pointer, progCodes)
            ins_pointer += CONST['input']['len']
            in_index += 1

        elif opCode == CONST['output']['code']:
            output = handleOutput(
                fullcode, ins_pointer, progCodes)
            ins_pointer += CONST['output']['len']

            # Store output
            outputs.append(output)

        # Calculation operation
        elif opCode == CONST['plus']['code']:
            progCodes, _ = handleParamOperation(
                fullcode, ins_pointer, progCodes)
            ins_pointer += CONST['plus']['len']

        elif opCode == CONST['mult']['code']:
            progCodes, _ = handleParamOperation(
                fullcode, ins_pointer, progCodes)
            ins_pointer += CONST['mult']['len']

        # Modify ins pointer operation
        elif opCode == CONST['jit']['code']:
            progCodes, new_pointer = handleParamOperation(
                fullcode, ins_pointer, progCodes)
            if new_pointer != 0:
                ins_pointer = new_pointer
            else:
                ins_pointer += CONST['jit']['len']

        elif opCode == CONST['jif']['code']:
            progCodes, new_pointer = handleParamOperation(
                fullcode, ins_pointer, progCodes)
            if new_pointer != 0:
                ins_pointer = new_pointer
            else:
                ins_pointer += CONST['jif']['len']

        # Comparision operation
        elif opCode == CONST['lt']['code']:
            progCodes, _ = handleParamOperation(
                fullcode, ins_pointer, progCodes)
            ins_pointer += CONST['lt']['len']

        elif opCode == CONST['eq']['code']:
            progCodes, _ = handleParamOperation(
                fullcode, ins_pointer, progCodes)
            ins_pointer += CONST['eq']['len']

        else:
            print('no such opcode')
            exit()

    return outputs


def main():
    software = '/diagnostic-program.txt'
    software_path = os.getcwd() + software
    # software_path = '/home/hieu/dev/adventofcode/adv07/example_1.txt'
    input_instruction = [5]
    outputs = processIntcode(software_path, input_instruction)
    print(len(outputs))
    print(outputs[-1])  # diagnostic-program => 10428568


if __name__ == "__main__":
    main()
