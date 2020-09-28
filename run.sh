# 6
for day in $(seq 1 30)
do
    ncl datetime=202006$(printf "%02d" $day) 01-read-fy4.ncl
done
