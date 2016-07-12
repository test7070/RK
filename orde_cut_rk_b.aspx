<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = "orde_vcc", t_content = "where=^^['','')^^", bbsKey = ['noa','no2'], as;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
            var bbsNum = [['txtCnt', 2, 0, 1]];
       		brwCount = -1;
			brwCount2 = -1;
            $(document).ready(function() {
                main();
            });
            /// end ready

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                var t_para = new Array();
	            try{
	            	t_para = JSON.parse(decodeURIComponent(q_getId()[5]));
	            	
	            	if(t_para.page=='cub_rk'){
	            		q_name = "orde_cub";
	            		t_content = "where=^^['"+t_para.cubno+"','"+t_para.page+"')^^";
	            	}else if(t_para.page=='cuc_rk'){
	            		q_name = "orde_cuc";
	            		t_content = "where=^^['"+t_para.cucno+"','"+t_para.page+"')^^";
	            	}else if(t_para.page=='cud_rk'){
	            		q_name = "orde_cud";
	            		t_content = "where=^^['"+t_para.cudno+"','"+t_para.page+"')^^";
	            	}else if(t_para.page=='cut_rk'){
	            		q_name = "orde_cut";
	            		t_content = "where=^^['"+t_para.cutno+"','"+t_para.page+"')^^";
	            	}else{
	            		t_content = "where=^^['"+t_para.vccno+"','"+t_para.custno+"','"+t_para.page+"')^^";
	            	}
	            	 
	            }catch(e){
	            }    
                brwCount = -1;
                mainBrow(0, t_content);
            }
			function mainPost() {
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
				
				$('#checkAllCheckbox').click(function(e){
					$('.ccheck').prop('checked',$(this).prop('checked'));
				});
			}
            function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						//if (isLoadGt == 1) {
							abbs = _q_appendData(q_name, "", true);
							isLoadGt = 0;
							refresh();
						//}
						break;
				}
			}

            function refresh() {
                _refresh();
                for(var i=0;i<q_bbsCount;i++){
					$('#lblNo_'+i).text(i+1);
				}
            }
            function bbsAssign() {
				_bbsAssign();
			}
		</script>
		<style type="text/css">
		</style>
	</head>


		
	<body>
		<div  id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;'  >
				<tr style='color:white; background:#003366;' >
					<th align="center" style="width:25px;max-width: 25px;"><input type="checkbox" id="checkAllCheckbox"/></th>
					<td align="center" style="width:30px;max-width: 30px;"> </td>
					<td align="center" style="width:120px;max-width: 120px;">製造批號</td>
					<td align="center" style="width:120px;max-width: 120px;">訂單編號</td>
					<td align="center" style="width:100px;max-width: 100px;">客戶</td>
					<td align="center" style="width:80px;max-width: 80px;">厚</td>
					<td align="center" style="width:80px;max-width: 80px;">皮膜厚</td>
					<td align="center" style="width:80px;max-width: 80px;">寬</td>
					<td align="center" style="width:80px;max-width: 80px;">長</td>
					<td align="center" style="width:80px;max-width: 80px;">單位</td>
					<td align="center" style="width:120px;max-width: 120px;">品名<br>皮膜</td>
					<td align="center" style="width:80px;max-width: 80px;">背面<br>處理</td>
					<td align="center" style="width:100px;max-width: 100px;">保護膜</td>
					<!--<td align="center" style="width:5%;">保護膜(二)</td>-->
					<td align="center" style="width:80px;max-width: 80px;">數量</td>
					<td align="center" style="width:80px;max-width: 80px;">重量</td>
					<td align="center" style="width:80px;max-width: 80px;">單價</td>
					<td align="center" style="width:80px;max-width: 80px;">備註</td>
					<td align="center" style="width:50px;max-width: 50px;">筆數</td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:450px;" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:100%;' >
				<tr style="display:none;">
					<th align="center" style="width:25px;max-width: 25px;"> </th>
					<td align="center" style="width:30px;max-width: 30px;"> </td>
					<td align="center" style="width:120px;max-width: 120px;">製造批號</td>
					<td align="center" style="width:120px;max-width: 120px;">訂單編號</td>
					<td align="center" style="width:100px;max-width: 100px;">客戶</td>
					<td align="center" style="width:80px;max-width: 80px;">厚</td>
					<td align="center" style="width:80px;max-width: 80px;">皮膜厚</td>
					<td align="center" style="width:80px;max-width: 80px;">寬</td>
					<td align="center" style="width:80px;max-width: 80px;">長</td>
					<td align="center" style="width:80px;max-width: 80px;">單位</td>
					<td align="center" style="width:120px;max-width: 120px;">品名<br>皮膜</td>
					<td align="center" style="width:80px;max-width: 80px;">背面<br>處理</td>
					<td align="center" style="width:100px;max-width: 100px;">保護膜</td>
					<!--<td align="center" style="width:5%;">保護膜(二)</td>-->
					<td align="center" style="width:80px;max-width: 80px;">數量</td>
					<td align="center" style="width:80px;max-width: 80px;">重量</td>
					<td align="center" style="width:80px;max-width: 80px;">單價</td>
					<td align="center" style="width:80px;max-width: 80px;">備註</td>
					<td align="center" style="width:50px;max-width: 50px;">筆數</td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:25px;max-width: 25px;"><input type="checkbox" class="ccheck" id="chkSel.*"/></td>
					<td style="width:30px;max-width: 30px;text-align: center;"><a id="lblNo.*" style="font-weight: bold;" readonly="readonly"> </a></td>
					<td style="width:120px;max-width: 120px;"><input id="txtMakeno.*" type="text" style="float:left;width:95%;"  readonly="readonly" /></td>
					<td style="width:120px;max-width: 120px;">
						<input id="txtAccy.*" type="text" style="display:none;"  readonly="readonly" />
						<input id="txtNoa.*" type="text" style="float:left;width:70%;"  readonly="readonly" />
						<input id="txtNo2.*" type="text" style="float:left;width:25%;"  readonly="readonly" />
					</td>
					<td style="width:100px;max-width: 100px;"><input id="txtComp.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:80px;max-width: 80px;"><input id="txtDime.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:80px;max-width: 80px;"><input id="txtRadius.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:80px;max-width: 80px;"><input id="txtWidth.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:80px;max-width: 80px;"><input id="txtLengthb.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:80px;max-width: 80px;"><input id="txtUnit.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:120px;max-width: 120px;">
						<input id="txtProductno.*" type="text" style="float:left;width:30%;"  readonly="readonly" />
						<input id="txtProduct.*" type="text" style="float:left;width:70%;"  readonly="readonly" />
						<input id="txtPvcno.*" type="text" style="float:left;width:50%;"  readonly="readonly" />
						<input id="txtPvc.*" type="text" style="float:left;width:50%;"  readonly="readonly" />
					</td>
					<td style="width:80px;max-width: 80px;"><input id="txtUcolor.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:100px;max-width: 100px;">
						<input id="txtPeno.*" type="text" style="display:none;"  readonly="readonly" />
						<input id="txtPe.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
					</td>
					<!--<td style="width:5%;">
						<input id="txtZinc.*" type="text" style="display:none;"  readonly="readonly" />
						<input id="txtFlower.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
					</td>-->
					<td style="width:80px;max-width: 80px;"><input id="txtMount.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:80px;max-width: 80px;"><input id="txtWeight.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:80px;max-width: 80px;"><input id="txtPrice.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:80px;max-width: 80px;"><input id="txtMemo.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:50px;max-width: 50px;background-color: pink;"><input type="text" id="txtCnt.*" class="txt num" style="float:left;width:95%;text-align: right;"/></td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/pop_ctrl.inc"-->
	</body>
</html>

