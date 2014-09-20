Commandline tool to import workouts from a Garmin Forerunner device under Linux.
Tested with Forerunner 305, may possibly work with other devices.


Dependencies
---------------------
The tool depends on `garmintools` to import data from a Garmin device. 
You can get those in .rpm format from [Andreas Diesner's website](http://www.andreas-diesner.de/garminplugin/doku.php?id=start), 
use the sources found on [Google Code](http://code.google.com/p/garmintools/), 
or embear's modified version available [here on GitHub](https://github.com/embear/garmintools).

Then, `java` runtime will be needed, along with `saxon`. 
If you want to import GPS data, too, you will also need `gpsbabel` installed.


How it works
--------------------
This tool is nothing more than a small handy wrapper around work made by others.
 - First, it uses `garmin_save_runs` from `garmintools` to import .gmn files from a Garmin device.
 - Then, it uses a bash/saxon script created by [Braiden Kindt](http://braiden.org) to convert the .gmn files to .tcx.


How to use it
--------------------
Simply dump everything to `~/exports` (this is the directory `garmin_save_runs` saves data into, so I 
figured, to avoid mess, it will be the best place to put this tool).
If you want, for convenience, you can copy the `importgarmin` file to
`/usr/bin`, or whatever else directory included in your `PATH`. 

Once you have all the depencencies satisfied and the files copied, just run:

    $ importgarmin

If everything went correctly, inside `~/exports` you should find the .gmn files created by `garmin_save_runs`,
each file accompanied by a converted .gmn.tcx Garmin Training Center file.


Troubleshooting
--------------------
Note that, when attempting to run `garmin_save_runs`, you may get a message about the device being
busy communicating. This is most often caused by the `garmin_gps` kernel module talking to the device.
If that's the case, you will need to edit `/etc/modprobe.d/blacklist.conf` and add `garmin_gps` to the blacklist.
After that, you can either try to unload to module at runtime, or just restart your OS.

Also, depending on your SELinux policy, it may turn out that you need root access for `garmin_save_runs` to 
successfully read from the device.

If you suddenly find your .gmn / .tcx files missing GPS data, try removing the files and running the tool again.
It seems that sometimes, if you run the import to soon after plugging in the device, GPS data is not transferred.
