class Adjacent:
    def __init__(self, strnum1, strnum2):
        self.first = strnum1
        self.second = strnum2

    def isValid(self):
        return int(self.first) <= int(self.second)

    def isDouble(self):
        return self.first == self.second


def isValidNumber(number):
    strnum = str(number)
    length = len(strnum)
    if length != 6:
        return False

    isValid = True
    isDouble = False

    for i in range(length-1, 0, -1):
        num1, num2 = strnum[i-1], strnum[i]
        adj = Adjacent(num1, num2)
        isValid = isValid and adj.isValid()
        isDouble = isDouble or adj.isDouble()

        # if isValid and isDouble and i-2>0:
        #     num0 = strnum[i-2]
        #     adj0 = Adjacent(num0, num1)
        #     check = adj0.isDouble()
        #     if not check:
        #         break
        #     else:
        #         isValid = False

    valid = isValid and isDouble

    return valid


def main():
    count = 0
    for i in range(178416, 676461+1):
        if isValidNumber(i):
            count += 1

    print('Different passwords: {}'.format(count))  # 1650


if __name__ == "__main__":
    main()
