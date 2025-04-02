import requests
import datetime

WEBHOOK_URL = "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=994141b6-afe2-4009-bb63-8bfd0ba1b99f"

roster = ["张三", "李四", "王二麻"]

def get_today_person():
    today = datetime.date.today()
    year, week, weekday = today.isocalendar()
    index = ((week * 5 + (weekday - 1)) // 5) % len(roster)
    return roster[index]

def send_wechat_message(person):
    message = {
        "msgtype": "text",
        "text": {
            "content": f"今日值日生：{person}"
        }
    }
    response = requests.post(WEBHOOK_URL, json=message)
    print(response.json())

if __name__ == "__main__":
    today = datetime.date.today()
    if today.weekday() < 5:
        person = get_today_person()
        send_wechat_message(person)
