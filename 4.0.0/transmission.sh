#!/bin/bash
###############################################
# chkconfig: - 16 84 						  #
# description: Start up transmission-daemon	  #
# Y-Space									  #
# www.itzmx.com								  #
# processname: transmission-daemon			  #
# config: /etc/sysconfig/transmission		  #
# source function library
. /etc/rc.d/init.d/functions
# Get network config
. /etc/sysconfig/network
[ "${NETWORKING}" = "no" ] && exit 0
# Defaults
TRANSMISSION_HOME=/home/transmission
DAEMON_USER="transmission"
DAEMON_ARGS="-g $TRANSMISSION_HOME/.config/transmission"
# Daemon
NAME=transmission-daemon
DAEMON=$(which $NAME)
DAEMON_PIDFILE=/var/run/$NAME.pid
DAEMON_LOCKFILE=/var/lock/subsys/$NAME
DAEMON_SCRIPTNAME=/etc/init.d/$NAME
DAEMON_LOGFILE=/var/log/$NAME.log
[ -x "$DAEMON" ] || exit 0
start() {
    echo -n $"Starting ${NAME}: "
    if [ -n "$TRANSMISSION_HOME" ]; then
        export TRANSMISSION_HOME
    fi
    su - $DAEMON_USER -c "$DAEMON $DAEMON_ARGS"
    sleep 2
    status $NAME &> /dev/null && echo_success || echo_failure
    RETVAL=$?
    if [ $RETVAL -eq 0 ]; then
        touch $DAEMON_LOCKFILE
        pidof -o %PPID -x $NAME > $DAEMON_PIDFILE
    fi
    echo
}
stop() {
    echo -n $"Shutting down ${NAME}: "
    killproc $NAME
    RETVAL=$?
    [ $RETVAL -eq 0 ] && /bin/rm -f $DAEMON_LOCKFILE $DAEMON_PIDFILE
    echo
}
case "$1" in
    start)
        start
    ;;
    stop)
        stop
    ;;
    restart)
        stop
        start
    ;;
    status)
        status $NAME
    ;;
    *)
        echo "Usage: $SCRIPTNAME {start|stop|restart|status}" >&2
        exit 3
    ;;
esac