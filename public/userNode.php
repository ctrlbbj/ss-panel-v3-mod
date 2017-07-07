<?php
/**
 * Created by PhpStorm.
 * User: microud
 * Date: 4/23/17
 * Time: 8:40 PM
 */

$userid = $_POST['userid'];
$email = $_POST['email'];
//echo $userid;

$userid = intval($userid)?$userid:"0";


$connection = new mysqli("localhost", "users", "password", "sspanel");

if ($connection->connect_error) {
    die('Connection failed: '. $connection->connect_error);
}

$sqlGetUserInfo = "SELECT user_name,port,passwd,method,money,transfer_enable,protocol,last_day_t,obfs,class,class_expire FROM user WHERE id=$userid AND email='$email'";

$result=$connection->query($sqlGetUserInfo);


if ($result) {
        if($result->num_rows>0){
		$row = $result->fetch_assoc();

		$collection['user'] = $row;		
		//echo json_encode($row);
	}else {
	die("wrongToken");
}

} else {
	die("wrongToken");
}



$sqlGetNodeList = "SELECT name,server,info,status,node_speedlimit,node_bandwidth,node_bandwidth_limit,node_ip FROM ss_node WHERE node_class<={$row['class']} AND node_class>0 AND type!=0";
//echo $sqlGetNodeList;
$nodeList = $connection->query($sqlGetNodeList);

//var_dump($nodeList);

if($nodeList) {
	if($nodeList->num_rows > 0){
		$i = 0;
		$rows = Array();
		for($i = 0; $i < $nodeList->num_rows; $i++) {
			$rows[$i] = $nodeList->fetch_assoc();
		}
		$collection['nodes'] = $rows;
	} else {
		$collection['nodes'] = "No NodeList";
	}
} else {
	$collection['nodes'] = "No nodelist";
}

echo json_encode($collection);

//$sqlGetUserInfoByUserId = 'SELECT * FROM user WHERE id=?';

//$stmt = $connection->prepare($sqlGetUserInfoByUserId);

//$stmt->bind_param('i', $userid);
//$stmt->execute();

//$queryResultOfUserInfo = $stmt->get_result();

//if ($queryResultOfUserInfo->num_rows > 0) {

//    $row = $queryResultOfFormInfo->fetch_assoc();
//    var_dump($row);
    //echo json_encode($row);

//} else {

//    echo "No user found";

//}

    #var_dump($fileList);

$connection->close();



?>
