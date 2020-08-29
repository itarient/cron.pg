# cron.pg
Simple bash script for postgresql databases backup through a cron daemon.

## Installation

1. Login under postgres system user and create some folder in postgre' home directory

```bash
root:~# su -l postgres`
postgres:~# mkdir cron.pg.d
```

2. copy backup.sh into cron.pg.d

`postgres:~# cp backup.sh cron.pg.d/`

3. make your jobs

```bash
postgres:~# vim my_job1.sh
postgres:~# vim my_jon2.sh
...
```

Use the following variables

* JOB_DIR - destination storage for your backups. backup.sh will form the following file structure inside it:

```
JOB_DIR
|- dbname1
|  |- dbname1-YYYY-mm-d1.gz
|  |- dbname1-YYYY-mm-d1.log
|  |- dbname1-YYYY-mm-d2.gz
|  |- dbname1-YYYY-mm-d2.log
|  ...
|- dbname2
|  |- dbname2-YYYY-mm-d1.gz
|  |- dbname2-YYYY-mm-d1.log
|  |- dbname2-YYYY-mm-d2.gz
|  |- dbname2-YYYY-mm-d2.log
|  ...
...
```

* JOB_DBLIST - space-separated database names to be backuped
* JOB_KEEP - keep this number of backup files

See an examples.

4. add your jobs to the crontab

```bash
postgres:~# crontab -e
```
```
0 4     * * 6   cd /var/lib/postgresql/cron.pg.d && ./job_weekly_keep4.sh
0 4     * * *   cd /var/lib/postgresql/cron.pg.d && ./job_daily_keep20.sh
```

5. Check your authorization rules in your pg_hba.conf. You need local peer authorization rule if you don't want specify login and passowrds inside your jobs. **If you use auxiliary user to make backups, change backup.sh, and add -U parameter to the pg_dump command line. Also use ~/.pgpass file for storing user password. This is MUST be done under different non-privileged system user, NOT postgres, and NOT root!!!***

```
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     peer
```

6. **!!! CHECK YOUR JOBS ARE MADE !!!**

7. **!!! !!! REGULARLY CHECK YOUR BACKUPS ARE RESTORABLE !!! !!!**
