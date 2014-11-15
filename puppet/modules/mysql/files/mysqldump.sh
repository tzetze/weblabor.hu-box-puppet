#!/bin/bash

DATABASES=`mysql --batch --execute="SHOW DATABASES" | grep -v "Database" | grep -v ".*_schema"`
for db in $DATABASES; do
    if [ "$db" != "Database" ]; then
        `mysqldump --events $db > /var/sqldump/$db.sql`
        `rm /var/sqldump/$db.sql.gz`
        `gzip /var/sqldump/$db.sql`
    fi
done;
exit;
