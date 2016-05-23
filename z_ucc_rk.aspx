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

			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'z_ucc_rk');
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_ucc_rk',
					options : [{
						type : '0', //[1]
						name : 'path',
						value : location.protocol + '//' +location.hostname + location.pathname.toLowerCase().replace('z_ucc_rk.aspx','')
					},{
						type : '0', //[2]
						name : 'db',
						value : q_db
					},{
						type : '0', //[3]
						name : 'stktype',
						value : q_getPara('sys.stktype')
					}, {
						type : '5', //[4] 1
						name : 'xkind',
						value : [q_getPara('report.all')].concat(q_getPara('sys.stktype').split(','))
					}, {
						type : '2', //[5][6]  2
						name : 'xproduct',
						dbf : 'ucc',
						index : 'noa,product',
						src : 'ucc_b.aspx'
					}, {
						type : '1', //[7][8] 3
						name : 'xradius'
					}, {
						type : '1', //[9][10] 4
						name : 'xdime'
					}, {
						type : '1', //[11][12] 5
						name : 'xwidth'
					}, {
						type : '1', //[13][14] 6
						name : 'xlengthb'
					}, {
						type : '6', //[15] 7
						name : 'edate'
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				
				$('#txtEdate').mask('999/99/99');
				$('#txtEdate').datepicker();
				$('#txtEdate').val(q_date());
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					default:
						break;
				}
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