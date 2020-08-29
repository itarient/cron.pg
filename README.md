# cron.pg
Simple bash script for postgresql databases backup through a cron daemon.

## Installation

1. Login under postgres system user and create some folder in postgre' home directory

root:~# su -l postgres
postgres:~# mkdir cron.pg.d

2. copy backup.sh into cron.pg.d

postgres:~# cp backup.sh cron.pg.d/

3. make your jobs

postgres:~# vim my_job1.sh
postgres:~# vim my_jon2.sh
...

4. add your jobs to the crontab

0 4     * * 6   cd /var/lib/postgresql/cron.pg.d && ./job_weekly_keep4.sh
0 4     * * *   cd /var/lib/postgresql/cron.pg.d && ./job_daily_keep20.sh

5. CHECK YOUR JOBS ARE MADE!!!

6. REGULARLY CHECK YOUR JOBS ARE RESTORABLE!!! !!!
