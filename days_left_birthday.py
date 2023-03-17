from datetime import datetime
from flask_restful import Api, Resource
from flask import Flask, jsonify, request

app = Flask(__name__)
api = Api(app)

class Hello(Resource):
    def get_birthday():
        
        postedData = request.get_json()
        year = postedData[int(input('enter the year you were born - yy:'))]
        month = postedData[int(input('enter the month you were born - mm: '))]
        day = postedData[int(input('enter the day you were born - dd: '))]

        birthday = datetime(2000+year,month,day)
        return birthday
        retMap = {
            'Date': birthday,
            'Status Code': 200
        }
        return jsonify(retMap)


# def calculate_dates(original_date, now):
#     d1 = datetime(now.year, original_date.month, original_date.day)
#     d2 = datetime(now.year+1, original_date.month, original_date.day)
    
#     return ((d1 if d1 > now else d2) - now).days

# bd = get_birthday()
# now = datetime.now()
# c = calculate_dates(bd, now)

# print(c)


api.add_resource(Hello, '/hello')


@app.route('/')
def hello_world():
    return "Want to know your days to your DOB?"

if __name__=="__main__":
    app.run(host='0.0.0.0')


# from datetime import date

# year = int(input('Year:'))
# month = int(input('Month:'))
# day = int(input('Day:'))

# birthday = date(year, month, day)
# today = date.today()
# next_birthday = birthday.replace(year=today.year)

# if next_birthday < today:
#     # birthday for this year has already passed
#     next_birthday = next_birthday.replace(year=next_birthday.year + 1)

# print('You are', int((today - birthday).days / 365), 'years old')
# print('Your next birthday is in', (next_birthday - today).days, 'days')