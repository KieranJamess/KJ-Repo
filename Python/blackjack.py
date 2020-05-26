# Drawcard function - If the play confirms they want to draw a card with 'y', it adds a random interger from 1 to 11 to their current sum. 
# If it goes over 21 they bust. They can continue to draw till bust or they choose not to draw.
def drawcard():
    from random import randint
    import random
    import time
    
    global playerscore
    
    draw_again = True
    while draw_again == True:
        
        draw = input('Would you like to draw a card? Y/N ')
        draw = draw.upper()
        if draw == 'Y':
            card = randint(1,11)
            playerscore = playerscore + card
            print(f'You now have {playerscore}\n')
            time.sleep(1.0)
            if playerscore <= 21:
                continue
            if playerscore > 21:
                break
            
        
        elif draw == 'N':
            dealer_draw = False
            break
            
# forces the dealer to draw a random card if the dealer has 16 or lower.            
def dealerbelow16():
    from random import randint
    import random
    import time
    
    global dealerscore
    
    dealer_draw = True
    while dealer_draw == True:
        
        if dealerscore <= 16 :
            dealerscore = dealerscore + randint(1,11)
            print(f'The dealer has {dealerscore}')
            time.sleep(1.0)
        else:
            dealer_draw = False
            continue
def bets():
    
    global bet
    
    bet_true = True
    while bet_true == True:
        
        bet = input(f'How much would you like to bet? You currently have {currency} ')
        if int(bet) > currency:
            print('Please enter within your budget\n')
        elif int(bet) < 0:
            print('Please enter positive numbers, and within your budget\n')
        else: 
            bet_true = False
            continue


from random import randint
import random

currency = 100

should_restart = True
while should_restart == True:
    
    dealer1 = randint(1,11)
    dealer2 = randint(1,11)
    player1 = randint(1,11)
    player2 = randint(1,11)
        
    playerscore = sum((player1,player2))
    dealerscore = sum((dealer1,dealer2))
    
    bets()
        
    print(f'You have {playerscore}. The dealer has {dealerscore}\n')

    drawcard()
    dealerbelow16()
    if dealerscore == playerscore:
        print(f'You have {playerscore}. The dealer has {dealerscore}')
        print('Draw\n')
    elif dealerscore > 21 and playerscore <=21:
        print(f'You have {playerscore}. The dealer has {dealerscore}')
        print('The dealer bust, you win\n')
        currency = int(bet) + currency
    elif  dealerscore < playerscore <= 21:
        print(f'You have {playerscore}. The dealer has {dealerscore}')
        print('You win\n')
        currency = int(bet) + currency
    elif playerscore < dealerscore <= 21:
        print(f'You have {playerscore}. The dealer has {dealerscore}')
        print('The dealer has won\n')
        currency = currency - int(bet)
    elif playerscore > 21 and dealerscore > 21:
        print(f'You have {playerscore}. The dealer has {dealerscore}')
        print(f'The dealer and you have both gone over 21!')
        currency = currency - int(bet)
    elif playerscore > 21 >= dealerscore:
        print(f'You have {playerscore}. The dealer has {dealerscore}')
        print(f'Dealer wins')
        currency = currency - int(bet)
    else:
        print('I am unsure of this function')
            
    play_again = input('Would you like to play again? Y/N ')
    play_again = play_again.upper()
    if play_again == 'Y':
        should_restart = True
    elif play_again == 'N':
        print(f'You ended on {currency}')
        should_restart = False
    else:
        should_restart = False     
                
        
