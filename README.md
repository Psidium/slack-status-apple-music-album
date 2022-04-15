# Slack Status Apple Music Self Update

Little script to get current track's info and show that on your Slack Status.

Main differences with current implementations:
* AppleScript and Bash only - no other knowledge required to read the scripts
* Prefer showing the album name rather than the music
* Always show album name and artist name
* completely local to your machine
* launchctl started every 10 seconds, no `wait`ing around
* always clear status (disable on .sh to avoid it messing with your actual status)

TODO:
* only sets or clears status if it contained :minidisc: emoji (as a marker for set by us) or if it was empty
* add autoclear timer for the duration of the music so status clears even if the script is dead

# Configuring and Enabling

## Create an slack application

* Create a new app https://api.slack.com/apps?new_app=1 providing a name and selecting the desired Slack Workspace that you're going to run apple music to slack on.

    * Under "Add features and functionality" select the "Permissions" section

    * Scroll down to "User Token Scopes" and add users.profile:write

    * scroll up to the top of the page and click "Install App to Workspace".

    * copy the `OAuth Access Token`, this will be used as the `SLACK_PERSONAL_TOKEN`

## Prepare your machine

```bash
# you need curl 7.82 at least (json support)
brew install curl
# check if it was installed on /usr/local/opt/curl/bin/curl otherwise change the curl call on the script
# easy way to enable disable the script
echo "SLACK_UPDATE_MUSIC_ON=true" >>  ~/.slack-status
echo 'SLACK_PERSONAL_TOKEN="xoxp-xxxxxxxxxxx"' >> ~/.slack-status 
cp ./com.psidium.SlackStatus.plist ~/Library/LaunchAgents/
# edit ~/Library/LaunchAgents/com.psidium.SlackStatus.plist so that PATH/TO/slack_status.sh point to the correct place (yeah I'm lazy not gonna write the script to replace it for you) 
launchctl load ~/Library/LaunchAgents/com.psidium.SlackStatus.plist
launchctl start com.psidium.SlackStatus
# accept the warning that bash will have access to Music.app
```


# References

https://github.com/sbdchd/apple-music-to-slack
https://gist.github.com/jgamblin/9701ed50398d138c65ead316b5d11b26?permalink_comment_id=2775093#gistcomment-2775093