from datetime import datetime
from flask_restful import Api, Resource
from flask import Flask, jsonify, request

app = Flask(__name__)
api = Api(app)

def get_user_birthday():
    year = int(input('Please enter the year of your birth [YY] '))
    month = int(input('Please enter the month of your birth [MM] '))
    day = int(input('Please enter the day of your birth [DD] '))

    birthday = datetime(2000+year,month,day)
    return birthday

def calculate_dates(original_date, now):
    x = datetime(now.year, original_date.month, original_date.day)
    y = datetime(now.year+1, original_date.month, original_date.day)
    
    return ((x if x > now else y) - now).days

birthday = get_user_birthday()
present = datetime.now()
days_to_birthday = calculate_dates(birthday, present)
print(f" ${days_to_birthday} days let to your birthday")

@app.route('/')
def hello_world():
    return "Want to know your days to your dob?"

if __name__=="__main__":
    app.run(host='0.0.0.0')