# Test 05

## Standard track:

Explain what the following script does:

```bash
if ! which nc
then
	echo "nc not found"
	exit 1
fi

if ! which md5sum
then
	echo "md5sum not found"
	exit 1
fi

if ! which sha1sum
then
	echo "sha1sum not found"
	exit 1
fi

echo "Access denied" > /tmp/msg

while true
do
	PW="$(echo $((RANDOM % 7923456982376 * $((RANDOM % 7923456982376 * $((RANDOM % 7923456982376))))))$(date +%Y%m%d%HH%MM) | md5sum | sha1sum | cut -d " " -f 1)"
	echo "blooper:$PW" | chpasswd
	echo $PW > /tmp/msg
	{ echo -ne "HTTP/1.0 200 OK\r\n\r\n"; cat /tmp/msg; } | nc -l -p 8765
	sleep 10
done
```

## Bonus track

Explain what is wrong with that script and how you could make it better.
