{$load=$point_node->getNodeLoad()}

<div id="load{$id}_chart" style="height: 300px; width: 100%;"></div>
	<div id="up{$id}_chart" style="height: 300px; width: 100%;"></div>
	<div id="alive{$id}_chart" style="height: 300px; width: 100%;"></div>
	<div id="speedtest{$id}_chart" style="height: 300px; width: 100%;"></div>
	<div id="speedtest{$id}_ping_chart" style="height: 300px; width: 100%;"></div>

				
	<script type="text/javascript">
		$().ready(function(){
			chart{$id} = new CanvasJS.Chart("load{$id}_chart",
			{
				title:{
					text: "节点负载情况 {$prefix}"
				},
				data: [
				{
					type: "line", 
					dataPoints: [
						{$i=0}
						{foreach $load as $single_load}
							{if $i==0}
								{literal}
								{
								{/literal}
									x: new Date({$single_load->log_time*1000}), y:{$single_load->getNodeLoad()}
								{literal}
								}
								{/literal}
								{$i=1}
							{else}
								{literal}
								,{
								{/literal}
									x: new Date({$single_load->log_time*1000}), y:{$single_load->getNodeLoad()}
								{literal}
								}
								{/literal}
							{/if}
						{/foreach}
						
					]
				}
				]
			});
			
			
			
			
			{$load=$point_node->getNodeAlive()}
			alive_chart{$id} = new CanvasJS.Chart("alive{$id}_chart",
			{
				title:{
					text: "最近一天节点在线人数情况 {$prefix}"
				},
				data: [
				{
					type: "line", 
					dataPoints: [
						{$i=0}
						{foreach $load as $single_load}
							{if $i==0}
								{literal}
								{
								{/literal}
									x: new Date({$single_load->log_time*1000}), y:{$single_load->online_user}
								{literal}
								}
								{/literal}
								{$i=1}
							{else}
								{literal}
								,{
								{/literal}
									x: new Date({$single_load->log_time*1000}), y:{$single_load->online_user}
								{literal}
								}
								{/literal}
							{/if}
						{/foreach}
						
					]
				}
				]
			});
			
			
			

			
			
			
			
			
			
			
				
			chart{$id}.render();
			alive_chart{$id}.render();

			
			
		});
		
		
		
		
			
	</script>