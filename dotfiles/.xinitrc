[ -x "$(command -v redshift)" ] && redshift -O 3500
while true; do
	xsetroot -name "$(date)"
	sleep 1
done &
