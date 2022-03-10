"""
This is a dumb calculator that can add and subtract whole numbers from zero to five.
When you run the code, you are prompted to enter two numbers (in the form of English
word instead of number) and the operator sign (also in the form of English word).
The code will perform the calculation and give the result if your input is what it
expects.

The code is very long and messy. Refactor it according to what you have learned about
code simplicity and efficiency.
"""

print('Welcome to this calculator!')
print('It can add and subtract whole numbers from zero to five')
a = input('Please choose your first number (zero to five): ')
b = input('What do you want to do? plus or minus: ')
c = input('Please choose your second number (zero to five): ')


dict_1 = {'zero':0,'one':1,'two':2,'three':3,'four':4, 'five':5}
def calculator (a,b,c):

    if b == 'plus':
        print(f'{a} {b} {c} equals {dict_1[a] + dict_1[c]}')
    elif b == 'minus':
        print(f'{a} {b} {c} equals {dict_1[a] - dict_1[c]}')
    else:
        print('Incorrect input')

if a not in dict_1.keys() or c not in dict_1.keys():
    print('Sorry I cannot compute this input. Check again')
else:
    calculator(a,b,c)


print("Thanks for using this calculator, goodbye :)")
