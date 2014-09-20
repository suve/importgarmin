#!/bin/bash

# This is a simple utility to run through all .gmn files
# created by garmin_save_runs inside ~/exports, and
# convert them to .ctx files.
#
# Also provides option to clear the directory of .tcx,
# keeping the original .gmn, and to copy all .tcx to
# a preferred location.


# If "clean" option is provided, remove the .tcx files
if [ "$1" == 'clear' ]; then
   find -name *.gmn.tcx -exec rm -v '{}' \;
   exit
fi

# If "copy" option is provided, copy all .tcx files
# to the specified location
if [ "$1" == "copy" ]; then
   
   # Check if destination dir is provided
   if [ -n "$2" ]; then
   
      # Yes, use provided dir
      DIR="$2"
   
   else
   
      # No, use a default directory
      DIR='~/exports/tcx' # Change this to whatever you prefer
   
   fi
   
   # Copy all files
   find -name *.gmn.tcx -exec cp -v -n '{}' "$DIR" \;
   exit
fi

# Set extension and command to use
EXT='.tcx'
COMM='./gmn2tcx.sh'

# List all .gmn files
LIST=`find -name *.gmn`

# Run through all files
for FILE in $LIST; do
   
   # Check if destination file exitsts
   if [ ! -e "$FILE$EXT" ]; then
      
      # If not, convert the .gmn to tcx and save it
      
      TCX=`$COMM $FILE`
      echo "$TCX" > $FILE$EXT
      
      # Notify about writing file
      echo Wrote: $FILE$EXT
      
   else
      
      # Notify about skipping file
      echo Skipped: $FILE$EXT
      
   fi
done
