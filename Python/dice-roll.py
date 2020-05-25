# This is a standard dice roller for those monopoly players.
def dice():
    import random
    numberList = [1,2,3,4,5,6]
    numberChoice= random.choice(numberList)

    print (f'The dice rolled a {numberChoice}!')
    
# This is a dice roller for the game, DnD. It uses a dictionary to store the values of each dice. 
def dndDice():
    import random
    dnddice = {
    "D20": [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20],
    "D12": [1,2,3,4,5,6,7,8,9,10,11,12],
    "D10": [1,2,3,4,5,6,7,8,9,10],
    "D8": [1,2,3,4,5,6,7,8],
    "D6": [1,2,3,4,5,6],
    "D4": [1,2,3,4]
    }
    diceChoice = input('Would you like a D20, D12, D10, D8, D6 or the D4? ')
    
    numberList = (dnddice[f'{diceChoice}'])
    numberChoice= random.choice(numberList)


    print (f'The dice rolled a {numberChoice}!')
