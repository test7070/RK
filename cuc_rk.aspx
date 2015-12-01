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
            var q_name = "cuc";
            var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtHours', 10, 0, 1], ['txtMount', 10, 0, 1], ['txtWeight', 10, 2, 1]];
            var bbmMask = [];
            var bbsMask = [['txtBtime','99:99'],['txtEtime','99:99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Noa';
            brwCount2 = 4;
            aPop = new Array(['txtMechno', 'lblMechno', 'mech', 'noa,mech', 'txtMechno,txtMech', 'mech_b.aspx']
            , ['txtCustno', 'btnCustno', 'cust', 'noa,comp', 'txtCustno,txtCust', 'cust_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
            });
			function sum() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#txtMins_'+i).val(getMins($('#txtBtime_'+i).val(),$('#txtEtime_'+i).val()));	
				}
			}
			function getMins(btime,etime){
				var mins = 0;
				var patt = /^([0-1][0-9]|[2][0-3]):([0-5][0-9])$/g;
				var bhr = btime.replace(patt,'$1');
				var bmin = btime.replace(patt,'$2');
				var ehr = etime.replace(patt,'$1');
				var emin = etime.replace(patt,'$2');
				
				try{
					bhr = parseInt(bhr);
					bmin = parseInt(bmin);
					ehr = parseInt(ehr);
					emin = parseInt(emin);
				}catch(e){
					bhr=0;
					bmin=0;
					ehr=0;
					emin=0;
				}
				mins = (ehr+(ehr<bhr || (ehr==bhr && emin<bmin)?24:0)-bhr)*60 + (emin-bmin);
				mins = isNumber(mins)?mins:0;
				return mins;
			}
			function isNumber(n) {
			  return !isNaN(parseFloat(n)) && isFinite(n);
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
                document.title = '裁切作業';
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbTypea", '分條作業,十呎裁切,四呎裁切,三呎裁切,二呎裁切');
				
                $('#btnOrde').click(function() {
					if(!(q_cur==1 || q_cur==2))
						return;
					var t_noa = $('#txtNoa').val();
                	var t_where ='';
                	q_box("orde_rk_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where+";"+";"+JSON.stringify({cucno:t_noa,page:'cuc_rk'}), "orde_cuc", "95%", "95%", '');
				});
            }

            function q_popPost(s1) {
                switch(s1) {
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
                	case 'orde_cuc':
                        if (b_ret != null) {
                        	as = b_ret;
                    		q_gridAddRow(bbsHtm, 'tbbs', 'txtOrdeno,txtNo2,txtSpec,txtClass,txtSize'
                        	, as.length, as, 'noa,no2,spec,class,size', '','');             	
                        }else{
                        	Unlock(1);
                        }
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                    default:
						if(b_pop.substring(0,8)=='cng_cuc_'){
							var n = b_pop.replace('cng_cuc_','');
							b_ret = getb_ret();
							if(b_ret != null && b_ret.length>0){
								$('#txtUno_'+n).val(b_ret[0].uno);
								$('#txtWeight_'+n).val(b_ret[0].eweight);
								$('#txtSize_'+n).val(b_ret[0].size);
								$('#txtDime_'+n).val(b_ret[0].dime);
								$('#txtWidth_'+n).val(b_ret[0].width);
							}
						}
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
                    default:
                    	try{
                    		t_para = JSON.parse(t_name);
                    		if(t_para.action == 'importOrde'){
                    			var as = _q_appendData("view_ordes", "", true);
		                		if (as[0] != undefined) {
		                			$('#txtSize_'+t_para.n).val(as[0].dime+'+'+as[0].radius+'*'+as[0].width+'*'+as[0].lengthb);	
		                			$('#txtSpec_'+t_para.n).val(as[0].spec);
		                			$('#txtSize2_'+t_para.n).val(as[0].source);		
		                		}else{
		                			alert('找不到訂單【'+t_para.ordeno+'-'+t_para.no2+'】');
		                		}
                    			sum();
                    		}
                    		
                    	}catch(e){
                    		
                    	}
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
                
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cuc') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('cuc_rk_s.aspx', q_name + '_s', "500px", "500px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	$('#txtBtime_'+i).focusout(function(e){
							sum();							
						});
						$('#txtEtime_'+i).focusout(function(e){
							sum();							
						});
                    	$('#txtOrdeno_'+i).change(function(e){
							var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
							n = parseInt(n);
							ImportOrde(n);
						});
						$('#txtNo2_'+i).change(function(e){
							var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
							n = parseInt(n);
							ImportOrde(n);
						});
                    	$('#txtMount_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtWeight_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtMount1_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtWeight1_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtMount2_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtWeight2_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtMount3_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtWeight3_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtMount4_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtWeight4_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtMount5_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtWeight5_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtUno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtUno_', '');
                            
							if(!(q_cur==1 || q_cur==2))
								return;
							var t_noa = $('#txtNoa').val();
		                	var t_where ='';
		                	q_box("cng_cub_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where+";"+";"+JSON.stringify({cucno:t_noa,n:n,page:'cuc_rk'}), "cng_cuc_"+n, "95%", "95%", '');
                        });
                    }
                }
                _bbsAssign();
                $('.num').each(function() {
					$(this).keyup(function() {
						var tmp=$(this).val();
						tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
						$(this).val(tmp);
					});
				}).focusin(function() {
					$(this).select();
				});
            }
            function ImportOrde(n){
				var t_ordeno = $('#txtOrdeno_'+n).val();
				var t_no2 = $('#txtNo2_'+n).val();
				if(t_ordeno.length>0 && t_no2.length>0){
					var t_where = "where=^^ noa='"+t_ordeno+"' and no2='" + t_no2 + "' ^^";
                	q_gt('view_ordes', t_where, 0, 0, 0, JSON.stringify({action:'importOrde',n:n,ordeno:t_ordeno,no2:t_no2}), r_accy);
				}
			}

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date()).focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {
				q_box("z_cuc_rkp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'cuc_rk', "95%", "95%", m_print);
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['ordeno']) {
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
                    $('#btnOrde').attr('disabled','disabled');
                } else {	
                    $('#txtDatea').datepicker();
                    $('#btnOrde').removeAttr('disabled');
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
                width: 250px;
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
                width: 700px;
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
            .dbbs{width: 1980px;}
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
		<div id='dmain' style="overflow:visible;width: 1200px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview"  >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td style="width:120px; color:black;"><a id='vewTypea'>作業</a></td>
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
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"></a></td>
						<td><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"></a></td>
						<td><input id="txtDatea"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTypea" class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMechno" class="lbl btn"></a></td>
						<td colspan="2">
							<input id="txtMechno"  type="text" class="txt" style="width:30%;"/>
							<input id="txtMech"  type="text" class="txt" style="width:65%;"/>
						</td>
						<td> </td>
						<td><input type="button" id="btnOrde" value="訂單匯入" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="4"><input id="txtMemo"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"></a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"></a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
					<tr></tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table class='tbbs'>
				<tr style='height:1px;' >
					<td style="width:20px;"></td>
					<td style="width:20px;"></td>
					<td style="width:200px;"></td>
					<td style="width:60px;"></td>
					<td style="width:150px;"></td>
					<td style="width:80px;"></td>
					<td style="width:200px;"></td>
					<td style="width:120px;"></td>
					<td style="width:120px;"></td>
					<td style="width:60px;"></td>
					<td style="width:60px;"></td>
					<td style="width:60px;"></td>
					<td style="width:60px;"></td>
					<td style="width:60px;"></td>
					<td style="width:60px;"></td>
					<td style="width:60px;"></td>
					<td style="width:60px;"></td>
					<td style="width:60px;"></td>
					<td style="width:60px;"></td>
					<td style="width:60px;"></td>
					<td style="width:100px;"></td>
					<td style="width:100px;"></td>
					<td style="width:100px;"></td>
					<td style="width:80px;"></td>
				</tr>
				<tr style='color:white; background:#003366;' >
					<td rowspan="2"><input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
					<td rowspan="2">項<BR>次</td>
					<td>訂單號碼</td>
					<td rowspan="2">皮膜<BR>編號</td>
					<td rowspan="2">COIL編號</td>
					<td rowspan="2">半成品<BR>進料<BR>重量(KG)</td>
					<td>SHEET(COIL)</td>
					<td rowspan="2">作業條件</td>
					<td>SHEET(COIL)</td>
					<td colspan="2">進料</td>
					<td colspan="2">裁切</td>
					<td colspan="2">成品</td>
					<td colspan="2">餘料</td>
					<td colspan="2">待修品</td>
					<td rowspan="2">廢料重量<BR>(KG)</td>
					<td rowspan="2">裁剪(包裝)<BR>工時(分)</td>
					<td rowspan="2">開始時間</td>
					<td rowspan="2">結束時間</td>	
					<td rowspan="2">施工工時(分)</td>
				</tr>
				<tr style='color:white; background:#003366;' >
					<td>製造批號</td>
					<td>規格尺寸</td>
					<td>裁剪(分條)尺寸</td>
					<td>數量</td>
					<td>重量</td>
					<td>數量</td>
					<td>重量</td>
					<td>片數</td>
					<td>重量</td>
					<td>片數</td>
					<td>重量</td>
					<td>片數</td>
					<td>重量</td>
				</tr>
			</table>
			<table id="tbbs" class='tbbs'>
				<tr style='height: 1px;' >
					<td style="width:20px;"></td>
					<td style="width:20px;"></td>
					<td style="width:200px;"></td>
					<td style="width:60px;"></td>
					<td style="width:150px;"></td>
					<td style="width:80px;"></td>
					<td style="width:200px;"></td>
					<td style="width:120px;"></td>
					<td style="width:120px;"></td>
					<td style="width:60px;"></td>
					<td style="width:60px;"></td>
					<td style="width:60px;"></td>
					<td style="width:60px;"></td>
					<td style="width:60px;"></td>
					<td style="width:60px;"></td>
					<td style="width:60px;"></td>
					<td style="width:60px;"></td>
					<td style="width:60px;"></td>
					<td style="width:60px;"></td>
					<td style="width:60px;"></td>
					<td style="width:100px;"></td>
					<td style="width:100px;"></td>
					<td style="width:100px;"></td>
					<td style="width:80px;"></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input id="txtNoq.*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="txtOrdeno.*" type="text" style="float:left;width:72%;"/>
						<input id="txtNo2.*" type="text" style="float:left;width:20%;"/>
						<input id="txtCubno.*" type="text" style="float:left;width:95%;"/>
					</td>
					<td><input id="txtSpec.*" type="text" style="float:left;width:95%;"/></td>
					<td><input id="txtUno.*" type="text" style="float:left;width:95%;"/></td>
					<td>
						<input id="txtMount.*" type="text" style="display:none;"/>
						<input id="txtWeight.*" type="text" class="txt num" style="float:left;width:95%;"/>
					</td>
					<td><input id="txtSize.*" type="text" style="float:left;width:95%;"/></td>
					<td><input id="txtMemo.*" type="text" style="float:left;width:95%;"/></td>
					<td>
						<input id="txtSize2.*" type="text" style="float:left;width:95%;"/>
						<input id="txtWidth.*" type="text" class="txt num" style="float:left;width:46%;"/>
						<input id="txtLengthb.*" type="text" class="txt num" style="float:left;width:46%;"/>
					</td>
					<td><input id="txtMount1.*" type="text" class="txt num" style="float:left;width:95%;"/></td>
					<td><input id="txtWeight1.*" type="text" class="txt num" style="float:left;width:95%;"/></td>
					<td><input id="txtMount2.*" type="text" class="txt num" style="float:left;width:95%;"/></td>
					<td><input id="txtWeight2.*" type="text" class="txt num" style="float:left;width:95%;"/></td>
					<td><input id="txtMount3.*" type="text" class="txt num" style="float:left;width:95%;"/></td>
					<td><input id="txtWeight3.*" type="text" class="txt num" style="float:left;width:95%;"/></td>
					<td><input id="txtMount4.*" type="text" class="txt num" style="float:left;width:95%;"/></td>
					<td><input id="txtWeight4.*" type="text" class="txt num" style="float:left;width:95%;"/></td>
					<td><input id="txtMount5.*" type="text" class="txt num" style="float:left;width:95%;"/></td>
					<td><input id="txtWeight5.*" type="text" class="txt num" style="float:left;width:95%;"/></td>
					<td><input id="txtWaste.*" type="text" class="txt num" style="float:left;width:95%;"/></td>
					<td><input id="txtHours.*" type="text" class="txt num" style="float:left;width:95%;"/></td>
					<td><input id="txtBtime.*" type="text" class="txt" style="float:left;width:95%;"/></td>
					<td><input id="txtEtime.*" type="text" class="txt" style="float:left;width:95%;"/></td>
					<td><input id="txtMins.*" type="text" class="txt num" style="float:left;width:95%;"/></td>
				</tr>
			</table>
		</div>

		<input id="q_sys" type="hidden" />
	</body>
</html>
