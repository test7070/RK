<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
			$(document).ready(function() {
				q_getId();
				q_gf('', 'z_ina_rkp');
			});
			function q_gfPost() {
			   $('#q_report').q_report({
					fileName : 'z_ina_rkp',
					options : [{
						type : '0', //[1]
						name : 'path',
						value : location.protocol + '//' +location.hostname + location.pathname.toLowerCase().replace('z_ina_rkp.aspx','')
					},{
						type : '0', //[2]
						name : 'db',
						value : q_db
					},{
                        type : '0',  //[3]
                        name : 'xkind',
                        value : q_getPara('sys.stktype')
                    },{
						type : '6',  //[4]  1
						name : 'xnoa'
					},{
						type : '8', //[5] 2
						name : 'merge',
						value : ('1@合併').split(',')
					}]
				});
				q_popAssign();
				q_langShow();
				$('#txtXdate1').mask('999/99/99');
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask('999/99/99');
				$('#txtXdate2').datepicker();  
				
				var t_para = new Array();
	            try{
	            	t_para = JSON.parse(q_getId()[3]);
	            }catch(e){
	            }    
	            if(t_para.length==0 || t_para.noa==undefined){
	            }else{
	            	$('#txtXnoa').val(t_para.noa);
	            }
				
				var t_date,t_year,t_month,t_day;
				t_date = new Date();
				t_date.setDate(1);
				t_year = t_date.getUTCFullYear()-1911;
				t_year = t_year>99?t_year+'':'0'+t_year;
				t_month = t_date.getUTCMonth()+1;
				t_month = t_month>9?t_month+'':'0'+t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day>9?t_day+'':'0'+t_day;
				$('#txtXdate1').val(t_year+'/'+t_month+'/'+t_day);
				
				t_date = new Date();
				t_date.setDate(35);
				t_date.setDate(0);
				t_year = t_date.getUTCFullYear()-1911;
				t_year = t_year>99?t_year+'':'0'+t_year;
				t_month = t_date.getUTCMonth()+1;
				t_month = t_month>9?t_month+'':'0'+t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day>9?t_day+'':'0'+t_day;
				$('#txtXdate2').val(t_year+'/'+t_month+'/'+t_day);
				
				$('<input id="btnOk2" type="button" value="查詢" style="font-size: 16px; font-weight: bold; color: blue; cursor: pointer;"/>').insertBefore('#btnOk');
            	$('#btnOk').hide();
            	$('#btnOk2').click(function(e){
            		switch($('#q_report').data('info').radioIndex) {
                        case 1:
                        	window.open("./pdf_rklabel04.aspx?noa="+$('#txtXnoa').val()+"&noq=&stktype="+q_getPara('sys.stktype')+"&db="+q_db);
                            break;
                        default:
                           	$('#btnOk').click();
                            break;
                    }
            	});
			}

			function q_boxClose(s2) {
			}
			function q_gtPost(s2) {
			}
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>