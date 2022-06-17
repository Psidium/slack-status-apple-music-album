#! /bin/bash



function clear_status() {

    /usr/local/opt/curl/bin/curl 'https://slack.com/api/users.profile.set' -X POST -H "Authorization: Bearer $SLACK_PERSONAL_TOKEN" --json @- <<EOF
{
  "profile": {
    "status_text": "",
    "status_emoji": "",
  }
}
EOF
}

function set_slack_status() {
    echo $STATUS
    /usr/local/opt/curl/bin/curl 'https://slack.com/api/users.profile.set' -X POST -H "Authorization: Bearer $SLACK_PERSONAL_TOKEN" --json @- <<EOF
{
  "profile": {
    "status_text": "$STATUS",
    "status_emoji": ":musical_note:",
  }
}
EOF
}

. ~/.slack-status
if ! $SLACK_UPDATE_MUSIC_ON; then
    exit 0
fi

STATUS=$(osascript -e '
tell application "Music"
	if player state = playing then
		local status
		set status to " 💽 " & album of current track & " 🎤 " & artist of current track as string
		local possibleStatus
		set possibleStatus to name of current track & status
		if length of possibleStatus > 99 then
			status
		else
			possibleStatus
		end if
	end if
end tell
')

if [[ -z  $STATUS ]]; then
    clear_status
else
    set_slack_status
fi



