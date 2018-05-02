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
			var uccgaItem = '';
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
				q_gf('', 'z_uccg_rk');
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_uccg_rk',
                    options : [{
							type : '0', //[1]
							name : 'path',
							value : location.protocol + '//' +location.hostname + location.pathname.toLowerCase().replace('z_uccpkk.aspx','')
						},{
							type : '0', //[2]
							name : 'db',
							value : q_db
						},{
	                        type : '1',
	                        name : 'date' //[3][4]       1
	                    }, {
	                        type : '2',
	                        name : 'product', //[5][6]   2
	                        dbf : 'ucaucc',
	                        index : 'noa,product',
	                        src : 'ucaucc_b.aspx'
	                    }, {
							type : '8', //[7]            3
							name : 'xoption',
							value : "detail@明細".split(',')
						}, {
							type : '8', //[8]            4
							name : 'xkind',
							value : q_getPara('sys.stktype').split(',')
						},{
	                        type : '6',
	                        name : 'edate' //[9]       5
	                    }, {
							type : '8', //[10]            6
							name : 'ykind',
							value : "A1@金屬底材,A4@皮膜,A5@保護膜,A7@成品,A8@溶劑".split(',')
						},{
	                        type : '6',
	                        name : 'xuno' //[11]       7
	                    }
                    ]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();

                $('#txtDate1').mask('999/99/99');
                $('#txtDate1').datepicker();
                $('#txtDate2').mask('999/99/99');
                $('#txtDate2').datepicker();
                $('#txtEdate').mask('999/99/99');
                $('#txtEdate').datepicker();
                
                var t_date, t_year, t_month, t_day;
				t_date = new Date();
				t_date.setDate(1);
				t_year = t_date.getUTCFullYear() - 1911;
				t_year = t_year > 99 ? t_year + '' : '0' + t_year;
				t_month = t_date.getUTCMonth() + 1;
				t_month = t_month > 9 ? t_month + '' : '0' + t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day > 9 ? t_day + '' : '0' + t_day;
				$('#txtDate1').val(t_year + '/' + t_month + '/' + t_day);

				t_date = new Date();
				t_date.setDate(35);
				t_date.setDate(0);
				t_year = t_date.getUTCFullYear() - 1911;
				t_year = t_year > 99 ? t_year + '' : '0' + t_year;
				t_month = t_date.getUTCMonth() + 1;
				t_month = t_month > 9 ? t_month + '' : '0' + t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day > 9 ? t_day + '' : '0' + t_day;
				$('#txtDate2').val(t_year + '/' + t_month + '/' + t_day);
				$('#txtEdate').val(t_year + '/' + t_month + '/' + t_day);
				
				//暫時先不用
				/*$('#btnOk').before($('#btnOk').clone().attr('id', 'btnOk2').show()).hide();
				$('#btnOk2').click(function() {
					switch($('#q_report').data('info').radioIndex) {
                        case 2:
                        	Lock(1);
                        	//q_func('qtxt.query.uccstk_1', 'uccstk.txt,uccstk_1,'+$('#txtXdate').val());
                            
                            $.ajax({
			                    url: 'uccg_rk.aspx?date='+$('#txtEdate').val()+'&db='+q_db,
			                    type: 'POST',
			                    dataType: 'text',
			                    timeout: 1200000,
			                    success: function(data){
			                       alert(data);
			                    },
			                    complete: function(){ 
			                    	Unlock(1);                
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
                            break;
                        default:
                           	$('#btnOk').click();
                            break;
                    }
				});*/
            }

            function q_boxClose(s2) {
            }

            function q_gtPost(t_name) {
				
			}
		</script>
		<style type="text/css">
			/*.q_report .option {
				width: 600px;
			}
			.q_report .option div.a1 {
				width: 580px;
			}
			.q_report .option div.a2 {
				width: 220px;
			}
			.q_report .option div .label {
				font-size:medium;
			}
			.q_report .option div .text {
				font-size:medium;
			}
			.q_report .option div .cmb{
				height: 22px;
				font-size:medium;
			}
			.q_report .option div .c2 {
				width: 80px;
			}
			.q_report .option div .c3 {
				width: 110px;
			}*/
		</style>
	</head>
	<body id="z_accc" ondragstart="return false" draggable="false"
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