#!/bin/bash
exec java -classpath /usr/share/java/saxon.jar net.sf.saxon.Transform "$@" 
