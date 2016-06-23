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
        	//2016/06/22 BBS 批號有值   品名就不可修改
        
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
			brwCount2 = 6;
			aPop = new Array(
				['txtCustno', 'lblCust', 'cust', 'noa,comp,addr_fact', 'txtCustno,txtComp,txtAddr', 'cust_b.aspx'],
				//['txtPost', 'lblPost', 'addr', 'post,addr', 'txtPost', 'addr_b.aspx'],
				['txtStationno', 'lblStore', 'store', 'noa,store', '0txtStationno,txtStation', 'store_b.aspx'],
				['txtUno_', 'btnUno_', 'view_uccc', 'uno,productno,product,spec,unit', '0txtUno_,txtProductno_,txtProduct_,cmbSpec_,txtUnit_', 'uccc_seek_b.aspx?;;;1=0', '95%', '60%'],
				['txtProductno_', 'btnProduct_', 'ucaucc', 'noa,product,unit', '0txtProductno_,txtProduct_,txtUnit_', 'ucaucc_b.aspx'],
				['txtProductno', 'lblProduct', 'ucaucc', 'noa,product', 'txtProductno,txtProduct', 'ucaucc_b.aspx']
			);
			function sum(){
				if(!(q_cur==1 || q_cur==2))
					return;
				var t_n = $('#cmbTypea').val()=='退料單' ? -1 : 1; 
				var t_weight = 0;
				for(var i=0;i<q_bbsCount;i++){
					$('#txtGmount_'+i).val(t_n*q_float('txtMount_'+i));
					$('#txtGweight_'+i).val(t_n*q_float('txtWeight_'+i));
				}
			}
			
			var t_spec = '';
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt('spec', '', 0, 0, 0, '');
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
				document.title = '領料組合作業';
				bbmMask = [['txtDatea', r_picd], ['txtCucdate', r_picd]];
				q_mask(bbmMask);
				//,退料單  移除,  不然還得增加入庫倉庫&儲位
				q_cmbParse("cmbTypea", '領料單,加寄庫出貨,退料');
				q_cmbParse("cmbSpec", t_spec,'s');
			}
			
			function q_popPost(s1) {
				switch (s1) {
					case 'txtUno_':
						refreshBbs();
						break;
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

			

			function btnOk() {
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				Lock(1, {
					opacity : 0
				});
				
				if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_get') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
			}
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock(1);
				var t_noa = $('#txtNoa').val();
				if(t_noa.length>0){
					q_gt('view_ina', "where=^^noa='" + t_noa + "'^^", 0, 0, 0, "isexist_ina",1);
				}
			}
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'spec':
						var as = _q_appendData("spec", "", true);
						t_spec='';
						for ( i = 0; i < as.length; i++) {
							t_spec+=','+as[i].noa+'@'+as[i].product;
						}
						if(t_spec.length==0) t_spec=' ';
						q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
						break;
					case 'isexist_ina':
						var t_noa = $('#txtNoa').val();
						var as = _q_appendData("view_ina", "", true);
						if(as[0]!=undefined){
							q_func('ina_post.post.post0', r_accy + ',' + t_noa + ',0');
						}else{
							q_func('qtxt.query.post0', 'get_rk.txt,post,'+t_noa+';0;' + r_userno );
						}
						break;
					case 'isexist_ina_delete':
						var t_noa = $('#txtNoa').val();
						var as = _q_appendData("view_ina", "", true);
						if(as[0]!=undefined){
							q_func('ina_post.post.post0_delete', r_accy + ',' + t_noa + ',0');
						}else{
							q_func('qtxt.query.post0_delete', 'get_rk.txt,post,'+t_noa+';0;' + r_userno );
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}
			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'ina_post.post.post0':
						var t_noa = $('#txtNoa').val();
						if(t_noa.length>0){
							q_func('qtxt.query.post0', 'get_rk.txt,post,'+t_noa+';0;' + r_userno );
						}
						break;
					case 'qtxt.query.post0':
						var t_noa = $('#txtNoa').val();
						if(t_noa.length>0){
							q_func('qtxt.query.post1', 'get_rk.txt,post,'+t_noa+';1;' + r_userno );	
						}
						break;
					case 'qtxt.query.post1':
						var t_noa = $('#txtNoa').val();
						var t_idno = $.trim($('#txtIdno').val());
						var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                        	if(as[0].status == 'insert' && as[0].noa == t_noa && t_idno.length==0){
                        		t_idno = as[0].uno;
                        		$('#txtIdno').val(t_idno);
                        	}
                        }
						if(t_noa.length>0 && t_idno.length>0){
							q_func('ina_post.post', r_accy + ',' + t_noa + ',1');
						}
						break;
					case 'ina_post.post.post0_delete':
						var t_noa = $('#txtNoa').val();
						if(t_noa.length>0){
							q_func('qtxt.query.post0_delete', 'get_rk.txt,post,'+t_noa+';0;' + r_userno );
						}
						break;
					case 'qtxt.query.post0_delete':
						_btnOk($('#txtNoa').val(), bbmKey[0], ( bbsHtm ? bbsKey[1] : ''), '', 3);
						break;
				}
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
						$('#txtProductno_' + j).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            $('#btnProduct_'+n).click();
                        });
						$('#txtMount_' + j).change(function() {
							sum();
						});
						$('#txtWeight_' + j).change(function() {
							sum();
							var t_weight = 0;
							for(var i=0;i<q_bbsCount;i++){
								t_weight = q_add(t_weight,q_float('txtWeight_'+i));
							}
							$('#txtWeight').val(t_weight);
						});
						$('#txtPrice_' + j).change(function() {
							sum();
						});
					}
				}
				_bbsAssign();
				refreshBbs();
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
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
				refreshBbs();
			}
			function refreshBbs(){
				if(q_cur==1 || q_cur==2)
					for(var i=0;i<q_bbsCount;i++){
						if($('#txtUno_'+i).val().length>0){
							$('#txtProductno_'+i).attr('disabled','disabled');
							$('#txtProduct_'+i).attr('disabled','disabled');
						}else{
							$('#txtProductno_'+i).removeAttr('disabled','disabled');
							$('#txtProduct_'+i).removeAttr('disabled','disabled');
						}
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
				 if (emp($('#txtNoa').val()))
                    return;

                if (!confirm(mess_dele))
                    return;
                q_cur = 3;

				var t_noa = $('#txtNoa').val();
				//_btnDele();
				if(t_noa.length>0){
					q_gt('view_ina', "where=^^noa='" + t_noa + "'^^", 0, 0, 0, "isexist_ina_delete",1);
				}
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
						<td align="center" style="width:25%"><a id='vewNoa'>單據編號</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
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
                        <td class="tdZ"> </td>
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
						<td><span> </span><a class="lbl" >入庫批號</a></td>
						<td colspan="5">
							<input id="txtIdno" type="text" class="txt" style="float:left;width:35%;"/>
							<span style="float:left;width:3%;"> </span>
							<a id="lblStore" class="lbl" style="float:left;width:5%;">倉庫</a>
							<input id="txtStationno" type="text" class="txt" style="float:left;width:15%;"/>
							<input id="txtStation" type="text" class="txt" style="float:left;width:15%;"/>
							<span style="float:left;width:3%;"> </span>
							<a id="lblPlace" class="lbl" style="float:left;width:5%;">儲位</a>
							<input id="txtRackno" type="text" class="txt" style="float:left;width:17%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblProduct" class="lbl" >產品</a></td>
						<td colspan="3">
							<input id="txtProductno" type="text" class="txt" style="float:left;width:35%;"/>
							<input id="txtProduct" type="text" class="txt" style="float:left;width:65%;"/>
						</td>
						<td><span> </span><a id="lblWeight" class="lbl">重量/M</a></td>
						<td><input id="txtWeight" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCustno" type="text" style="float:left;width:25%;"/>
							<input id="txtComp" type="text" style="float:left;width:75%;"/>
							<input id="txtNick" type="text" style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td colspan="3" >
							<input id="txtAddr" type="text" style="float:left; width:100%;"/>
						</td>
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
					<tr> </tr>
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
					<td align="center" style="width:80px;">數量<BR>重量</td>
					<td align="center" style="display:none;">實際<BR>數量<BR>重量/M</td>
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
					<td><select id="cmbSpec.*" style="width:95%;"> </select></td>
					<td><input class="txt" id="txtUnit.*" type="text"  style="width:95%;"/></td>
					<td>
						<input class="txt num" id="txtMount.*" type="text" style="width:95%;"/>
						<input class="txt num" id="txtWeight.*" type="text" style="width:95%;"/>
						<input id="txtGmount.*" type="text" style="display:none;"/>
						<input id="txtGweight.*" type="text" style="display:none;"/>
					</td>
					<td style="display:none;">
						<input class="txt num" id="txtEweight.*" type="text" style="width:95%;"/>
						<input class="txt num" id="txtMweight.*" type="text" style="width:95%;"/>
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