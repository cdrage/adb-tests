#!/bin/bash
echo "
##########
$1: TESTING WORDPRESS EXAMPLE
##########
"

# We build mariadb. as wordpress uses an aggregated database of mariadb

echo "
[mariadb-atomicapp]
	db_user = foo
	db_pass = foo
	db_name = foo

[wordpress]
	db_user = foo
	db_pass = foo
	db_name = foo
" >> answers.conf

mkdir build

docker build -t projectatomic/mariadb-centos7-atomicapp \
  -f nulecule-library/mariadb-centos7-atomicapp/Dockerfile \
  nulecule-library/mariadb-centos7-atomicapp/

docker build -t projectatomic/wordpress-centos7-atomicapp \
  -f nulecule-library/wordpress-centos7-atomicapp/Dockerfile \
  nulecule-library/wordpress-centos7-atomicapp/

atomic run projectatomic/wordpress-centos7-atomicapp --provider=$1 -a answers.conf --destination=build