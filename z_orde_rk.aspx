<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			var t_ucc='';
			var t_style='';
			var t_adpro='';
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'z_orde_rk');
			});
			function q_gfPost() {
				q_gt('adpro', '', 0, 0, 0, '');
								
			}
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'adpro':
						var as = _q_appendData("adpro", "", true);
						t_adpro='';
						for ( i = as.length-1; i >=0; i--) {
							t_adpro+=','+as[i].noa+'@'+as[i].product;
						}
						if(t_adpro.length==0) t_adpro=' ';
						q_gt('ucc', '', 0, 0, 0, "");
						break;
					case 'ucc':
						t_ucc = ' @';
						var as = _q_appendData("ucc", "", true);
						for ( i = 0; i < as.length; i++) {
							t_ucc += (t_ucc.length > 0 ? '&' : '') + as[i].noa + '@' + as[i].noa;
						}
						q_gt('style', '', 0, 0, 0, "");
						break;
					case 'style':
						t_style = ' @';
						var as = _q_appendData("style", "", true);
						for ( i = 0; i < as.length; i++) {
							t_style += (t_style.length > 0 ? '&' : '') + as[i].noa + '@' + as[i].noa+'.'+as[i].product;
						}
						loadFinish();
						break;	
				}
			}
			function loadFinish() {
				$('#q_report').q_report({
					fileName : 'z_orde_rk',
					options : [{
						type : '0', //[1]
						name : 'path',
						value : location.protocol + '//' +location.hostname + location.pathname.toLowerCase().replace('z_orde_rkp.aspx','')
					},{
						type : '0', //[2]
						name : 'db',
						value : q_db
					}, {
						type : '1', //[3][4]   1
						name : 'xdate'
					}, {
						type : '1', //[5][6]   2
						name : 'xodate'
					}, {
						type : '2', //[7][8]   3
						name : 'xcust',
						dbf : 'cust',
						index : 'noa,comp',
						src : 'cust_b.aspx'
					}, {
						type : '2', //[9][10]  5
						name : 'xproduct',
						dbf : 'ucc',
						index : 'noa,product',
						src : 'ucc_b.aspx'
					}, {
						type : '5', //[11]  6
						name : 'xstype',
						value : [q_getPara('report.all')].concat(q_getPara('orde.stype').split(','))
					}, {
						type : '5', //[11]  6
						name : 'xcustpro',
						value : [q_getPara('report.all')].concat(t_adpro.split(','))
					}, {
						type : '5', //[13]  8
						name : 'xcancel',
						value : [q_getPara('report.all')].concat(new Array('1@Y', '0@N'))
					}, {
						type : '5', //[14]  9
						name : 'xend',
						value : [q_getPara('report.all')].concat(new Array('1@Y', '0@N'))
					}, {
						type : '1', //[15][16]   14
						name : 'xdime'
					}, {
						type : '1', //[17][18]  12
						name : 'xradius'
					}, {
						type : '1', //[19][20]  13
						name : 'xwidth'
					}, {
						type : '1', //[24][25]   15
						name : 'xlengthb'
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				
				if (q_getPara('sys.project').toUpperCase()=='RK'){
					$('#lblXdate').text('訂貨日期');
					$('#lblXodate').text('交貨日期');
				}
				
				$('#txtXdate1').mask('999/99/99');
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask('999/99/99');
				$('#txtXdate2').datepicker();
				$('#txtXodate1').mask('999/99/99');
				$('#txtXodate1').datepicker();
				$('#txtXodate2').mask('999/99/99');
				$('#txtXodate2').datepicker();
				$('#Xstktype select').val('').change();
				
				$('#Xbproduct3 select').change(function(e){
					$('#Xeproduct3 select').val($('#Xbproduct3 select').val());
				});
				var t_key = q_getHref();
				if (t_key[1] != undefined)
					$('#txtXnoa').val(t_key[1]);
				
			}
			

			function q_boxClose(s2) {
			}
		</script>
		<style type="text/css">
			.num {
				text-align: right;
				padding-right: 2px;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>