import itertools
import sys
import os
sys.path.append('../')
from adv05.main import processIntcode


def amply(filename: str, phases: list) -> int:
    path = os.getcwd() + filename
    # print(path)
    # phases = [4, 3, 2, 1, 0]
    # phases = [0,1,2,3,4]
    # phases = [1,0,4,3,2]

    # amp_A
    insA = [phases[0], 0]
    outputs_A = processIntcode(path, insA)

    # amp_B
    insB = [phases[1]]
    insB.append(outputs_A[-1])
    outputs_B = processIntcode(path, insB)
    # amp_C
    insC = [phases[2]]
    insC.append(outputs_B[-1])
    outputs_C = processIntcode(path, insC)
    # amp_D
    insD = [phases[3]]
    insD.append(outputs_C[-1])
    outputs_D = processIntcode(path, insD)
    # amp_E
    insE = [phases[4]]
    insE.append(outputs_D[-1])
    outputs_E = processIntcode(path, insE)

    return outputs_E[-1]


def phase_generator(start, end: int) -> list:
    arr = []
    for i in range(start, end+1):
        arr.append(i)
    # arr = [start, ... , end]
    return list(itertools.permutations(arr))


def main():
    phases = phase_generator(0, 4)
    max = 0
    for phase in phases:
        result = amply('/amplifier.txt', phase)
        if result >= max:
            max = result
    print(max)  # 21860



if __name__ == "__main__":
    main()
