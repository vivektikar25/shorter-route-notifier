#!/bin/bash

highway_time=$(curl 'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=%22D-Mart%20Baner,%20Near,%20Yash%20Orchid%20Private%20Road,%20Baner,%20Pune,%20Maharashtra%20411045%22&destinations=%22AtulNagar%20Phase%20I,%20Atul%20Nagar,%20Warje,%20Pune,%20Maharashtra%22&departure_time=now&key=AIzaSyBXTwMcj3NNo9mI26JFCLDzbmRaY-3XXjY' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.8' -H 'upgrade-insecure-requests: 1' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36' -H 'x-chrome-uma-enabled: 1' -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'cache-control: max-age=0' -H 'authority: maps.googleapis.com' -H 'x-client-data: CJC2yQEIpbbJAQj6nMoBCKmdygEI0p3KAQioo8oB' --compressed | jq -r '.rows[0].elements[0].duration_in_traffic.value')

baner_to_pashan_time=$(curl 'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=%22D-Mart%20Baner,%20Near,%20Yash%20Orchid%20Private%20Road,%20Baner,%20Pune,%20Maharashtra%20411045%22&destinations=%22Pashan%20Cir,%20Pashan%20Gaon,%20Pashan,%20Pune,%20Maharashtra%22&departure_time=now&key=AIzaSyBXTwMcj3NNo9mI26JFCLDzbmRaY-3XXjY' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.8' -H 'upgrade-insecure-requests: 1' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36' -H 'x-chrome-uma-enabled: 1' -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'cache-control: max-age=0' -H 'authority: maps.googleapis.com' -H 'x-client-data: CJC2yQEIpbbJAQj6nMoBCKmdygEI0p3KAQioo8oB' --compressed | jq -r '.rows[0].elements[0].duration_in_traffic.value')

pashan_to_atulnagar_time=$(curl 'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=%22Pashan%20Cir,%20Pashan%20Gaon,%20Pashan,%20Pune,%20Maharashtra%22&destinations=%22AtulNagar%20Phase%20I,%20Atul%20Nagar,%20Warje,%20Pune,%20Maharashtra%22&departure_time=now&key=AIzaSyBXTwMcj3NNo9mI26JFCLDzbmRaY-3XXjY' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.8' -H 'upgrade-insecure-requests: 1' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36' -H 'x-chrome-uma-enabled: 1' -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'authority: maps.googleapis.com' -H 'x-client-data: CJC2yQEIpbbJAQj6nMoBCKmdygEI0p3KAQioo8oB' --compressed | jq -r '.rows[0].elements[0].duration_in_traffic.value')


via_pashan_time=$((baner_to_pashan_time+pashan_to_atulnagar_time))
echo $highway_time
echo $via_pashan_time

if [ $highway_time -gt $via_pashan_time ]
then
    curl -X POST \
  https://fcm.googleapis.com/fcm/send \
  -H 'authorization: key=AAAAA6pERKw:APA91bEw58oJejWUzh6dAAGLpG_zIKdKcpa3XIM3eHIrG6wtoW0GLBqkzu2pacYoIN6YW4cupIaG6h9ix235bBh5BJuVD2JXPMwPdzWbLjaNEMMLOf-VLpZMMQVdGvOJjcHfBQdaVCul' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: 19aa9857-8c28-2b8f-588d-4f4969e13fb0' \
  -d '

{ "notification": {
    "title": "Take Pashan",
    "body": "Pashan - '$((via_pashan_time/60))', Highway - '$((highway_time/60))'",
    "click_action" : "https://www.google.co.in/maps/dir/Yash+Orchid+Private+Road,+Mohan+Nagar+Co-Op+Society,+Baner,+Pune,+Maharashtra+411045/AtulNagar+Phase+I,+Atul+Nagar,+Warje,+Pune,+Maharashtra/@18.5194401,73.7632367,8452m/data=!3m2!1e3!4b1!4m14!4m13!1m5!1m1!1s0x3bc2beb8978f43d7:0xc5620795527a3a69!2m2!1d73.770773!2d18.5527911!1m5!1m1!1s0x3bc2be2cb3bb5aab:0x3b94c526eb3fc7e1!2m2!1d73.7926456!2d18.4860907!3e0"
  },

  "to" : "c9vPbg7Akco:APA91bH3jPE16ck5CiE1BdSTRWt4Pjgo-hnhM0WHeLo99lDHtirvUnkQ4hx3FT90t2gG0sqOXIYCYuEbCZLB4ybBykEAQqsGjyY5_2KwIrFYGlvG3pys-7Wu5gJA_ovsLl3TKgLJcSVc"

}'
else
    curl -X POST \
  https://fcm.googleapis.com/fcm/send \
  -H 'authorization: key=AAAAA6pERKw:APA91bEw58oJejWUzh6dAAGLpG_zIKdKcpa3XIM3eHIrG6wtoW0GLBqkzu2pacYoIN6YW4cupIaG6h9ix235bBh5BJuVD2JXPMwPdzWbLjaNEMMLOf-VLpZMMQVdGvOJjcHfBQdaVCul' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: 19aa9857-8c28-2b8f-588d-4f4969e13fb0' \
  -d '

{ "notification": {
    "title": "Take Highway",
    "body": "Highway - '$((highway_time/60))', Pashan - '$((via_pashan_time/60))'",
    "click_action" : "https://www.google.co.in/maps/dir/Yash+Orchid+Private+Road,+Mohan+Nagar+Co-Op+Society,+Baner,+Pune,+Maharashtra+411045/AtulNagar+Phase+I,+Atul+Nagar,+Warje,+Pune,+Maharashtra/@18.5194401,73.7632367,8452m/data=!3m2!1e3!4b1!4m14!4m13!1m5!1m1!1s0x3bc2beb8978f43d7:0xc5620795527a3a69!2m2!1d73.770773!2d18.5527911!1m5!1m1!1s0x3bc2be2cb3bb5aab:0x3b94c526eb3fc7e1!2m2!1d73.7926456!2d18.4860907!3e0"
  },

  "to" : "c9vPbg7Akco:APA91bH3jPE16ck5CiE1BdSTRWt4Pjgo-hnhM0WHeLo99lDHtirvUnkQ4hx3FT90t2gG0sqOXIYCYuEbCZLB4ybBykEAQqsGjyY5_2KwIrFYGlvG3pys-7Wu5gJA_ovsLl3TKgLJcSVc"

}'
fi
