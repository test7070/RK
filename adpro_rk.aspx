<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
    <head>
        <title> </title>
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
			var q_name = "adpro";
			var q_readonly = [];
			var bbmNum = [];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			brwCount2 = 10;
			//q_xchg = 1;
			q_desc = 1;
			aPop = new Array(
				['txtProductno', 'lblProductno', 'ucc', 'noa,product', 'txtProductno,txtProduct', 'ucc_b.aspx'],
				['txtTggno', 'lblTggno', 'tgg', 'noa,comp', 'txtTggno,txtComp', 'tgg_b.aspx']
			);

			$(document).ready(function() {
				bbmKey = ['noa'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1);
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function mainPost() {
				//bbmMask = [['txtMon', r_picm], ['txtDatea', r_picd]];
				//q_mask(bbmMask);
				//bbmNum = [['txtExreprice', 10, q_getPara('vcc.pricePrecision'), 1],['txtExprice', 10, q_getPara('vcc.pricePrecision'), 1],['txtDiffprice', 10, q_getPara('vcc.pricePrecision'), 1],['txtWeight', 10, q_getPara('vcc.weightPrecision'), 1]];
				
			}
			
			function sum() {
				//$('#txtDiffprice').val(q_sub(dec($('#txtExprice').val()),dec($('#txtExreprice').val())));
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'btnOk_checkNoa':
						var as = _q_appendData("adpro", "", true);
						if (as[0] != undefined) {
							alert('物品編號重複!!');
							$('#txtNoa').val('').focus();
						}else{
							var t_noa = trim($('#txtNoa').val());
							if (t_noa.length != 0)
								wrServer(t_noa);
						}
						Unlock(1);
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('adpro_rk_s.aspx', q_name + '_s', "500px", "450px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtNoa').focus();
				refreshBbm();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtProduct').focus();
				refreshBbm();
			}

			function btnPrint() {

			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock(1);

			}

			function btnOk() {
				Lock(1,{opacity:0});
				var t_noa = $.trim($('#txtNoa').val());
				if(t_noa.length > 0 && q_cur==1){
					var t_where = "where=^^ noa='" + t_noa + "' ^^";
					q_gt('adpro', t_where, 0, 0, 0, "btnOk_checkNoa", r_accy);
					return;
				}
				if (t_noa.length == 0){
					//q_gtnoa(q_name, t_noa);
					q_gtnoa('', t_noa);
				}
				else
					wrServer(t_noa);
			}

			function wrServer(key_value) {
				var i;

				xmlSql = '';
				if (q_cur == 2)
					xmlSql = q_preXml();

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}

			function refresh(recno) {
				_refresh(recno);
				refreshBbm();
			}
			function refreshBbm() {
				if (q_cur == 1) {
					$('#txtNoa').css('color', 'black').css('background', 'white').removeAttr('readonly');
				} else {
					$('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function q_appendData(t_Table) {
				return _q_appendData(t_Table);
			}

			function btnSeek() {
				_btnSeek();
			}

			function btnTop() {
				_btnTop();
			}

			function btnPrev() {
				_btnPrev();
			}

			function btnPrevPage() {
				_btnPrevPage();
			}

			function btnNext() {
				_btnNext();
			}

			function btnNextPage() {
				_btnNextPage();
			}

			function btnBott() {
				_btnBott();
			}

			function q_brwAssign(s1) {
				_q_brwAssign(s1);
			}

			function btnDele() {
				_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}
		</script>
		<style type="text/css">
            #dmain {
                overflow: visible;
            }
            .dview {
                float: left;
                width: 400px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 35px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 800px;
                /*margin: -1px;
                 border: 1px black solid;*/
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                width: 9%;
            }
            .tbbm .tdZ {
                width: 1%;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: blue;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs{width: 1200px;}
            .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                /*background: #cad3ff;*/
                background: lightgrey;
                width: 100%;
            }
            .tbbs tr {
                height: 35px;
            }
            .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
            .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:120px; color:black;"><a>編號</a></td>
						<td align="center" style="width:180px; color:black;"><a>類別</a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='product' style="text-align: center;">~product</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">編號</a></td>
						<td><input id="txtNoa"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">類別</a></td>
						<td><input id="txtProduct"  type="text" class="txt c1" /></td>
						<!--<td colspan="3">
							<input id="txtProductno" type="text" class="txt c2" />
							<input id="txtProduct" type="text" class="txt c3" />
						</td>-->
					</tr>

				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>