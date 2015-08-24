#!/bin/bash

LOGFILE=/var/log/skills-recommender-ui.log

cd /opt/skills-recommender-ui >> $LOGFILE
npm install >> $LOGFILE
bower install --allow-root >> $LOGFILE
gulp build >> $LOGFILE
