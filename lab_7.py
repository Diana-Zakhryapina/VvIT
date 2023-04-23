import telebot
from telebot import types
import psycopg2
import datetime

token = "6174273223:AAEET0K3RS53cUPRTGTXsFogs5ecog_VO68"

bot = telebot.TeleBot(token)


conn = psycopg2.connect(dbname='simple_bot', user='postgres', password='', host='localhost')
cursor = conn.cursor()
# определяем номер недели в году для текущей даты


# проверяем, является ли номер недели четным числом
if datetime.date.today().isocalendar()[1] % 2 == 0:
    week = 'чётная'
    next_week = 'нечётная'
else:
    week = 'нечётная'
    next_week = 'чётная'


# получаем номер нужного нам дня

def get_date_by_weekday(weekday, next):
    weekdays = {'ПОНЕДЕЛЬНИК': 0, 'ВТОРНИК': 1, 'СРЕДА': 2,
                'ЧЕТВЕРГ': 3, 'ПЯТНИЦА': 4, 'СУББОТА': 5}
    today = datetime.date.today()
    current_weekday = today.weekday()
    days_diff = weekdays[weekday] - current_weekday
    target_date = today + datetime.timedelta(days=days_diff + next)
    return target_date.strftime('%d.%m')


# если запрашивается конкретный день

def get_day(day, week):
    cursor.execute(
        "SELECT * FROM timetable JOIN subject on timetable.subject = subject.id_subject"
        " JOIN teacher on teacher.subject = subject.id_subject "
        " WHERE timetable.day=%s and timetable.week=%s ORDER BY timetable.id_timetable",
        (day, week))
    answer = f'{day}  {get_date_by_weekday(day, 0)}\n'
    for row in cursor.fetchall():
        if row[2] == 10:
            answer += f'{row[4]}\n{row[7]}\n\n'
        else:
            answer += f'{row[4]}\n{row[7]}\n{row[9]}\n{row[3]}\n\n'
    return answer


# если запрашивается неделя

def get_week(week, nxt):
    cursor.execute(
        "SELECT * FROM timetable JOIN subject on timetable.subject = subject.id_subject"
        " JOIN teacher on teacher.subject = subject.id_subject "
        " WHERE timetable.week=%s ORDER BY timetable.id_timetable",
        (week,))
    answer = f'ПОНЕДЕЛЬНИК {get_date_by_weekday("ПОНЕДЕЛЬНИК", nxt)}\n'
    current_day = 'ПОНЕДЕЛЬНИК'
    for row in cursor.fetchall():
        if current_day != row[1]:
            answer += f'\n{row[1]}  {get_date_by_weekday(row[1], nxt)}\n'
            current_day = row[1]
        if row[2] == 10:
            answer += f'{row[4]}\n{row[7]}\n\n'
        else:
            answer += f'{row[4]}\n{row[7]}\n{row[9]}\n{row[3]}\n\n'
    return answer

# print(get_week(week, 0))

@bot.message_handler(commands=['start'])
def start(message):
    keyboard = types.ReplyKeyboardMarkup()
    keyboard.row("Хочу", "/help", "Расписание")
    bot.send_message(message.chat.id, 'Здравствуйте! Хотите узнать свежую информацию о МТУСИ?', reply_markup=keyboard)

@bot.message_handler(commands=['timetable'])
def get_timetable(message):
    print(1)
    keyboard = types.ReplyKeyboardMarkup()
    keyboard.row("Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота")
    keyboard.row('На эту неделю', 'На следующую неделю')
    bot.send_message(message.chat.id, 'Выберите команду', reply_markup=keyboard)

@bot.message_handler(commands=['week'])
def get_week_command(message):
    bot.send_message(message.chat.id, get_week(week, 0))

@bot.message_handler(commands=['next_week'])
def get_next_week_command(message):
    bot.send_message(message.chat.id, get_week(next_week, 7))

@bot.message_handler(commands=['help'])
def start_message(message):
    bot.send_message(message.chat.id, 'Я умею:\n /week - Вывести расписание на текущую неделю\n'
                                      '/next_week - Вывести расписание на следующую неделю\n'
                                      '/timetable - Выбрать день недели')

@bot.message_handler(content_types=['text'])
def answer(message):
    if message.text.lower() == "хочу":
        bot.send_message(message.chat.id, 'Тогда тебе сюда - https://mtuci.ru/')
    elif message.text.lower() == "расписание":
        keyboard = types.ReplyKeyboardMarkup()
        keyboard.row("Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота")
        keyboard.row('На эту неделю', 'На следующую неделю')
        bot.send_message(message.chat.id, 'Выбери команду', reply_markup=keyboard)
    elif message.text.upper() in ['ПОНЕДЕЛЬНИК', 'ВТОРНИК', 'СРЕДА', 'ЧЕТВЕРГ', 'ПЯТНИЦА', 'СУББОТА']:
        bot.send_message(message.chat.id, get_day(message.text.upper(), week))
    elif message.text.lower() == 'на эту неделю':
        bot.send_message(message.chat.id, get_week(week, 0))
    elif message.text.lower() == 'на следующую неделю':
        bot.send_message(message.chat.id, get_week(next_week, 7))


bot.polling()