#!/bin/bash

# 企业微信 Webhook 地址（替换成你的）
WEBHOOK_URL="https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=994141b6-afe2-4009-bb63-8bfd0ba1b99f"

# 轮值人员列表
ROSTER=("张三" "李四" "王二麻")

# 获取当前日期
TODAY=$(date +%Y-%m-%d)
WEEKDAY=$(date +%u)  # 1-7 (1=周一, 7=周日)

# 计算当前年份的第一个周一作为基准日期
YEAR=$(date +%Y)
START_DATE=$(date -d "$YEAR-01-01 +$(( (8 - $(date -d "$YEAR-01-01" +%u)) % 7 )) days" +%Y-%m-%d)

# 计算索引（确保轮值人员按照工作日循环）
if [[ $WEEKDAY -le 5 ]]; then
    DAY_DIFF=$(( ($(date -d "$TODAY" +%s) - $(date -d "$START_DATE" +%s)) / 86400 ))
    INDEX=$(( (DAY_DIFF / 5) % ${#ROSTER[@]} ))

    PERSON=${ROSTER[$INDEX]}

    # 发送消息到企业微信
    MESSAGE="{\"msgtype\": \"text\", \"text\": {\"content\": \"今日值日生：$PERSON\"}}"
    curl -X POST -H "Content-Type: application/json" -d "$MESSAGE" "$WEBHOOK_URL"
else
    echo "今天是周末，不发送通知"
fi
