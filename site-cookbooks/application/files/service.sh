#!/bin/bash
#
# chkconfig: 35 90 12
# description: skills-recommender server
#

LOGFILE=/var/log/skills-recommender.log

start() {
  echo "Starting skills-recommender server:"

  cd /opt/skills-recommender
  mvn package
  java -jar target/skills-recommender-1.0.0-SNAPSHOT-jar-with-dependencies.jar /opt/data 2>&1 >> $LOGFILE &
  echo $! > /var/run/skills-recommender.pid

  echo "skills-recommender server started"
  echo
}
stop() {
  echo "Stopping skills-recommender server:"
  kill `cat /var/run/skills-recommender.pid`
  rm -f /var/run/skills-recommender.pid
  echo
}
status() {
  [ -f /var/run/skills-recommender.pid ] && exit 0 || exit 1
}
case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  status)
    status
    ;;
  restart|reload|condrestart)
    stop
    start
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|reload|status}"
    exit 1
esac
exit 0
