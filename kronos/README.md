# Kronos by Droogy

Kronos is a bash shell script which returns X amount of people that the target follows, beginning with the oldest.  
This could be a useful tool in OSINT investigations as users will typically follow people and things closest to their interests right away.  
Note: The Twitter API will only go back for the last 1000 people your target has followed.

## Usage

- You must have a Twitter developer account in order to utilize the API.
- For this script we will only need the Bearer Token, export this as an environment variable before running the script.
```bash
export TOKEN=<your bearer token>
```
- you will also need cURL and jq installed for this script to work
- Next you just need to run the script and provide a username (without the @) and let the script run it's magic!
- Optional: You can also provide a JSON file with followers as an argument and the script can parse that without having to make an API call
```bash
# run alone and provide username and number of followers to parse
./kronos.sh
# run with already compiled list of followers for target
./kronos.sh twitter_data.json
```

## Output
The output is super simple and clean, a new line with a link for each username that your target follows, ordered by date
```bash
https://twitter.com/User1
https://twitter.com/User2
https://twitter.com/User3
```