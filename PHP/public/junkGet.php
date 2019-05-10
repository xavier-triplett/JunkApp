<?php
        
    require_once '../include/connect.php';
        
    try {
        $pdo = new_pdo();
        
        $sql = "SELECT * FROM Items";
        
        $where = "";
        $parameters = array();
        $allItems = false;
        foreach ($_GET as $key => $value) {
        	$allItems = true;
            $param = ':' . $key;
            $parameters[$param] = $value;
            $where .= " AND " . $key . ' = ' . $param;
        }
        $where = "WHERE " . substr($where, 5);
        if ($allItems) {
	        $sql .=  " " . $where;
        }

        
        $stmt = $pdo->prepare($sql);
        // foreach ($parameters as $key => $value) {
        //     $stmt->bindParam($key, $value);
        // }
        
        $stmt->execute($parameters);
        
        $resultArray = $stmt->fetchAll();
        
        echo json_encode($resultArray);
    }
    catch (PDOException $e) {
        echo "Error unable to execute SQL select statement: error#", (int)$e->getCode(), " (", $e->getMessage(), ") ", $e->getFile() , ":" , $e->getLine(), " <br>" ;
    }
    


