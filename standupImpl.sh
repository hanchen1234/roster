#!/bin/bash

WEBHOOK_URL="https://chat.googleapis.com/v1/spaces/AAQAUy5McwQ/messages?key=AIzaSyDdI0hCZtE6vySjMm-WEfRq3CPzqKqqsHI&token=FWnoX2-vLAPH9772Pkz5oZYuOGot14MkUTPjr5GyhIs"

people=("刘佳颖" "陈晗" "付莹" "刘文宾" "韩家怡" "王钰")

start_date="2025-04-14"
today=$(date +%Y-%m-%d)

start_ts=$(date -d "$start_date" +%s)
today_ts=$(date -d "$today" +%s)

if [ "$start_ts" -gt "$today_ts" ]; then
  echo "${people[0]}"
  exit 0
fi

work_days=0

current_date="$start_date"
while [ "$(date -d "$current_date" +%s)" -le "$today_ts" ]; do
  day_of_week=$(date -d "$current_date" +%u)
  if [ "$day_of_week" -lt 6 ]; then
    work_days=$((work_days + 1))
  fi
  current_date=$(date -d "$current_date +1 day" +%Y-%m-%d)
done

index=$((work_days % ${#people[@]}))
person=${people[$index]}
MESSAGE="{\"msgtype\": \"text\", \"text\": {\"content\": \"Congrats! standup host is：$person\"}}"

if [ "$(date +%w)" -eq 6 ] || [ "$(date +%w)" -eq 0 ]; then 
  exit 0
else
  curl -X POST -H "Content-Type: application/json" -d "$MESSAGE" "$WEBHOOK_URL"
fi
