##### START OF AUTO-GENERATED BITVAVO TELEPORT ALIASES #####
alias git-email='git config --global user.email'
alias ping-url='echo https://jump.monitoring.internal.bitvavo.com:443/webapi/ping/default'
alias vpn-conn='if curl --silent --output /dev/null $(ping-url); then echo "Connected to VPN successfully"; true; else warp-cli connect && warp-cli debug access-reauth && echo "Checking connection... (max 10 retries, usually takes 6-7 retries)" && curl --retry 10 --retry-delay 15 --silent --output /dev/null --show-error $(ping-url) && echo "Connected to VPN successfully" || echo "Could not connect to VPN"; fi'

# usage: db-login [db-user] [db-cluster1] [db-cluster2] ...
db-login(){ for db in "${@:2}"; do tsh db login --db-user=$1 $db; done }
# actual part of do-grep is ${grep//,/\\|}, but now replaced with ${grep//,/\\|} to fix EOF parser
do-grep(){ acc=""; for grep in $*; do; acc="$acc | grep \"${grep//,/\\\|}\""; done; awk -v i="$acc" "BEGIN {print substr(i,3); }"; }
req-id-latest(){ tsh requests ls | eval $(do-grep $@) | head -n 1 | awk "{ print \$1 }" }
req-id-others-latest(){ tsh requests ls | grep --invert-match $(git-email) | eval $(do-grep $@) | head -n 1 | awk "{ print \$1 }" }
tsh-login(){ tsh login --proxy=jump.monitoring.internal.bitvavo.com --auth="${1:-default}" --user=$(git config --global user.email) }
alias tshr-login='tsh-login reviewer'
alias req-id-own-pending='req-id-latest $(git-email) PENDING'
alias req-id-own-approved='req-id-latest $(git-email) APPROVED'
tshr-approve(){ tshr-login && id=$(req-id-others-latest PENDING $1); if [ -z "$id" ]; then print "No pending requests to approve, logging back in with default Teleport user"; else tsh request review $id --approve; fi; tsh-login }
tsh-assume(){ id=$(req-id-own-approved $1); if [ -z "$id" ]; then if [ -z "$(req-id-own-pending $1)" ]; then print "Create a request first"; else print "Your pending request is not approved yet"; fi; false; else tsh login --request-id $id; fi; }

req() {
read "reason?What is the reason you need access? ";
if [ -z "$reason" ]; then read "reason?What is the reason you need access? "
else
        # Re-authenticate and connect to VPN + try 5 times to login to Teleport with 5 sec timeouts
        vpn-conn && for i in 1 2 3 4 5; do tsh-login && break || sleep 5; done;
        tsh request new --roles="$1" --reason="$reason"; eval $2; eval $3; eval $4; eval $5;
fi
}

LAST_SIGINT_TIME=0
STOP_TSH_REVIEW_LOOP=false

handle_sigint() {
    current_time=$(date +%s)
    if [ $(($current_time - $LAST_SIGINT_TIME)) -le 2 ]; then echo " - Received two CTRL + C exit commands within 2 seconds. Exiting..."; kill -SIGINT $! &>/dev/null; STOP_TSH_REVIEW_LOOP=true;
    else kill -SIGINT $! &>/dev/null; echo " - Press 2x CTRL + C within 2 seconds to fully exit."; LAST_SIGINT_TIME=$current_time; fi
}

tsh-review-loop(){
  vpn-conn; STOP_TSH_REVIEW_LOOP=false; REQUESTS_TO_IGNORE=(); trap handle_sigint SIGINT; tput sc;
  while [ "$STOP_TSH_REVIEW_LOOP" = false ];
  if [ "$STOP_TSH_REVIEW_LOOP" = true ]; then return; fi;

  tput rc; tput ed; echo "[CHECKING FOR PENDING REQUESTS]";
  do tshr-login > /dev/null && id=$(req-id-others-latest PENDING $1);
    REQ_DETAILS=$(if [ -z "$id" ] || [[ "${REQUESTS_TO_IGNORE[@]}" =~ "$id" ]]; then echo ""; else echo $(tsh request show $id); fi); CREATED_AGE=0;
    if [ ! -z "$id" ]; then CREATED=$(tsh request show "$id" --format json | grep created | head -n 1 | sed -E 's/ *"created": "+//;s/",$//'| cut -c 1-19); fi;
    if [ ! -z "$id" ]; then CREATED_AGE=$(($(date '+%s')-$(TZ=UTC date -jf "%Y-%m-%dT%H:%M:%S" $CREATED +%s))); fi;

    # Don't show requests newer than 7 seconds as requests can get auto-approved by pagerduty the first 5 seconds
    if [ -z "$REQ_DETAILS" -o "$CREATED_AGE" -lt 7 ]; then tput rc; echo "[`date +%H:%M:%S`] - No new pending requests found. Checking again in 60 sec... Press 1x CTRL + C to force check for pending requests directly. Press 4x CTRL + C within 2 seconds to fully exit.\n\n"; tsh-login > /dev/null; sleep 60 & wait; continue; fi;

    # actual part of do-grep is sed 's/\//g', but now replaced with sed 's/\\//g' to fix EOF parser
    MESSAGE=($(echo $REQ_DETAILS | sed 's/Request ID: \(.*\) Username: \(.*\) Roles: \(.*\) Reason: \(.*\) Reviewers: \(.*\)/Request from: \2 (\3): \4/' | sed 's/"//g' | sed 's/\\//g'));
    APPROVE="$(osascript -e 'display dialog "'"$MESSAGE"'\n\nApprove request?" buttons {"Ignore", "Deny", "Approve"} default button "Approve"')"

    if [ "$APPROVE" = "button returned:Approve" ]; then echo "Approving request ($id)..."; tsh request review $id --approve;
    elif [ "$APPROVE" = "button returned:Deny" ]; then echo "Denying request ($id)..."; tsh request review $id --deny;
    else echo "[`date +%H:%M`] Ignoring request ($id)."; REQUESTS_TO_IGNORE+=($id); fi;
  done;
}
# The primary team as desired (auto-generated using prompt)
BITVAVO_TEAM='growth'

alias tsh-assume-${BITVAVO_TEAM}='tsh-assume ${BITVAVO_TEAM}'

# The database clusters to login as desired (auto-generated using prompt)
alias login-db-read='db-login ${BITVAVO_TEAM}-readonly bitvavo-reader prod-growth-mysql-reader'
alias login-db-write='db-login ${BITVAVO_TEAM}-readwrite bitvavo'
alias tsh-login-ro='tsh-login; tsh-assume ${BITVAVO_TEAM}; login-db-read;'
alias tsh-login-rw='tsh-login; tsh-assume ${BITVAVO_TEAM}; login-db-read; login-db-write;'

alias tsh-req-ro='req ${BITVAVO_TEAM}-readonly tsh-assume-${BITVAVO_TEAM} login-db-read'
alias tsh-req-rw='req ${BITVAVO_TEAM}-readonly,${BITVAVO_TEAM}-readwrite tsh-assume-${BITVAVO_TEAM} login-db-read login-db-write'

# line below for example will result in: tsh-review-loop trading,wallet-node-access
alias tsh-review='tsh-review-loop ${BITVAVO_TEAM}$([ -z ${BITVAVO_ROLE_ALT} ] && (echo "") || (echo ",${BITVAVO_ROLE_ALT}"))'
alias tsh-review-all='tsh-review-loop'
##### END OF AUTO-GENERATED BITVAVO TELEPORT ALIASES #####
