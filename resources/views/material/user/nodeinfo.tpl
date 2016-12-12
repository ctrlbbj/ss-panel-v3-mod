


{include file='user/header_info.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">节点信息</h1>
			</div>
		</div>
		<div class="container">
			<section class="content-inner margin-top-no">
				<div class="ui-card-wrap">
					<div class="row">
						<div class="col-lg-12 col-sm-12">
							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">注意！</p>
										<p>配置文件以及二维码请勿泄露！</p>
									</div>
									
								</div>
							</div>
						</div>
						<div class="col-lg-12 col-sm-12">
							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">配置信息</p>
										<p>服务器地址：{$ary['server']}<br>
										服务器端口：{$ary['server_port']}<br>
										加密方式：{$ary['method']}<br>
										密码：{$ary['password']}<br>
										{if $config['enable_rss']=='true'&&$node->custom_rss==1&&!($user->obfs=='plain'&&$user->protocol=='origin')}
										协议：{$user->protocol}<br>
										协议参数：{$user->protocol_param}<br>
										混淆：{$user->obfs}<br>
										混淆参数：{$user->obfs_param}<br>
										{/if}
										
										</p>
									</div>
									
								</div>
							</div>
						</div>					
						<div class="col-lg-12 col-sm-12">
							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">客户端下载</p>
										<p><a href="https://bit.no.com:43110/shadowsocksr.bit"><i class="icon icon-lg">desktop_windows</i>&nbsp;Windows</a> 选择 C# 版</p>
										<p><a href="https://github.com/qinyuhang/ShadowsocksX-NG/releases"><i class="icon icon-lg">laptop_mac</i>&nbsp;Mac OS X</a></p>
										<p><a href="https://github.com/breakwa11/shadowsocks-rss/wiki/Python-client"><i class="icon icon-lg">laptop_windows</i>&nbsp;Linux</a></p>
										<p><a href="https://bit.no.com:43110/shadowsocksr.bit"><i class="icon icon-lg">android</i>&nbsp;Android</a> 选择 Android 版</p>
										<p><a href="https://itunes.apple.com/us/app/shadowrocket/id932747118"><i class="icon icon-lg">phone_iphone</i>&nbsp;iOS</a></p>
									</div>
									
								</div>
							</div>
						</div>
						
						<div class="col-lg-12 col-sm-12">
							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">SSR-Python 配置Json</p>
										<textarea class="form-control" rows="6">{$json_show}</textarea>
									</div>
									
								</div>
							</div>
						</div>
						
						<div class="col-lg-12 col-sm-12">
							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">配置链接</p>
										<input id="ss-qr-text" class="form-control" value="{$ssqr_s}">
											{if $mu == 0}
											<p><a href="{$ssqr}"/>Android 手机上用默认浏览器打开点我就可以直接添加了(给原版APP)</a></p>
											{/if}
										{if $config['enable_rss']=='true'&&$node->custom_rss==1&&!($user->obfs=='plain'&&$user->protocol=='origin')}
										<p><a href="{$ssqr_s_new}"/>Android 手机上用默认浏览器打开点我就可以直接添加了(给 SSR)</a></p>
										<p><a href="{$ssqr_s_new}"/>iOS 上用 Safari 打开点我就可以直接添加了(给 Shadowrocket)</a></p>
										{/if}
									</div>
									
								</div>
							</div>
						</div>
						
						{if $config['enable_rss']=='true'&&$node->custom_rss==1&&!($user->obfs=='plain'&&$user->protocol=='origin')}
							{if $mu == 0}
							<div class="col-lg-12 col-sm-12">
								<div class="card">
									<div class="card-main">
										<div class="card-inner margin-bottom-no">
											<p class="card-heading">原版配置二维码</p>
											<div class="text-center">
												<div id="ss-qr-y"></div>
											</div>
										</div>
										
									</div>
								</div>
							</div>
							{/if}
						
						<div class="col-lg-12 col-sm-12">
							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">SSR 旧版(3.8.3之前)配置二维码</p>
										<div class="text-center">
											<div id="ss-qr"></div>
										</div>
									</div>
									
								</div>
							</div>
						</div>
						
						<div class="col-lg-12 col-sm-12">
							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">SSR 新版(3.8.3之后)配置二维码</p>
										<div class="text-center">
											<div id="ss-qr-n"></div>
										</div>
									</div>
									
								</div>
							</div>
						</div>
						
						{else}
						
						<div class="col-lg-12 col-sm-12">
							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">配置二维码</p>
										<div class="text-center">
											<div id="ss-qr"></div>
										</div>
									</div>
									
								</div>
							</div>
						</div>
						
						{/if}
						
						{if $mu == 0}
								<div class="col-lg-12 col-sm-12">
									<div class="card">
										<div class="card-main">
											<div class="card-inner margin-bottom-no">
												<STRIKE>
													<p class="card-heading">iOS9 上 Surge 配置</p>
													<div class="row">
											
														<div class="col-md-12">
													<p>您要先安装 Shadowrocket 。</p>
													先去app store上下载安装Shadowrocket
													<p>然后配置的话，直接下载生成好的配置文件，然后在 APP 里添加设置时选择 Download configuration from URL ，把地址粘贴进去添加。</p>
													<p>第一种分流方式，按照域名的文件下载地址，点击直接下载：<a href="{$link1}">{$link1}</a></p>

													<p>第二种分流方式，按照地区的文件下载地址，感谢 @Tony 提供，点击直接下载：<a href="{$link2}">{$link2}</a></p>
													<br>
												<div class="col-md-12">
													</div>
												</STRIKE>
											</div>
										
										</div>
									</div>
								</div>
						{/if}
						
					</div>
				</div>
			</section>
		</div>
	</main>







{include file='user/footer.tpl'}


<script src="/assets/public/js/jquery.qrcode.min.js"></script>
<script>
	var text_qrcode = '{$ssqr_s}';
	jQuery('#ss-qr').qrcode({
		"text": text_qrcode
	});
	
	{if $config['enable_rss']=='true'&&$node->custom_rss==1&&!($user->obfs=='plain'&&$user->protocol=='origin')}
	var text_qrcode1 = '{$ssqr}';
	jQuery('#ss-qr-y').qrcode({
		"text": text_qrcode1
	});
	
	var text_qrcode2 = '{$ssqr_s_new}';
	jQuery('#ss-qr-n').qrcode({
		"text": text_qrcode2
	});
	{/if}

</script>
