## Session 3
## Web scraping and twitter

install.packages('rtweet', dependencies = T)
library("rtweet")
token <- create_token(
  app = "Tweetajba",
  consumer_key = "jVBIk5jUjOyt0UNdjmdYkuXqA",
  consumer_secret = "Uxx40X5eKpDnlelDslbkZdTqnVybDcBpvJ8J9sFzEZCBndn1S3",
  access_token = "132473954-VKytDrbnoyHMB1kxnrrjTMFWvk5KQYDj7z4fS0ZS",
  access_secret = "McPo32j1yav2pUIYbVARBSZIRvqNufPvcPVAxqiJ1ldYB")

## check to see if the token is loaded
identical(token, get_token())
#FALSE?