#!/bin/bash

# Copyright 2020 by George Tarasov
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

JOB_SUFFIX=$(date +"%Y-%m-%d-%H-%M")

# Iterate on database list given in JOB_DBLIST variable
for dbname in $JOB_DBLIST
do
  # Specify the target directory
  _dir="$JOB_DIR/$dbname"
  # Make directory if it doesn't exist
  [ -d "$_dir" ] || mkdir "$_dir"
  pushd "$_dir"

  # Make the backup and the log. Check error code
  _arh_file="./$dbname-$JOB_SUFFIX.gz"
  _log_file="./$dbname-$JOB_SUFFIX.log"
  pg_dump -C $dbname 2> "$_log_file" | gzip > "$_arh_file"
  if [ ! "${PIPESTATUS[0]}" == "0" ]
  then
    logger --tag "cron.pg ($dbname)" "Database backup error! See log file: $_log_file"
    continue
  fi

  # Prune old backups and logs
  _files=( $(ls ./$dbname-*.gz | sort) )
  _files_count=${#_files[@]}
  if [ "$_files_count" -gt "$JOB_KEEP" ]
  then
    _del_count=$(( _files_count - JOB_KEEP ))
    rm ${_files[@]:0:${_del_count}}
  fi
  _files=( $(ls ./$dbname-*.gz | sort) )
  _files_count=${#_files[@]}
  if [ "$_files_count" -gt "$JOB_KEEP" ]
  then
    _del_count=$(( _files_count - JOB_KEEP ))
    rm ${_files[@]:0:${_del_count}}
  fi
  
  popd
done
