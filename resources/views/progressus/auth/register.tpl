{include file='header_new.tpl'}

	<header id="head" class="secondary"></header>

	<!-- container -->
	<div class="container">

		<ol class="breadcrumb">
			<li><a href="/">首页</a></li>
			<li class="active">注册</li>
		</ol>

		<div class="row">
			
			<!-- Article main content -->
			<article class="col-xs-12 maincontent">
				<header class="page-header">
					<h1 class="page-title">注册</h1>
				</header>
				
				<div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
					<div class="panel panel-default">
						<div class="panel-body">
							<h3 class="thin text-center">注册</h3>
							<p class="text-center text-muted">已经拥有一个账号？请<a href="/auth/login">点击这里</a>登录。</p>
							<p class="text-center text-muted">需要邀请码？请<a href="/code">点击这里</a>查询。</p>
							<hr>

							
								<div class="top-margin">
									<label>昵称 <span class="text-danger">*</span></label>
									<input id="name" type="text" class="form-control">
								</div>
								<div class="top-margin">
									<label>Email <span class="text-danger">*</span></label>
									<input id="email" type="text" class="form-control">
								</div>

								<div class="row top-margin">
									<div class="col-sm-6">
										<label>密码 <span class="text-danger">*</span></label>
										<input id="passwd" type="text" class="form-control">
									</div>
									<div class="col-sm-6">
										<label>确认密码 <span class="text-danger">*</span></label>
										<input id="repasswd" type="text" class="form-control">
									</div>
								</div>

								<div class="top-margin">
									<label>选择您的联系方式 <span class="text-danger">*</span></label>
									<select class="form-control" id="imtype">
										<option></option>
										<option value="1">微信</option>
										<option value="2">QQ</option>
										<option value="3">Google+</option>
									</select>
								</div>
								<div class="top-margin">
									<label>在这输入联系账号 <span class="text-danger">*</span></label>
									<input id="wechat" type="text" class="form-control">
								</div>
								<div class="top-margin">
									<label>邀请码 <span class="text-danger">*</span></label>
									<input id="code" type="text" class="form-control" value="{$code}">
								</div>

								<hr>

								<div class="row">
									<div class="col-lg-8">
										<label class="checkbox">
											注册即代表同意<a href="/tos">服务条款</a>，以及保证所录入信息的真实性，如有不实信息会导致账号被删除。
										</label>                        
									</div>
									<div class="col-lg-4 text-right">
										<button id="tos" class="btn btn-action" type="submit">注册</button>
									</div>
								</div>
							

							{include file='dialog.tpl'}
						
						
							<div aria-hidden="true" class="modal modal-va-middle fade" id="tos_modal" role="dialog" tabindex="-1">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-heading">
											<h2 class="modal-title">注册 服务条款</h2>
										</div>
										<div class="modal-inner">
											{include file='reg_tos.tpl'}
										</div>
										<div class="modal-footer">
											<p class="text-right"><button class="btn btn-action btn-flat btn-brand-accent waves-attach waves-effect" data-dismiss="modal" type="button">不同意</button><button class="btn btn-action btn-flat btn-brand-accent waves-attach waves-effect" data-dismiss="modal" id="reg" type="button">同意</button></p>
											
										</div>
									</div>
								</div>
							</div>

						</div>
					</div>

				</div>
				
			</article>
			<!-- /Article -->

		</div>
	</div>	<!-- /container -->
	

{include file='footer_new.tpl'}

<script>
    $(document).ready(function(){
        function register(){
            $.ajax({
                type:"POST",
                url:"/auth/register",
                dataType:"json",
                data:{
                    email: $("#email").val(),
                    name: $("#name").val(),
                    passwd: $("#passwd").val(),
                    repasswd: $("#repasswd").val(),
					wechat: $("#wechat").val(),
					imtype: $("#imtype").val(),
                    code: $("#code").val(),
                    agree: $("#agree").val()
                },
                success:function(data){
                    if(data.ret == 1){
                        $("#result").modal();
                        $("#msg").html(data.msg+"  3秒后跳转。");
                        window.setTimeout("location.href='/auth/login'", 3000);
                    }else{
                        $("#result").modal();
                        $("#msg").html(data.msg);
                    }
                },
                error:function(jqXHR){
                    $("#msg-error").hide(10);
                    $("#msg-error").show(100);
                    $("#msg-error-p").html("发生错误："+jqXHR.status);
                }
            });
        }
        $("html").keydown(function(event){
            if(event.keyCode==13){
                $("#tos_modal").modal();
            }
        });
        $("#reg").click(function(){
            register();
        });
		
		$("#tos").click(function(){
            $("#tos_modal").modal();
        });
    })
</script>