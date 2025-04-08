#!/bin/bash

WEBHOOK_URL="https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=90977e98-2843-4836-b669-f28d6f2b72c6"

ROSTER=("Ying" "Kevin" "Wenbin" "Milovan" "Han" "Andrey" "Xiao" "Yu")

index=$(cat current_index.txt)
next_index=$((index + 1))
next_index=$((next_index % ${#ROSTER[@]}))

weekday=$(date +%u)
if [[ $weekday -le 5 ]]; then
    person=${ROSTER[next_index]}
    MESSAGE="{\"msgtype\": \"text\", \"text\": {\"content\": \"今日站会ta说了算：$person\"}}"
    curl -X POST -H "Content-Type: application/json" -d "$MESSAGE" "$WEBHOOK_URL"
    $next_index > current_index.txt
else
    echo "weekend off"
fi