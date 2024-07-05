package live

import rego.v1

user(uid) := http.send({"method": "GET", "url": sprintf("https://hacker-news.firebaseio.com/v0/user/%s.json", [uid])}).body
