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
		
			q_tables = 't';
			var toIns = true;
			var q_name = "vcf";
			var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
			var q_readonlys = ['txtNoq'];
			var q_readonlyt = ['txtNoq'];
			var bbmNum = [];
			var bbsNum = [];
			var bbtNum = [];
			var bbmMask = [];
			var bbsMask = [];
			var bbtMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			brwCount2 = 5;
			currentNoa = '';
			aPop = new Array(
				['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', '0txtProductno_,txtProduct_', 'ucc_b.aspx']
            	,['txtUno_', 'btnUno_', 'view_uccc2', 'uno,productno,product,spec,dime,width', '0txtUno_,txtProductno_,txtProduct_,txtSize_,txtDime_,txtWidth_', 'uccc_seek_b2.aspx?;;;1=0', '95%', '95%']);
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				bbtKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function sum() {
				for (var i = 0; i < q_bbsCount; i++) {
				}
			}

			function mainPost() {
				q_getFormat();
				document.title = '生產作業';
				bbmMask = [['txtDatea', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbCustno", '1@皮膜,2@保護膜,3@物料','s');
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
					default:
                    	try{
                    		t_para = JSON.parse(t_name);
                    		if(t_para.action == 'getDensity'){
                    			try{
                					var t_density = 0,t_mount = q_float('txtMount_'+t_para.n);
                    				var as = _q_appendData("ucc", "", true);
			                		if (as[0] != undefined) {
		                				try{
		                					t_density = parseFloat(as[0].density);
			                			}catch(e){
			                				t_density = 0;
			                			}
			                		}
			                		$('#txtWeight_'+t_para.n).val(round(q_mul(t_density,t_mount),0));
		                		}catch(e){
		                			$('#txtWeight_'+t_para.n).val(0);
		                		}
                    		}
                    	}catch(e){
                    		
                    	}
                    	break;
				}
			}

			function q_stPost() {
				if (q_cur == 1 || q_cur == 2){
					q_func('qtxt.query.vcf2cub', 'vcf.txt,vcf2cub,'+$('#txtNoa').val());
				}
				if(q_cur==3){
					q_func('qtxt.query.vcf2cub', 'vcf.txt,vcf2cub,'+currentNoa);
				}
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
					default:
						break;
				}
				b_pop = '';
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
			}

			function btnPrint() {
				q_box("z_vcf_rk.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'vcf_rk', "95%", "95%", m_print);
            }

			function btnOk() {
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					return;
				}
				if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
				sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_vcf') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['uno']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['noa'] = abbm2['noa'];
				return true;
			}
			function bbtSave(as) {
				if (!as['uno']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				/*var rbSelect = -1;
				for(var i=0;i<q_bbsCount;i++){
					if($('#rbNum_'+i).prop('checked')){
						rbSelect = i;
						break;
					}
				}
				if(rbSelect==-1){
					$('#rbNum_'+0).click();
				}*/
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
                    $('#txtDatea').datepicker('destroy');
                } else {	
                    $('#txtDatea').datepicker();
                }
			}
			
			/*function getPosition(element) {
			    var xPosition = 0;
			    var yPosition = 0;
			  
			    while(element) {
			        xPosition += (element.offsetLeft - element.scrollLeft + element.clientLeft);
			        yPosition += (element.offsetTop - element.scrollTop + element.clientTop);
			        element = element.offsetParent;
			    }
			    return { x: xPosition, y: yPosition };
			}*/
			
			
			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
					if ($('#btnMinus_' + i).hasClass('isAssign'))
						continue;
					$('#txtMount_' + i).bind('change', function(e) {
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                		if($('#txtProductno_'+n).val().length>0){
                			t_where = "where=^^ noa='" + trim($('#txtProductno_'+n).val()) + "' ^^";
                			q_gt('ucc', t_where, 0, 0, 0, JSON.stringify({action:"getDensity",n:n}), r_accy);
                		}
                	});
					/*	
					$('#txtUno_' + i).bind('contextmenu', function(e) {
                        e.preventDefault();
                        var n = $(this).attr('id').replace('txtUno_', '');
                        
						if(!(q_cur==1 || q_cur==2))
							return;
						var t_noa = $('#txtNoa').val();
	                	var t_where ='';
	                	q_box("cng_cub_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where+";"+";"+JSON.stringify({cubno:t_noa,n:n,page:'cub_rk'}), "cng_cub_"+n, "95%", "95%", '');
                    });*/
				}
				_bbsAssign();
			}
			function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if ($('#btnMinut__' + i).hasClass('isAssign')) 
                    	continue;
                	/*$('#txtProductno__' + i).bind('contextmenu', function(e) {
                        e.preventDefault();
                        if(!(q_cur==1 || q_cur==2))
							return;
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnProduct__'+n).click();
                    });*/
                    
                }
                _bbtAssign();
            }
			
			function q_appendData(t_Table) {
				return _q_appendData(t_Table);
			}

			function btnSeek() {
				_btnSeek();
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('vcf_rk_s.aspx', q_name + '_s', "500px", "500px", q_getMsg("popSeek"));
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
				currentNoa = $('#txtNoa').val();
				_btnDele();	
			}

			function btnCancel() {
				_btnCancel();
			}

			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
			
			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function btnPlut(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function q_popPost(id) {
				switch (id) {
					default:
						break;
				}
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
				width: 1000px;
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
			#dbbt {
                width: 600px;
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
						<td style="width:80px; color:black;"><a>日期</a></td>
						<td style="width:100px; color:black;"><a>單號</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='noa' style="text-align: center;">~noa</td>
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
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="3"><textarea id='txtMemo' rows="3" class="txt c1"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
			<div class='dbbs'>
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;">
							<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:30px;"> </td>
						<td style="width:80px;" align="center">類型</td>
						<td style="width:150px;" align="center">批號</td>
						<td style="width:250px;" align="center">品名</td>
						<td style="width:80px;" align="center">M</td>
						<td style="width:80px;" align="center">重量</td>
						<td style="width:150px;" align="center">備註</td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td align="center">
							<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input id="txtNoq.*" type="text" style="display:none;"/>
						</td>
						<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td><select id="cmbCustno.*" style="float:left;width:95%;"> </select></td>
						<td><input id="txtUno.*" type="text" style="float:left;width:95%;"/></td>
						<td>
							<input class="txt" id="txtProductno.*" type="text" style="width:40%;float:left;"/>
							<input class="txt" id="txtProduct.*" type="text" style="width:55%;float:left;"/>
							<input id="btnProduct.*" type="button" style="display:none;">
						</td>
						<td><input id="txtMount.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td><input id="txtWeight.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td><input id="txtMemo.*" type="text" style="float:left;width:95%;"/></td>
					</tr>
				</table>
			</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt">
			<table id="tbbt">
				<tbody>
					<tr class="head" style="color:white; background:#003366;">
						<td style="width:20px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"> </td>
						<td style="width:150px; text-align: center;">製造批號</td>
						<td style="width:400px; text-align: center;">備註</td>
					</tr>
					<tr>
						<td>
							<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td><input id="txtUno..*" type="text" style="float:left;width:95%;"/></td>
						<td><input id="txtMemo..*" type="text" style="float:left;width:95%;"/></td>
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>