<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			var q_name = "vcc_rk_s";
			var q_readonly = [];
			 aPop = new Array( ['txtCustno', 'lblCustno', 'cust', 'noa,nick', 'txtCustno', 'cust_b.aspx']);
			$(document).ready(function() {
				main();
			});
			function main() {
				mainSeek();
				q_gf('', q_name);
			}

			function q_gfPost() {
				q_getFormat();
				q_langShow();
				bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbTypea", '@全部,'+q_getPara('vcc.typea'));
                $('#txtBdate').datepicker();
                $('#txtEdate').datepicker();
			}

			function q_gtPost(t_name) {
				switch (t_name) {
				}
			}

			function q_seekStr() {
				var t_typea = $.trim($('#cmbTypea').val());
				var t_bdate = $.trim($('#txtBdate').val());
                var t_edate = $.trim($('#txtEdate').val());
				var t_noa = $.trim($('#txtNoa').val());
				var t_custno = $.trim($('#txtCustno').val());
				var t_cust = $.trim($('#txtCust').val());
				var t_invo = $.trim($('#txtInvono').val());
				var t_uno = $.trim($('#txtUno').val());
				var t_ordeno = $.trim($('#txtOrdeno').val());
				
				var t_where = " 1=1 "
					+ q_sqlPara2("typea", t_typea) 
					+ q_sqlPara2("datea", t_bdate,t_edate) 
					+ q_sqlPara2("noa", t_noa)
					+ q_sqlPara2("custno", t_custno);
				if(t_cust.length>0)
					t_where += " and charindex('"+t_cust+"',comp)>0";
				if(t_invo.length>0)
					t_where += " and charindex('"+t_invo+"',invono)>0";
				if(t_uno.length>0)
		       		t_where += " and exists(select noa from view_vccs"+r_accy+" where view_vccs"+r_accy+".noa=view_vcc"+r_accy+".noa and charindex('"+t_uno+"',view_vccs"+r_accy+".uno)>0 )";
				if(t_ordeno.length>0)
		       		t_where += " and exists(select noa from view_vccs"+r_accy+" where view_vccs"+r_accy+".noa=view_vcc"+r_accy+".noa and charindex('"+t_ordeno+"',view_vccs"+r_accy+".ordeno)>0 )";
		       			
				t_where = ' where=^^' + t_where + '^^ ';
				return t_where;
			}
		</script>
		<style type="text/css">
			.seek_tr {
				color: white;
				text-align: center;
				font-weight: bold;
				background-color: #76a2fe;
			}
			input{
				font-size:medium;
			}
			.readonly{
				color: green;
				background: rgb(237, 237, 238);
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek" border="1" cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTypea'> </a></td>
					<td><select id="cmbTypea" style="width:215px; font-size:medium;" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;"><a id='lblDatea'>日期</a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:90px;"><a id='lblNoa'>出貨單號</a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:220px;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblCustno'>客戶編號</a></td>
					<td><input id="txtCustno" type="text"/></td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblCust'>客戶名稱</a></td>
					<td><input id="txtCust" type="text"/></td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblInvono'>發票號碼</a></td>
					<td><input id="txtInvono" type="text"/></td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblUno'>批號</a></td>
					<td><input id="txtUno" type="text"/></td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblOrdeno'>訂單編號</a></td>
					<td><input id="txtOrdeno" type="text"/></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>