#!/usr/bin/php
<?php

// Read shopware config
$config = include '/shopware/config.php';
extract($config['db']);

// Create database
echo shell_exec("mysql -u$username -p$password -h$host -P$port -e 'CREATE DATABASE $dbname'");


$mysql_conn = "mysql -u$username -p$password -h$host -P$port $dbname";


include '/swtools/sql-data.php';
foreach ($sql_files as $file) {
	echo shell_exec("$mysql_conn < $file 2>&1");
}

if (file_exists('/shopware/demo.sql')) {
	echo shell_exec("$mysql_conn < /shopware/demo.sql 2>&1");
	echo shell_exec("rm /shopware/demo.sql 2>&1");
}