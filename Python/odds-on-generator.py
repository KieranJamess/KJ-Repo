Result = input('What number would you like? ')
Start = input("What start number would you like? ")
End = input("What end number would you like? ")

Range = (randint(int(Start),int(End)))

if Range == int(Result):
    print ('Well Done')
    
else:
    print ('Incorrect :(')
    
print(f'The number was {Range}')
