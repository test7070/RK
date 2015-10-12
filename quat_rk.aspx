<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            q_tables = 's';
            var q_name = "quat";
            var q_readonly = [ 'txtWorker', 'txtWorker2'];
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
            brwCount2 = 15;
            aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp,nick,serial', 'txtCustno,txtComp,txtNick,txtSerial', 'cust_b.aspx']
            	,['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
            	,['txtSpec_', 'btnSpec_', 'ucc', 'noa,product', 'txtSpec_,txtClass_', 'ucc_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'no3'];
                q_brwCount();
                q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
                
            });
			function sum(){
				for(var i=0;i<q_bbsCount;i++){
					
					
				}
				
			}
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }

            function mainPost() {
                q_getFormat();
                document.title = '報價作業';
                bbmMask = [['txtDatea', r_picd]];
                bbsMask = [];
                q_mask(bbmMask);
                q_cmbParse("combPaytype", q_getPara('vcc.paytype'));
                $("#combPaytype").change(function(e) {
					if (q_cur == 1 || q_cur == 2){
						$('#txtPaytype').val($('#combPaytype').find(":selected").text());
						$(this)[0].selectedIndex=0;
					}
				});
                $("#txtPaytype").focus(function(e) {
					var n = $(this).val().match(/[0-9]+/g);
					var input = document.getElementById("txtPaytype");
					if ( typeof (input.selectionStart) != 'undefined' && n != null) {
						input.selectionStart = $(this).val().indexOf(n);
						input.selectionEnd = $(this).val().indexOf(n) + (n + "").length;
					}
				}).click(function(e) {
					var n = $(this).val().match(/[0-9]+/g);
					var input = document.getElementById("txtPaytype");
					if ( typeof (input.selectionStart) != 'undefined' && n != null) {
						input.selectionStart = $(this).val().indexOf(n);
						input.selectionEnd = $(this).val().indexOf(n) + (n + "").length;
					}
				});
				$('#combAddr').change(function (e){
					$('#txtAddr').val($('#combAddr').find("option:selected").text());
				});
            }

            function q_popPost(s1) {
                switch(s1) {
                	case 'txtCustno':
						if ($('#txtCustno').val().length>0) {
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
							q_gt('custaddr', t_where, 0, 0, 0, "");
						}else{
							document.all.combAddr.options.length = 0;
						}
						break;
                    case 'txtMechno':
                       /*var t_mechno = trim($('#txtMechno').val());
                        if (t_mechno.length > 0) {
                            var t_where = "where=^^ enda=0 and mechno='" + t_mechno + "' ^^";
                            q_gt('view_ordes', t_where, 0, 0, 0, "", r_accy);
                        }*/
                        break
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
                	case 'custaddr':
						var as = _q_appendData("custaddr", "", true);
						var t_item = " @ ";
						if (as[0] != undefined) {
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].post + '@' + as[i].addr;
							}
						}
						document.all.combAddr.options.length = 0;
						q_cmbParse("combAddr", t_item);
						break;
                	case 'flors_coin':
						var as = _q_appendData("flors", "", true);
						var z_coin='';
						for ( i = 0; i < as.length; i++) {
							z_coin+=','+as[i].coin;
						}
						if(z_coin.length==0) z_coin=' ';
						
						q_cmbParse("cmbCoin", z_coin);
						if(abbm[q_recno])
							$('#cmbCoin').val(abbm[q_recno].coin);
						q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
						break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function btnOk() {
				Lock(1, {
                    opacity : 0
                });
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    Unlock(1);
                    return;
                }
                $('#txtAddr2').val($('#txtAddr').val());
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_quat') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('quat_rk_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	$('#txtProductno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtProductno_', '');
                            $('#btnProduct_'+n).click();
                        });
                        $('#txtSpec_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtSpec_', '');
                            $('#btnSpec_'+n).click();
                        });
                    	$('#txtMount_'+i).change(function(e){
                    		sum();
                    	});
                    	
                    }
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date()).focus();
                var t_memo = '1.本公司僅接受自出貨日後3個月內之客訴，交易如有爭議涉訟時，雙方同意以台灣桃園地方法院為第一審管轄法院。';
				t_memo += '\n2.雙方同意依合約簽訂交期後20天內出貨。(如因非本公司因素之不可抗力造成延誤，不在此限。)';			
                $('#txtMemo').val(t_memo);
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                if ($('#txtCustno').val().length>0) {
					var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
					q_gt('custaddr', t_where, 0, 0, 0, "");
				}else{
					document.all.combAddr.options.length = 0;
				}
            }

            function btnPrint() {
				q_box("z_quat_rkp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'quat_rk', "95%", "95%", m_print);
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['product']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (t_para) {
                    $('#txtDatea').datepicker('destroy');
                    $('#txtOdate').datepicker('destroy');
                    $('#btnOrde').attr('disabled','disabled');
                    $('#combPaytype').attr('disabled','disabled');
                    $('#combAddr').attr('disabled','disabled');
                } else {	
                    $('#txtDatea').datepicker();
                    $('#txtOdate').datepicker();
                    $('#btnOrde').removeAttr('disabled');
                    $('#combPaytype').removeAttr('disabled');
                    $('#combAddr').removeAttr('disabled');
                }
                if(q_cur==1){
                	$('#txtNoa').removeAttr('readonly').css('color','black').css('background-color','white');
                }else{
                	$('#txtNoa').attr('readonly','readonly').css('color','green').css('background-color','rgb(237,237,237)');
                }
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
                width: 350px;
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
                width: 900px;
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
            .dbbs {
                width: 1250px;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                /*background: #cad3ff;*/
                background: lightgrey;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
            .dbbs .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            #dbbt {
                width: 1250px;
            }
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }
            #InterestWindows {
                display: none;
                width: 20%;
                background-color: #cad3ff;
                border: 5px solid gray;
                position: absolute;
                z-index: 50;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:visible;width:1400px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview"  >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td style="width:200px; color:black;"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='comp'>~comp</td>
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
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">合約編號</a></td>
						<td><input id="txtNoa"  type="text" class="txt c1" maxlength="20"/></td>
						<td><span> </span><a class="lbl">日期</a></td>
						<td><input id="txtDatea"  type="text" class="txt c1"/></td>
				
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"></a></td>
						<td colspan="2">
							<input id="txtCustno"  type="text" class="txt" style="width:30%;" maxlength="20"/>
							<input id="txtComp"  type="text" class="txt" style="width:70%;" maxlength="50"/>
							<input id="txtNick"  type="text" class="txt" style="display:none;" maxlength="20"/>
						</td>
						<td><span> </span><a id="lblSerial" class="lbl"></a></td>
						<td><input id="txtSerial"  type="text" class="txt c1" maxlength="20"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">代表人</a></td>
						<td colspan="2"><input id="txtBoss"  type="text" class="txt c1" maxlength="20"/></td>
						<td><span> </span><a class="lbl">連絡人</a></td>
						<td colspan="2"><input id="txtConn"  type="text" class="txt c1" maxlength="20"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">電話</a></td>
						<td colspan="2"><input id="txtTel"  type="text" class="txt c1" maxlength="20"/></td>
						<td><span> </span><a class="lbl">傳真</a></td>
						<td colspan="2"><input id="txtFax"  type="text" class="txt c1" maxlength="20"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">交貨日期</a></td>
						<td><input id="txtOdate"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">付款方式</a></td>
						<td>
							<input id="txtPaytype" type="text" class="txt" style="float:left;width: 80%;" maxlength="20"/>
							<select id="combPaytype" style="float:left;width:20px;"></select>							
						</td>
						<td><span> </span><a class="lbl">付款備註</a></td>
						<td colspan="3"><input id="txtMemo2"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">包裝方式</a></td>
						<td><input id="txtPacktype"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">交貨方式</a></td>
						<td style="color:black;"><input type="checkbox" id="chkChka1">賣方運送</td>
						<td style="color:black;"><input type="checkbox" id="chkChka2">買方自運</td>
						<td style="color:black;"><input type="checkbox" id="chkChka3">可分批交運</td>
						<td style="color:black;"><input type="checkbox" id="chkChka4">不可分批交運</td>
					</tr>
					<tr>
						<td></td>
						<td  style="color:black;" colspan="2"><input type="checkbox" id="chkChka5">出貨數量若不足五噸，另需負擔運費</td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">交貨地點</a></td>
						<td colspan="5">
							<input id="txtAddr"  type="text" class="txt" maxlength="50" style="float:left;width:97%;"/>
							<input id="txtAddr2"  type="text" style="display:none;"/>
							<select id="combAddr" style="float:left;width:3%;"> </select>
						</td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">交貨公差</a></td>
						<td><input id="txtTolerance"  type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td><input id="txtFloata" type="text" class="txt num c1" /></td>
						<td>
							<span style="float:left;display:block;width:10px;"></span>
							<select id="cmbCoin" style="float:left;width:80px;" onchange='coin_chg()'></select>
						</td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">材料類別</a></td>
						<td style="color:black;"><span style="display: block;width:20px;float:left;">A.</span><input type="checkbox" style="float:left;" id="chkChkb1">一般流通品</td>
					</tr>
					<tr>
						<td> </td>
						<td style="color:black;"><span style="display: block;width:20px;float:left;">B.</span><input type="checkbox" style="float:left;" id="chkChkb2">買方專用材料</td>
					</tr>
					<tr>
						<td> </td>
						<td style="color:black;"><span style="display: block;width:20px;float:left;"></span><input type="checkbox" style="float:left;" id="chkChkb3">特製皮膜</td>
						<td style="color:black;" colspan="4"><input type="checkbox" id="chkChkb4">特殊規格鋼捲，於合約完成後半年內未出貨完畢，買方需購回剩餘原材料。</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="5"><textarea id="txtMemo" rows="5" class="txt c1"></textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"></a></td>
						<td><input id="txtWorker" type="text" class="txt c1" maxlength="20"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"></a></td>
						<td><input id="txtWorker2" type="text" class="txt c1" maxlength="20"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs signup'>
				<tr style='color:white; background:#003366;' >
					<td style="width:20px;">
						<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
					</td>
					<td style="width:20px;"></td>
					<td style="width:200px;">品名</td>
					<td style="width:60px;">厚</td>
					<td style="width:60px;">皮膜厚</td>
					<td style="width:60px;">寬</td>
					<td style="width:60px;">長</td>
					<td style="width:160px;">皮膜</td>
					<td style="width:60px;">背面<BR>處理</td>
					<td style="width:100px;">保護膜</td>
					<td style="width:60px;">單位</td>
					<td style="width:80px;">數量</td>
					<td style="width:80px;">重量</td>
					<td style="width:80px;">單價</td>
					<td style="width:120px;display:none;">P/O</td>
					<td style="width:120px;display:none;">P/N</td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input id="txtNo3.*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="txtProductno.*" type="text" style="width:45%"/>
						<input id="txtProduct.*" type="text" style="width:45%"/>
						<input id="btnProduct.*" type="button" style="display:none;"/>
					</td>
					<td><input id="txtDime.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtRadius.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWidth.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtLengthb.*" type="text" class="txt c1 num"/></td>

					<td>
						<input id="txtSpec.*" type="text" style="width:45%"/>
						<input id="txtClass.*" type="text" style="width:45%"/>
						<input id="btnSpec.*" type="button" style="display:none;"/>
					</td>
					<td><input id="txtUcolor.*" type="text" class="txt c1"/></td>
					<td><input id="txtSource.*" type="text" class="txt c1"/></td>
					
					<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
					<td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWeight.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtPrice.*" type="text" class="txt c1 num"/></td>
					<td style="display:none;"><input id="txtPo.*" type="text" class="txt c1"/></td>
					<td style="display:none;"><input id="txtPn.*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>

		<input id="q_sys" type="hidden" />
	</body>
</html>
