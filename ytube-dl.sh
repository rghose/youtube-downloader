#!/usr/bin/env bash
video_url="${1}"
out_file_name="${2:-out.video}"
curl \
  -H 'Upgrade-insecure-requests: 1' \
  -H 'Cache-control: max-age=0' \
  -H 'Accept-language: en-US,en;q=0.8,bn;q=0.6' \
  -H 'Accept-encoding: gzip, deflate, sdch' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36' \
  "${video_url}" \
| gunzip \
| egrep -o 'https%3A%2F%2F[^\.]*\.googlevideo.com%2F[^,\]*' \
| perl -pe 's/\%(\w\w)/chr hex $1/ge' \
| head -n1 \
| xargs wget -O "${out_file_name}"
