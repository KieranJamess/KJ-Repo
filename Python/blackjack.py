def drawcard():
    from random import randint
    import random
    
    global playerscore
    
    draw_again = True
    while draw_again == True:
        
        draw = input('Would you like to draw a card? Y/N ')
        draw = draw.upper()
        if draw == 'Y':
            card = randint(1,11)
            playerscore = playerscore + card
            print(f'You now have {playerscore}\n')
            if playerscore > 21:
                print('bust')
                break
            
        
        elif draw == 'N':
            dealer_draw = False
            break
            
def dealerbelow16():
    from random import randint
    import random
    
    global dealerscore
    
    dealer_draw = True
    while dealer_draw == True:
        
        if dealerscore <= 16 :
            dealerscore = dealerscore + randint(1,11)
        else:
            dealer_draw = False
            continue

from random import randint
import random
    
should_restart = True
while should_restart == True:
    
    dealer1 = randint(1,11)
    dealer2 = randint(1,11)
    player1 = randint(1,11)
    player2 = randint(1,11)
        
    playerscore = sum((player1,player2))
    dealerscore = sum((dealer1,dealer2))
        
    print(f'You have {playerscore}. The dealer has {dealerscore}\n')

    drawcard()
    dealerbelow16()
    if dealerscore == playerscore:
        print(f'You have {playerscore}. The dealer has {dealerscore}')
        print('Draw\n')
    elif dealerscore > 21 and playerscore <=21:
        print(f'You have {playerscore}. The dealer has {dealerscore}')
        print('The dealer bust, you win\n')
    elif  dealerscore < playerscore <= 21:
        print(f'You have {playerscore}. The dealer has {dealerscore}')
        print('You win\n')
    elif playerscore < dealerscore <= 21:
        print(f'You have {playerscore}. The dealer has {dealerscore}')
        print('The dealer has won\n')
            
    play_again = input('Would you like to play again? Y/N ')
    play_again = play_again.upper()
    if play_again == 'Y':
        should_restart = True
    elif play_again == 'N':
        should_restart = False
    else:
        should_restart = False     
                
        
