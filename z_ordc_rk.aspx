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
            var t_part = "";
            $(document).ready(function() {
            	q_getId();
            	q_gt('part', 'order=^^noa^^', 0, 0, 0, "getPart");
                      
            });
            function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_ordc_rk',
					options : [{
						type : '0', //[1]
						name : 'path',
						value : location.protocol + '//' +location.hostname + location.pathname.toLowerCase().replace('z_ordc_rk.aspx','')
					},{
						type : '0', //[2] 
						name : 'db',
						value : q_db
					}, {//[3]
						type : '0',
						name : 'xkind',
						value : q_getPara('sys.stktype')
					}, {//  [4][5]  1
                        type : '1',
                        name : 'date'
                    }, {//  [6][7]  2
                        type : '1',
                        name : 'odate'
                    }, {//  [8][9]  3
                        type : '1',
                        name : 'rdate'
                    }, {//  [10][11]  4
                        type : '1',
                        name : 'rc2date'
                    }, {//  [12][13]   5
                        type : '2', 
                        name : 'tgg',
                        dbf : 'tgg',
                        index : 'noa,comp',
                        src : 'tgg_b.aspx'
                    }, {// [14][15]  6
                        type : '2',
                        name : 'product',
                        dbf : 'ucc',
                        index : 'noa,product',
                        src : 'ucc_b.aspx'
                    }, {
                        type : '8',// [16]  7
                        name : 'xpart',
                        value : t_part.split(',')
                    }, {
						type : '5', //[17]  8
						name : 'kind',
						value : [q_getPara('report.all')].concat(q_getPara('sys.stktype').split(','))
					}, {
						type : '5', //[18]  9
						name : 'enda',
						value : [q_getPara('report.all')].concat(('1@已結案,0@未結案').split(','))
					}]
				});
				q_langShow();
                q_popAssign();
				
				$('#txtDate1').mask(r_picd);
                $('#txtDate1').datepicker();
                $('#txtDate2').mask(r_picd);
                $('#txtDate2').datepicker();
                
                $('#txtOdate1').mask(r_picd);
                $('#txtOdate1').datepicker();
                $('#txtOdate2').mask(r_picd);
                $('#txtOdate2').datepicker();
                
                $('#txtRdate1').mask(r_picd);
                $('#txtRdate1').datepicker();
                $('#txtRdate2').mask(r_picd);
                $('#txtRdate2').datepicker();
                
                $('#txtRc2date1').mask(r_picd);
                $('#txtRc2date1').datepicker();
                $('#txtRc2date2').mask(r_picd);
                $('#txtRc2date2').datepicker();
                
	            var t_para = new Array();
	            try{
	            	t_para = JSON.parse(q_getId()[3]);
	            }catch(e){
	            }    
	            if(t_para.length==0 || t_para.noa==undefined){
	            }else{
	            	//$('#txtNoa').val(t_para.noa);
	            }
            }
			function q_funcPost(t_func, result) {
                switch(t_func) {
                    default:
                        break;
                }
            }
			function q_gtPost(t_name) {
				switch(t_name){
					case 'getPart':
						var as = _q_appendData("part", "", true);
						t_part = "";
						if (as[0] != undefined) {
							for(var i=0;i<as.length;i++){
								t_part += (t_part.length==0?'':',')+as[i].noa+'@'+as[i].part;
							}
						}
						q_gf('', 'z_ordc_rk'); 
						break;
				}
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
           
          