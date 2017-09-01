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

            q_desc = 1;
            q_tables = 's';
            var q_name = "costa";
            var q_readonly = ['txtNoa'];
            var q_readonlys = [];
            var bbmNum = [['txtPrice1',15,2,1],['txtPrice2',15,2,1],['txtPrice3',15,2,1],['txtPrice4',15,2,1]
            	,['txtPrice5',15,2,1],['txtPrice6',15,2,1],['txtPrice7',15,2,1],['txtPrice8',15,2,1]];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 3;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Noa';
            aPop = new Array(
				['txtProductno_', 'btnProduct_', 'chgitem', 'noa,item', 'txtProductno_,txtProduct_', 'chgitem_b.aspx']);
			var t_mech = '';
			function sum() {}
            
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt('mech', '', 0, 0, 0, "mech");
                
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
                bbmMask = [['txtMon', r_picm]];
                q_mask(bbmMask);
                q_cmbParse("cmbMechno", t_mech, 's');
            }

            function q_boxClose(s2) {                
            	var ret;
                b_ret = getb_ret();
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'mech':
                        var as = _q_appendData("mech", "", true);
                        t_mech = ' @ ';
                        if(as[0]!=undefined){
                        	for(var i=0;i<as.length;i++){
                        		t_mech += (t_mech.length>0?',':'') + as[i].noa+'@'+as[i].mech;
                        	}	
                        }
                        q_gt(q_name, q_content, q_sqlCount, 1, 0);
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                } 
            }

            function btnOk() {
            	sum();
            	
            	var t_mon = $.trim($('#txtMon').val());
            	if(t_mon.length==0){
            		alert('請輸入月份');
            		return;
            	}
            	$('#txtNoa').val(t_mon);
            	wrServer(t_mon);
            }
            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('costa_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#txtProductno_' + i).bind('contextmenu', function(e) {
                            //滑鼠右鍵/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtProductno_', '');
                            $('#btnProduct_'+n).click();
                        });
                       	$('#txtWages_'+i).change(function(e){sum();});
                        $('#txtMakeless_'+i).change(function(e){sum();});
                        $('#txtMoney_'+i).change(function(e){sum();});
					}
				}
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtMon').val(q_date().substr(0, 6));
                $('#txtMon').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                sum();
            }

            function btnPrint() {
                q_box('z_costap.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
            	var chkNum = false;
            	try{
            		var t_wages = $.trim(as['wages']);
            		var t_makeless = $.trim(as['makeless']);
            		var t_money = $.trim(as['money']);
            		t_wages = t_wages.replace(',','');
            		t_makeless = t_makeless.replace(',','');
            		t_money = t_money.replace(',','');
            		
            		t_wages = t_wages.length==0?0:parseFloat(t_wages);
            		t_makeless = t_makeless.length==0?0:parseFloat(t_makeless);
            		t_money = t_money.length==0?0:parseFloat(t_money);
            		
            		if(t_wages!=0 || t_makeless!=0 || t_money!=0)
            			chkNum = true;
            	}catch(e){}
            	           	
                if (!chkNum) {
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
				/*overflow: hidden;*/
			}
			.dview {
				float: left;
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
				width: 600px;
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
				color: black;
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
				width: 95%;
				float: left;
			}
			.num {
				text-align: right;
			}
			.tbbm td {
				margin: 0 -1px;
				padding: 0;
			}
			.tbbm select {
				font-size: medium;
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
				width: 800px;
			}
			.dbbs .tbbs {
				margin: 0;
				padding: 2px;
				border: 2px lightgrey double;
				border-spacing: 1;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: lightgrey;
				width: 100%;
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
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div class="dview" id="dview" >
			<table class="tview" id="tview" >
				<tr>
					<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
					<td style="width:100px; color:black;"><a id='vewMon'> </a></td>
					<td style="width:100px; color:black;"><a>直接人工</a></td>
					<td style="width:100px; color:black;"><a>製造費用</a></td>
				</tr>
				<tr>
					<td><input id="chkBrow.*" type="checkbox" style=''/></td>
					<td id='mon' style="text-align: center;">~mon</td>
					<td id='wages' style="text-align: center;">~wages</td>
					<td id='makeless' style="text-align: center;">~makeless</td>
				</tr>
			</table>
		</div>
		<div class='dbbm'>
			<table class="tbbm" id="tbbm">
				<tr style="height:1px;">
					<td> </td>
					<td> </td>
					<td> </td>
					<td> </td>
					<td class="tdZ"> </td>
				</tr>
				<tr>
					<td><span> </span><a id="lblMon" class="lbl"> </a></td>
					<td><input id="txtMon" type="text" class="txt c1"/></td>
					<td style="display:none;"><span> </span><a id="lblNoa" class="lbl"> </a></td>
					<td style="display:none;"><input id="txtNoa" type="text" class="txt c1"/></td>
				</tr>
				<!--<tr>
					<td><span> </span><a id="lblWages" class="lbl">直接人工</a></td>
					<td><input id="txtWages" type="text" class="txt num c1"/> </td>
				</tr>-->
				<!--<tr>
					<td><span> </span><a id="lblMakeless" class="lbl">製造費用</a></td>
					<td><input id="txtMakeless" type="text" class="txt num c1"/> </td>
				</tr>-->
				<tr>
					<td> </td>
					<td><span> </span><a style="color:black;">生產</a></td>
					<td> </td>
					<td><span> </span><a style="color:black;">裁切</a></td>
				</tr>
				<tr>
					<td><span> </span><a id="lblPrice1" class="lbl">直接人工</a></td>
					<td><input id="txtPrice1" type="text" class="txt num c1"/> </td>
					<td><span> </span><a id="lblPrice5" class="lbl">直接人工</a></td>
					<td><input id="txtPrice5" type="text" class="txt num c1"/> </td>
				</tr>
				<tr>
					<td><span> </span><a id="lblPrice2" class="lbl">製造費用</a></td>
					<td><input id="txtPrice2" type="text" class="txt num c1"/> </td>
					<td><span> </span><a id="lblPrice6" class="lbl">製造費用</a></td>
					<td><input id="txtPrice6" type="text" class="txt num c1"/> </td>
				</tr>
				<tr>
					<td><span> </span><a id="lblPrice3" class="lbl">電費</a></td>
					<td><input id="txtPrice3" type="text" class="txt num c1"/> </td>
					<td><span> </span><a id="lblPrice7" class="lbl">電費</a></td>
					<td><input id="txtPrice7" type="text" class="txt num c1"/> </td>
				</tr>
				<tr>
					<td><span> </span><a id="lblPrice4" class="lbl">瓦斯費</a></td>
					<td><input id="txtPrice4" type="text" class="txt num c1"/> </td>
					<td><span> </span><a id="lblPrice8" class="lbl">瓦斯費</a></td>
					<td><input id="txtPrice8" type="text" class="txt num c1"/> </td>
				</tr>
				<tr>
					<td><span> </span><a id="lblMemo" class="lbl">備註</a></td>
					<td colspan="3"><textarea id="txtMemo" rows="5" class="txt c1"> </textarea></td>
				</tr>
			</table>
		</div>	
		<!-- 2017/07/20 先暫時不用BBS -->
		<div class='dbbs' style="display:none;">
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;">
							<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"> </td>
						<td style="width:150px;display:none;" align="center">製造批號</td>
						<td style="width:80px;display:none;" align="center">工時比率</td>
						<td style="width:200px;display:none;" align="center">品名</td>
						<td style="width:100px;" align="center">工作站</td>
						<td style="width:100px;" align="center">直接人工</td>
						<td style="width:100px;" align="center">製造費用</td>
						<td style="width:100px;" align="center">變動成本</td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td align="center">
							<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input id="txtNoq.*" type="text" style="display:none;"/>
						</td>
						<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td style="display:none;"><input id="txtMakeno.*" type="text" style="float:left;width:95%;"/> </td>
						<td style="display:none;"><input id="txtMount.*" type="text" class="num" style="float:left;width:95%;"/> </td>
						<td style="display:none;">
							<input id="txtProductno.*" type="text" style="float:left;width:40%;"/> 
							<input id="txtProduct.*" type="text" style="float:left;width:50%;"/>
							<input id="btnProduct.*" type="button" style="display:none;"/>
						</td>
						<td><select id='cmbMechno.*' style="float:left;width:95%;"> </select></td>
						<td><input id="txtWages.*" type="text" class="num" style="float:left;width:95%;"/> </td>
						<td><input id="txtMakeless.*" type="text" class="num" style="float:left;width:95%;"/> </td>
						<td><input id="txtMoney.*" type="text" class="num" style="float:left;width:95%;"/> </td>
					</tr>
				</table>
			</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
