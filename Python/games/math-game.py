# This was a little math game I made playing around with a random number generator.

def game():
    from random import randint
    import random
    score = 0
    
    should_restart = True
    while should_restart == True:
    
        number1 = randint(1,12)
        number2 = randint(1,12)
        optionList = ['*','+','/','-']
        option = random.choice(optionList)

        print (f'What is {number1} {option} {number2}?\nPlease answer to the nearest whole number')

        result = input('Answer = ')
        
        if option == '+':
            answer = number1 + number2
            if answer == int(result):
                score = score+1
                print (f'Well Done, the answer was {answer}')
                print (f'Your current score is {score}\n ' )
                    
            else:
                print (f'You suck, the answer was {answer}')
                print (f'\nYour final score was {score}')
                should_restart = False

        if option == '/':
            answer = number1 / number2
            answer = int(round(answer))
            if answer == int(result):
                score = score+1
                print (f'Well Done, the answer was {answer}')
                print (f'Your current score is {score}\n ' )  
    
            else:
                print (f'You suck, the answer was {answer}')
                print (f'\nYour final score was {score}')
                should_restart = False
        
        if option == '*':
            answer = number1 * number2
            if answer == int(result):
                score = score+1
                print (f'Well Done, the answer was {answer}')
                print (f'Your current score is {score}\n ' )  
    
            else:
                print (f'You suck, the answer was {answer}')
                print (f'\nYour final score was {score}')
                should_restart = False
        
        if option == '-':
            answer = number1 - number2
            if answer == int(result):
                score = score+1
                print (f'Well Done, the answer was {answer}')
                print (f'Your current score is {score}\n ' )  
    
            else:
                print (f'You suck, the answer was {answer}')
                print (f'\nYour final score was {score}')
                should_restart = False
