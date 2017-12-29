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
            var q_readonly = ['txtNoa','txtPrice1','txtPrice2','txtPrice3','txtPrice4','txtPrice5','txtPrice6','txtPrice7','txtPrice8'];
            var q_readonlys = [];
            var bbmNum = [['txtPrice1',15,2,1],['txtPrice2',15,2,1],['txtPrice3',15,2,1],['txtPrice4',15,2,1]
            	,['txtPrice5',15,2,1],['txtPrice6',15,2,1],['txtPrice7',15,2,1],['txtPrice8',15,2,1]];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Noa';
            aPop = new Array(
				['txtProductno_', 'btnProduct_', 'chgitem', 'noa,item', 'txtProductno_,txtProduct_', 'chgitem_b.aspx']);
			var t_mech = '';
			function sum() {
				var price1=0,price2=0,price3=0,price4=0,price5=0,price6=0,price7=0,price8=0;
				for(var i=0;i<q_bbsCount;i++){
					price1 = q_add(price1,q_float('txtPrice1_'+i));
					price2 = q_add(price2,q_float('txtPrice2_'+i));
					price3 = q_add(price3,q_float('txtPrice3_'+i));
					price4 = q_add(price4,q_float('txtPrice4_'+i));
					price5 = q_add(price5,q_float('txtPrice5_'+i));
					price6 = q_add(price6,q_float('txtPrice6_'+i));
					price7 = q_add(price7,q_float('txtPrice7_'+i));
					price8 = q_add(price8,q_float('txtPrice8_'+i));
				}
				$('#txtPrice1').val(price1);
				$('#txtPrice2').val(price2);
				$('#txtPrice3').val(price3);
				$('#txtPrice4').val(price4);
				$('#txtPrice5').val(price5);
				$('#txtPrice6').val(price6);
				$('#txtPrice7').val(price7);
				$('#txtPrice8').val(price8);
			}
            
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
					if ($('#btnMinus_' + i).hasClass('isAssign'))
						continue;
					$('#txtPrice1_'+i).change(function(e){
						sum();
					});
					$('#txtPrice2_'+i).change(function(e){
						sum();
					});
					$('#txtPrice3_'+i).change(function(e){
						sum();
					});
					$('#txtPrice4_'+i).change(function(e){
						sum();
					});
					$('#txtPrice5_'+i).change(function(e){
						sum();
					});
					$('#txtPrice6_'+i).change(function(e){
						sum();
					});
					$('#txtPrice7_'+i).change(function(e){
						sum();
					});
					$('#txtPrice8_'+i).change(function(e){
						sum();
					});
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
            		var t_price1 = $.trim(as['price1']);
            		var t_price2 = $.trim(as['price2']);
            		var t_price3 = $.trim(as['price3']);
            		var t_price4 = $.trim(as['price4']);
            		var t_price5 = $.trim(as['price5']);
            		var t_price6 = $.trim(as['price6']);
            		var t_price7 = $.trim(as['price7']);
            		var t_price8 = $.trim(as['price8']);
            		
            		t_price1 = t_price1.replace(',','');
            		t_price2 = t_price2.replace(',','');
            		t_price3 = t_price3.replace(',','');
            		t_price4 = t_price4.replace(',','');
            		t_price5 = t_price5.replace(',','');
            		t_price6 = t_price6.replace(',','');
            		t_price7 = t_price7.replace(',','');
            		t_price8 = t_price8.replace(',','');
            		t_price1 = t_price1.length==0?0:parseFloat(t_price1);
            		t_price2 = t_price2.length==0?0:parseFloat(t_price2);
            		t_price3 = t_price3.length==0?0:parseFloat(t_price3);
            		t_price4 = t_price4.length==0?0:parseFloat(t_price4);
            		t_price5 = t_price5.length==0?0:parseFloat(t_price5);
            		t_price6 = t_price6.length==0?0:parseFloat(t_price6);
            		t_price7 = t_price7.length==0?0:parseFloat(t_price7);
            		t_price8 = t_price8.length==0?0:parseFloat(t_price8);
            		
            		if(as['makeno'].length>0 || t_price1!=0 || t_price2!=0 || t_price3!=0 || t_price4!=0
        				|| t_price5!=0 || t_price6!=0 || t_price7!=0 || t_price8!=0)
            			chkNum = true;
            	}catch(e){
            		
            	}
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
				width: 1800px;
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
			.dbbs {}
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
		<div>
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:100px; color:black;"><a id='vewMon'> </a></td>
						<td style="width:80px; color:black;"><a>直接人工</a></td>
						<td style="width:80px; color:black;"><a>製造費用</a></td>
						<td style="width:80px; color:black;"><a>電費</a></td>
						<td style="width:80px; color:black;"><a>瓦斯費</a></td>
						<td style="width:80px; color:black;"><a>直接人工</a></td>
						<td style="width:80px; color:black;"><a>製造費用</a></td>
						<td style="width:80px; color:black;"><a>電費</a></td>
						<td style="width:80px; color:black;"><a>瓦斯費</a></td>	
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='mon' style="text-align: center;">~mon</td>
						<td id='price1' style="text-align: center;">~price1</td>
						<td id='price2' style="text-align: center;">~price2</td>
						<td id='price3' style="text-align: center;">~price3</td>
						<td id='price4' style="text-align: center;">~price4</td>
						<td id='price5' style="text-align: center;">~price5</td>
						<td id='price6' style="text-align: center;">~price6</td>
						<td id='price7' style="text-align: center;">~price7</td>
						<td id='price8' style="text-align: center;">~price8</td>
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
		</div>
		<div style="width: 900px;">
			<table>
				<tr style='color:white; background:#003366;' > 				
					<td align="center" colspan="1" rowspan="2" style="width:50px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" colspan="1" rowspan="2" style="width:50px;"><a style="font-weight: bold;text-align: center;display: block;width:95%;"> </a></td>
					<td align="center" colspan="1" rowspan="2" style="width:120px;"><a>製造批號</a></td>
					<td align="center" colspan="4" rowspan="1" style="width:320px;"><a>生產</a></td>
					<td align="center" colspan="4" rowspan="1" style="width:320px;"><a>裁切</a></td>
				</tr>
				<tr style='color:white; background:#003366;' > 	
					<!--  -->
					<!--  -->
					<!-- 製造批號 -->
					<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>直接人工</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>製造費用</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>電費</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>瓦斯費</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>直接人工</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>製造費用</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>電費</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>瓦斯費</a></td>
				</tr>
			</table>
		</div>
		<div class='dbbs' style="width: 900px;">
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;display:none;' >
						<td style="width:50px;"> </td>
						<td style="width:50px;"> </td>
						<td style="width:120px;" align="center">製造批號</td>
						<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>直接人工</a></td>
						<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>製造費用</a></td>
						<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>電費</a></td>
						<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>瓦斯費</a></td>
						<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>直接人工</a></td>
						<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>製造費用</a></td>
						<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>電費</a></td>
						<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>瓦斯費</a></td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td style="width:50px;" align="center">
							<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input id="txtNoq.*" type="text" style="display:none;"/>
						</td>
						<td style="width:50px;"><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td style="width:120px;"><input id="txtMakeno.*" type="text" style="float:left;width:95%;"/> </td>
						<td style="width:80px;"><input id="txtPrice1.*" type="text" class="num" style="float:left;width:95%;"/> </td>
						<td style="width:80px;"><input id="txtPrice2.*" type="text" class="num" style="float:left;width:95%;"/> </td>
						<td style="width:80px;"><input id="txtPrice3.*" type="text" class="num" style="float:left;width:95%;"/> </td>
						<td style="width:80px;"><input id="txtPrice4.*" type="text" class="num" style="float:left;width:95%;"/> </td>
						<td style="width:80px;"><input id="txtPrice5.*" type="text" class="num" style="float:left;width:95%;"/> </td>
						<td style="width:80px;"><input id="txtPrice6.*" type="text" class="num" style="float:left;width:95%;"/> </td>
						<td style="width:80px;"><input id="txtPrice7.*" type="text" class="num" style="float:left;width:95%;"/> </td>
						<td style="width:80px;"><input id="txtPrice8.*" type="text" class="num" style="float:left;width:95%;"/> </td>
					</tr>
				</table>
			</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
