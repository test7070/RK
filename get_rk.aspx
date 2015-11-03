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
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			q_tables = 's';
			var q_name = "get";
			var q_readonly = ['txtNoa', 'txtWorker','txtComp','txtStore','txtWorker2'];
			var q_readonlys = [];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			brwCount2 = 4;
			aPop = new Array(
				//['txtPost', 'lblPost', 'addr', 'post,addr', 'txtPost', 'addr_b.aspx'],
				['txtStoreno', 'lblStore', 'store', 'noa,store', '0txtStoreno,txtStore', 'store_b.aspx'],
				['txtUno_', 'btnUno_', 'view_uccc', 'uno,productno,product,size,unit', '0txtUno_,txtProductno_,txtProduct_,txtSize_,txtUnit_', 'uccc_seek_b.aspx?;;;1=0', '95%', '60%'],
				['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product,unit', '0txtProductno_,txtProduct_,txtUnit_', 'ucaucc_b.aspx'],
				['txtRackno', 'lblRackno', 'rack', 'noa,rack,storeno,store', '0txtRackno', 'rack_b.aspx']
			);
			function sum(){
				if(!(q_cur==1 || q_cur==2))
					return;
			}
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function mainPost() {
				q_getFormat();
				document.title = '領退料作業';
				bbmMask = [['txtDatea', r_picd], ['txtCucdate', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", '領料單,退料單');
				
			}
			
			function q_popPost(s1) {
				switch (s1) {
					
				}
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function btnOk() {
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				Lock(1, {
					opacity : 0
				});
				var t_n = $('#cmbTypea').val()=='退料單' ? -1 : 1; 
				for(var i=0;i<q_bbsCount;i++){
					$('#txtEweight_'+i).val(Math.abs(q_float('txtEweight_'+i)));
					$('#txtMweight_'+i).val(Math.abs(q_float('txtMweight_'+i)));
				
					$('#txtGmount_'+i).val(t_n*q_float('txtEweight_'+i));
					$('#txtGweight_'+i).val(t_n*q_float('txtMweight_'+i));	
				}
				if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_vcc') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
			}
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock(1);
			}
			
			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('get_rk_s.aspx', q_name + '_s', "500px", "500px", q_getMsg("popSeek"));
			}

			function bbsAssign() {
				for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
					$('#lblNo_'+j).text(j+1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtProductno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtProductno_', '');
                            $('#btnProduct_'+n).click();
                        });
						$('#txtMount_' + j).change(function() {
							sum();
						});
						
						$('#txtWeight_' + j).change(function() {
							sum();
						});
						
						$('#txtPrice_' + j).change(function() {
							sum();
						});
					}
				}
				_bbsAssign();
			}

			function btnIns() {
				_btnIns();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
				$('#cmbTypea').val('領料');
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
			}

			function btnPrint() {
				q_box("z_get_rkp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'get_rk', "95%", "95%", m_print);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno'] && !as['uno']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['datea'] = abbm2['datea'];
				return true;
			}


			function refresh(recno) {
				_refresh(recno);
				for(var i=0;i<q_bbsCount;i++){
					$('#txtEweight_'+i).val(Math.abs(q_float('txtGmount_'+i)));
					$('#txtMweight_'+i).val(Math.abs(q_float('txtGweight_'+i)));
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}

			function btnMinus(id) {
				_btnMinus(id);
				sum();
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
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="width:1200px;overflow: visible;">
            <div class="dview" id="dview" >
                <table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:25%"><a id='vewTypea'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='typea'>~typea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
                <table class="tbbm"  id="tbbm">
                    <tr style="height:1px;">
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td class="tdZ"></td>
                    </tr>
					<tr>
						<td><span> </span><a id="lblType" class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
						<td><span> </span><a id="lblDatea" class="lbl" > </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblNoa" class="lbl" > </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan='5'>
							<textarea id="txtMemo" rows="6" class="txt c1"> </textarea>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
					<tr></tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
            <table id="tbbs" class='tbbs'>
                <tr style='color:white; background:#003366;' >
                    <td  align="center" style="width:30px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
                    <td align="center" style="width:20px;">項次</td>
                    <td align="center" style="width:160px;">批號</td>
					<td align="center" style="width:150px;">品名</td>
					<td align="center" style="width:200px;">規格</td>
					<td align="center" style="width:50px;">單位</td>
					<td align="center" style="width:80px;">領/退料<BR>數量<BR>重量</td>
					<td align="center" style="width:80px;">實際<BR>數量<BR>重量</td>
					<td align="center" style="width:200px;">備註</td>
					
				</tr>
				<tr  style='background:#cad3ff;'>
                    <td align="center">
	                    <input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
	                    <input id="txtNoq.*" type="text" style="display: none;" />
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input class="txt" id="txtUno.*" type="text" style="width:95%;"/></td>
					<td>
						<input id="txtProductno.*" type="text" style="width:45%"/>
						<input id="txtProduct.*" type="text" style="width:45%"/>
						<input id="btnProduct.*" type="button" style="display:none;"/>
					</td>
					<td><input id="txtSize.*" type="text" style="width:95%" maxlength="20"/></td>
					<td><input class="txt" id="txtUnit.*" type="text"  style="width:95%;"/></td>
					<td>
						<input class="txt num" id="txtMount.*" type="text" style="width:95%;"/>
						<input class="txt num" id="txtWeight.*" type="text" style="width:95%;"/>
					</td>
					<td>
						<input class="txt num" id="txtEweight.*" type="text" style="width:95%;"/>
						<input class="txt num" id="txtMweight.*" type="text" style="width:95%;"/>
						<input id="txtGmount.*" type="text" style="display:none;"/>
						<input id="txtGweight.*" type="text" style="display:none;"/>
					</td>
					<td>
						<input class="txt" id="txtMemo.*" type="text" style="width:95%;"/>
					</td>
					
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>