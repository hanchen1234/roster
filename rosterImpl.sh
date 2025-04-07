#!/bin/bash

WEBHOOK_URL="https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=90977e98-2843-4836-b669-f28d6f2b72c6"

ROSTER=("付莹" "付昱" "刘文宾" "俞潇" "陈晗")

TODAY=$(date +%Y-%m-%d)
WEEKDAY=$(date +%u)

YEAR=$(date +%Y)
START_DATE=$(date -v1d -v"${YEAR}y" +%Y-%m-%d)
START_WEEKDAY=$(date -j -f "%Y-%m-%d" "$START_DATE" +%u)
DAYS_TO_FIRST_MONDAY=$(( (8 - START_WEEKDAY) % 7 ))
START_DATE=$(date -j -v+"${DAYS_TO_FIRST_MONDAY}d" -f "%Y-%m-%d" "$START_DATE" +%Y-%m-%d)

if [[ $WEEKDAY -le 5 ]]; then
    DAY_DIFF=$(( ($(date -j -f "%Y-%m-%d" "$TODAY" +%s) - $(date -j -f "%Y-%m-%d" "$START_DATE" +%s)) / 86400 ))
    INDEX=$(( (DAY_DIFF / 5) % ${#ROSTER[@]} ))

    PERSON=${ROSTER[$INDEX]}

    MESSAGE="{\"msgtype\": \"text\", \"text\": {\"content\": \"今日站会ta说了算：$PERSON\"}}"
    curl -X POST -H "Content-Type: application/json" -d "$MESSAGE" "$WEBHOOK_URL"
else
    echo "今天是周末，不发送通知"
fi