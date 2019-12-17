
import sys
import os
sys.path.append('../')

from adv05.main import processIntcode

def main():

    filename = '/amplifier.txt'
    path = os.getcwd() + filename
    # print(path)
    first_instruction = 0
    input_instruction = first_instruction
    outputs = processIntcode(path, input_instruction)
    print(len(outputs))
    print(outputs[-1])

    input_instruction = first_instruction + 1
    outputs = processIntcode(path, input_instruction)
    print(len(outputs))
    print(outputs[-1])


if __name__ == "__main__":
    main()
