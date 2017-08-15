#!/bin/bash
[[ -z "${INFLUX_HOST}" ]] && INFLUX_HOST='localhost'
[[ -z "${INFLUX_USER}" ]] && INFLUX_USER='root'
[[ -z "${INFLUX_PASSWORD}" ]] && INFLUX_PASSWORD='root'
[[ -z "${INFLUX_PORT}" ]] && INFLUX_PORT='8086'
[[ -z "${INFLUX_DB}" ]] && INFLUX_DB='glances'
[[ -z "${INFLUX_PREFIX}" ]] && INFLUX_PREFIX=''
[[ -z "${INFLUX_TAGS}" ]] && INFLUX_TAGS='server:server1,owner:foobar'
[[ -z "${INFLUX_TIME}" ]] && INFLUX_TIME='30'
[[ -z "${GLANCES_OPTIONS}" ]] && GLANCES_OPTIONS=''

echo "Setting Influx export to use host: $INFLUX_HOST"
echo "Setting Influx export to use user: $INFLUX_USER"
echo "Setting Influx export to use password: $INFLUX_PASSWORD"
echo "Setting Influx export to use port: $INFLUX_PORT"
echo "Setting Influx export to use db: $INFLUX_DB"
echo "Setting Influx export to use prefix: $INFLUX_PREFIX"
echo "Setting Influx export to use tags: $INFLUX_TAGS"
echo "Setting Influx export to run every: $INFLUX_TIME seconds"

sed -i "s/^port=.*/port=$INFLUX_PORT/g" /etc/glances/glances.conf
sed -i "s/^user=.*/user=$INFLUX_USER/g" /etc/glances/glances.conf
sed -i "s/^password=.*/password=$INFLUX_PASSWORD/g" /etc/glances/glances.conf
sed -i "s/^host=.*/host=$INFLUX_HOST/g" /etc/glances/glances.conf
sed -i "s/^db=.*/db=$INFLUX_DB/g" /etc/glances/glances.conf
sed -i "s/^prefix=.*/prefix=$INFLUX_PREFIX/g" /etc/glances/glances.conf
sed -i "s/^tags=.*/tags=$INFLUX_TAGS/g" /etc/glances/glances.conf


sed -i "s/^prefix=$/#prefix=/g" /etc/glances/glances.conf
sed -i "s/^tags=$/#tags=/g" /etc/glances/glances.conf

/usr/local/bin/glances --export-influxdb --time 30 --quiet $GLANCES_OPTIONS
