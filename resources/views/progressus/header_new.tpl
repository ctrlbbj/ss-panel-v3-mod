<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport"    content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<meta name="author"      content="Sergey Pozhilov (GetTemplate.com)">
	
	<title>{$config["appName"]}</title>
	
	<link rel="stylesheet" media="screen" href="//fonts.gmirror.org/css?family=Open+Sans:300,400,700">
	<link rel="stylesheet" href="/theme/progressus/assets/css/bootstrap.min.css">
	<!-- <link href="//cdn.bootcss.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet"> -->
	<link rel="stylesheet" href="/theme/progressus/assets/css/font-awesome.min.css">
	<!-- <link href="//cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet"> -->

	<!-- Custom styles for our template -->
	<link rel="stylesheet" href="/theme/progressus/assets/css/bootstrap-theme.css" media="screen" >
	<link rel="stylesheet" href="/theme/progressus/assets/css/main.css">

	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
	<script src="/theme/progressus/assets/js/html5shiv.js"></script>
	<script src="/theme/progressus/assets/js/respond.min.js"></script>
	<![endif]-->
</head>

<body class="home">
	<!-- Fixed navbar -->
	<div class="navbar navbar-inverse navbar-fixed-top headroom" >
		<div class="container">
			<div class="navbar-header">
				<!-- Button for smallest screens -->
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse"><span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button>
				<a class="navbar-brand" href="/"><img src="/theme/progressus/assets/images/logo.png" alt="Progressus HTML5 template" height="40px"></a>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav pull-right">
					<li class="active"><a href="/">首页</a></li>
					<li><a href="/code">邀请码</a></li>
					{if $user->isLogin}
					<li><a href="/user/">用户中心</a></li>
					<li><a class="btn" href="/user/logout">登出</a></li>
					{else}
					<li><a href="/auth/login">登录</a></li>
					<li><a class="btn" href="/auth/register">注册</a></li>
					{/if}
				</ul>
			</div><!--/.nav-collapse -->
		</div>
	</div> 
	<!-- /.navbar -->