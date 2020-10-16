import datetime

import textToSpeech

def check(year,month,day):
    expiryDate = datetime.datetime(year, month, day)
    today = datetime.date.today()
    dateFormat = str(today).split("-")
    currentDate = datetime.datetime(int(dateFormat[0]), int(dateFormat[1]), int(dateFormat[2]))
    print(dateFormat)
    print(today)
    if(currentDate > expiryDate):
        textToSpeech.botSpeaks('Sorry to disappoint,   the product is expired. Please change it')
        return True
    else:
        return False
