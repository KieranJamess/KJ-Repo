# This was my first little test gimmick after learning a little about Python to test my own knowledge. 

# Imports randint for random number generation.
from random import randint

Result = input('What number would you like? ')
Start = input("What start number would you like? ")
End = input("What end number would you like? ")
Range = (randint(int(Start),int(End)))

if Range == int(Result):
    print ('Well Done')
    
else:
    print ('Incorrect :(')
    
print(f'The number was {Range}')
