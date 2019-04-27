<?php

	function new_pdo(){
		
		require_once '../config/config.php';
		
		$options = [
		    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
		    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
		    PDO::ATTR_EMULATE_PREPARES   => false,
		];

		$dsn = 'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=' . DB_CHARSET;
		
		try{
			$pdo = new PDO($dsn, DB_USERNAME, DB_PASSWORD, $options);
		} catch (PDOException $e) {
			echo "Failed to connect to MySQL: error #", (int)$e->getCode(), " (", $e->getMessage(), ") ", $e->getFile() , ":" , $e->getLine(), " <br>" ;
		}

		return $pdo;
	}

