<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
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
			q_desc = 1;
			q_tables = 's';
			var q_name = "vcc";
			var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2'];
			var q_readonlys = [];
			var bbmNum = [];
			var bbsNum = [['txtMount', 10, 0, 1], ['txtWeight', 10, 2, 1]];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			//ajaxPath = "";
			aPop = new Array(
				['txtCustno', 'lblCust', 'cust', 'noa,comp,nick,tel,zip_fact,addr_fact,paytype', 'txtCustno,txtComp,txtNick,txtTel,txtPost,txtAddr,txtPaytype', 'cust_b.aspx']
				,['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']
				,['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
				,['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
            	,['txtSpec_', 'btnSpec_', 'spec', 'noa,product', 'txtSpec_,txtClass_', 'spec_b.aspx']
            	,['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx']
			);
			brwCount2 = 12;
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

			var t_spec;
			function sum() {
				if (!(q_cur == 1 || q_cur == 2))
					return;
				$('#cmbTaxtype').val((($('#cmbTaxtype').val()) ? $('#cmbTaxtype').val() : '1'));
				$('#txtMoney').attr('readonly', true);
				$('#txtTax').attr('readonly', true);
				$('#txtTotal').attr('readonly', true);
				$('#txtMoney').css('background-color', 'rgb(237,237,238)').css('color', 'green');
				$('#txtTax').css('background-color', 'rgb(237,237,238)').css('color', 'green');
				$('#txtTotal').css('background-color', 'rgb(237,237,238)').css('color', 'green');

				var t_mount = 0, t_price = 0, t_money = 0, t_moneyus = 0, t_weight = 0, t_total = 0, t_tax = 0;
				var t_mounts = 0, t_prices = 0, t_moneys = 0, t_weights = 0;
				var t_unit = '';
				var t_float = q_float('txtFloata');
				var t_tranmoney = dec($('#txtTranmoney').val());
				for (var j = 0; j < q_bbsCount; j++) {
					t_unit = $.trim($('#txtUnit_' + j).val()).toUpperCase();
					t_product = $.trim($('#txtProduct_' + j).val());
					if (t_unit.length == 0 && t_product.length > 0) {
						if (t_product.indexOf('管') > 0)
							t_unit = '支';
						else
							t_unit = 'KG';
						$('#txtUnit_' + j).val(t_unit);
					}
					t_weights = q_float('txtWeight_' + j);
					t_prices = q_float('txtPrice_' + j);
					t_mounts = q_float('txtMount_' + j);
					if (t_unit.length == 0 || t_unit == 'KG' || t_unit == 'M2' || t_unit == 'M' || t_unit == '批' || t_unit == '公斤' || t_unit == '噸' || t_unit == '頓') {
						t_moneys = q_mul(t_prices, t_weights);
					} else {
						t_moneys = q_mul(t_prices, t_mounts);
					}
					if (t_float == 0) {
						t_moneys = round(t_moneys, 0);
					} else {
						t_moneyus = q_add(t_moneyus, round(t_moneys, 2));
						t_moneys = round(q_mul(t_moneys, t_float), 0);
					}
					var t_styles = $.trim($('#txtStyle_' + j).val());
					var t_unos = $.trim($('#txtUno_' + j).val());
					var t_dimes = $.trim($('#txtDime_' + j).val());
					if (!(t_styles == '' && t_unos == '' && t_dimes == 0))
						t_weight = q_add(t_weight, t_weights);
					t_mount = q_add(t_mount, t_mounts);
					t_money = q_add(t_money, t_moneys);
					$('#txtTotal_' + j).val(t_moneys);
				}
				t_total = t_money;
				t_tax = 0;
				t_taxrate = parseFloat(q_getPara('sys.taxrate')) / 100;
				switch ($('#cmbTaxtype').val()) {
					case '1':
						// 應稅
						t_tax = round(q_mul(t_money, t_taxrate), 0);
						t_total = q_add(t_money, t_tax);
						break;
					case '2':
						//零稅率
						t_tax = 0;
						t_total = q_add(t_money, t_tax);
						break;
					case '3':
						// 內含
						t_tax = q_sub(t_money, round(q_div(t_money, q_add(1, t_taxrate)), 0));
						t_total = t_money;
						t_money = q_sub(t_total, t_tax);
						break;
					case '4':
						// 免稅
						t_tax = 0;
						t_total = q_add(t_money, t_tax);
						break;
					case '5':
						// 自定
						$('#txtTax').attr('readonly', false);
						$('#txtTax').css('background-color', 'white').css('color', 'black');
						t_tax = round(q_float('txtTax'), 0);
						t_total = q_add(t_money, t_tax);
						break;
					case '6':
						// 作廢-清空資料
						t_money = 0, t_tax = 0, t_total = 0;
						break;
					default:
				}
				t_price = q_float('txtPrice');
				if (t_price != 0) {
					$('#txtTranmoney').val(round(q_mul(t_weight, t_price), 0));
				}
				$('#txtWeight').val(t_weight);
				$('#txtMoney').val(t_money);
				$('#txtTax').val(t_tax);
				$('#txtTotal').val(t_total);
				if (t_float == 0)
					$('#txtTotalus').val(0);
				else
					$('#txtTotalus').val(t_moneyus);
			}

			function mainPost() {// 載入資料完，未 refresh 前
				q_getFormat();
				document.title = '交運作業';
				bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", q_getPara('vcc.typea'));
				q_cmbParse("cmbStype", q_getPara('vccst.stype'));
				q_cmbParse("combPaytype", q_getPara('rc2.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
				q_cmbParse("cmbKind", q_getPara('sys.stktype'));
				//=======================================================
				//限制帳款月份的輸入 只有在備註的第一個字為*才能手動輸入
				$('#txtMemo').change(function() {
					if ($('#txtMemo').val().substr(0, 1) == '*')
						$('#txtMon').removeAttr('readonly');
					else
						$('#txtMon').attr('readonly', 'readonly');
				});
				$('#txtMon').click(function() {
					if ($('#txtMon').attr("readonly") == "readonly" && (q_cur == 1 || q_cur == 2))
						q_msg($('#txtMon'), "月份要另外設定，請在" + q_getMsg('lblMemo') + "的第一個字打'*'字");
				});

				$("#cmbTypea").focus(function() {
					var len = $(this).children().length > 0 ? $(this).children().length : 1;
					$(this).attr('size', len + "");
				}).blur(function() {
					$(this).attr('size', '1');
				});
				$("#cmbKind").focus(function() {
					var len = $(this).children().length > 0 ? $(this).children().length : 1;
					$(this).attr('size', len + "");
				}).blur(function() {
					$(this).attr('size', '1');
				}).click(function(e) {
					sum();
				});
				$("#cmbTaxtype").change(function(e) {
					sum();
				});
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
				//=====================================================================
				/* 若非本會計年度則無法存檔 */
				$('#txtDatea').focusout(function() {
					if ($(this).val().substr(0, 3) != r_accy) {
						$('#btnOk').attr('disabled', 'disabled');
						alert(q_getMsg('lblDatea') + '非本會計年度。');
					} else {
						$('#btnOk').removeAttr('disabled');
					}
				});
				$('#btnVcceImport').click(function() {
					var t_ordeno = $('#txtOrdeno').val();
					var t_custno = $('#txtCustno').val();
					var t_where = '1=1 ';
					t_where += q_sqlPara2('ordeno', t_ordeno) + q_sqlPara2('custno', t_custno) + " and ((len(gmemo)=0) or gmemo='cubu') and kind='" + $('#cmbKind').val() + "'";
					q_box("vcce_import_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy, 'view_vcce_import', "95%", "95%", q_getMsg('popVcceImport'));
				});
				$('#btnOrdeno').click(function() {
					if(!(q_cur==1 || q_cur==2))
						return;
					var t_noa = $('#txtNoa').val();
                	var t_custno = $('#txtCustno').val();
                	var t_where ='';
                	q_box("orde_rk_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where+";"+";"+JSON.stringify({vccno:t_noa,custno:t_custno,page:'vcc_rk'}), "orde_vcc", "95%", "95%", '');
				});
				$('#btnCut').click(function() {
					if(!(q_cur==1 || q_cur==2))
						return;
					var t_noa = $('#txtNoa').val();
                	var t_custno = $('#txtCustno').val();
                	var t_where ='';
                	q_box("cut_rk_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where+";"+";"+JSON.stringify({vccno:t_noa,custno:t_custno,page:'vcc_rk'}), "cut_vcc", "95%", "95%", '');
				});
				$('#lblAccno').click(function() {
					q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('btnAccc'), true);
				});
				$('#txtFloata').change(function() {
					sum();
				});
				$('#txtTax').change(function() {
					sum();
				});
				$('#txtPrice').change(function() {
					sum();
				});

				$('#txtAddr').change(function() {
					var t_custno = trim($(this).val());
					if (!emp(t_custno)) {
						focus_addr = $(this).attr('id');
						var t_where = "where=^^ noa='" + t_custno + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "");
					}
				});

				$('#txtAddr2').change(function() {
					var t_custno = trim($(this).val());
					if (!emp(t_custno)) {
						focus_addr = $(this).attr('id');
						var t_where = "where=^^ noa='" + t_custno + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "");
					}
				});

				$('#txtCustno').change(function() {
					if (!emp($('#txtCustno').val())) {
						var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
						q_gt('custaddr', t_where, 0, 0, 0, "");
					}
				});
				$('#lblInvono').click(function() {
					if ($('#txtInvono').val().length > 0)
						q_pop('txtInvono', "vcca.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtInvono').val() + "';" + r_accy, 'vcca', 'noa', 'datea', "95%", "95%px", q_getMsg('lblInvono'), true);
				});
			}

			function q_boxClose(s2) {/// q_boxClose 2/4
				var ret;
				switch (b_pop) {
					case 'orde_vcc':
                        if (b_ret != null) {
                        	as = b_ret;
                    		q_gridAddRow(bbsHtm, 'tbbs', 'txtOrdeno,txtNo2,txtProductno,txtProduct,txtDime,txtRadius,txtWidth,txtLengthb,txtSpec,txtClass,txtUcolor,txtRackno,txtUnit,txtPrice'
                        	, as.length, as, 'noa,no2,productno,product,dime,radius,width,lengthb,spec,class,ucolor,source,unit,price', '','');             	
                        	//訂單資料
                        	var t_ordeno = $('#txtOrdeno_0').length>0?$('#txtOrdeno_0').val():'';
                    		q_gt('view_orde', "where=^^ noa='"+t_ordeno+"' ^^", 0, 0, 0, JSON.stringify({action:'importOrde'}));
                        }else{
                        	Unlock(1);
                        }
                        break;
                    case 'cut_vcc':
                        if (b_ret != null) {
                        	as = b_ret;
                    		q_gridAddRow(bbsHtm, 'tbbs', 'txtOrdeno,txtNo2,txtUno,txtProductno,txtProduct,txtDime,txtRadius,txtWidth,txtLengthb,txtSpec,txtClass,txtUcolor,txtRackno,txtUnit,txtPrice'
                        	, as.length, as, 'noa,no2,uno,productno,product,dime,radius,width,lengthb,spec,class,ucolor,source,unit,price', '','');             	
                        	//訂單資料
                        	var t_ordeno = $('#txtOrdeno_0').length>0?$('#txtOrdeno_0').val():'';
                    		q_gt('view_orde', "where=^^ noa='"+t_ordeno+"' ^^", 0, 0, 0, JSON.stringify({action:'importOrde'}));
                        }else{
                        	Unlock(1);
                        }
                        break;
					case q_name + '_s':
						q_boxClose2(s2);
						/// q_boxClose 3/4
						break;
				}/// end Switch
				b_pop = '';
			}

			function distinct(arr1) {
				var uniArray = [];
				for (var i = 0; i < arr1.length; i++) {
					var val = arr1[i];
					if ($.inArray(val, uniArray) === -1) {
						uniArray.push(val);
					}
				}
				return uniArray;
			}

			function q_gtPost(t_name) {/// 資料下載後 ...
				switch (t_name) {
					case "getAcomp":
						var as = _q_appendData("acomp", "", true);
                		if (as[0] != undefined) {
                			$('#txtCno').val(as[0].noa);	
                			$('#txtAcomp').val(as[0].acomp);	
                		}
                		Unlock(1);
						break;
					case q_name:
						if (q_cur == 4)// 查詢
							q_Seek_gtPost();
						break;
					default:
                    	try{
                    		t_para = JSON.parse(t_name);
                    		if(t_para.action == 'importOrde'){
                    			var as = _q_appendData("view_orde", "", true);
		                		if (as[0] != undefined) {
		                			$('#txtOrdeno').val(as[0].noa);	
		                			$('#txtAddr2').val(as[0].addr2);	
		                			$('#txtPaytype').val(as[0].paytype);	
		                			$('#txtMemo').val(as[0].memo2);
		                			$('#txtTel').val(as[0].tel);		
		                		}
                    			sum();
                    		}
                    	}catch(e){
                    		
                    	}
                    	break;
				}
			}

			function btnOk() {
				var t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtDatea', q_getMsg('lblDatea')], ['txtCustno', q_getMsg('lblCust')], ['txtCno', q_getMsg('lblAcomp')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}

				Lock(1, {
					opacity : 0
				});
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					Unlock(1);
					return;
				}
				if ($('#txtDatea').val().substring(0, 3) != r_accy) {
					alert('年度異常錯誤，請切換到【' + $('#txtDatea').val().substring(0, 3) + '】年度再作業。');
					Unlock(1);
					return;
				}
				if ($.trim($('#txtNick').val()).length == 0 && $.trim($('#txtComp').val()).length > 0)
					$('#txtNick').val($.trim($('#txtComp').val()).substring(0, 4));
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
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;

				q_box('vcc_rk_s.aspx', q_name + '_s', "550px", "640px", q_getMsg("popSeek"));
			}

			function bbsAssign() {/// 表身運算式
				for (var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
					}
				}//j
				_bbsAssign();
			}

			function btnIns() {
				_btnIns();
				
				Lock(1, {
					opacity : 0
				});
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date);
				$('#cmbTaxtype').val(1);
				q_gt('acomp', '', 0, 0, 0, 'getAcomp', r_accy);
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
				sum();
			}

			function btnPrint() {
				q_box("z_vcc_rkp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'vcc_rk', "95%", "95%", m_print);
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['product'] && !as['uno'] && parseFloat(as['mount'].length == 0 ? "0" : as['mount']) == 0 && parseFloat(as['weight'].length == 0 ? "0" : as['weight']) == 0) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['type'] = abbm2['type'];
				as['mon'] = abbm2['mon'];
				as['noa'] = abbm2['noa'];
				as['datea'] = abbm2['datea'];
				as['tggno'] = abbm2['tggno'];
				as['kind'] = abbm2['kind'];
				if (abbm2['storeno'])
					as['storeno'] = abbm2['storeno'];
				t_err = '';
				if (as['price'] != null && (dec(as['price']) > 99999999 || dec(as['price']) < -99999999))
					t_err = q_getMsg('msgPriceErr') + as['price'] + '\n';

				if (as['total'] != null && (dec(as['total']) > 999999999 || dec(as['total']) < -99999999))
					t_err = q_getMsg('msgMoneyErr') + as['total'] + '\n';

				if (t_err) {
					alert(t_err);
					return false;
				}

				return true;
			}

			function refresh(recno) {
				_refresh(recno);
			}

			function q_popPost(s1) {
				switch (s1) {
					default:
						break;
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
				if (q_tables == 's')
					bbsAssign();
			}

			function q_appendData(t_Table) {
				dataErr = !_q_appendData(t_Table);
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
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 300px;
				border-width: 0px;
			}
			.tview {
				border: 5px solid gray;
				font-size: medium;
				background-color: black;
			}
			.tview tr {
				height: 30px;
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
				width: 10%;
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
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
			}
			.dbbs {
				width: 1700px;
			}
			.tbbs a {
				font-size: medium;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.num {
				text-align: right;
			}
			select {
				font-size: medium;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div style="overflow: auto;display:block;">
			<!--#include file="../inc/toolbar.inc"-->
		</div>
		<div style="overflow: auto;display:block;width:1280px;">
			<div class="dview" id="dview">
				<table class="tview" id="tview"	>
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewNick'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='nick'>~nick</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm" id="tbbm">
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblType' class="lbl"> </a></td>
						<td>
							<select id="cmbTypea" class="txt" style="width:40%;"></select>
							<select id="cmbStype" class="txt" style="width:60%;"></select>
						</td>
						<td><span> </span><a id='lblKind' class="lbl"> </a></td>
						<td><select id="cmbKind" class="txt c1"></select></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon" type="text" class="txt c1"/></td>
						<td><input id="txtOrdeno" type="text" style="display:none;" /></td>
						<td></td>
						<td><input id="btnOrdeno" type="button" class="txt c1"/></td>
						<td><input id="btnCut" type="button" value="製成品匯入" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtCno" type="text" style="float:left;width:25%;"/>
							<input id="txtAcomp" type="text" style="float:left;width:75%;"/>
						</td>
						<td><span> </span><a id='lblInvono' class="lbl"> </a></td>
						<td colspan="2"><input id="txtInvono" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtCustno" type="text" style="float:left;width:25%;"/>
							<input id="txtComp" type="text" style="float:left;width:75%;"/>
							<input id="txtNick" type="text" style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan="4"><input id="txtTel" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtSalesno" type="text" style="float:left;width:50%;"/>
							<input id="txtSales" type="text" style="float:left;width:50%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td colspan="4" >
							<input id="txtPost" type="text" style="float:left; width:15%;"/>
							<input id="txtAddr" type="text" style="float:left; width:85%;"/>
						</td>
						<td><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td colspan="2"><select id="cmbTrantype" class="txt c1" name="D1" ></select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr2' class="lbl"> </a></td>
						<td colspan="4" >
							<input id="txtPost2" type="text" style="float:left; width:15%;"/>
							<input id="txtAddr2" type="text" style="float:left; width:85%;"/>
						</td>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtPaytype" type="text" style="float:left; width:87%;"/>
							<select id="combPaytype" style="float:left; width:26px;"></select>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCardeal' class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtCardealno" type="text" style="float:left;width:25%;"/>
							<input id="txtCardeal" type="text" style="float:left;width:75%;" />
						</td>
						<td><span> </span><a id='lblCarno' class="lbl"> </a></td>
						<td colspan="2"><input id="txtCarno" type="text" class="txt c1" /></td>
					</tr>
					<tr style="display:none;">
						<td><span> </span><a id='lblTotalus' class="lbl"> </a></td>
						<td><input id="txtTotalus" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td><input id="txtFloata" type="text" class="txt num c1" /></td>
						<td>
							<span style="float:left;display:block;width:10px;"></span>
							<select id="cmbCoin" style="float:left;width:80px;"></select>
						</td>
						
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td>
							<input id="txtTax" type="text" class="txt num c1 istax" />
							<input id="txtVccatax" type="text" class="txt num c1 " style="display:none;" />
						</td>
						<td>
							<span style="float:left;display:block;width:10px;"></span>
							<select id="cmbTaxtype" style="float:left;width:80px;" ></select>
						</td>
						<td><span> </span><a id='lblTotal' class="lbl istax"> </a></td>
						<td><input id="txtTotal" type="text" class="txt num c1 istax" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWeight' class="lbl"> </a></td>
						<td><input id="txtWeight" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblPrices' class="lbl"> </a></td>
						<td><input id="txtPrice" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblTranmoney' class="lbl"> </a></td>
						<td><input id="txtTranmoney" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="7"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td></td>
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td><input id="txtAccno" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style=' text-align:center'>
				<tr style='color:white; background:#003366;' >
					<td style="width:20px;">
						<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
					</td>
					<td style="width:20px;"></td>
					<td style="width:200px;">批號</td>
					<td style="width:200px;">品名</td>
					<td style="width:60px;">厚</td>
					<td style="width:60px;">皮膜厚</td>
					<td style="width:60px;">寬</td>
					<td style="width:60px;">長</td>
					<td style="width:160px;">皮膜</td>
					<td style="width:60px;">背面<BR>處理</td>
					<td style="width:100px;">保護膜</td>
					<td style="width:60px;">單位</td>
					<td style="width:100px;">包裝內容</td>
					<td style="width:80px;">件數</td>
					<td style="width:80px;">數量</td>
					<td style="width:80px;">重量</td>
					<td style="width:80px;">單價(KG)</td>
					<td style="width:80px;">金額</td>
					<td style="width:200px;">備註</td>
					<td style="width:200px;">訂單編號</td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input id="txtNoq.*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="txtUno.*" type="text" class="txt c1"/></td>
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
					<td><input id="txtRackno.*" type="text" class="txt c1"/></td>
					<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
					<td><input id="txtChecker.*" type="text" class="txt c1"/></td>
					<td><input id="txtLengthc.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWeight.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtPrice.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtTotal.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
					<td>
						<input id="txtOrdeno.*" type="text" style="float:left;width:72%;"/>
						<input id="txtNo2.*" type="text" style="float:left;width:20%;"/>
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>