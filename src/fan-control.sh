#!/bin/bash

gpio mode 6 out

temp1=$(< /sys/class/thermal/thermal_zone0/temp)
temp2=$(< /sys/class/thermal/thermal_zone1/temp)

dir=/home/orangepi/fan-control
maxtemp=50000  # temperature max 50 C

log() {
    dt=$(date "+%d/%m/%Y %H:%M:%S")
    echo "${dt} => ${1}" >> ${dir}/fan-control.log
}

if [ ${temp1} -gt ${maxtemp} ]
then
    log "ON : temp1 = ${temp1}"
    gpio write 6 1
else
    if [ ${temp2} -gt ${maxtemp} ]
    then
        log "ON : temp2 = ${temp2}"
        gpio write 6 1
    else
        log "OFF : temp1 = ${temp1} ; temp2 = ${temp2}"
        gpio write 6 0
    fi
fi

exit 0
