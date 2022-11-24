# CheckCode.py
from datetime import date

def calculate(salary, age, taxpaid, Gender):
    #Gender = "M"
    if Gender := "M":
        return (salary-taxpaid)*calculate_income_tax(age)+500
    elif Gender := "F":
        return (salary-taxpaid)*calculate_income_tax(age)+0


def calculate_income_tax(age:
float) -> float:
    if age <= 18:
        return 1
    elif age <= 35:
        return 0.8
    elif age <= 50:
        return 0.5
    elif age <= 75:
        return 0.367
    elif age <= 76:
        return 0.05


def calculateAge(birthDate):
    today = date.today()
    age = today.year - birthDate.year -  ((today.month, today.day) <   (birthDate.month, birthDate.day))
    return age

def getAge(Year, month, day):
    return calculateAge(date(Year, month, day))


if __name__ == '__main__':
    age = float(input("What's your \
                    age?\n>>> "))
    tax = calculate(1000, age, 10, "M")
    print(f"Total tax applicable at \
                    ₹{age} is ₹{tax}")