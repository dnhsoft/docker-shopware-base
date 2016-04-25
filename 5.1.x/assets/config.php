<?php
return array(
    'db' => array(
        'username' => getenv('SWDB_USER'),
        'password' => getenv('SWDB_PASS'),
        'dbname' => getenv('SWDB_DATABASE'),
        'host' => getenv('SWDB_HOST'),
        'port' => getenv('SWDB_PORT'),
    )
);
