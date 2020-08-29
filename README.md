# cron.pg
Simple bash script for postgresql databases backup through a cron daemon.

## Installation

1. Login under postgres system user and create some folder in postgre' home directory

`root:~# su -l postgres`
`postgres:~# mkdir cron.pg.d`

2. copy backup.sh into cron.pg.d

`postgres:~# cp backup.sh cron.pg.d/`

3. make your jobs

`postgres:~# vim my_job1.sh`
`postgres:~# vim my_jon2.sh`
...

Use the following variables

* JOB_DIR - target volume for your backups. backup.sh will form the following file structure inside it:

`JOB_DIR`
`|- dbname1`
`|  |- dbname1-YYYY-mm-d1.gz`
`|  |- dbname1-YYYY-mm-d1.log`
`|  |- dbname1-YYYY-mm-d2.gz`
`|  |- dbname1-YYYY-mm-d2.log`
`|  ...`
`|- dbname2`
`|  |- dbname2-YYYY-mm-d1.gz`
`|  |- dbname2-YYYY-mm-d1.log`
`|  |- dbname2-YYYY-mm-d2.gz`
`|  |- dbname2-YYYY-mm-d2.log`
`|  ...`
`|- ...`
`...`

* JOB_DBLIST - space-separated database names to be backuped
* JOB_KEEP - keep this number of backup files

See examples.

4. add your jobs to the crontab

`0 4     * * 6   cd /var/lib/postgresql/cron.pg.d && ./job_weekly_keep4.sh`
`0 4     * * *   cd /var/lib/postgresql/cron.pg.d && ./job_daily_keep20.sh`

5. CHECK YOUR JOBS ARE MADE!!!

6. REGULARLY CHECK YOUR JOBS ARE RESTORABLE!!! !!!
