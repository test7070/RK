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
            var q_readonly = ['txtNoa','txtMoney'];
            var q_readonlys = [];
            var bbmNum = [['txtWages',15,0,1],['txtMakeless',15,0,1],['txtMoney',15,0,1]];
            var bbsNum = [['txtMount', 15, 2, 1],['txtPrice', 15, 2, 1],['txtMoney', 15, 0, 1]];
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
			function sum() {
				var t_money=0;
            	for(var i=0;i<q_bbsCount;i++){
            		t_money = q_add(t_money,q_float('txtMoney_'+i));
            	}    
            	$('#txtMoney').val(t_money);
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
                        t_mech = '';
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
            	
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtMon').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_costa') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }
            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('costa_s.aspx', q_name + '_s', "500px", "300px", q_getMsg("popSeek"));
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
            		var t_mount = $.trim(as['mount']);
            		var t_price = $.trim(as['price']);
            		t_mount = t_mount.replace(',','');
            		t_price = t_price.replace(',','');
            		t_mount = t_mount.length==0?0:parseFloat(t_mount);
            		t_price = t_price.length==0?0:parseFloat(t_price);
            		
            		//console.log(t_mount+'_'+t_price);
            		//console.log(as['mount']+'_'+as['price']);
            		if(t_mount!=0 || t_price!=0)
            			chkNum = true;
            	}catch(e){}
            	
            	
                if (!as['productno'] && !as['product'] && !as['acc1'] && !as['acc2'] && !chkNum) {
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
					<td style="width:80px; color:black;"><a id='vewNoa'> </a></td>
					<td style="width:100px; color:black;"><a id='vewMon'> </a></td>
				</tr>
				<tr>
					<td><input id="chkBrow.*" type="checkbox" style=''/></td>
					<td id='noa' style="text-align: center;">~noa</td>
					<td id='mon' style="text-align: center;">~mon</td>
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
					<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
					<td><input id="txtNoa" type="text" class="txt c1"/></td>
					<td><span> </span><a id="lblMon" class="lbl"> </a></td>
					<td><input id="txtMon" type="text" class="txt c1"/></td>
				</tr>
				<tr>
					<td><span> </span><a id="lblWages" class="lbl">直接人工</a></td>
					<td><input id="txtWages" type="text" class="txt num c1"/> </td>
				</tr>
				<tr>
					<td><span> </span><a id="lblMakeless" class="lbl">製造費用</a></td>
					<td><input id="txtMakeless" type="text" class="txt num c1"/> </td>
				</tr>
				<tr>
					<td><span> </span><a id="lblMoney" class="lbl">變動成本</a></td>
					<td><input id="txtMoney" type="text" class="txt num c1"/> </td>
				</tr>
			</table>
		</div>	
		<div class='dbbs'>
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;">
							<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"> </td>
						<td style="width:150px;" align="center">製造批號</td>
						<td style="width:80px;" align="center">工時比率</td>
						<td style="width:200px;" align="center">品名</td>
						<td style="width:100px;" align="center">變動成本</td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td align="center">
							<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input id="txtNoq.*" type="text" style="display:none;"/>
						</td>
						<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td><input id="txtMakeno.*" type="text" style="float:left;width:95%;"/> </td>
						<td><input id="txtMount.*" type="text" class="num" style="float:left;width:95%;"/> </td>
						<td>
							<input id="txtProductno.*" type="text" style="float:left;width:40%;"/> 
							<input id="txtProduct.*" type="text" style="float:left;width:50%;"/>
							<input id="btnProduct.*" type="button" style="display:none;"/>
						</td>
						<td><input id="txtMoney.*" type="text" class="num" style="float:left;width:95%;"/> </td>
					</tr>
				</table>
			</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
