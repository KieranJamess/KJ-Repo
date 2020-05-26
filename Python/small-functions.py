# Function that outs the smallest number if both are even, or if one or more numbers are odd, print out the biggest value.

def lesser_even(a,b):
    if a%2==0 and b%2==0:
        if a < b:
            return a
        else:
            return b
    elif a%2==1 or b%2==1:
        return max(a,b)

# Function that outputs True or False if the first charater of two words are the same.

def first_letter(text):
    wordlist = text.lower().split()

    return wordlist[0][0] == wordlist[1][0]

# Function that returns the first and fourth charater of a string as capitals. 

def caps(name):

    first_letter = name[0]
    inbetween = name[1:3]
    fouth_letter = name[3]
    rest = name[4:]
    
    return first_letter.upper() + inbetween + fouth_letter.upper() + rest

# Function that reverses each word in a sentence.

def reverse(text):
    wordlist = text.split()
    reverse_word_list = wordlist [::-1]
    return reverse_word_list
        
# Function that returns true if a number is within the range 90 - 110 or 190 - 210.

def within10(n):
    if n in range(90,110):
        return True
    elif n in range (190,210):
        return True
    else:
        return False

# Function that takes an input of a word, and multiples each charater in the word by 3.

def triple(text):
    result = ''
    for char in text:
        result += char*3
    return result

# Function that operates as a blackjack mini-game. User inputs 3 integers. If one of the integers are a 11, it will -10 from the sum if the sum was over 21. 

def blackjack (n1,n2,n3):
    if sum((n1,n2,n3)) <= 21:
        return sum((n1,n2,n3))
    elif n1 == 11 and sum((n1,n2,n3)) > 21:
            return sum((n1,n2,n3)) - 10
    elif n2 == 11 and sum((n1,n2,n3)) > 21:
            return sum((n1,n2,n3)) - 10
    elif n3 == 11 and sum((n1,n2,n3)) > 21:
            return sum((n1,n2,n3)) - 10
    else:
        print('bust')
    
