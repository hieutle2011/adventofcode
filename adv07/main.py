
import sys
import os
sys.path.append('../')

from adv05.main import processIntcode


def main():

    filename = '/amplifier.txt'
    path = os.getcwd() + filename
    # print(path)
    instructions = [0, 1]
    outputs = processIntcode(path, instructions)
    print(len(outputs))
    print(outputs[-1])



if __name__ == "__main__":
    main()
