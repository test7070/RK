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
			var q_name = "cub";
			var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
			var q_readonlys = ['txtNoq','txtMakeno','txtSize','txtDime','txtWidth','txtProductno','txtProduct','txtPrice','txtW01','txtW02','txtW03','txtTotal'];
			var q_readonlyt = ['txtNoq','txtProductno','txtProduct'];
			var bbmNum = [];
			var bbsNum = [];
			var bbtNum = [];
			var bbmMask = [];
			var bbsMask = [['txtBtime','99:99'],['txtEtime','99:99']];
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
				,['txtCustno_', 'btnCust_', 'cust', 'noa,nick', 'txtCustno_,txtComp_', 'cust_b.aspx']
				,['txtSpec_', 'btnSpec_', 'spec', 'noa,product', 'txtSpec_', 'spec_b.aspx']
				,['txtProductno__', 'btnProduct__', 'ucc', 'noa,product', 'txtProductno__,txtProduct__', 'ucc_b.aspx']
				,['txtScolor_', 'btnScolor_', 'ucc', 'noa,product', 'txtScolor_,txtProcess_', 'ucc_b.aspx']
            	,['txtZinc_', 'btnZinc_', 'ucc', 'noa,product', 'txtZinc_,txtFlower_', 'ucc_b.aspx']
            	,['txtUno__', 'btnUno__', 'view_uccc2', 'uno,productno,product', '0txtUno__,txtProductno__,txtProduct__', 'uccc_seek_b2.aspx?;;;1=0', '95%', '95%']
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
					if($('#txtBtime_'+i).val().length>0 || $('#txtEtime_'+i).val().length>0)
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

			function mainPost() {
				q_getFormat();
				document.title = '生產作業';
				bbmMask = [['txtDatea', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbKind", '1@皮膜,2@保護膜','t');
				
				q_cmbParse("combProcess", ' ,覆膜,覆膜代工,抗指紋,抗指紋代工,試貼,試塗');
				$('#combProcess').change(function(e){
					$('#txtProcess').val($(this).val());
					$(this)[0].selectedIndex = 0;
				});
				
				$('#dbbt').mousedown(function(e) {
					if(e.button==2){			   		
						$(this).data('xtop',parseInt($(this).css('top')) - e.clientY);
						$(this).data('xleft',parseInt($(this).css('left')) - e.clientX);
					}
				}).mousemove(function(e) {
					if(e.button==2 && e.target.nodeName!='INPUT'){ 
						$(this).css('top',$(this).data('xtop')+e.clientY);
						$(this).css('left',$(this).data('xleft')+e.clientX);
					}
				}).bind('contextmenu', function(e) {
					if(e.target.nodeName!='INPUT')
						e.preventDefault();
				});
				
				$('#btnOrde').click(function() {
					if(!(q_cur==1 || q_cur==2))
						return;
					var t_noa = $('#txtNoa').val();
                	var t_where ='';
                	q_box("orde_rk_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where+";"+";"+JSON.stringify({cubno:t_noa,page:'cub_rk'}), "orde_cub", "100%", "100%", '');
				});
				
				$('#btnCubu_rk').click(function() {
					var t_where = "noa='" + trim($('#txtNoa').val()) + "'";
						q_box("cubu_rk_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";"+r_accy, 'cubu', "95%", "95%", q_getMsg('popCubu'));
				});
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'isexist_get_modi':
						var t_noa = $('#txtNoa').val();
						var as = _q_appendData("view_get", "", true);
						if(as[0]!=undefined){
							q_func('get_post.post.post1', r_accy + ',' + t_noa + ',1');
						}
						break;
					case 'isexist_get_dele':
						var t_noa = currentNoa;
						var as = _q_appendData("view_get", "", true);
						if(as[0]!=undefined){
							alert('isexist_get_dele:'+t_noa);
							q_func('get_post.post.post0', r_accy + ',' + t_noa + ',0');
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						else if(q_cur==0 && toIns){
							var t_h1 = q_getHref();
							if($.trim(t_h1[0])==''){
								$('#btnIns').click();
							}
							toIns = false;
						}
						break;
					default:
                    	try{
                    		t_para = JSON.parse(t_name);
                    		if(t_para.action == 'importOrde'){
                    			var as = _q_appendData("view_ordes", "", true);
		                		if (as[0] != undefined) {
		                			$('#txtCustno_'+t_para.n).val(as[0].custno);	
		                			$('#txtComp_'+t_para.n).val(as[0].comp);	
		                			$('#txtDime_'+t_para.n).val(as[0].dime);	
		                			$('#txtRadius_'+t_para.n).val(as[0].radius);	
		                			$('#txtWidth_'+t_para.n).val(as[0].width);	
		                			$('#txtLengthb_'+t_para.n).val(as[0].lengthb);
		                			$('#txtSpec_'+t_para.n).val(as[0].scolor);
		                			$('#txtSource_'+t_para.n).val(as[0].source);	
		                			
		                			$('#txtScolor_'+t_para.n).val(as[0].zinc);
		                			$('#txtProcess_'+t_para.n).val(as[0].source);
		                			$('#txtZinc_'+t_para.n).val(as[0].hard);
		                			$('#txtFlower_'+t_para.n).val(as[0].uno);
		                		}else{
		                			alert('找不到訂單【'+t_para.ordeno+'-'+t_para.no2+'】');
		                		}
                    			sum();
                    		}else if(t_para.action == 'getDensity'){
                    			try{
                					var t_density = 0,t_mount = q_float('txtWeight__'+t_para.n);
                    				var as = _q_appendData("ucc", "", true);
			                		if (as[0] != undefined) {
		                				try{
		                					t_density = parseFloat(as[0].density);
			                			}catch(e){
			                				t_density = 0;
			                			}
			                		}
			                		$('#txtWweight__'+t_para.n).val(round(q_mul(t_density,t_mount),0));
		                		}catch(e){
		                			$('#txtWweight__'+t_para.n).val(0);
		                		}
                    		}else if(t_para.action == 'getProduct'){
                    			try{
                    				var as = _q_appendData("view_uccb", "", true);
			                		if (as[0] != undefined) {
		                				$('#txtProductno__'+t_para.n).val(as[0].productno);
		                				$('#txtProduct__'+t_para.n).val(as[0].product);
			                		}else{
			                			$('#txtProductno__'+t_para.n).val('');
		                				$('#txtProduct__'+t_para.n).val('');
			                		}
		                		}catch(e){
		                		}
                    		}else if(t_para.action == 'getSpec'){
                    			try{
                    				var as = _q_appendData("spec", "", true);
			                		if (as[0] != undefined) {
		                				$('#txtSize_'+t_para.n).val(as[0].product);
		                			}
		                		}catch(e){
		                		}
                    		}else if(t_para.action == 'checkMakeno'){
                    			try{
                    				var as = _q_appendData("view_cub", "", true);
			                		if (as[0] != undefined) {
		                				for(var i=0;i<as.length;i++){
		                					if(as[i].noa!=t_para.noa){
		                						alert('製造批號重覆，請檢查!');
		                						return;
		                					}
		                				}
		                			}
		                			save();
		                		}catch(e){
		                		}
                    		}
                    	}catch(e){
                    		
                    	}
                    	break;
				}
			}

			function q_stPost() {
				/*if (q_cur == 1 || q_cur == 2){
					t_noa = $('#txtNoa').val();
					if(t_noa.length>0){
						q_func('qtxt.query.cub2get1', 'cub.txt,cub2get,'+t_noa+';0');
					}
				}*/
				/*if(q_cur==3){
					//alert('q_stPost:'+currentNoa);
					q_gt('view_get', "where=^^noa='" + currentNoa + "'^^", 0, 0, 0, "isexist_get_dele",1);				
				}*/
			}
			function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'get_post.post.post0':
                	alert('q_funcPost:'+t_noa);
                		var t_noa = currentNoa;
						q_func('qtxt.query.cub2get', 'cub.txt,cub2get,'+t_noa+';0');
						break;
                	case 'qtxt.query.cub2get1':
                		t_noa = $('#txtNoa').val();
                		console.log('qtxt.query.cub2get1:'+t_noa);
                		q_func('qtxt.query.cub2get2', 'cub.txt,cub2get,'+t_noa+';1');
                		break;
            		case 'qtxt.query.cub2get2':
            			t_noa = $('#txtNoa').val();
            			console.log('qtxt.query.cub2get2:'+t_noa);
                		q_gt('view_get', "where=^^noa='" + t_noa + "'^^", 0, 0, 0, "isexist_get_modi",1);
                		break;
                    default:
                        break;
                }
            }

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'orde_cub':
                        if (b_ret != null) {
                        	as = b_ret;
                    		q_gridAddRow(bbsHtm, 'tbbs', 'txtOrdeno,txtNo2,txtCustno,txtComp,txtProductno,txtProduct,txtDime,txtRadius,txtWidth,txtLengthb,txtUnit,txtSize,txtSpec,txtScolor,txtProcess,txtZinc,txtFlower,txtWeight'
                        	, as.length, as, 'noa,no2,custno,nick,productno,product,dime,radius,width,lengthb,unit,size,spec,zinc,source,hard,uno,tweight', 'txtOrdeno','');             	
                        }else{
                        	Unlock(1);
                        }
                        $('#rbNum_0').prop('checked',true);
						$('#rbNum_0').click();
                        break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
					default:
						if(b_pop.substring(0,8)=='cng_cub_'){
							var n = b_pop.replace('cng_cub_','');
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

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
				InsertBbs();
				$('#rbNum_0').prop('checked',true);
				$('#rbNum_0').click();
				//$('#rbNum_0').prop('checked',true);
				//$('#rbNum_'+i).click();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
				InsertBbs();
				$('#rbNum_0').prop('checked',true);
				$('#rbNum_0').click();
				//$('#rbNum_0').prop('checked',true);
				//$('#rbNum_'+i).click();
			}
			function InsertBbs(){
				//固定6筆
				for(var i=q_bbsCount;i<=6;i++){
					q_gridAddRow(bbsHtm, 'tbbs', 'txtNoq', 1);
				}
				noqlist = ["001","002","003","004","005","006"];
				
				for(var i=0;i<q_bbsCount;i++){
					if(i>=6){
						$('#txtNoq_'+i).parent().parent().hide();
						$('#txtOrdeno_'+i).val('');
					}		
					else{
						n = noqlist.indexOf($('#txtNoq_'+i).val());
						if(n>=0){
							noqlist[n] = '';
						}
					}
				}
				for(var i=0;i<noqlist.length;i++){
					if($('#txtNoq_'+i).val().length==0){
						t_noq = '';
						for(var j=0;j<noqlist.length;j++){
							if(noqlist[j].length>0){
								$('#txtNoq_'+i).val(noqlist[j]);
								noqlist[j] = '';
								break;
							}
						}
					}
				}
			}

			function btnPrint() {
				q_box("z_cubp_rk.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'cub_rk', "95%", "95%", m_print);
            }

			function btnOk() {
				//檢查製造批號是否已重覆
				t_where="where=^^ vcceno='"+$('#txtVcceno').val()+"' ^^";
				q_gt('view_cub', t_where, 0, 0, 0, JSON.stringify({action:'checkMakeno',noa:$('#txtNoa').val()}), r_accy);
			}
			function save(){
				toIns = false;
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					return;
				}
				if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
                //COIL 重量(KG) = 耗料重
               	for(var i=0;i<q_bbsCount;i++){
               		$('#txtGweight_'+i).val($('#txtWeight_'+i).val());
               	}
                
                //製造批號
            	var t_manufactureno = $.trim($('#txtVcceno').val());
            	if(t_manufactureno.length>0){
            		for(var i=0;i<q_bbsCount;i++){
                		if($('#txtMakeno_'+i).val().length==0){
                			$('#txtMakeno_'+i).val(t_manufactureno+'-'+(i+1));
                		}
                	}	
            	}    
                //寫入bbt  gweight
        		for(var i=0;i<q_bbtCount;i++){
        			$('#txtGweight__'+i).val($('#txtWeight__'+i).val());
        			$('#txtGmount__'+i).val($('#txtMount__'+i).val());
            	}	
                
                sum();
                refreshBbt();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cub') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
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
				as['noa'] = abbm2['noa'];
				return true;
			}
			function bbtSave(as) {
				if (!as['productno'] && !as['product'] && !as['mount'] && !as['weight'] && !as['memo']) {
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
                    $('#cmbProcess').attr('disabled','disabled');
                    $('#btnOrde').attr('disabled','disabled');
                    $('#btnCubu_rk').removeAttr('disabled');
                    $('#combProcess').attr('disabled','disabled');
                } else {	
                    $('#txtDatea').datepicker();
                    $('#cmbProcess').removeAttr('disabled');
                    $('#btnOrde').removeAttr('disabled');
                    $('#btnCubu_rk').attr('disabled', 'disabled');
                    $('#combProcess').removeAttr('disabled');
                    if($('#txtVcceno').val().length>0)
                    	$('#txtVcceno').attr('disabled','disabled');
                }
			}
			
			function getPosition(element) {
			    var xPosition = 0;
			    var yPosition = 0;
			  
			    while(element) {
			        xPosition += (element.offsetLeft - element.scrollLeft + element.clientLeft);
			        yPosition += (element.offsetTop - element.scrollTop + element.clientTop);
			        element = element.offsetParent;
			    }
			    return { x: xPosition, y: yPosition };
			}
			
			function refreshBbt(){
				if($('input:radio:checked[name="rbNum"]').length>0){
	                var n = $('input:radio:checked[name="rbNum"]').attr('id').replace(/^(.*)_(\d+)$/,'$2');
	                var t_noq = $('#txtNoq_'+n).val();
	                for(var i=0;i<q_bbtCount;i++){
	                	if($('#txtUno__'+i).val().length==0
	                		&& $('#txtProductno__'+i).val().length==0
	                		&& $('#txtProduct__'+i).val().length==0
	                		&& $('#txtMemo__'+i).val().length==0
	                		&& q_float('txtMount__'+i)==0
	                		&& q_float('txtWeight__'+i)==0){
	                		if($('#txtNor__'+i).val().length!=0){
								$('#txtNor__'+i).val(t_noq);      
	                		}		
                		}else{
                			
                		}
                		if($('#txtNor__'+i).val().length==0){
							$('#txtNor__'+i).val(t_noq);      
                		}
	                }
                }
				
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
						
						$('#rbNum_'+i).click(function(e){
							var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
							var noq = $('#txtNoq_'+n).val(); 
							
							var top = getPosition(this).y + 30;
							var left = getPosition(this).x + 20;
							//alert($(this).css('top')+'_'+top+'__'+left);
							$('#dbbt').css('top',top);
							$('#dbbt').css('left',left);
							$('#dbbt').show();
							refreshBbt();
							bbtAssign();
						});
						$('#txtUno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtUno_', '');
                            
							if(!(q_cur==1 || q_cur==2))
								return;
							var t_noa = $('#txtNoa').val();
		                	var t_where ='';
		                	q_box("cng_cub_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where+";"+";"+JSON.stringify({cubno:t_noa,n:n,page:'cub_rk'}), "cng_cub_"+n, "95%", "95%", '');
                        });
                        /*$('#txtProductno_' + i).bind('contextmenu', function(e) {
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            $('#btnProduct_'+n).click();
                        });*/
                        $('#txtScolor_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            if(!(q_cur==1 || q_cur==2))
								return;
                            var n = $(this).attr('id').replace('txtScolor_', '');
                            $('#btnScolor_'+n).click();
                        });
                        $('#txtZinc_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            if(!(q_cur==1 || q_cur==2))
								return;
                            var n = $(this).attr('id').replace('txtZinc_', '');
                            $('#btnZinc_'+n).click();
                        });
                        $('#txtCustno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            if(!(q_cur==1 || q_cur==2))
								return;
                            var n = $(this).attr('id').replace('txtCustno_', '');
                            $('#btnCust_'+n).click();
                        });
					}
				}
				_bbsAssign();
				refreshBbt();
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
			function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                    	$('#txtProductno__' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            if(!(q_cur==1 || q_cur==2))
								return;
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            $('#btnProduct__'+n).click();
                        });
                        $('#txtUno__' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            if(!(q_cur==1 || q_cur==2))
								return;
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            $('#btnUno__'+n).click();
                        });
                        $('#txtWeight__' + i).bind('change', function(e) {
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                    		if($('#txtProductno__'+n).val().length>0){
                    			t_where = "where=^^ noa='" + trim($('#txtProductno__'+n).val()) + "' ^^";
                    			q_gt('ucc', t_where, 0, 0, 0, JSON.stringify({action:"getDensity",n:n}), r_accy);
                    		}
                    	});
                    }
                }
                _bbtAssign();
                if($('input:radio:checked[name="rbNum"]').length>0){
	                var n = $('input:radio:checked[name="rbNum"]').attr('id').replace(/^(.*)_(\d+)$/,'$2');
	                var t_noq = $('#txtNoq_'+n).val();
	                $('#dbbt').find('tr').hide();
	                $('#dbbt').find('tr').eq(0).show();
	                var m = 0;
	                for(var i=0;i<q_bbtCount;i++){
	                	if($('#txtNor__'+i).val() == t_noq || $('#txtNor__'+i).val().length==0){
	                		$('#lblNo__' + i).text(m++ + 1);
	                		$('#txtNor__'+i).parent().parent().show();
	                	}
	                }
                }
            }
			function ImportOrde(n){
				var t_ordeno = $('#txtOrdeno_'+n).val();
				var t_no2 = $('#txtNo2_'+n).val();
				if(t_ordeno.length>0 && t_no2.length>0){
					var t_where = "where=^^ noa='"+t_ordeno+"' and no2='" + t_no2 + "' ^^";
                	q_gt('view_ordes', t_where, 0, 0, 0, JSON.stringify({action:'importOrde',n:n,ordeno:t_ordeno,no2:t_no2}), r_accy);
				}
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
				q_box('cub_rk_s.aspx', q_name + '_s', "500px", "500px", q_getMsg("popSeek"));
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
				toIns = false;
				_btnDele();	
			}

			function btnCancel() {
				toIns = false;
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
					case 'txtUno_':
						var bbs_n = b_seq;
						t_spec = $.trim($('#txtSize_'+bbs_n).val());
						if(t_spec.length>0){
							t_where = "where=^^ noa='" + t_spec + "' ^^";
							q_gt('spec', t_where, 0, 0, 0, JSON.stringify({action:"getSpec",n:bbs_n}), r_accy);
						}
						break;
					case 'txtUno__':
						var bbt_n = b_seq;
						var bbs_n = $('input:radio:checked[name="rbNum"]').attr('id').replace(/^(.*)_(\d+)$/,'$2');
						var t_nor = $('#txtNoq_'+bbs_n).val();
						if($('#txtNor__'+bbt_n).val().length==0)
							$('#txtNor__'+bbt_n).val(t_nor);
							
						t_where = "where=^^ uno='" + trim($('#txtUno__'+bbt_n).val()) + "' ^^";
            			q_gt('view_uccb', t_where, 0, 0, 0, JSON.stringify({action:"getProduct",n:bbt_n}), r_accy);
						break;
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
				width: 2650px;
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
                width: 1000px;
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
						<td style="width:80px; color:black;"><a>製造批號</a></td>
						<td style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td style="width:100px; color:black;">生產製程</td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='vcceno' style="text-align: center;">~vcceno</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='process' style="text-align: center;">~process</td>
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
						<td><span> </span><a class="lbl" >生產製程</a></td>
						<td>
							<input id="txtProcess" type="text" class="txt" style="float:left;width:80%;"/>
							<select id="combProcess" class="txt" style="float:left;width:15%;"> </select>
						</td>
						<td><span> </span><a class="lbl">製造批號</a></td>
						<td><input id="txtVcceno" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="3"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMonth" class="lbl" style="display:none;">月份</a></td>
						<td><input id="txtMonth" type="text" class="txt c1" style="display:none;"/></td>
						<td> </td>
						<td><input type="button" id="btnOrde" value="訂單匯入" /></td>
					</tr>
					<tr>
						<td> </td>
						<td> </td>
						<td> </td>
						<td><input type="button" id="btnCubu_rk" value="物料" /></td>
					</tr>
					<tr> </tr>
				</table>
			</div>
			<div class='dbbs'>
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;display:none;">
							<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"> </td>
						<td style="width:40px;"> </td>
						<td style="width:200px;" align="center">訂單號碼</td>
						<td style="width:100px;" align="center">客戶</td>
						<td style="width:200px;" align="center">鋼捲編號</td>
						<td style="width:100px;" align="center">品名</td>
						<td style="width:100px;" align="center">COIL<BR>規格<BR>尺寸(厚X寬)</td>
						<td style="width:100px;" align="center">COIL<BR>重量(KG)</td>
						<td style="width:100px;" align="center">PVC皮規格</td>
						<td style="display:none;" align="center">RECOIL編號</td>
						<td style="width:100px;" align="center">RECOIL<BR>M<BR>重量(KG)</td>
						<td style="width:100px;" align="center">廢料重量(KG)</td>
						<td style="width:100px;" align="center">包裝數量<BR>/LOT</td>
						<td style="display:none;" align="center">開始時間</td>
						<td style="display:none;" align="center">結束時間</td>	
						<td style="width:80px;" align="center">施工工時(分)</td>
						<!-- COIL 重量(KG) = 耗料重-->
						<td style="display:none;" align="center">耗料重</td>
						<td style="width:80px;" align="center">投入重量</td>
						<td style="width:100px;" align="center">原物料成本</td>
						<td style="width:80px;" align="center">直接人工</td>
						<td style="width:80px;" align="center">製造費用</td>
						<td style="width:150px;" align="center">製造批號</td>
						<td style="width:80px;" align="center">鋼捲<BR>重量</td>
						<td style="width:80px;" align="center">皮膜<BR>重量</td>
						<td style="width:80px;" align="center">保護膜<BR>重量</td>
						<td style="width:80px;" align="center">接著劑<BR>重量</td>
						<td style="width:80px;" align="center">接著劑<BR>稀釋液<BR>重量</td>
						<td style="width:80px;" align="center">背漆<BR>重量</td>
						<td style="width:80px;" align="center">背漆<BR>稀釋液<BR>重量</td>
						<td style="width:80px;" align="center">面漆<BR>重量</td>
						<td style="width:80px;" align="center">鋼捲<BR>成本</td>
						<td style="width:80px;" align="center">皮膜<BR>成本</td>
						<td style="width:80px;" align="center">保護膜<BR>成本</td>
						<td style="width:80px;" align="center">接著劑<BR>成本</td>
						<td style="width:80px;" align="center">接著劑<BR>稀釋液<BR>成本</td>
						<td style="width:80px;" align="center">背漆<BR>成本</td>
						<td style="width:80px;" align="center">背漆<BR>稀釋液<BR>成本</td>
						<td style="width:80px;" align="center">面漆<BR>成本</td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td align="center" style="display: none;">
							<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						</td>
						<td>
							<input type="radio" id="rbNum.*" name="rbNum"/>
							<input id="txtNoq.*" type="text" style="display:none;"/>
						</td>
						<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td>
							<input id="txtOrdeno.*" type="text" style="float:left;width:70%;"/>
							<input id="txtNo2.*" type="text" style="float:left;width:20%;"/>
						</td>
						<td>
							<input id="txtCustno.*" type="text" style="float:left;width:95%;"/>
							<input id="txtComp.*" type="text" style="float:left;width:95%;"/>
							<input id="btnCust.*" type="button" style="display:none;"/>
						</td>
						<td title="鋼捲編號">
							<input id="txtUno.*" type="text" style="float:left;width:95%;"/>
						</td>
						<td>
							<input class="txt" id="txtProductno.*" type="text" style="width:95%;float:left;"/>
							<input class="txt" id="txtProduct.*" type="text" style="width:95%;float:left;"/>
							<input id="btnProduct.*" type="button" style="display:none;">
						</td>
						<td>
							<input id="txtSize.*" type="text" style="float:left;width:95%;"/>
							<input id="txtDime.*" type="text" class="num" style="float:left;width:45%;"/>
							<input id="txtWidth.*" type="text" class="num" style="float:left;width:45%;"/>
						</td>
						<td><input id="txtWeight.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td title="PVC皮規格">
							<input id="txtRadius.*" type="text" class="num" style="float:left;width:45%;"/>
							<input id="txtLengthb.*" type="text" class="num" style="float:left;width:45%;"/>
						</td>
						<td title="RECOIL編號" style="display:none;">
							<input id="txtOth.*" type="text" style="float:left;width:95%;"/>
						</td>
						<td title="RECOIL重量(KG)">
							<input id="txtW09.*" type="text" class="num" style="float:left;width:95%;"/>
							<input id="txtHweight.*" type="text" class="num" style="float:left;width:95%;"/>
						</td>
						
						<td title="廢料重量(KG)">
							<input id="txtPrice.*" type="text" class="num" style="float:left;width:95%;" title="由損耗月報表產生"/>
						</td>
						<td title="包裝數量/LOT">
							<input id="txtMount.*" type="text" class="num" style="float:left;width:95%;"/>
						</td>
						<td style="display:none;"><input id="txtBtime.*" type="text" style="float:left;width:95%;"/></td>
						<td style="display:none;"><input id="txtEtime.*" type="text" style="float:left;width:95%;"/></td>
						<td><input id="txtMins.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<!-- COIL 重量(KG) = 耗料重-->
						<td style="display:none;"><input id="txtGweight.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td><input id="txtW03.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td><input id="txtTotal.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td><input id="txtW01.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td><input id="txtW02.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td><input id="txtMakeno.*" type="text" style="float:left;width:95%;"/></td>
						<td><input id="txtX01.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td><input id="txtX02.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td><input id="txtX03.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td><input id="txtX04.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td><input id="txtX05.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td><input id="txtX06.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td><input id="txtX07.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td><input id="txtX08.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td><input id="txtY01.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td><input id="txtY02.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td><input id="txtY03.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td><input id="txtY04.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td><input id="txtY05.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td><input id="txtY06.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td><input id="txtY07.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td><input id="txtY08.*" type="text" class="num" style="float:left;width:95%;"/></td>
					</tr>
				</table>
			</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" style="position: absolute; z-index: 2;top:100px;left:600px;display:none;" >
			<table id="tbbt">
				<tbody>
					<tr class="head" style="color:white; background:#003366;">
						<td style="width:20px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"><input type="button" value="關閉" onclick="$('#dbbt').hide();"/></td>
						<td style="width:80px; text-align: center;">類型</td>
						<td style="width:200px; text-align: center;">批號</td>
						<td style="width:200px; text-align: center;">品名</td>
						<td style="width:100px; text-align: center;">用量M</td>
						<td style="width:100px; text-align: center;">重量KG</td>
						<td style="width:200px; text-align: center;">備註</td>
					</tr>
					<tr>
						<td>
							<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
							<input class="txt" id="txtNor..*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td><select id="cmbKind..*" style="width:95%;"> </select></td>
						<td>
							<input class="txt" id="txtUno..*" type="text" style="width:95%;" />
							<input id="btnUno..*" type="button" style="display:none;" />
						</td>
						<td>
							<input class="txt" id="txtProductno..*" type="text" style="width:45%;float:left;"/>
							<input class="txt" id="txtProduct..*" type="text" style="width:45%;float:left;"/>
							<input id="btnProduct..*" type="button" style="display:none;">
						</td>
						<td>
							<input class="txt" id="txtMount..*" type="text" style="display:none;"/>
							<input class="txt" id="txtGmount..*" type="text" style="display:none;"/>
							<input class="txt" id="txtWeight..*" type="text" style="width:95%;text-align: right;"/>
							<input class="txt" id="txtGweight..*" type="text" style="display:none;"/>
						</td>
						<td>
							<input class="txt" id="txtWweight..*" type="text" style="width:95%;text-align: right;"/>
						</td>
						<td><input class="txt" id="txtMemo..*" type="text" style="width:95%;" /></td>
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>