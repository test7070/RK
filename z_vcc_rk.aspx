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

			var t_custtype='',t_adpro='';
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'z_vcc_rk');
			});
			function q_gfPost() {
				q_gt('custtype', '', 0, 0, 0, "custtype");
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'custtype':
						var as = _q_appendData("custtype", "", true);
						if (as[0] != undefined) {
							t_custtype = '';
							for (i = 0; i < as.length; i++) {
								t_custtype = t_custtype + (t_custtype.length > 0 ? ',' : '') + $.trim(as[i].noa) + '@' + $.trim(as[i].namea);
							}
						}
						q_gt('adpro', '', 0, 0, 0, "adpro");
						break;
					case 'adpro':
						var as = _q_appendData("adpro", "", true);
						if (as[0] != undefined) {
							t_adpro = '';
							for (i = 0; i < as.length; i++) {
								t_adpro = t_adpro + (t_adpro.length > 0 ? ',' : '') + $.trim(as[i].noa) + '@' + $.trim(as[i].product);
							}
						}
						loadFinish();
						break;
					default:
						break;
				}
			}
			function loadFinish() {
				$('#q_report').q_report({
					fileName : 'z_vcc_rk',
					options : [{
						type : '0', //[1]
						name : 'path',
						value : location.protocol + '//' +location.hostname + location.pathname.toLowerCase().replace('z_vcc_rk.aspx','')
					},{
						type : '0', //[2]
						name : 'db',
						value : q_db
					},{
						type : '0', //[3]
						name : 'stktype',
						value : q_getPara('sys.stktype')
					},{
						type : '0', //[4]
						name : 'ordestype',
						value : q_getPara('orde.stype')
					},{
						type : '5', //[5] 1
						name : 'xkind',
						value : [q_getPara('report.all')].concat(q_getPara('sys.stktype').split(','))
					}, {
						type : '5', //[6] 2
						name : 'xcusttype',
						value : [q_getPara('report.all')].concat(t_adpro.split(','))
					},{
                        type : '1',//[7][8] 3
                        name : 'xdate'
                    }, {
						type : '2', //[9][10] 4
						name : 'xcust',
						dbf : 'cust',
						index : 'noa,nick',
						src : 'cust_b.aspx'
					}, {
						type : '2', //[11][12] 5
						name : 'xproduct',
						dbf : 'ucc',
						index : 'noa,product',
						src : 'ucc_b.aspx'
					}, {
						type : '1', //[13][14] 6
						name : 'xradius'
					}, {
						type : '1', //[15][16] 7
						name : 'xdime'
					}, {
						type : '1', //[17][18] 8
						name : 'xwidth'
					}, {
						type : '1', //[19][20] 9
						name : 'xlengthb'
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				
				$('#txtXdate1').mask('999/99/99');
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask('999/99/99');
				$('#txtXdate2').datepicker();

				var t_date, t_year, t_month, t_day;
				t_date = new Date();
				t_date.setDate(1);
				t_year = t_date.getUTCFullYear() - 1911;
				t_year = t_year > 99 ? t_year + '' : '0' + t_year;
				t_month = t_date.getUTCMonth() + 1;
				t_month = t_month > 9 ? t_month + '' : '0' + t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day > 9 ? t_day + '' : '0' + t_day;
				$('#txtXdate1').val(t_year + '/' + t_month + '/' + t_day);

				t_date = new Date();
				t_date.setDate(35);
				t_date.setDate(0);
				t_year = t_date.getUTCFullYear() - 1911;
				t_year = t_year > 99 ? t_year + '' : '0' + t_year;
				t_month = t_date.getUTCMonth() + 1;
				t_month = t_month > 9 ? t_month + '' : '0' + t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day > 9 ? t_day + '' : '0' + t_day;
				$('#txtXdate2').val(t_year + '/' + t_month + '/' + t_day);
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