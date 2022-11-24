from datetime import date


def calculateAge(birthDate):
    today = date.today()
    age = today.year - birthDate.year -  ((today.month, today.day) <   (birthDate.month, birthDate.day))
    return age

def calcage():
    calculateAge(date(1986, 2, 3))
# Driver code
print(calculateAge(date(1986, 2, 3)))