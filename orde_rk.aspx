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
            var q_name = "orde";
            var q_readonly = ['txtWorker', 'txtWorker2','txtMoney','txtTax','txtTotal','txtQuatno'];
            var q_readonlys = ['txtNo2'];
            var bbmNum = [];
            var bbsNum = [['txtMount', 10, 0, 1], ['txtWeight', 10, 2, 1], ['txtPrice', 15, 3, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_copy=1;
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            brwCount2 = 10;
            q_desc = 1;
            aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp,nick,addr_comp,tel,fax', 'txtCustno,txtComp,txtNick,txtAddr,txtTel,txtFax', 'cust_b.aspx']
            	,['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
            	,['txtScolor_', 'btnScolor_', 'ucc', 'noa,product', 'txtScolor_,txtClass_', 'ucc_b.aspx']
            	,['txtZinc_', 'btnZinc_', 'ucc', 'noa,product', 'txtZinc_,txtSource_', 'ucc_b.aspx']
            	,['txtHard_', 'btnHard_', 'ucc', 'noa,product', 'txtHard_,txtUno_', 'ucc_b.aspx']
            	,['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']);
           	t_spec='',t_adpro='';
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'no2'];
                q_brwCount();
                q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
            });
			function sum(){
				if(!(q_cur==1 || q_cur==2))
					return;
				$('#cmbTaxtype').val((($('#cmbTaxtype').val())?$('#cmbTaxtype').val():'1'));
                $('#txtMoney').attr('readonly', true);
                $('#txtTax').attr('readonly', true);
                $('#txtTotal').attr('readonly', true);
                $('#txtMoney').css('background-color', 'rgb(237,237,238)').css('color', 'green');
                $('#txtTax').css('background-color', 'rgb(237,237,238)').css('color', 'green');
                $('#txtTotal').css('background-color', 'rgb(237,237,238)').css('color', 'green');
                
                
				var t_money = 0,t_tax=0,t_total=0;
				for(var i=0;i<q_bbsCount;i++){
					t_unit = $.trim($('#txtUnit_'+i).val()).toUpperCase();
					t_count = (t_unit.length == 0 || t_unit == 'KG' || t_unit == 'M2' || t_unit == 'M²' || t_unit == 'M' || t_unit == '批' || t_unit == '公斤' || t_unit == '噸' || t_unit == '頓')?q_float('txtWeight_'+i):q_float('txtMount_'+i);
					t_moneys = round(q_mul(q_float('txtPrice_'+i),t_count),0);
					q_tr('txtTotal_'+i,t_moneys,0);
					t_money = q_add(t_money,t_moneys);
				}
				
				//------------------------------------------------------------------------------
				t_taxrate = parseFloat(q_getPara('sys.taxrate')) / 100;
                switch ($('#cmbTaxtype').val()) {
                    case '1':
                        // 應稅
                        t_tax = round(q_mul(t_money,t_taxrate), 0);
                        t_total = q_add(t_money,t_tax);
                        break;
                    case '2':
                        //零稅率
                        t_tax = 0;
                        t_total = q_add(t_money,t_tax);
                        break;
                    case '3':
                        // 內含
                        t_tax = q_sub(t_money,round(q_div(t_money, q_add(1, t_taxrate)), 0));
                        t_total = t_money;
                        t_money = q_sub(t_total,t_tax);
                        break;
                    case '4':
                        // 免稅
                        t_tax = 0;
                        t_total = q_add(t_money,t_tax);
                        break;
                    case '5':
                        // 自定
                        $('#txtTax').attr('readonly', false);
                        $('#txtTax').css('background-color', 'white').css('color', 'black');
                        t_tax = round(q_float('txtTax'), 0);
                        t_total = q_add(t_money,t_tax);
                        break;
                    case '6':
                        // 作廢-清空資料
                        t_money = 0, t_tax = 0, t_total = 0;
                        break;
                    default:
                }
				//---------------------------
				q_tr('txtMoney',t_money,0);
				q_tr('txtTax',t_tax,0);
				q_tr('txtTotal',t_total,0);
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
                document.title = '單筆買賣合約書';
                bbmMask = [['txtDatea', r_picd]];
                bbsMask = [];
                q_mask(bbmMask);
                
                switch(q_getPara('sys.project').toUpperCase()){
					case 'RK':
						var paytype_rk = ",出貨前T/T,出貨時收現金或當日現金票,合約簽訂後3天內T/T50%訂金，尾款於出貨前T/T,月結30天,月結40天";
						q_cmbParse("combPaytype", paytype_rk);
						$('#txtPaytype').change(function(e){
		                	if($('#txtPaytype').val().indexOf('月結')>=0){
		                		if($('#txtMemo2').val().length==0){
		                			$('#txtMemo2').val('每月25日以後出的貨,視同當月之貨款並計算請款,依出貨實際數量計價');
		                		}
		                	}else{
		                		if($('#txtMemo2').val().length==0){
		                			$('#txtMemo2').val('依實際出貨數量計價');
		                		}
		                	}
		                });
		                $("#combPaytype").change(function(e) {
							if (q_cur == 1 || q_cur == 2){
								$('#txtPaytype').val($('#combPaytype').find(":selected").text());
								$(this)[0].selectedIndex=0;
								$('#txtPaytype').change();
							}
						});
		                
						break;
					default:
						q_cmbParse("combPaytype", q_getPara('vcc.paytype'));
						$("#cmbTaxtype").change(function(e) {
		                    sum();
		                });
		                $("#combPaytype").change(function(e) {
							if (q_cur == 1 || q_cur == 2){
								$('#txtPaytype').val($('#combPaytype').find(":selected").text());
								$(this)[0].selectedIndex=0;
							}
						});
						break;
				}
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
				
                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
                q_cmbParse("cmbSpec", t_spec,'s');
                q_cmbParse("cmbCustpro", t_adpro,'s');
                q_cmbParse("cmbStype", q_getPara('orde.stype'));
                
                
				$('#btnQuat').click(function(e){
					if(!(q_cur==1 || q_cur==2))
						return;
					var t_noa = $('#txtNoa').val();
                	var t_custno = $('#txtCustno').val();
                	var t_where ='';
                	q_box("quat_rk_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where+";"+";"+JSON.stringify({ordeno:t_noa,custno:t_custno,page:'orde_rk'}), "quat_orde", "95%", "95%", '');
                });
                var t_where = "where=^^ 1=0 ^^ stop=100";
				q_gt('custaddr', t_where, 0, 0, 0, "");
				$('#txtCustno').change(function() {
					if (!emp($('#txtCustno').val())) {
						var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^ stop=100";
						q_gt('custaddr', t_where, 0, 0, 0, "");
					}
				});
            }
            function distinct(arr1){
                var uniArray = [];
                for(var i=0;i<arr1.length;i++){
                    var val = arr1[i];
                    if($.inArray(val, uniArray)===-1){
                        uniArray.push(val);
                    }
                }
                return uniArray;
            }

            function q_popPost(s1) {
                switch(s1) {
                	case 'txtCustno':
						if (!emp($('#txtCustno').val())) {
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^ stop=100";
							q_gt('custaddr', t_where, 0, 0, 0, "");
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
                	case 'quat_orde':
                        if (b_ret != null) {
                        	as = b_ret;
                    		q_gridAddRow(bbsHtm, 'tbbs', 'txtQuatno,txtNo3,txtProductno,txtProduct,txtDime,txtRadius,txtWidth,txtLengthb,cmbSpec,txtScolor,txtClass,txtUcolor,txtZinc,txtHard,txtSource,txtUno,txtUnit,txtUnit2,txtMount,txtWeight,txtPrice'
                        	, as.length, as, 'noa,no3,productno,product,dime,radius,width,lengthb,spec,scolor,class,ucolor,zinc,hard,source,uno,unit,unit2,emount,eweight,price', '','');
                        	
                        	var t_quatno = $('#txtQuatno_0').length>0?$('#txtQuatno_0').val():'';
                        	q_gt('view_quat', "where=^^ noa='"+t_quatno+"' ^^", 0, 0, 0, JSON.stringify({action:'importQuat'}));
                        }else{
                        	Unlock(1);
                        }
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
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
						q_gt('spec', '', 0, 0, 0, '');
						break;
                	case 'spec':
						var as = _q_appendData("spec", "", true);
						t_spec='';
						for ( i = 0; i < as.length; i++) {
							t_spec+=','+as[i].noa+'@'+as[i].product;
						}
						if(t_spec.length==0) t_spec=' ';
						q_gt('adpro', '', 0, 0, 0, '');
						break;
					case 'adpro':
						var as = _q_appendData("adpro", "", true);
						t_adpro='';
						for ( i = as.length-1; i >=0; i--) {
							t_adpro+=','+as[i].noa+'@'+as[i].product;
						}
						if(t_adpro.length==0) t_adpro=' ';
						q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
						break;
                	case 'getAcomp':
						var as = _q_appendData("acomp", "", true);
						if (as[0] != undefined) {
							$('#txtCno').val(as[0].noa);
							$('#txtAcomp').val(as[0].nick);
						}
						Unlock(1);
						$('#txtNoa').val('AUTO');
						$('#txtDatea').val(q_date());
						$('#txtMon').val(q_date().substring(0, 6));
						$('#txtDatea').focus();
						break;
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
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                    	try{
                    		t_para = JSON.parse(t_name);
                    		if(t_para.action == 'importQuat'){
                    			var as = _q_appendData("view_quat", "", true);
		                		if (as[0] != undefined) {
		                			$('#txtQuatno').val(as[0].noa);	
		                			$('#txtAddr2').val(as[0].addr);	
		                			$('#txtPaytype').val(as[0].paytype);	
		                			$('#txtMemo2').val(as[0].memo2);
		                			$('#txtFax').val(as[0].fax);
		                			$('#txtTel').val(as[0].tel);
		                			$('#txtMemo').val(as[0].memo.replace('chr(10)','\n'));
		                			$('#txtCustno').val(as[0].custno);
		                			$('#txtComp').val(as[0].comp);
		                			$('#txtNick').val(as[0].nick);
		                			$('#cmbCoin').val(as[0].coin);
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
                //共六碼:前二碼西元年,例:2015為15,第三碼為部門別,固定是1,第四碼為月份,10月取A,11月取B,12月取C,後面2碼為當月序號
                var t_noa = trim($('#txtNoa').val());
                var t_date = new Date();
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, (''+t_date.getFullYear()).slice(-2,4)+'1'+('123456789ABC').substring(t_date.getMonth(),t_date.getMonth()+1),6);
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('orde_rk_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
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
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            $('#btnProduct_'+n).click();
                        });
                        $('#txtScolor_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            $('#btnScolor_'+n).click();
                        });
                    	$('#txtMount_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtWeight_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtPrice_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtUnit_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtZinc_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            $('#btnZinc_'+n).click();
                        });
                        $('#txtHard_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            $('#btnHard_'+n).click();
                        });
                    }
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#chkIsproj').prop('checked',true);
                var t_memo = '1.本公司僅接受自出貨日後3個月內之客訴，交易如有爭議涉訟時，雙方同意以台灣桃園地方法院為第一審管轄法院。';
				t_memo += '\n2.雙方同意依合約簽訂交期後20天內出貨。(如因非本公司因素之不可抗力造成延誤，不在此限。)';			
                if(!$('#chekQcopy').prop('checked'))
                	$('#txtMemo').val(t_memo);
                q_gt('acomp', '', 0, 0, 0, 'getAcomp', r_accy);
				var t_where = "where=^^ 1=0 ^^ stop=100";
				q_gt('custaddr', t_where, 0, 0, 0, "");
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {
				q_box("z_orde_rkp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'orde_rk', "95%", "95%", m_print);
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['productno']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['custno'] = abbm2['custno'];
                as['comp'] = abbm2['nick'];
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
                } else {	
                    $('#txtDatea').datepicker();
                    $('#txtOdate').datepicker();
                    $('#btnOrde').removeAttr('disabled');
                    $('#combPaytype').removeAttr('disabled');
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
            function combAddr_chg() {/// 只有 comb 開頭，才需要寫 onChange() ，其餘 cmb 連結資料庫
				if (q_cur == 1 || q_cur == 2) {
					$('#txtAddr2').val($('#combAddr').find("option:selected").text());
					$('#txtPost2').val($('#combAddr').find("option:selected").val());
				}
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
                width: 1200px;
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
                width: 1700px;
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
                width: 1500px;
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
						<td style="width:100px; color:black;"><a id='vewOdate'> </a></td>
						<td style="width:100px; color:black;"><a id='vewNoa'> </a></td>
						<td style="width:100px; color:black;"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='odate'>~odate</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='nick'>~nick</td>
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
						<td><span> </span><a class="lbl">訂單編號</a></td>
						<td><input id="txtNoa"  type="text" class="txt c1" maxlength="20"/></td>
						<td><span> </span><a class="lbl">日期</a></td>
						<td><input id="txtDatea"  type="text" class="txt c1"/></td>
						<td><span> </span><a class="lbl">交貨日期</a></td>
						<td><input id="txtOdate"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"></a></td>
						<td colspan="2">
							<input id="txtCustno"  type="text" class="txt" style="width:30%;" maxlength="20"/>
							<input id="txtComp"  type="text" class="txt" style="width:70%;" maxlength="50"/>
							<input id="txtNick"  type="text" class="txt" style="display:none;" maxlength="20"/>
						</td>
						<td><select id="cmbStype" class="txt c1"> </select></td>
						<td> </td>
						<td align="center">
                            <input id="chkIsproj" type="checkbox"/>
                            <span> </span><a id='lblIsproj'> </a>
                        </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTel" class="lbl"> </a></td>
						<td colspan="2"><input id="txtTel"  type="text" class="txt c1" maxlength="20"/></td>
						<td> </td>
						<td> </td>
						<td align="center">
                            <input id="chkEnda" type="checkbox"/>
                            <span> </span><a id='lblEnda'> </a>
                        </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblFax" class="lbl"></a></td>
						<td colspan="2"><input id="txtFax"  type="text" class="txt c1" maxlength="20"/></td>
						<td><span> </span><a id="lblSales" class="lbl btn">業務</a></td>
						<td colspan="5">
							<input id="txtSalesno"  type="text" class="txt" style="width:45%;"/>
							<input id="txtSales"  type="text" class="txt" style="width:45%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAddr" class="lbl"></a></td>
						<td colspan="5"><input id="txtAddr"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAddr2" class="lbl"></a></td>
						<td colspan="5">
							<input id="txtAddr2"  type="text" class="txt" style="width:95%;"/>
							<select id="combAddr" style="width: 20px" onchange='combAddr_chg()'></select>
						</td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">付款方式</a></td>
						<td>
							<input id="txtPaytype" type="text" class="txt" style="float:left;width: 80%;"/>
							<select id="combPaytype" style="float:left;width:20px;"></select>							
						</td>
						<td><span> </span><a class="lbl">付款備註</a></td>
						<td colspan="3"><input id="txtMemo2"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
                        <td><span> </span><a id='lblMoney' class="lbl"> </a></td>
                        <td><input id="txtMoney" type="text" class="txt num c1" /></td>
                        <td><span> </span><a id='lblTax' class="lbl"> </a></td>
                        <td>
                        	<input id="txtTax" type="text" class="txt num" style="width:50%;"/>
                        	<span style="float:left;display:block;width:3%;"></span>
                        	<select id="cmbTaxtype" style="float:left;width:42%;" > </select>
                        </td>
                        <td><span> </span><a id='lblTotal' class="lbl"> </a></td>
                        <td><input id="txtTotal" type="text" class="txt num c1" /></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td><input id="txtFloata" type="text" class="txt num c1" /></td>
						<td>
							<span style="float:left;display:block;width:10px;"></span>
							<select id="cmbCoin" style="float:left;width:80px;" onchange='coin_chg()'></select>
						</td>
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
						<td align="center"><input id="btnQuat" type="button" value="報價匯入"/></td>
						<td><input id="txtQuatno" type="text" class="txt c1" /></td>
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
					<td style="width:50px;">序</td>
					<td style="width:80px;">類別</td>
					<td style="width:120px;">品名</td>
					<td style="width:60px;">厚</td>
					<td style="width:60px;">皮膜厚</td>
					<td style="width:60px;">寬</td>
					<td style="width:60px;">長</td>
					<td style="width:100px;">規格</td>
					<td style="width:160px;">皮膜</td>
					<td style="width:60px;">背面<BR>處理</td>
					<td style="width:100px;">保護膜(一)<br>編號<BR>名稱</td>
					<td style="width:100px;">保護膜(二)<br>編號<BR>名稱</td>	
					<td style="width:80px;">數量</td>
					<td style="width:80px;">重量/M</td>
					<td style="width:60px;">計量<BR>單位</td>
					<td style="width:80px;">單價</td>
					<td style="width:60px;">計價<BR>單位</td>
					<td style="width:80px;">金額</td>
					<td style="width:200px;">P/O<br>P/N</td>
					<td style="width:40px;">結<br>案</td>
					<td style="width:40px;">取<br>消</td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input id="txtQuatno.*" type="text" style="display: none;"/>
						<input id="txtNo3.*" type="text" style="display: none;"/>
						<input id="txtCustno.*" type="text" style="display: none;"/>
						<input id="txtComp.*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="txtNo2.*" type="text" class="txt c1"/></td>
					<td><select id='cmbCustpro.*' style="width:95%;" class="txt c1"> </select></td>
					<td>
						<input id="txtProductno.*" type="text" style="width:95%"/>
						<input id="txtProduct.*" type="text" style="width:95%"/>
						<input id="btnProduct.*" type="button" style="display:none;"/>
					</td>
					<td><input id="txtDime.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtRadius.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWidth.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtLengthb.*" type="text" class="txt c1 num"/></td>
					<td><select id='cmbSpec.*' style="width:95%;" class="txt c1"> </select></td>
					<td>
						<input id="txtScolor.*" type="text" style="width:95%"/>
						<input id="txtClass.*" type="text" style="width:95%"/>
						<input id="btnScolor.*" type="button" style="display:none;"/>
					</td>
					<td><input id="txtUcolor.*" type="text" class="txt c1"/></td>
					<td>
						<input id="txtZinc.*" type="text" class="txt c1"/>
						<input id="txtSource.*" type="text" class="txt c1"/>
						<input id="btnZinc.*" type="button" style="display:none;"/>
					</td>
					<td>
						<input id="txtHard.*" type="text" class="txt c1"/>
						<input id="txtUno.*" type="text" class="txt c1"/>
						<input id="btnHard.*" type="button" style="display:none;"/>
					</td>
					<td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWeight.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtUnit2.*" type="text" class="txt c1"/></td>
					<td><input id="txtPrice.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
					<td><input id="txtTotal.*" type="text" class="txt c1 num"/></td>
					<td><textarea id="txtMemo.*" rows="2" class="txt c1"> </textarea></td>
					<td><input type="checkbox" id="chkEnda.*"  class="txt c1"/></td>
					<td><input type="checkbox" id="chkCancel.*"  class="txt c1"/></td>
				</tr>
			</table>
		</div>

		<input id="q_sys" type="hidden" />
	</body>
</html>
