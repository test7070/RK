<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			var q_name = "ordcs_rk", t_content = "where=^^['','')^^", bbsKey = ['noa','no2'], as;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
			
			var i, s1;
			$(document).ready(function() {
				main();
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				var t_para = new Array();
	            try{
	            	t_para = JSON.parse(decodeURIComponent(q_getId()[5]));
	            	t_content = "where=^^['"+t_para.productno+"','"+t_para.spec+"',"+t_para.dime+")^^";
	            }catch(e){
	            }    
                brwCount = -1;
                mainBrow(0, t_content);
                for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
				}
			}

			function q_gtPost() {
			}

			function refresh() {
				_refresh();
			}
			function bbsAssign() {
				
			}
		</script>
		<style type="text/css">
		</style>
	</head>

	<body>
		<div id="dbbs">
			<table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:98%' >
				<tr>
					<td align="center" style="width:20px;"> </td>
					<th align="center" style="width:120px;" ><a>單號</a></th>
					<th align="center" style="width:100px;" ><a>日期</a></th>
					<th align="center" style="width:120px;" ><a>廠商</a></th>
					<th align="center" style="width:120px;" ><a>品名</a></th>
					<th align="center" style="width:120px;" ><a>規格</a></th>
					<th align="center" style="width:50px;" ><a>厚</a></th>
					<th align="center" style="width:60px;" ><a>數量</a></th>
					<th align="center" style="width:60px;" ><a>重量</a></th>
					<th align="center" style="width:60px;" ><a>單價</a></th>
				</tr>
				<tr>
					<td><input name="sel"  id="radSel.*" type="radio" style="display:none;" />
						<a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a>
					</td>
					<td><input class="txt" id="txtNoa.*" type="text" style="width:95%;" readonly="readonly" /></td>
					<td><input class="txt" id="txtDatea.*" type="text" style="width:95%;" readonly="readonly" /></td>
					<td><input class="txt" id="txtNick.*" type="text" style="width:95%;" readonly="readonly" /></td>
					<td><input class="txt" id="txtProduct.*" type="text" style="width:95%;" readonly="readonly" /></td>
					<td><input class="txt" id="txtCspec.*" type="text" style="width:95%;" readonly="readonly" /></td>
					<td><input class="txt" id="txtDime.*" type="text" style="width:95%;text-align: right;" readonly="readonly" /></td>
					<td><input class="txt" id="txtMount.*" type="text" style="width:95%;text-align: right;" readonly="readonly" /></td>
					<td><input class="txt" id="txtWeight.*" type="text" style="width:95%;text-align: right;" readonly="readonly" /></td>
					<td><input class="txt" id="txtPrice.*" type="text" style="width:95%;text-align: right;" readonly="readonly" /></td>
				</tr>
			</table>
			<!--#include file="../inc/brow_ctrl.inc"-->
		</div>

	</body>
</html>