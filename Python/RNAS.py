from random import randint
import smtplib, ssl
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

class my_dictionary(dict):

    def __init__(self):
        self = dict()

    def add(self, key, value):
        self[key] = value

dict_obj = my_dictionary()
def newdict():

    global totaltickets
    global new_raffle

    totalticketsstring = input("How many tickets does this raffle have? ")
    totaltickets = int(totalticketsstring)

    n = 0
    while n < int(totaltickets):
        n = n + 1
        dict_obj.add(n, 'NULL')

    new_raffle = 'no'


def purchase():

    global name
    global random
    global email

    name = input(str("What is the name of the user? "))
    email = input(str("What is the email of the user? "))
    tickets = input("How many tickets have they ordered? ")

    name = name.capitalize()

    i = 0
    while i < int(tickets):
        random = randint(1, totaltickets)
        if dict_obj[random] == 'NULL':
            dict_obj[random] = name
            i = i + 1
        elif dict_obj[random] != 'NULL':
            search(dict_obj, 'NULL')
            if search.a == []:
                print('All entries have been taken')
                print(dict_obj.items())
                break
        elif listleft > tickets:
            print('Youve oversold the tickets')
        else:
            pass

def search(myDict, search1):
    search.a=[]
    for key, value in myDict.items():
        if search1 in value:
            search.a.append(key)

def soldout():

    global needdict

    if listleft == 0:
        print('All entries have been taken')
        print(dict_obj.items())
        needdict = False
        try:
            with open('data.csv', 'w') as f:
                for key in dict_obj.keys():
                    f.write("%s, %s\n" % (key, dict_obj[key]))
        except IOError:
            print("I/O error")
        quit()

def sendemail():
    search(dict_obj, f'{name}')
    if search.a == []:
        print('fail')
    else:
        yourlist = search.a
###
    sender_email = "email"
    receiver_email = f"{email}"
    message = MIMEMultipart("alternative")
    message["Subject"] = f"Your Numbers for PRODUCT!"
    message["From"] = sender_email
    message["To"] = receiver_email
    text = """\
    """
    html = """
EMAILTEMPLATE
    """.format(name=name,numbernew=yourlist)

    part1 = MIMEText(text, "plain")
    part2 = MIMEText(html, "html")
    message.attach(part1)
    message.attach(part2)
    # send your email

    try:
        server = smtplib.SMTP_SSL("smtp.ADDRESS.co.uk", 143)
        server.login("EMAIL", "PASSWORD")
        server.sendmail(
            sender_email, receiver_email, message.as_string()
        )
        server.quit()
    except Exception as e:
        print("Failed to send email notification: %s" %e)

new_raffle = input("Do you need to create a new raffle? ")
new_raffle = new_raffle.lower()

global numbernew

needdict = True
while needdict == True:

    if new_raffle == 'yes':
        newdict()
        search(dict_obj, 'NULL')
        listleft = (len(search.a))
        print(f'Remaining Tickets: {listleft}')
        soldout()
        purchase()
        #sendemail()
    elif new_raffle == 'no':
        while listleft > 0:
            search(dict_obj, 'NULL')
            listleft = (len(search.a))
            print(f'Remaining Tickets: {listleft}')
            soldout()
            purchase()
            #sendemail()
    for key, value in dict_obj.items():
        if value == name:
            numbernew = key
            print(numbernew)


