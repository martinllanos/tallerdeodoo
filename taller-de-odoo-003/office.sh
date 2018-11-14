#!/bin/sh

### BEGIN INIT INFO
# Provides:        office.sh
# Required-Start:  $network $remote_fs $syslog
# Required-Stop:   $network $remote_fs $syslog
# Default-Start:   2 3 4 5
# Default-Stop:    1
# Short-Description: Start soffice daemon
### END INIT INFO
OOo_HOME=/usr/bin
SOFFICE_PATH=$OOo_HOME/soffice
PIDFILE=/var/run/libreoffice-server.pid
set -e

case "$1" in
    start)
    if [ -f $PIDFILE ]; then
      echo "LibreOffice headless server has already started."
      sleep 5
      exit
    fi
      echo "Starting LibreOffice headless server"
      #$SOFFICE_PATH --headless --nologo --nofirststartwizard --    accept="socket,host=127.0.0.1,port=2002;urp" & > /dev/null 2>&1
      $SOFFICE_PATH --nologo --nofirststartwizard --headless --norestore --invisible --pidfile=$PIDFILE "--accept=socket,host=localhost,port=8100,tcpNoDelay=1;urp;" & > /de
v/null 2>&1
    ;;
    stop)
    if [ -f $PIDFILE ]; then
      echo "Stopping LibreOffice headless server."
      pkill soffice.bin
      rm -f $PIDFILE
      exit
    fi
      echo "LibreOffice headless server is not running."
      exit
    ;;
    *)
    echo "Usage: $0 {start|stop}"
    exit 1
esac
