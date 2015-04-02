# docker-opengrok

The one-liner to spin up a code search engine

OpenGrok is a code search engine made by Sun (and now Oracle). It provides
similar functions to [LXR](http://lxr.linux.no/) but more. This project
encapsulated OpenGrok into a docker container. Allowing you to start an
instance of OpenGrok by one command.

## Usage

To start the OpenGrok, simply run:

```sh
docker run -d -v [source to be indexed on host]:/src -p [public port]:8080 steinwaywhw/opengrok
```

It may take a while for the indexer to finish the first-time indexing, after
that, the search engine is available at `http://host:[public port]/source/`.

## Note

The project supports dynamic index updating through `inotifywait` recursively on the source folder. However, `touch` doesn't help. You should add or delete or modify the content of some source file to make it happen.

### Java heap size

Modify the JAVA_OPTS environment variable in the Dockerfile to suit your needs.

### inotify

You will certainly need to adjust your docker host's inotify settings if you want to index anything remotely interesting:

```sudo sysctl -w fs.inotify.max_user_watches=2147483647```

### cpu usage

The initial indexing will make your host machine extremely unresponsive. You can adjust docker cpu usage quotas for all docker machines or just the running one by tweaking the cgroups settings on the host.

To adjust it for all machines:

```echo '100000' | sudo tee --append /sys/fs/cgroup/cpu/docker/cpu.cfs_quota_us```

For individual docker processes, look in the docker folder there for the one with the matching the hash, and edit the cpu.cfs_quota_us in a similar fashion. Cgroups settings are inherited structurally. See cgroups documentation: https://www.kernel.org/doc/Documentation/scheduler/sched-bwc.txt
