#!/usr/bin/env bash

if [[ "$(apt list --installed 2> /dev/null  | grep  postgresql-contrib)" ]]; then
	echo "pysql dependencies already installed"
else
	echo "updating os..."
	sudo apt update
	sudo apt upgrade
	
	echo "installing necessary packages"
	sudo apt install -y postgresql postgresql-contrib
fi

if [ "$1" = "--build" -o "$1" = "-b" ]; then
	echo "container is building..."
	docker-compose up  -d --build

else 
	echo "container is starting..."
	docker-compose up -d
fi

echo "copying tbl_actual to database server"
psql -U postgres -h localhost -p 38 -f databases/stms/tbl_actual.sql
echo "copying tbl_actual_data to database server"
psql -U postgres -h localhost -p 38 -f databases/stms/tbl_actual_data.sql
echo "copying tbl_kintai to database server"
psql -U postgres -h localhost -p 38 -f databases/stms/tbl_kintai.sql

echo "done happy programming"
