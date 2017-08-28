<?php
require_once __DIR__."/../../config/.config.php";
$db_host = $System_Config['db_host'];
$db_user = $System_Config["db_username"];
$db_pass = $System_Config["db_password"];
$db_name = $System_Config["db_database"];
$db_port = "3306";
$pwdMethod = $System_Config["pwdMethod"];
$salt = $System_Config["salt"];

if(isset($_REQUEST["username"]) && isset($_REQUEST["password"])){
    $username = $_REQUEST["username"];
    $password = $_REQUEST["password"];
}else{
    $result["result"] = "error";
    $result["message"] = "参数不完整。";
    $result = json_encode($result,JSON_UNESCAPED_UNICODE);
    echo $result;
    exit();
}

//连接数据库
try {
    $resLink = new mysqli($db_host,$db_user,$db_pass,$db_name,$db_port);
    $query = "
    SELECT * FROM `user` WHERE `email` = '{$username}'; 
    ";
    $results = $resLink->query($query);
    $result_ss = $results->fetch_array();
} catch (Exception $e) {
    echo $e->getMessage().$e->getLine();
    exit();
}
//验证密码
if(!Hash::checkPassword($result_ss["pass"],$password,$pwdMethod,$salt)){
    $result["result"] = "error";
    $result["message"] = "密码错误。";
    $result = json_encode($result,JSON_UNESCAPED_UNICODE);
    echo $result;
    exit();
}
$result = array();
$result["result"] = "success";
//获取ss参数
$result["port"] = $result_ss["port"];
$result["passwd"] = $result_ss["passwd"];
$result["methond"] = $result_ss["method"];
$result["protocol"] = $result_ss["protocol"];
$result["protocol_param"] = $result_ss["protocol_param"];
$result["obfs"] = $result_ss["obfs"];
$result["obfs_param"] = $result_ss["obfs_param"];
$result["class"] = (int)$result_ss["class"];
$result["expire_in"] = $result_ss["expire_in"];
$class = $result["class"];



//获取节点列表
$query = "SELECT * FROM `ss_node` WHERE `id` >= 3 AND `node_class` <= {$class}; ";
$resLink->query("set names utf8");
$results = $resLink->query($query);
$result_node = $results->fetch_array();
while ($result_node){
    $result["ips"][]["name"] = $result_node["name"];
    $result["ips"][]["ip"] = $result_node["node_ip"];
    $result["ips"][]["status"] = $result_node["status"];
    $result_node = $results->fetch_array();
}
echo json_encode($result,JSON_UNESCAPED_UNICODE);
exit();

class Hash
{
    public static function passwordHash($password,$method,$salt)
    {
        switch ($method) {
            case 'md5':
                return md5($password.$salt);
                break;
            case 'sha256':
                return hash("sha256",$password.$salt);
                break;
            default:
                return hash("sha256",$password.$salt);
        }
        return $password;
    }



    // @TODO
    public static function checkPassword($hashedPassword, $password,$method,$salt)
    {
        if ($hashedPassword == self::passwordHash($password,$method,$salt)) {
            return true;
        }
        return false;
    }
}

