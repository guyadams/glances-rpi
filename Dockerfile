FROM hypriot/rpi-python
RUN apt-get update && apt-get install -y gcc make  build-essential python-dev libev4 libev-dev
RUN apt-get install -y vim
RUN pip install glances[wifi,ip,folders,docker,cpuinfo,action]
RUN pip install bernhard couchdb elasticsearch influxdb kafka-python pika potsdb prometheus-client statsd protobuf futures python-dateutil pytz
#RUN pip install pyzmq --install-option="--zmq=bundled"

RUN sed -i "s/self.stats\['cpu_hz_current'\] = /#self.stats['cpu_hz_current'] = /g" /usr/local/lib/python2.7/dist-packages/glances/plugins/glances_quicklook.py
RUN sed -i "s/self.stats\['cpu_hz'\] = /#self.stats['cpu_hz'] = /g" /usr/local/lib/python2.7/dist-packages/glances/plugins/glances_quicklook.py

ADD glances.conf /etc/glances/glances.conf
ADD start_glances.sh /start_glances.sh
RUN chmod +x /start_glances.sh
#RUN pip install glances[export]


CMD /start_glances.sh
