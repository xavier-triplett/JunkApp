<?php

	// For PUT and POST requests the params go into the body
	// x-www-form-urlencoded

	require_once '../include/connect.php';
			
	$dbh = new_pdo();   

	if ($_SERVER['REQUEST_METHOD'] == 'PUT')
	{
		$input = file_get_contents("php://input");
		$data = json_decode($input);

		try {


			$sql = "UPDATE Items SET Price = :phpPrice, Category = :phpCategory, Description = :phpDescription WHERE Name = :phpName"; 
			
			$stmt = $dbh->prepare($sql);


			$stmt->bindParam(':phpPrice', $data->Price);
			$stmt->bindParam(':phpCategory', $data->Category);
			$stmt->bindParam(':phpDescription', $data->Description);

			$stmt->bindParam(':phpName', $data->Name);

			$stmt->execute();

			echo $stmt->rowCount(), " row(s) updated in Items \n";
		}
		catch (PDOException $e) {
				echo "Error: unable to execute SQL update statement: error #", (int)$e->getCode(), " (", $e->getMessage(), ") ", $e->getFile() , ":" , $e->getLine(), " <br>" ;
		}

	}




