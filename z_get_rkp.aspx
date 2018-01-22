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
                q_gf('', 'z_get_rkp');       
            });
            function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_get_rkp',
					options : [{
						type : '0', //[1]
						name : 'path',
						value : location.protocol + '//' +location.hostname + location.pathname.toLowerCase().replace('z_get_rkp.aspx','')
					},{
						type : '0', //[2]
						name : 'db',
						value : q_db
					},{
						type : '6', //[3]     1
						name : 'noa'
					},{
						type : '8', //[4]   標籤用     2
						name : 'showacomp',
						value : "1@顯示公司抬頭".split(',')
					},{
						type : '5', //[5] 3
						name : 'xtype',
						value : [q_getPara('report.all')].concat('領料單,加寄庫出貨,退料,盤點,報廢'.split(','))
					},{
                        type : '1',//[6][7] 4
                        name : 'xdate'
                    }, {
						type : '2', //[8][9] 5
						name : 'xproduct',
						dbf : 'ucc',
						index : 'noa,product',
						src : 'ucc_b.aspx'
					},{
						type : '2', //[10][11]  6
						name : 'xcust',
						dbf : 'cust',
						index : 'noa,comp',
						src : 'cust_b.aspx'
					}, {
						type : '2', //[12][13] 7
						name : 'xproduct2',
						dbf : 'ucc',
						index : 'noa,product',
						src : 'ucc_b.aspx'
					}]
				});
				q_popAssign();
				$('#chkShowacomp').children().eq(0).prop('checked',true);
				
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
	            	$('#txtNoa').val(t_para.noa);
	            }
	            $('<input id="btnOk2" type="button" value="查詢" style="font-size: 16px; font-weight: bold; color: blue; cursor: pointer;"/>').insertBefore('#btnOk');
            	$('#btnOk').hide();
            	$('#btnOk2').click(function(e){
            		switch($('#q_report').data('info').radioIndex) {
                        case 2:
                        	window.open("./pdf_rklabel02.aspx?table=get&noa="+$('#txtNoa').val()+"&noq=&db="+q_db+"&acomp="+($('#chkShowacomp').children().eq(0).prop('checked')?'1':'0'));
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
			//function q_boxClose(s2) {}
			function q_gtPost(s2) {}
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
           
          