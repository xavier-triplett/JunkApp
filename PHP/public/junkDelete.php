<?php

	// For PUT and POST requests the params go into the body
	// x-www-form-urlencoded

	require_once '../include/connect.php';
			
	$dbh = new_pdo();   

	if ($_SERVER['REQUEST_METHOD'] == 'DELETE')
	{
		$input = file_get_contents("php://input");
		$data = json_decode($input);

		try {


			$sql = "DELETE FROM Items WHERE Name = :phpName, Price = :phpPrice, Category = :phpCategory, Description = :phpDescription"; 
			
			$stmt = $dbh->prepare($sql);


			$stmt->bindParam(':phpName', $data->Name);
			$stmt->bindParam(':phpPrice', $data->Price);
			$stmt->bindParam(':phpCategory', $data->Category);
			$stmt->bindParam(':phpDescription', $data->Description);

			$stmt->execute();

			echo $stmt->rowCount(), " row(s) deleted from Items \n";
		}
		catch (PDOException $e) {
				echo "Error: unable to execute SQL delete statement: error #", (int)$e->getCode(), " (", $e->getMessage(), ") ", $e->getFile() , ":" , $e->getLine(), " <br>" ;
		}

	}




