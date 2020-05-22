# This was a little math game I made playing around with a random number generator.

from random import randint
import random
number1 = randint(1,12)
number2 = randint(1,12)
optionList = ['*','+','/','-']
option = random.choice(optionList)


print (f'What is {number1} {option} {number2}?\nPlease answer to the nearest whole number. ')

result = input('Answer = ')

if option == '+':
    answer = number1 + number2
    if answer == int(result):
        print (f'Well Done, the answer was {answer}')
    
    else:
        print (f'You suck, the answer was {answer}')

if option == '/':
    answer = number1 / number2
    answer = int(round(answer))
    if answer == int(result):
        print (f'Well Done, the answer was {answer}')
    
    else:
        print (f'You suck, the answer was {answer}')
        
if option == '*':
    answer = number1 * number2
    if answer == int(result):
        print (f'Well Done, the answer was {answer}')
    
    else:
        print (f'You suck, the answer was {answer}')
        
if option == '-':
    answer = number1 - number2
    if answer == int(result):
        print (f'Well Done, the answer was {answer}')
    
    else:
        print (f'You suck, the answer was {answer}')

