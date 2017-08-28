<?php
// 
// 此SS PANEL接口用于SS PANEL 魔改版
// 
//////////////////////////////////////////////////////////////
// wp需要include的
// require_once( dirname(__FILE__) . '/wp-load.php' );
//////////////////////////////////////////////////////////////
// ss-panel需要include的
//ini_set("display_errors", "On");
//error_reporting(E_ALL | E_STRICT);

include __DIR__ . '/SSPANEL_API_mod_config.php';

//  PUBLIC_PATH
define('PUBLIC_PATH', __DIR__);
// Bootstrap
require PUBLIC_PATH.'/../bootstrap.php';

use Slim\App;
use Slim\Container;
use App\Controllers;
use App\Models;
use App\Models\User;
use App\Models\LoginIp;
use App\Utils\Wecenter;
use App\Utils;
use App\Utils\Hash;
use App\Services;
use App\Services\Auth;
use App\Models\Node;
use App\Models\Relay;
use App\Utils\Tools;

$commands = array( 'login','getproduct','getclientinfo','proxylist','allproxylist' );

function out( $array )
{
	if( DEBUG_MODE )
		$array['post'] = $_POST;
	
	exit(json_encode($array));
}

if(!isset($_REQUEST['acctoken'])){
	out(array(
		'errcode'=>10000,
		'errmsg'=>'wrong access token.'
	));	
}

if($_REQUEST['acctoken']!= ACCESS_KEY ){
	out(array(
		'errcode'=>10000,
		'errmsg'=>'wrong access token.'
	));
}
if(!isset($_REQUEST['command'])){
	out(array(
		'errcode'=>10001,
		'errmsg'=>'command is missing'
	));
}
if(!in_array($_REQUEST['command'],$commands)){
	out(array(
		'errcode'=>10002,
		'errmsg'=>'wrong command',
		'command'=>$_REQUEST['command']
	));
}
switch($_REQUEST['command']){
	case 'login':
		login();
		break;
	case 'allproxylist':
		allproxylist();
		break;
}

out(array('errcode'=>99999,'errmsg'=>'something errors.'));

// ss panel login
function login()
{
	if(!isset($_REQUEST['email']) or !isset($_REQUEST['password'])){
		out(array(
		  'errcode'=>11001,
		  'errmsg'=>'Email or Password Invalid'
		));
    }
	$username = strtolower( $_REQUEST['email'] );
	$password = urldecode( $_REQUEST['password'] );
	
	// Handle Login
    $user = User::where('email', '=', $username)->first();
	if ($user == null) {
		out(array(
		  'errcode'=>11002,
		  'errmsg'=>'Email or Password Error'
		));
	}
	
	if (!Hash::checkPassword($user->pass, $password)) {
		$loginip=new LoginIp();
		$loginip->ip=$_SERVER["REMOTE_ADDR"];
		$loginip->userid=$user->id;
		$loginip->datetime=time();
		$loginip->type=1;
		$loginip->save();

		out(array(
		  'errcode'=>11002,
		  'errmsg'=>'Email or Password Error'
		));
	}
		
	$time =  3600*24;
	Auth::login($user->id, $time);
	$loginip=new LoginIp();
	$loginip->ip=$_SERVER["REMOTE_ADDR"];
	$loginip->userid=$user->id;
	$loginip->datetime=time();
	$loginip->type=0;
	$loginip->save();
	
	Wecenter::add($user, $password);
    Wecenter::Login($user, $password, $time);
	
	out(array(
		'errcode'=>0,
		'token'=>'111'
	));
}

function allproxylist()
{
	if(!isset($_REQUEST['email']) or !isset($_REQUEST['password'])){
		out(array(
		  'errcode'=>11001,
		  'errmsg'=>'Email or Password Invalid'
		));
    }
	
	$username = strtolower( $_REQUEST['email'] );
	$password = urldecode( $_REQUEST['password'] );

	// Handle Login
    $user = User::where('email', '=', $username)->first();
	if ($user == null) {
		out(array(
		  'errcode'=>11002,
		  'errmsg'=>'Email or Password Error'
		));
	}
	
	if (!Hash::checkPassword($user->pass, $password)) {
		$loginip=new LoginIp();
		$loginip->ip=$_SERVER["REMOTE_ADDR"];
		$loginip->userid=$user->id;
		$loginip->datetime=time();
		$loginip->type=1;
		$loginip->save();

		out(array(
		  'errcode'=>11002,
		  'errmsg'=>'Email or Password Error'
		));
	}
		
	$time =  3600*24;
	Auth::login($user->id, $time);
	$loginip=new LoginIp();
	$loginip->ip=$_SERVER["REMOTE_ADDR"];
	$loginip->userid=$user->id;
	$loginip->datetime=time();
	$loginip->type=0;
	$loginip->save();
	
	Wecenter::add($user, $password);
    Wecenter::Login($user, $password, $time);
	
	if ($user->is_admin) {
		$nodes = Node::where('type', 1)->orderBy('name')->get();
	} else {
		$nodes = Node::where(
			function ($query) use ($user) {
				$query->Where("node_group", "=", $user->node_group)
					->orWhere("node_group", "=", 0);
			}
		)->where('type', 1)->where("node_class", "<=", $user->class)->orderBy('name')->get();
	}

	$relay_rules = Relay::where('user_id', $user->id)->orwhere('user_id', 0)->orderBy('id', 'asc')->get();

	if (!Tools::is_protocol_relay($user)) {
		$relay_rules = array();
	}

	$node_prefix=array();
	$node_method=array();
	$a=0;
	$node_order=array();
	$node_alive=array();
	$node_prealive=array();
	$node_heartbeat=array();
	$node_bandwidth=array();
	$node_muport=array();

	if ($user->is_admin) {
		$ports_count = Node::where('type', 1)->where('sort', 9)->orderBy('name')->count();
	} else {
		$ports_count = Node::where(
			function ($query) use ($user) {
				$query->Where("node_group", "=", $user->node_group)
					->orWhere("node_group", "=", 0);
			}
		)->where('type', 1)->where('sort', 9)->where("node_class", "<=", $user->class)->orderBy('name')->count();
	}

	$ports_count += 1;
	$output_nodeinfo = array();
	foreach ($nodes as $node) {
		if ((($user->class>=$node->node_class&&($user->node_group==$node->node_group||$node->node_group==0))||$user->is_admin)&&(!$node->isNodeTrafficOut())) {
			if ($node->sort==9) {
				$mu_user=User::where('port', '=', $node->server)->first();
				$mu_user->obfs_param=$user->getMuMd5();
				array_push($node_muport, array('server'=>$node,'user'=>$mu_user));
				continue;
			}

			$temp=explode(" - ", $node->name);
			if (!isset($node_prefix[$temp[0]])) {
				$node_prefix[$temp[0]]=array();
				$node_order[$temp[0]]=$a;
				$node_alive[$temp[0]]=0;

				if (isset($temp[1])) {
					$node_method[$temp[0]]=$temp[1];
				} else {
					$node_method[$temp[0]]="";
				}

				$a++;
			}


			if ($node->sort==0||$node->sort==7||$node->sort==8||$node->sort==10) {
				$node_tempalive=$node->getOnlineUserCount();
				$node_prealive[$node->id]=$node_tempalive;
				if ($node->isNodeOnline() !== null) {
					if ($node->isNodeOnline() === false) {
						$node_heartbeat[$temp[0]]="离线";
					} else {
						$node_heartbeat[$temp[0]]="在线";
					}
				} else {
					if (!isset($node_heartbeat[$temp[0]])) {
						$node_heartbeat[$temp[0]]="暂无数据";
					}
				}

				if ($node->node_bandwidth_limit==0) {
					$node_bandwidth[$temp[0]]=(int)($node->node_bandwidth/1024/1024/1024)." GB / 不限";
				} else {
					$node_bandwidth[$temp[0]]=(int)($node->node_bandwidth/1024/1024/1024)." GB / ".(int)($node->node_bandwidth_limit/1024/1024/1024)." GB - ".$node->bandwidthlimit_resetday." 日重置";
				}

				if ($node_tempalive!="暂无数据") {
					$node_alive[$temp[0]]=$node_alive[$temp[0]]+$node_tempalive;
				}
			} else {
				$node_prealive[$node->id]="暂无数据";
				if (!isset($node_heartbeat[$temp[0]])) {
					$node_heartbeat[$temp[0]]="暂无数据";
				}
			}

			if (isset($temp[1])) {
				if (strpos($node_method[$temp[0]], $temp[1])===false) {
					$node_method[$temp[0]]=$node_method[$temp[0]]." ".$temp[1];
				}
			}
			
			//print_r( $node );
			array_push($node_prefix[$temp[0]], $node);
			
			{
				$temp_nodeinfo = array();
				$temp_nodeinfo['type'] = 6;
				$temp_nodeinfo['port'] = $user->port;
				$temp_nodeinfo['product_name'] = '';
				$temp_nodeinfo['group_name'] = '';
				$temp_nodeinfo['name'] = $temp[0];
				$temp_nodeinfo['hostname'] = $node->server;
				$temp_nodeinfo['password'] = $user->passwd;
				$temp_nodeinfo['obfs'] = '';
				$temp_nodeinfo['obfsparam'] = $user->getMuMd5();
				$temp_nodeinfo['method'] = $node->method;
				$temp_nodeinfo['traffic_remaining'] = $node->attributes["node_bandwidth"];
				$temp_nodeinfo['protocol']=str_replace("_compatible", "", $user->protocol);
				$temp_nodeinfo['protocolparam']='';
				$temp_nodeinfo['active'] = 0;
				$temp_nodeinfo['charge_type'] = 2; // online pro
				$temp_nodeinfo['username'] = '';
				
				$output_nodeinfo[] = $temp_nodeinfo;
			}
		}
	}
	
	$node_prefix=(object)$node_prefix;
	$node_order=(object)$node_order;
	
	$proxylist[] = $output_nodeinfo;
	
	$output=array('errcode'=>0,'proxylist'=>$proxylist);
	
	out( $output );
	
	//print_r( $output_nodeinfo );
	/*
	echo "node_prefix<br/>";
	print_r( $node_prefix );
	echo "node_method<br/>";
	print_r( $node_method );
	echo "node_order<br/>";
	print_r( $node_order );
	echo "node_alive<br/>";
	print_r( $node_alive ); 
	echo "node_prealive<br/>";
	print_r( $node_prealive );
	echo "node_heartbeat<br/>";
	print_r( $node_heartbeat );
	echo "node_bandwidth<br/>";
	print_r( $node_bandwidth );
	echo "node_muport<br/>";
	print_r( $node_muport );
	*/
	
/*		
	//获取用户id
	$uid = $q->GetUidByEmail($username);
	$oo = new Ss\User\Ss($uid);
	
	$ss_pass = $oo->get_pass();
	$ss_port = $oo->get_port();
	
	$node = new Ss\Node\Node();
	$node0 = $node->NodesArray(0);

	//获得流量信息
	if($oo->get_transfer()<1000000)
	{
		$transfers=0;}else{ $transfers = $oo->get_transfer();
	}
	//计算流量并保留2位小数
	$all_transfer = $oo->get_transfer_enable()/$togb;
	$unused_transfer =  $oo->unused_transfer()/$togb;
	$used_100 = 0;
	if( $transfer_enable = $oo->get_transfer_enable() ){
		$used_100 = $oo->get_transfer()/$oo->get_transfer_enable();
		$used_100 = round($used_100,2);
		$used_100 = $used_100*100;
	}
	//计算流量并保留2位小数
	$transfers = $transfers/$tomb;
	$transfers = round($transfers,2);
	$all_transfer = round($all_transfer,2);
	$unused_transfer = round($unused_transfer,2);

	//注册时间
	$reg_datetime = $oo->get_reg_datetime();
	//到期时间（时间卡）
	$expired_time = $oo->get_expired_time();

	$traffic_info = array( 'all' => $all_transfer, 
	'used' =>$transfers, 
	'unsed' => $unused_transfer, 
	'used_percent' => intval($used_100),
	'regtime' => $reg_datetime, 
	'exptime' => $expired_time
	);
	
	$nodes = array();
	foreach($node0 as $row){
		$node = array();
		$node['type'] = 6;
		$node['port'] = $ss_port;
		$node['product_name'] = '';
		$node['group_name'] = '';
		$node['name'] = $row['node_name'];
		$node['hostname'] = $row['node_server'];
		$node['password'] = $ss_pass;
		$node['obfs'] = SSR_OBFS;
		$node['obfsparam'] = SSR_OBFS_PARAM;
		$node['method'] = $row['node_method'];
		$node['traffic_remaining'] = $unused_transfer;
		$node['protocol']=SSR_PROTOCOL;
		$node['protocolparam']='';
		$node['active'] = 0;
		$node['charge_type'] = 2; // online pro
		$node['username'] = '';
		
		$nodes[] = $node;
	}
	//////////////////////////////////////////////////////////////////
	
	$proxylist[] = $nodes;
	
	$output=array('errcode'=>0,'proxylist'=>$proxylist);
	
	out( $output );
	*/
}

// show all nodes
function do_ss_panel_show_allnodes()
{
	//////////////////////////////////////////////////////////////////
	// 以下是ss-panel的登录方式.
	$username = strtolower( $_REQUEST['log'] );
	$password = \Ss\User\Comm::SsPW( urldecode( $_REQUEST['pwd'] ) ); // 有些密码含有特别字符.客户端会URL编码
	//$password = urldecode( $_REQUEST['pwd'] ); // 有些密码含有特别字符.客户端会URL编码
	
	$rem = 'week';
	$c = new \Ss\User\UserCheck();
	$q = new \Ss\User\Query();
	$login_ret = $c->EmailLogin($username,$password);
	if( !$login_ret ) 
		die( 'Username or password error' );

	//获取用户id
	$uid = $q->GetUidByEmail($username);
	$oo = new Ss\User\Ss($uid);
	
	$ss_pass = $oo->get_pass();
	$ss_port = $oo->get_port();
	
	$node = new Ss\Node\Node();
	$node0 = $node->NodesArray(0);
	
	foreach($node0 as $row){
		
		$server =  $row['node_server'];
		$method = $row['node_method'];

		$ssurl =  $method.":".$ss_pass."@".$server.":".$ss_port;
		$ssqr = "ss://".base64_encode($ssurl);
		echo $ssqr."<br/>";
	}
	exit;
}

exit;
?>