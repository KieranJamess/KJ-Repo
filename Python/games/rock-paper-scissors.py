import random

score = 0

should_restart = True
while should_restart == True:

    rps = ['Rock', 'Paper', 'Scissors']
    rps_cpu = random.choice(rps)

    correct_input = True
    while correct_input == True:

        rps_user = input(str('Rock, Paper or Scissors? '))
        rps_user = rps_user.capitalize()

        if rps_user == 'Rock':
            correct_input = False
        elif rps_user == 'Paper':
            correct_input = False
        elif rps_user == 'Scissors':
            correct_input = False
        else:
            print('Please enter, Rock, Paper or Scissors')
            correct_input = True

    if rps_user == rps_cpu:
        print(f'Draw, you both got {rps_user}')
    elif rps_user == 'Scissors' and rps_cpu == 'Rock':
        print('CPU got Rock, you win!')
        score = score + 1
        print(f'Your current score is {score}')
    elif rps_user == 'Rock' and rps_cpu == 'Paper':
        print('CPU got Paper, you win!')
        score = score + 1
        print(f'Your current score is {score}')
    elif rps_user == 'Paper' and rps_cpu == 'Scissors':
        print('CPU got Scissors, you win!')
        score = score + 1
        print(f'Your current score is {score}')
    else:
        print(f'CPU got {rps_cpu}. You lose')
        score = score - 1
        print(f'Your current score is {score}')

    play_again = input('Would you like to play again? Y/N ')
    play_again = play_again.upper()
    if play_again == 'Y':
        should_restart = True
    elif play_again == 'N':
        print(f'Your score was {score}')
        should_restart = False
    else:
        should_restart = False
