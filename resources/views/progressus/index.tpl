{include file='header_new.tpl'}

<!-- thumbnail -->
<div style='margin:0 auto;width:0px;height:0px;overflow:hidden;'>
	<img src="/theme/progressus/assets/images/thumbnail.jpg" width='640px'>
</div>
<!-- /thumbnail -->

<!-- Header -->
	<header id="head">
		<div class="container">
			<div class="row">
				<h1 class="lead">世界这么大，何不去看看？</h1>
				<p class="tagline">Across the Great Wall we can reach every corner in the world.</p>
				{if $user->isLogin}
				<p><a class="btn btn-action btn-lg" role="button" href="/auth/register">进入用户中心</a></p>
				{else}
				<p><a class="btn btn-default btn-lg" role="button" href="/auth/login">登录</a> <a class="btn btn-action btn-lg" role="button" href="/auth/register">注册</a></p>
				{/if}
			</div>
		</div>
	</header>
	<!-- /Header -->

	<!-- Intro -->
	<div class="container text-center">
		<br> <br>
		<h2 class="thin">墙里花开墙外笑，多情总被无情扰。</h2>
		<p class="text-muted">
			Facebook, Twitter, YouTube, Instergram, Google, Gmail...<br> 
			同一个世界，同一张网。
		</p>
	</div>
	<!-- /Intro-->
		
	<!-- Highlights - jumbotron -->
	<div class="jumbotron top-space">
		<div class="container">
			
			<h3 class="text-center thin">我们的优势</h3>
			
			<div class="row">
				<div class="col-md-3 col-sm-6 highlight">
					<div class="h-caption"><h4><i class="fa fa-cogs fa-5"></i>高速节点</h4></div>
					<div class="h-body text-center">
						<p>精选日本，香港等优质节点，让您即使观看视频也感觉不到卡顿。</p>
					</div>
				</div>
				<div class="col-md-3 col-sm-6 highlight">
					<div class="h-caption"><h4><i class="fa fa-flash fa-5"></i>免费开始</h4></div>
					<div class="h-body text-center">
						<p>一切从免费开始，只要您有邀请码，可以免费使用我们的服务，如果免费额度满足不了您，可以进入我们的商城，购买相应的商品！邀请好友还有返利赠送！</p>
					</div>
				</div>
				<div class="col-md-3 col-sm-6 highlight">
					<div class="h-caption"><h4><i class="fa fa-heart fa-5"></i>隐私保护</h4></div>
					<div class="h-body text-center">
						<p>数据库加密，保障账户安全。多种加密连接方式，保障用户上网隐私，远离一切烦恼。</p>
					</div>
				</div>
				<div class="col-md-3 col-sm-6 highlight">
					<div class="h-caption"><h4><i class="fa fa-smile-o fa-5"></i>客户服务</h4></div>
					<div class="h-body text-center">
						<p>您可通过工单系统提交问题，也可联系客服QQ：272429870，有问必答！</p>
					</div>
				</div>
			</div> <!-- /row  -->
		
		</div>
	</div>
	<!-- /Highlights -->

	<!-- container -->
	<div class="container">

		<h2 class="text-center top-space">获取邀请码</h2>
		<br>

		<div class="jumbotron top-space">
			<h4>由于种种你懂的原因以及为了限制侵权下载等诸多非法上网行为，我们实行邀请注册制度。老司机也会不定时向公众发放邀请码。老司机马上开车，上车请点击右侧按钮刷卡。</h4>
     		<p class="text-right"><a href="/code" class="btn btn-primary btn-large">滴，学生卡 »</a></p>
  		</div>

</div>	<!-- /container -->



{include file='footer_new.tpl'}