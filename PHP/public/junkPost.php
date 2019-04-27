<?php

	// For PUT and POST requests the params go into the body
	// x-www-form-urlencoded
	require_once '../include/connect.php';

	// this POST is to add an element to a specific table (with specified column names)

	// make sure that the POST map has a key for the column names that you want to add to the
	// table that this POST is for

	// $_POST contains all the keys that match your webrowser/postmans/iOS add request keys
	$dbh = new_pdo(); 

	if ($_SERVER['REQUEST_METHOD'] == 'POST')
	{
		$input = file_get_contents("php://input");
		$data = json_decode($input);

		try {

			//$dbh = new_pdo();   // try to connect to our database with the specified user, ...

			// :Year is a php variable. Item is the name of our database table.
			// the values in the parentheses, e.g. name is a column of the table
            $sql = "INSERT INTO Items (Name, Price, Category, Description) VALUES (:Name, :Price, :Category, :Description)"; // escapes all values to make													 //	sure no values cause errors
			$stmt = $dbh->prepare($sql);

			// reusing the variable :Year and assigning it the value from the
			// webbrowser/postman/ios add request
			$stmt->bindParam(':Name', $data->Name);
			
			$stmt->bindParam(':Price', $data->Price);
			
            $stmt->bindParam(':Category', $data->Category);

			$stmt->bindParam(':Description', $data->Description);

			$stmt->execute();

			echo $stmt->rowCount(), " row(s) added to Items \n";
		}
		catch (PDOException $e) {
				echo "Error: unable to execute SQL insert statement: error #", (int)$e->getCode(), " (", $e->getMessage(), ") ", $e->getFile() , ":" , $e->getLine(), " <br>" ;
		}
		
	}




