#/bin/bash
#
# Kronos by Droogy
#
# Kronos returns the last X amount of users
# any given person has followed on twitter

printf "###################################################\n"
printf "Please note the Twitter API is limited to checking
the last 1000 users someone has followed.\n"
printf "###################################################\n\n"

# if you already have json formatted list of followed users then use this module
if [ "$1" ]; then
	read -p "how many old followers you wanna see? " numOld
	# looks up negative index to grab last X amount of followers
	jq --arg numOld "$numOld" ".data[-$numOld:]" $1 > ugly.json
	# parse raw username string from list of JSON objects
	cat ugly.json | jq -r '.[].username' > last_$numOld.json
	cat ./last_$numOld.json
	exit
fi

# get variables from user
read -p "gib username(no @): " handle
read -p "how many old followers you wanna see? " numOld2

# get data on specified user to parse numerical ID we need for next step
curl -s "https://api.twitter.com/2/users/by?usernames=$handle" -H "Authorization: Bearer $TOKEN" -o raw_user.json

# parse out raw id string
cat raw_user.json | jq -r '.data[].id' > id.txt

# set id equal to variable
clear
printf "Parsing username -> id...\n"
sleep 1
# read file into variable
id=$(<id.txt)
clear
printf "The id for $handle is: $id\n Grabbing followers now"
sleep 2
# grab X users and save json
curl -s "https://api.twitter.com/2/users/$id/following?max_results=1000" -H "Authorization: Bearer $TOKEN" -o last1000_$handle.json
clear

# jq requires us to import bash variables with --arg
jq --arg numOld2 "$numOld2" ".data[-$numOld2:]" last1000_$handle.json > ugly.json
cat ugly.json | jq -r '.[].username' > $handle_last$numOld2.txt

# small loop to turn usernames into links
while read i; do
	echo "https://twitter.com/$i"
done < $handle_last$numOld2.txt