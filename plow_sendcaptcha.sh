#!/bin/bash
#
# Sends an email with image as attachment using mutt.

# Set your own email adress :
declare -r MAILTO='marrco@localhost'
# Vars :
declare -r ERR_FATAL=1
CORPS_MAIL=/tmp/mail_plowshare

# Image file expected, provided by plowdown
if [ ! -f "$2" ]; then
    exit $ERR_FATAL
fi

echo "Hi!

Here is a captcha to solve; it comes from $1." > $CORPS_MAIL 

mutt -s 'captcha plowshare' -a $2 -- "$MAILTO" >/dev/null < $CORPS_MAIL || {
        echo 'mailx fatal error, abort' >&2;
        exit $ERR_FATAL;
}

echo 'Please check your email account and enter captcha solution here:' >&2
IFS= read -r
echo "$REPLY"
exit 0
