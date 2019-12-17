def fuelAmt(mass):
    return int(mass / 3) - 2


def fuelMassAmt(mass):
    fuel = mass
    result = 0

    while fuel > 0:
        fuel = int(fuel / 3) - 2
        if fuel > 0:
            result += fuel
    return result


def main():
    resutl = 0
    file = open('./input.txt', 'r')
    for line in file:
        mass = line.split('\n')[0]
        resutl += fuelMassAmt(int(mass))
    file.close()
    print(resutl)


if __name__ == "__main__":
    main()
