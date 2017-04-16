<footer id="footer" class="top-space">

		<div class="footer2">
			<div class="container">
				<div class="row">
					
					<div class="col-md-6 widget">
						<div class="widget-body">
							<p class="simplenav">
								<b><a href="/">首页</a></b> | 
								<a href="/code">邀请码</a> |
								{if $user->isLogin}
								<a href="/user/">用户中心</a> |
								<a href="/user/logout">退出</a> |
								{else}
								<a href="/auth/login">登陆</a> |
								<a href="/auth/register">注册</a>
								{/if}
							</p>
						</div>
					</div>

					<div class="col-md-6 widget">
						<div class="widget-body">
							<p class="text-right">
								&copy; 2016 <a href="/">{$config["appName"]}.</a> Powered by <a href="/staff">STAFF.</a>
							</p>
						</div>
					</div>

				</div> <!-- /row of widgets -->
			</div>
		</div>

	</footer>	
		




	<!-- JavaScript libs are placed at the end of the document so the pages load faster -->
	<script src="//cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
	<script src="//cdn.bootcss.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
	<script src="/theme/progressus/assets/js/headroom.min.js"></script>
	<script src="/theme/progressus/assets/js/jQuery.headroom.min.js"></script>
	<script src="/theme/progressus/assets/js/template.js"></script>
	<!--<script src="/theme/material/js/base.min.js"></script>-->
	<!--<script src="/theme/material/js/project.min.js"></script>-->

	<!-- Javascript -->
  <script type="text/javascript">
	try{
		if(window.console && window.console.log)
			console.log("偶然\n\n徐志摩\n\n我是天空里的一片云，\n偶尔投影在你的波心——\n你不必讶异，\n更无须欢喜——\n在转瞬间消灭了踪影。\n你我相逢在黑夜的海上，\n你有你的，我有我的，方向；\n你记得也好，\n最好你忘掉，\n在这交会时互放的光亮！\n","\nHey man! There is nothing here now.\nClick the moom to go back!\nwang@siyi.me\n\n");
	}catch(e){
	}
	</script>
</body>
</html>