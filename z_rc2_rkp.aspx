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
                q_gf('', 'z_rc2_rkp');       
            });
            function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_rc2_rkp',
					options : [{
						type : '0', //[1]
						name : 'path',
						value : location.protocol + '//' +location.hostname + location.pathname.toLowerCase().replace('z_rc2_rkp.aspx','')
					},{
						type : '0', //[2]
						name : 'db',
						value : q_db
					},{
						type : '0', //[3]
						name : 'kind',
						value : q_getPara('sys.stktype')
					},{
						type : '6', //[4]
						name : 'noa'
					},{
						type : '8', //[5]
						name : 'merge',
						value : ('1@合併').split(',')
					}]
				});
				q_popAssign();

	            var t_para = new Array();
	            try{
	            	t_para = JSON.parse(q_getId()[3]);
	            }catch(e){
	            }    
	            if(t_para.length==0 || t_para.noa==undefined){
	            }else{
	            	$('#txtNoa').val(t_para.noa);
	            }
	            
	            $('<input id="btnOk2" type="button" value="查詢" style="font-size: 16px; font-weight: bold; color: blue; cursor: pointer;"/>').insertBefore('#btnOk');
            	$('#btnOk').hide();
            	$('#btnOk2').click(function(e){
            		switch($('#q_report').data('info').radioIndex) {
                        case 2:
                        	window.open("./pdf_rklabel01.aspx?noa="+$('#txtNoa').val()+"&noq=&stktype="+q_getPara('sys.stktype')+"&db="+q_db);
                        	
                           // pdf_rklabel01(q_getPara('sys.stktype'),$('#txtNoa').val(),'');
                            break;
                        default:
                           	$('#btnOk').click();
                            break;
                    }
            	});
            }

			function q_funcPost(t_func, result) {
                switch(t_func) {
                    default:
                        break;
                }
            }
            
			function q_gtPost(s2) {}
			
			function pdf_rklabel01(stktype,noa,noq){
				console.log(JSON.stringify({stype:stktype,noa:noa,noq:noq}));
				
				$.ajax({
                    url: 'pdf_rklabel01.aspx',
                    headers: { 'database': q_db },
                    type: 'POST',
                    data: JSON.stringify({stktype:stktype,noa:noa,noq:noq}),
                    dataType: 'text',
                    timeout: 10000,
                    success: function(data){
                		console.log('pdf_rklabel01');
                		window.location = 'pdf_rklabel01.aspx';
                    },
                    complete: function(){
                    },
                    error: function(jqXHR, exception) {
                        var errmsg = this.url+'資料讀取異常。\n';
                        if (jqXHR.status === 0) {
                            alert(errmsg+'Not connect.\n Verify Network.');
                        } else if (jqXHR.status == 404) {
                            alert(errmsg+'Requested page not found. [404]');
                        } else if (jqXHR.status == 500) {
                            alert(errmsg+'Internal Server Error [500].');
                        } else if (exception === 'parsererror') {
                            alert(errmsg+'Requested JSON parse failed.');
                        } else if (exception === 'timeout') {
                            alert(errmsg+'Time out error.');
                        } else if (exception === 'abort') {
                            alert(errmsg+'Ajax request aborted.');
                        } else {
                            alert(errmsg+'Uncaught Error.\n' + jqXHR.responseText);
                        }
                    }
                });	
			}
		</script>
		
		<style type="text/css">
			#frameReport table{
					border-collapse: collapse;
				}
		</style>
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
           
          