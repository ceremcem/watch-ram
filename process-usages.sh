#!/bin/bash
[[ "$(whoami)" == "root" ]] || { sudo $0 "$@"; exit 0; }

containsElement () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

res=$(ps -eo pcpu,pmem,pid,user,args --sort=-pcpu --no-headers| head -20)
res+=$(ps -eo pcpu,pmem,pid,user,args --sort=-pmem --no-headers| head -20)

handled=()
echo "["
while read pcpu pmem pid user args; do
	if containsElement "$pid" "${handled[@]}"; then
		>&2 echo "In both lists: PID:$pid ($args)"
		continue
	fi
	handled+=("$pid")
	cat <<- EOL
	{
	  "pcpu": $pcpu,
	  "pmem": $pmem,
	  "pid": $pid,
	  "user": "$user",
	  "args": "$args",
	  "pwdx": "$(pwdx $pid | awk '{print $2}')"
	},
EOL
done <<< $res
echo "]"
