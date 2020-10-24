
settings{
   logfile = "/tmp/lsyncd.log",
   pidfile = "/tmp/lsyncd.pid",
   statusFile = "/tmp/lsyncd.stat",
   statusInterval = 1,
}

sync{
   default.rsync,
   source = "/data/music",
   target = "/backup2/music",
}

sync{
   default.rsync,
   source = "/data/document",
   target = "/backup2/document",
}

sync{
   default.rsync,
   source = "/data/picture",
   target = "/backup2/picture",
}

sync{
   default.rsync,
   source = "/data/video",
   target = "/backup/video",
}
