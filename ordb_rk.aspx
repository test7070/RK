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
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			q_tables = 's';
			var q_name = "ordb";
			var q_readonly = ['txtTgg', 'txtAcomp', 'txtSales', 'txtNoa', 'txtWorker', 'txtWorker2','txtMoney','txtWeight','txtTotal','txtTax','txtTotalus'];
			var q_readonlys = ['txtC1', 'txtNotv', 'txtNo3','txtOrdeno','txtNo2'];
			var bbmNum = [['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 10, 0, 1], ['txtTotalus', 10, 2, 1], ['txtWeight', 10, 3, 1], ['txtFloata', 10, 4, 1]];
			var bbsNum = [['txtPrice', 12, 2, 1], ['txtTotal', 12, 2, 1, 1], ['txtWeight', 10, 3, 1], ['txtMount', 10, 2, 1],['txtTheory',10,2,1],['textSize1', 10, 3, 1], ['textSize2', 10, 2, 1], ['textSize3', 10, 3, 1], ['textSize4', 10, 2, 1]];
			var bbmMask = [];
			var bbsMask = [['txtStyle', 'A']];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			aPop = new Array(['txtProductno_', 'btnProduct_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx']
				,['txtProductno1_', 'btnProduct1_', 'bcc', 'noa,product,unit', 'txtProductno1_,txtProduct_,txtUnit_', 'bcc_b.aspx'] 
			, ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']
			, ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
			//['txtUno_', 'btnUno_', 'view_uccc', 'uno', 'txtUno_', 'uccc_seek_b.aspx?;;;1=0','95%','60%'],
			['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick,paytype,tel,fax,addr_fact,zip_fact', 'txtTggno,txtTgg,txtNick,txtPaytype,txtTel,txtFax,txtAddr,txtPost', 'tgg_b.aspx']
			,['txtPartno', 'lblPart', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx'] );
		   	brwCount2 = 10;
		   	
		   	t_coin='',t_spec='';
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'no3'];
				q_brwCount();
				q_gt('style', '', 0, 0, 0, '');
				
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
				$('#cmbTaxtype').val((($('#cmbTaxtype').val())?$('#cmbTaxtype').val():'1'));
                $('#txtMoney').attr('readonly', true);
                $('#txtTax').attr('readonly', true);
                $('#txtTotal').attr('readonly', true);
                $('#txtMoney').css('background-color', 'rgb(237,237,238)').css('color', 'green');
                $('#txtTax').css('background-color', 'rgb(237,237,238)').css('color', 'green');
                $('#txtTotal').css('background-color', 'rgb(237,237,238)').css('color', 'green');

                var t_mount = 0, t_price = 0, t_money = 0, t_moneyus=0, t_weight = 0, t_total = 0, t_tax = 0;
                var t_mounts = 0, t_prices = 0, t_moneys = 0, t_weights = 0;
                var t_unit = '';
                var t_float = q_float('txtFloata');
                var t_kind = (($('#cmbKind').val())?$('#cmbKind').val():'');
                t_kind = t_kind.substr(0, 1);
                for (var j = 0; j < q_bbsCount; j++) {
                    t_unit = $.trim($('#txtUnit_' + j).val()).toUpperCase();
                    //---------------------------------------
                    if (t_kind == 'B') {
                        q_tr('txtRadius_' + j, q_float('textSize1_' + j));
                        q_tr('txtWidth_' + j, q_float('textSize2_' + j));
                        q_tr('txtDime_' + j, q_float('textSize3_' + j));
                        q_tr('txtLengthb_' + j, q_float('textSize4_' + j));
                    } else if (t_kind == 'C')  {//鋼筋、胚
                        q_tr('txtLengthb_' + j, q_float('textSize3_' + j));
                    }else{
                        q_tr('txtDime_' + j, q_float('textSize1_' + j));
                        q_tr('txtWidth_' + j, q_float('textSize2_' + j));
                        q_tr('txtLengthb_' + j, q_float('textSize3_' + j));
                        q_tr('txtRadius_' + j, q_float('textSize4_' + j));
                    }
                    $('#txtTheory_'+j).val(getTheory(j));
					var t_Product = $('#txtProduct_' + j).val();
					if(t_Product.indexOf('管') > -1 && dec($('#txtWeight_' + j).val()) == 0){
						$('#txtWeight_' + j).val($('#txtTheory_' + j).val());
					}
                    //---------------------------------------
                    t_weights = q_float('txtWeight_' + j);
                    t_prices = q_float('txtPrice_' + j);
                    t_mounts = q_float('txtMount_' + j);
                	t_moneys = q_mul(t_prices,t_weights);
                    if(t_float==0){
                    	t_moneys = round(t_moneys,0);
                    }else{
                    	t_moneyus = q_add(t_moneyus,round(t_moneys,2));
                    	t_moneys = round(q_mul(t_moneys,t_float),0);
                    }
                    t_weight = q_add(t_weight,t_weights);
                    t_mount = q_add(t_mount,t_mounts);
                    t_money = q_add(t_money,t_moneys);
                    $('#txtTotal_' + j).val(FormatNumber(t_moneys));
                }
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
                t_price = q_float('txtPrice');
                if (t_price != 0) {
                    $('#txtTranmoney').val(FormatNumber(round(q_mul(t_weight,t_price),0)));
                }
                $('#txtWeight').val(FormatNumber(t_weight));

                $('#txtMoney').val(FormatNumber(t_money));
                $('#txtTax').val(FormatNumber(t_tax));
                $('#txtTotal').val(FormatNumber(t_total));
                if(t_float==0)
                	$('#txtTotalus').val(0);
                else
                	$('#txtTotalus').val(FormatNumber(t_moneyus));
            }

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtOdate', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbKind", q_getPara('sys.stktype'));
				//q_cmbParse("cmbCoin", q_getPara('sys.coin'));
				q_cmbParse("combPaytype", q_getPara('rc2.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
				
				q_cmbParse("cmbCoin", t_coin);
				//if(abbm[q_recno]) $('#cmbCoin').val(abbm[q_recno].coin);
				q_cmbParse("cmbSpec", t_spec,'s');
						
				$('#lblOrde').click(function() {
					if(!(q_cur==1 || q_cur ==2))
						return;
					var t_where = " 1=1 and enda='0' and kind='"+$('#cmbKind').val()+"' ";
					var t_ordeno_where = ' and (  ';
					var t_ordeno = trim($('#txtOrdeno').val());
					t_ordeno = t_ordeno.split(',');
					for(var i=0;i<t_ordeno.length;i++){
						if(trim(t_ordeno[i]).length > 0){
							var t_no2 = t_ordeno[i].split('-');
							if(t_no2.length>0 && t_no2[1]){
								for(var j=0;j<t_no2.length;j++){
									t_ordeno_where+= " (noa='"+t_no2[0]+"' and no2='" + t_no2[1] + "') or";
								}
							}else{
									t_ordeno_where+= " (noa='"+t_ordeno[i]+ "') or";
							}
						}
					}
					t_ordeno_where = t_ordeno_where.substring(0,t_ordeno_where.length-2) + ' )';
					t_where += (t_ordeno_where.indexOf('noa') == -1?'':t_ordeno_where);
					q_box("ordests_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "95%", "95%", q_getMsg('popOrde'));
				});
				$("#combPaytype").change(function(e) {
					if (q_cur == 1 || q_cur == 2)
						$('#txtPaytype').val($('#combPaytype').find(":selected").text());
				});
				$('#txtAddr').change(function(){
					var t_where = "where=^^ noa='" + trim($(this).val()) + "' ^^";
					q_gt('cust', t_where , 0, 0, 0, "", r_accy);
				});
				$("#txtPaytype").focus(function(e) {
					var n = $(this).val().match(/[0-9]+/g);
					var input = document.getElementById("txtPaytype");
					if ( typeof (input.selectionStart) != 'undefined' && n != null) {
						input.selectionStart = $(this).val().indexOf(n);
						input.selectionEnd = $(this).val().indexOf(n) + (n+"").length;
					}
				}).click(function(e) {
					var n = $(this).val().match(/[0-9]+/g);
					var input = document.getElementById("txtPaytype");
					if ( typeof (input.selectionStart) != 'undefined' && n != null) {
						input.selectionStart = $(this).val().indexOf(n);
						input.selectionEnd = $(this).val().indexOf(n) + (n+"").length;
					}
				});
				$('#txtFloata').change(function() {
					sum();
				});
				$("#cmbTaxtype").change(function(e) {
					sum();
				});
				$('#txtTotal').change(function() {
					sum();
				});
				//變動尺寸欄位
				$('#cmbKind').change(function() {
					size_change();
				});
			}

			function q_boxClose(s2) {///   q_boxClose 2/4
				var ret;
				switch (b_pop) {
					case 'ordes':
						b_ret = getb_ret();
						ordesArray = b_ret;
						if (ordesArray && ordesArray[0] != undefined) {
							var distinctArray = new Array;
							var inStr = '';
							for(var i=0;i<ordesArray.length;i++){distinctArray.push(ordesArray[i].noa);}
							distinctArray = distinct(distinctArray);
							for(var i=0;i<distinctArray.length;i++){
								inStr += "'"+distinctArray[i]+"',";
							}
							inStr = inStr.substring(0,inStr.length-1);
							var t_where = "where=^^ ordeno in("+inStr+") and (isnull(ordeno,'') != '') ^^";
							q_gt('ordbs', t_where , 0, 0, 0, "", r_accy);
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						///   q_boxClose 3/4
						break;
				}/// end Switch
				b_pop = '';
			}

			var StyleList = '';
			var ordesArray = new Array;
			var t_uccArray = new Array;
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'ordbs':
						var as = _q_appendData("ordbs", "", true);
						for(var i = 0;i<as.length;i++){
							for(var j=0;j<ordesArray.length;j++){
								if(as[i].ordeno == ordesArray[j].noa && as[i].no2 == ordesArray[j].no2){
									ordesArray[j].mount = dec(ordesArray[j].mount)-dec(as[i].mount);
									ordesArray[j].weight = dec(ordesArray[j].weight)-dec(as[i].weight);
								}
							}
						}
						for(var i=0;i<ordesArray.length;i++){
							if (ordesArray[i].mount <=0 || ordesArray[i].weight <=0 || ordesArray[i].noa == '') {
									ordesArray.splice(i, 1);
									i--;
							}
						}
						if (ordesArray[0] != undefined){
							for(var i=0;i<q_bbsCount;i++){$('#btnMinus_'+i).click();}
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtUno,txtStyle,txtClass,txtProductno,txtProduct,txtUnit,txtMount,txtWeight,txtPrice,txtOrdeno,txtNo2,txtRadius,txtDime,txtWidth,txtLengthb,cmbSpec', ordesArray.length, ordesArray
		                                                          , 'uno,style,class,productno,product,unit,mount,weight,price,noa,no2,radius,dime,width,lengthb,spec'
		                                                          ,'txtOrdeno,txtNo2');   /// 最後 aEmpField 不可以有【數字欄位】
							var oAMap = ordesArray.map(function(el){return el['noa'];});
							for(var i = 0;i<oAMap.length;i++){
								if((oAMap.indexOf(oAMap[i]) != oAMap.lastIndexOf(oAMap[i])) || oAMap[i] == ''){
									ordesArray.splice(i, 1);
									oAMap.splice(i, 1);
									i--;
								}else if(trim(ordesArray[i].acoin) != '' && dec(ordesArray[i].afloata) !=0 && dec(ordesArray[i].afloata).toString() != 'NaN'){
									$('#cmbCoin').val(ordesArray[i].acoin);
									$('#txtFloata').val(ordesArray[i].afloata);
								}
							}
							$('#txtMemo').val(distinct(ordesArray.map(function(el){return el['amemo'];})).toString());
						}
						size_change();
						sum();
						ordesArray = new Array;
						break;
					case 'style' :
						var as = _q_appendData("style", "", true);
						StyleList = new Array();
						StyleList = as;
						q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
						break;
					case 'flors_coin':
						var as = _q_appendData("flors", "", true);
						t_coin='';
						for ( i = 0; i < as.length; i++) {
							t_coin+=','+as[i].coin;
						}
						if(t_coin.length==0) t_coin=' ';
						q_gt('spec', '', 0, 0, 0, "spec");
						break;
					case 'spec':
						var as = _q_appendData("spec", "", true);
						t_spec='';
						for ( i = 0; i < as.length; i++) {
							t_spec+=','+as[i].noa+'@'+as[i].product;
						}
						if(t_spec.length==0) t_spec=' ';
						q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
						break;
					case 'flors':
						var as = _q_appendData("flors", "", true);
						if (as[0] != undefined) {
							q_tr('txtFloata',as[0].floata);
							sum();
						}
						break;
					case 'cust' :
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined) {
							var CustAddr = trim(as[0].addr_fact);
							if(CustAddr.length>0){
								$('#txtAddr').val(CustAddr);
								$('#txtPost').val(as[0].zip_fact);
							}
						}
						break;
					case q_name:
						t_uccArray = _q_appendData("ucc", "", true);
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}  /// end switch
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock(1);
			}
			
			function coin_chg() {
				var t_where = "where=^^ ('" + $('#txtOdate').val() + "' between bdate and edate) and coin='"+$('#cmbCoin').find("option:selected").text()+"' ^^";
				q_gt('flors', t_where, 0, 0, 0, "");
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

			function GetOrdenoList(){
				var ReturnStr = new Array;
				for(var i=0;i<q_bbsCount;i++){
					var thisVal = trim($('#txtOrdeno_'+i).val());
					if(thisVal.length > 0)
						ReturnStr.push(thisVal);
				}
				ReturnStr = distinct(ReturnStr).sort();
				return ReturnStr.toString();
			}

			function btnOk() {
				//物料品名欄位寫入
				if($('#cmbKind').val()=='1'){
					for (var j = 0; j < q_bbsCount; j++) {
						$('#txtProductno_' + j).val($('#txtProductno1_' + j).val());
					}
				}
				
				Lock(1, {
					opacity : 0
				});
				$('#txtOrdeno').val(GetOrdenoList());
				//日期檢查
				if ($('#txtOdate').val().length == 0 || !q_cd($('#txtOdate').val())) {
					alert(q_getMsg('lblOdate') + '錯誤。');
					Unlock(1);
					return;
				}
				if ($('#txtOdate').val().substring(0, 3) != r_accy) {
					alert('年度異常錯誤，請切換到【' + $('#txtOdate').val().substring(0, 3) + '】年度再作業。');
					Unlock(1);
					return;
				}
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				sum();
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtOdate').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ordb') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;

				q_box('ordb_s.aspx', q_name + '_s', "600px", "400px", q_getMsg("popSeek"));
			}

			function getTheory(b_seq) {
				t_Radius = $('#txtRadius_' + b_seq).val();
				t_Width = $('#txtWidth_' + b_seq).val();
				t_Dime = $('#txtDime_' + b_seq).val();
				t_Lengthb = $('#txtLengthb_' + b_seq).val();
				t_Mount = $('#txtMount_' + b_seq).val();
				t_Style = $('#txtStyle_' + b_seq).val();
                t_Productno = $('#txtProductno_' + b_seq).val();
				var theory_setting={
					calc:StyleList,
					ucc:t_uccArray,
					radius:t_Radius,
					width:t_Width,
					dime:t_Dime,
					lengthb:t_Lengthb,
					mount:t_Mount,
					style:t_Style,
					productno:t_Productno,
					round:3
				};
				return theory_st(theory_setting);
			}

			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#btnHistory_'+j).click(function(e){
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							var t_pno = $.trim($('#txtProductno_'+n).val());
							var t_spec = $.trim($('#cmbSpec_'+n).val());
							var t_dime = q_float('txtDime_'+n);
							
		                	var t_where ='';
		                	q_box("ordcs_rk_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where+";"+";"+JSON.stringify({productno:t_pno,spec:t_spec,dime:t_dime}), "ordcs_rk", "95%", "95%", '');
						});
						$('#btnTmprecord_' + j).click(function(){
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							var t_pno = $.trim($('#txtProductno_'+n).val());
							var t_no3 = $.trim($('#txtNo3_'+n).val());
							var t_noa = $.trim($('#txtNoa').val());
							if((t_pno.length>0) && (t_no3.length>0) && (t_noa.length>0) && (t_noa != 'AUTO')){
								var t_where = "noa='" + t_noa + "' and no3='" + t_no3 + "' ";
								q_box("ordbt_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordbt', "95%", "95%", '詢價紀錄');
							}
						});
						
						$('#txtProductno_' + j).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtProductno_', '');
                            $('#btnProduct_'+n).click();
                        });
                        $('#txtProductno1_' + j).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtProductno1_', '');
                            $('#btnProduct1_'+n).click();
                        });
						$('#txtMount_' + j).change(function() {sum();});
						$('#txtWeight_' + j).change(function() {sum();});
						$('#txtPrice_' + j).change(function() {sum();});
						$('#txtTotal_' + j).change(function() {sum();});
						$('#txtC1_' + j).change(function() {sum();});
						$('#txtStyle_' + j).blur(function() {
							$('input[id*="txtProduct_"]').each(function() {
								thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
				               	$(this).attr('OldValue',$('#txtProductno_'+thisId).val());
							});
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							ProductAddStyle(n);
						});
						//計算理論重
						$('#textSize1_' + j).change(function() {sum();});
						$('#textSize2_' + j).change(function() {sum();});
						$('#textSize3_' + j).change(function() {sum();});
						$('#textSize4_' + j).change(function() {sum();});
					}
				}
				_bbsAssign();
				size_change();
				if(q_getPara('sys.project').toUpperCase()=='RK'){
					$('#lblWeights_st').text('重量/M');
				}		
			}

			function btnIns() {
				_btnIns();
				$('#chkIsproj').attr('checked',true);
				$('#txtNoa').val('AUTO');
				$('#txtOdate').val(q_date());
				$('#txtCno').val('1');
				$('#txtAcomp').val((q_getPara('sys.comp').substring(0,3)=='裕承隆'?q_getPara('sys.comp').substring(0,3):q_getPara('sys.comp').substring(0,2)));
				$('#txtOdate').focus();
				size_change();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtOdate').focus();
				size_change();
				sum();
			}

			function btnPrint() {
				q_box("z_ordbstp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy , 'ordb', "95%", "95%", m_print);
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno'] && !as['product'] && !as['spec'] && !dec(as['total'])) {//不存檔條件
                    as[bbsKey[1]] = '';
                    /// no2 為空，不存檔
                    return;
                }

				q_nowf();
				as['datea'] = abbm2['datea'];
				as['kind'] = abbm2['kind'];
				as['tggno'] = abbm2['tggno'];
				as['odate'] = abbm2['kind'];
				as['enda'] = abbm2['enda'];

				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				size_change();
				//q_popPost('txtProductno_');
				$('input[id*="txtProduct_"]').each(function() {
					thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
		          	$(this).attr('OldValue',$('#txtProductno_'+thisId).val());
				});
 			}

			function q_popPost(s1) {
				switch (s1) {
					case 'txtProductno_':
						$('input[id*="txtProduct_"]').each(function() {
							thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
		                	$(this).attr('OldValue',$('#txtProductno_'+thisId).val());
						});
                        if(trim($('#txtStyle_' + b_seq).val()).length != 0)
                        	ProductAddStyle(b_seq);
						$('#txtClass_' + b_seq).focus();
						break;
					case 'txtTggno':
						$('#txtSalesno').focus();
						break;
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				size_change();
			}

			function btnMinus(id) {
				_btnMinus(id);
				sum();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				size_change();
				if (q_tables == 's')
					bbsAssign();
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

			function size_change() {
				if (q_cur == 1 || q_cur == 2) {
					$('input[id*="textSize"]').removeAttr('disabled');
				} else {
					$('input[id*="textSize"]').attr('disabled', 'disabled');
				}
				$('#cmbKind').val((($('#cmbKind').val())?$('#cmbKind').val():q_getPara('vcc.kind')));
                var t_kind = (($('#cmbKind').val())?$('#cmbKind').val():'');
                t_kind = t_kind.substr(0, 1);		
				if (t_kind == 'B') {
					$('#lblSize_help').text(q_getPara('sys.lblSizeb'));
					$('.dbbs').css('width', '1530px');
					$('#Size').css('width', '300px');
					$('.st').show();$('.bcc').hide();
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).show();
						$('#textSize2_' + j).show();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).show();
						$('#x1_' + j).show();
						$('#x2_' + j).show();
						$('#x3_' + j).show();
						$('#cmbSpec_'+j).css('width', '300px');
						$('#textSize1_' + j).val($('#txtRadius_' + j).val());
						$('#textSize2_' + j).val($('#txtWidth_' + j).val());
						$('#textSize3_' + j).val($('#txtDime_' + j).val());
						$('#textSize4_' + j).val($('#txtLengthb_' + j).val());
					}
				} else  if (t_kind == 'C'){//鋼筋和鋼胚
					$('#lblSize_help').text(q_getPara('sys.lblSizec'));
					$('.dbbs').css('width', '1530px');
					$('#Size').css('width', '55px');
					$('.st').show();$('.bcc').hide();
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).hide();
						$('#textSize2_' + j).hide();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).hide();
						$('#x1_' + j).hide();
						$('#x2_' + j).hide();
						$('#x3_' + j).hide();
						$('#cmbSpec_'+j).css('width', '55px');
						$('#textSize1_' + j).val(0);
						$('#txtDime_' + j).val(0);
						$('#textSize2_' + j).val(0);
						$('#txtWidth_' + j).val(0);
						$('#textSize3_' + j).val($('#txtLengthb_' + j).val());
						$('#textSize4_' + j).val(0);
						$('#txtRadius_' + j).val(0);
					}
				}else if(t_kind=='1'){//物料
					//物料品名欄位寫回
					for (var j = 0; j < q_bbsCount; j++) {
						$('#txtProductno1_' + j).val($('#txtProductno_' + j).val());
					}
					$('.dbbs').css('width', '1270px');
					$('.st').hide();
					$('.bcc').show();
				}else{
					$('#lblSize_help').text(q_getPara('sys.lblSizea'));
					$('.dbbs').css('width', '1530px');
					$('#Size').css('width', '220px');
					$('.st').show();$('.bcc').hide();
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).show();
						$('#textSize2_' + j).show();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).hide();
						$('#x1_' + j).show();
						$('#x2_' + j).show();
						$('#x3_' + j).hide();
						$('#cmbSpec_'+j).css('width', '220px');
						$('#textSize1_' + j).val($('#txtDime_' + j).val());
						$('#textSize2_' + j).val($('#txtWidth_' + j).val());
						$('#textSize3_' + j).val($('#txtLengthb_' + j).val());
						$('#textSize4_' + j).val(0);
						$('#txtRadius_' + j).val(0);
					}
				}
			}

			function FormatNumber(n) {
				var xx = "";
				if (n < 0) {
					n = Math.abs(n);
					xx = "-";
				}
				n += "";
				var arr = n.split(".");
				var re = /(\d{1,3})(?=(\d{3})+$)/g;
				return xx + arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
			}

		</script>
		<style type="text/css">
			#dmain {
				/*overflow: hidden;*/
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
				width: 1530px;
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
			#dbbt {
				width: 1525px;
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
			.trX {
				background: pink;
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
			<div class="dview" id="dview"  >
				<table class="tview" id="tview"	>
					<tr>
						<td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewOdate"> </a></td>
						<td align="center" style="width:100px; color:black;"><a id="vewNoa"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewNick"> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='odate'>~odate</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='nick'>~nick</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm"  id="tbbm">
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
						<td><span> </span><a id='lblOdate' class="lbl"> </a></td>
						<td><input id="txtOdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblKind' class="lbl"> </a></td>
						<td><select id="cmbKind" class="txt c1" > </select></td>
						<td><span> </span><a id='lblPart' class="lbl btn"> </a></td>
						<td>
							<input id="txtPartno" type="text" class="txt" style="width:45%;"/>
							<input id="txtPart" type="text" class="txt" style="width:55%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td colspan="4">
						<input id="txtCno" type="text" style="float:left;width:25%;"/>
						<input id="txtAcomp" type="text" style="float:left;width:75%;"/>
						</td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtNoa"   type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td ><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtTggno" type="text" style="float:left;width:25%;"/>
							<input id="txtTgg"  type="text" style="float:left;width:75%;"/>
							<input id="txtNick"  type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id='lblContract_st' class="lbl"> </a></td>
						<td colspan="2"><input id="txtContract"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan="4">
						<input id="txtTel"  type="text"  class="txt c1"/>
						</td>
						<td><span> </span><a id='lblOrde' class="lbl btn"> </a></td>
						<td colspan="2"><input id="txtOrdeno" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td colspan="4"><input id="txtFax" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td colspan="2">
						<input id="txtSalesno" type="text" style="float:left;width:50%;"/>
						<input id="txtSales" type="text" style="float:left;width:50%;"/>
						</td>
						
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td colspan="4" >
							<input id="txtPost"  type="text" style="float:left; width:25%;"/>
							<input id="txtAddr"  type="text" style="float:left; width:75%;"/></td>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtPaytype" type="text" style="float:left; width:115px;"/>
							<select id="combPaytype" style="float:left; width:26px;"></select>
							<select id="cmbTrantype" class="txt" name="D1" style="float:left; width:60px;"></select>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTotalus' class="lbl"> </a></td>
						<td>	<input id="txtTotalus" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td><input id="txtFloata" type="text" class="txt num c1" /></td>
						<td><span style="float:left;display:block;width:10px;"></span><select id="cmbCoin" style="float:left;width:80px;" onchange='coin_chg()' > </select></td>
						<td class="st"><span> </span><a id='lblWeight' class="lbl"> </a></td>
						<td class="st"><input id="txtWeight"  type="text" class="txt num c1"/></td>
						<td><a id='lblIsproj' class="lbl" style="float:right;"> </a><span> </span>
						<input id="chkIsproj" type="checkbox" style="float:right;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td><input id="txtTax" type="text" class="txt num c1" /></td>
						<td><span style="float:left;display:block;width:10px;"></span><select id="cmbTaxtype" style="float:left;width:80px;" > </select></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt num c1" /></td>
						<td><a id='lblEnd' class="lbl" style="float:right;"> </a><span> </span>
						<input id="chkEnda" type="checkbox" style="float:right;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="7">
						<input id="txtMemo" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td class="trX"><span> </span><a id='lblOrdgweight' class="lbl"> </a></td>
						<td class="trX"><input id="txtOrdgweight" type="text" class="txt c1 num" /></td>
						<td class="trX"><span> </span><a id='lblOrdeweight' class="lbl"> </a></td>
						<td class="trX"><input id="txtOrdeweight" type="text" class="txt c1 num" /></td>
						<td class="trX"><span> </span><a id='lblCtrlweight' class="lbl"> </a></td>
						<td class="trX"><input id="chkIsctrlweight" type="checkbox"/></td>
						<td class="trX"> </td>
						<td class="trX"> </td>
						<td class="tdZ trX"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblApv" class="lbl"> </a></td>
						<td><input id="txtApv" type="text"  class="txt c1" disabled="disabled"/></td>
						<!--<td><span> </span><a id='lblEnd' class="lbl"> </a></td>
						<td><input id="chkEnda" type="checkbox"/></td>-->
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style=' text-align:center'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:150px;"><a>品號<BR>品名</a></td>
					<td class="st" align="center" style="width:340px;" id='Size'><a id='lblSize_help'> </a>
					<BR><a id='lblSize_st'> </a></td>
					<td align="center" style="width:50px;"><a id='lblUnit'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMount_st'> </a></td>
					<td class="st" align="center" style="width:80px;"><a id='lblWeights_st'> </a></td>
					<td align="center" style="width:80px;"><a id='lblPrices_st'> </a></td>
					<td align="center" style="width:100px;"><a id='lblTotals'> </a><br><a id='lblTheorys' class="st"> </a></td>
					<td align="center" style="width:80px;"><a id='lblC1s'> </a><br><a id='lblNotvs'> </a></td>
					<td align="center" style="width:180px;"><a id='lblMemos_st'> </a><br><a id='lblOrdenos_st'> </a></td>
					<td align="center" style="width:60px;"><a>鋼廠</a></td>
					<td align="center" style="width:250px;"><a id='lblUno_st'> </a></td>
					<td align="center" style="width:40px;"><a>採購<BR>記錄</a></td>
					<td align="center" style="width:40px;"><a>詢價<BR>記錄</a></td>	
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNo3.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input class="st" id="txtProductno.*" type="text" style="width:95%;" />
						<input class="btn" id="btnProduct.*" type="button" style="display:none;"/>
						<input class="bcc" type="text" id="txtProductno1.*"  style="width:95%;"/>
						<input class="btn"  id="btnProductno1.*" type="button" style="display:none;"/>
						<input type="text" id="txtProduct.*" style="width:95%;" />
					</td>
					<td class="st">
						<input class="txt num" id="textSize1.*" type="text" style="float: left;width:55px;" disabled="disabled"/>
						<div id="x1.*" style="float: left;display:block;width:20px;padding-top: 4px;" >
							x
						</div>
						<input class="txt num" id="textSize2.*" type="text" style="float: left;width:55px;"  disabled="disabled"/>
						<div id="x2.*" style="float: left;display:block;width:20px;padding-top: 4px;">
							x
						</div>
						<input class="txt num" id="textSize3.*" type="text" style="float: left;width:55px;" disabled="disabled"/>
						<div id="x3.*" style="float: left;display:block;width:20px;padding-top: 4px;">
							x
						</div>
						<input class="txt num" id="textSize4.*" type="text"  style="float: left;width:55px;" disabled="disabled"/>
					<!--上為虛擬下為實際-->
						<input id="txtRadius.*" type="text" style="display:none;"/>
						<input id="txtWidth.*" type="text" style="display:none;"/>
						<input id="txtDime.*" type="text" style="display:none;"/>
						<input id="txtLengthb.*" type="text" style="display:none;"/>
						<!--<input id="txtSpec.*" type="text" style="float:left;"/>-->
						<select id='cmbSpec.*' style="width:95%;"> </select>
					</td>
					<td><input id="txtUnit.*" type="text" style="width:90%;"/></td>
					<td><input id="txtMount.*" type="text" class="txt num" style="width:95%;"/></td>
					<td class="st"><input id="txtWeight.*" type="text" class="txt num" style="width:95%;"/></td>
					<td><input id="txtPrice.*" type="text"  class="txt num" style="width:95%;"/></td>
					<td>
						<input id="txtTotal.*" type="text" class="txt num" style="width:97%;"/>
						<input id="txtTheory.*" type="text" class="txt num st" style="width:97%;"/>
					</td>
					<td>
						<input id="txtC1.*" type="text" class="txt num" style="width:97%;"/>
						<input id="txtNotv.*" type="text" class="txt num" style="width:97%;"/>
					</td>
					<td >
						<input id="txtMemo.*" type="text" style="width:95%; float:left;"/>
						<input id="txtOrdeno.*" type="text"  style="width:65%;float:left;"/>
						<input id="txtNo2.*" type="text"  style="width:25%;float:left;"/>
					</td>
					<td> <input id="txtSource.*" type="text" style="float:left;width:95%;" /> </td>
					<td> <input id="txtUno.*" type="text" style="float:left;width:95%;" /> </td>
					<td><input type="button" id="btnHistory.*" value="." /></td>
					<td><input type="button" id="btnTmprecord.*" value="." /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
