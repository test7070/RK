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
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'z_orde_rk');
			});
			function q_gfPost() {
				q_gt('ucc', '', 0, 0, 0, "");				
			}
			function q_gtPost(t_name) {
				switch (t_name) {
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
						type : '5', //[12]  7
						name : 'xtran',
						value : [q_getPara('report.all')].concat(q_getPara('sys.tran').split(','))
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
					}
					
					
					, {
						type : '5', //[16]  10
						name : 'xsortby',
						value : 'custno@依客戶,sizea@依尺寸,dime@依厚度'.split(',')
					}, {
						type : '5', //[17]  11
						name : 'xstktype',
						value : [q_getPara('report.all')].concat(q_getPara('sys.stktype').split(','))
					}, {
                        type : '1', //[26][27]  16
                        name : 'yradius'
                    }, {
                        type : '1', //[28][29]   18
                        name : 'ydime'
                    }, {
                        type : '1', //[30][31]  17
                        name : 'ywidth'
                    }, {
                        type : '1', //[32][33]   19
                        name : 'ylengthb'
                    }, {
						type : '5', //[36] 22
						name : 'xstyle',
						value : t_style.split('&')
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
				setDefaultValue();
				size_change();
				$('#Xstktype select').change(function() {
					size_change();
				});
				$('#Xbproduct3 select').change(function(e){
					$('#Xeproduct3 select').val($('#Xbproduct3 select').val());
				});
				var t_key = q_getHref();
				if (t_key[1] != undefined)
					$('#txtXnoa').val(t_key[1]);
				
				if(q_getPara('sys.project').toUpperCase()=='PK'){
					$('#q_report').find('span.radio').eq(6).click();
				}else{
					$('#q_report div div').eq(6).hide();
				}
			}
			
			function setDefaultValue() {
				$('#txtXradius1').val(0).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(0);
				});
				$('#txtXradius2').val(9999.99).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(9999.99);
				});
				$('#txtXwidth1').val(0).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(0);
				});
				$('#txtXwidth2').val(9999.99).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(9999.99);
				});
				$('#txtXdime1').val(0).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(0);
				});
				$('#txtXdime2').val(9999.99).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(9999.99);
				});
				$('#txtXlengthb1').val(0).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(0);
				});
				$('#txtXlengthb2').val(99999.9).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(99999.9);
				});
				$('#txtYwidth1').val(0).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(0);
				});
				$('#txtYwidth2').val(9999.99).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(9999.99);
				});
				$('#txtYdime1').val(0).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(0);
				});
				$('#txtYdime2').val(9999.99).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(9999.99);
				});
			}

			function size_change() {
				var SelectedVal = $('#Xstktype select').val().toUpperCase();
				if (!($('#Xstktype').is(":hidden"))) {
					switch (SelectedVal.substring(0,1)) {
						case 'A':
							$('#Xradius').hide();
							$('#Xwidth').show();
							$('#lblXwidth').text('厚度');
							$('#lblXdime').text('寬度');
							$('#Xdime').show();
							$('#Xlengthb').show();
							break;
						case 'B':
							$('#Xradius').show();
							$('#Xwidth').show();
							$('#lblXwidth').text('長徑');
							$('#lblXdime').text('厚度');
							$('#Xdime').show();
							$('#Xlengthb').show();
							break;
						case 'C':
							$('#Xradius').hide();
							$('#Xwidth').hide();
							$('#Xdime').hide();
							$('#Xlengthb').show();
							break;
						default:
							$('#Xradius').show();
							$('#Xwidth').show();
							$('#lblXwidth').text('長徑');
							$('#lblXdime').text('厚度');
							$('#Xdime').show();
							$('#Xlengthb').show();
							break;
					}
					setDefaultValue();
					$('#Xitype .cmb').change();
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