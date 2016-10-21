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
            var q_name = "get_rk", t_content = "where=^^['','')^^", bbsKey = ['inano','inanoq'], as;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
       		brwCount = -1;
			brwCount2 = -1;
            $(document).ready(function() {
                main();
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                var t_para = new Array();
	            try{
	            	t_para = JSON.parse(decodeURIComponent(q_getId()[5]));
	            	t_content = "where=^^['"+t_para.noa+"','"+t_para.custno+"')^^";
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
						abbs = _q_appendData(q_name, "", true);
						refresh();
						break;
				}
			}

            function refresh() {
                _refresh();
                for(var i=0;i<q_bbsCount;i++){
					$('#lblNo_'+i).text(i+1);
				}
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
					<td align="center" style="width:30px;max-width: 30px;"><a>　</a></td>
					<td align="center" style="width:60px;max-width: 60px;">客戶</td>
					<td align="center" style="width:80px;max-width: 80px;">批號</td>
					<td align="center" style="width:100px;max-width: 100px;">品名</td>
					<td align="center" style="width:60px;max-width: 60px;">底材</td>
					<td align="center" style="width:60px;max-width: 60px;">厚</td>
					<td align="center" style="width:60px;max-width: 60px;">皮膜<br>厚</td>
					<td align="center" style="width:60px;max-width: 60px;">寬</td>
					<td align="center" style="width:60px;max-width: 60px;">長</td>
					<td align="center" style="width:100px;max-width: 80px;">皮膜</td>
					<td align="center" style="width:60px;max-width: 60px;">背面<br>處理</td>
					<td align="center" style="width:60px;max-width: 60px;">保護膜</td>
					<td align="center" style="width:60px;max-width: 60px;">單位</td>
					<td align="center" style="width:60px;max-width: 60px;">件數</td>
					<td align="center" style="width:60px;max-width: 60px;">數量</td>
					<td align="center" style="width:60px;max-width: 60px;">重量</td>
					<td align="center" style="width:80px;max-width: 80px;">備註</td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:450px;" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:100%;' >
				<tr style="display:none;">
					<th align="center" style="width:25px;max-width: 25px;"><a>　</a></th>
					<td align="center" style="width:30px;max-width: 30px;"><a>　</a></td>
					<td align="center" style="width:60px;max-width: 60px;">客戶</td>
					<td align="center" style="width:80px;max-width: 80px;">批號</td>
					<td align="center" style="width:100px;max-width: 100px;">品名</td>
					<td align="center" style="width:60px;max-width: 60px;">底材</td>
					<td align="center" style="width:60px;max-width: 60px;">厚</td>
					<td align="center" style="width:60px;max-width: 60px;">皮膜<br>厚</td>
					<td align="center" style="width:60px;max-width: 60px;">寬</td>
					<td align="center" style="width:60px;max-width: 60px;">長</td>
					<td align="center" style="width:80px;max-width: 80px;">皮膜</td>
					<td align="center" style="width:60px;max-width: 60px;">背面<br>處理</td>
					<td align="center" style="width:60px;max-width: 60px;">保護膜</td>
					<td align="center" style="width:60px;max-width: 60px;">單位</td>
					<td align="center" style="width:60px;max-width: 60px;">件數</td>
					<td align="center" style="width:60px;max-width: 60px;">數量</td>
					<td align="center" style="width:60px;max-width: 60px;">重量</td>
					<td align="center" style="width:80px;max-width: 80px;">備註</td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:25px;max-width: 25px;"><input type="checkbox" class="ccheck" id="chkSel.*"/></td>
					<td style="width:30px;max-width: 30px;">
						<a id="lblNo.*" style="font-weight: bold;" readonly="readonly"> </a>
						<input id="txtOrdeno.*" type="text" style="display:none;"/>	
						<input id="txtNo2.*" type="text" style="display:none;"/>						
					</td>
					<td style="width:60px;max-width: 60px;"><input id="txtCust.*" type="text" style="float:left;width:95%;"  readonly="readonly" /></td>
					<td style="width:80px;max-width: 80px;"><input id="txtUno.*" type="text" style="float:left;width:95%;"  readonly="readonly" /></td>
					<td style="width:100px;max-width: 100px;">
						<input id="txtProductno.*" type="text" style="float:left;width:30%;"  readonly="readonly" />
						<input id="txtProduct.*" type="text" style="float:left;width:60%;"  readonly="readonly" />
					</td>
					<td style="width:60px;max-width: 60px;"><input id="txtStyle.*" type="text" style="float:left;width:95%;"  readonly="readonly" /></td>
					<td style="width:60px;max-width: 60px;"><input id="txtDime.*" type="text" style="float:left;width:95%;"  readonly="readonly" /></td>
					<td style="width:60px;max-width: 60px;"><input id="txtRadius.*" type="text" style="float:left;width:95%;"  readonly="readonly" /></td>
					<td style="width:60px;max-width: 60px;"><input id="txtWidth.*" type="text" style="float:left;width:95%;"  readonly="readonly" /></td>
					<td style="width:60px;max-width: 60px;"><input id="txtLengthb.*" type="text" style="float:left;width:95%;"  readonly="readonly" /></td>
					<td style="width:80px;max-width: 80px;">
						<input id="txtSpec.*" type="text" style="float:left;width:45%;"  readonly="readonly" />
						<input id="txtClass.*" type="text" style="float:left;width:45%;"  readonly="readonly" />
					</td>
					<td style="width:60px;max-width: 60px;"><input id="txtUcolor.*" type="text" style="float:left;width:95%;"  readonly="readonly" /></td>
					<td style="width:60px;max-width: 60px;"><input id="txtRackno.*" type="text" style="float:left;width:95%;"  readonly="readonly" /></td>
					<td style="width:60px;max-width: 60px;"><input id="txtUnit.*" type="text" style="float:left;width:95%;"  readonly="readonly" /></td>
					<td style="width:60px;max-width: 60px;"><input id="txtLengthc.*" type="text" style="float:left;width:95%;"  readonly="readonly" /></td>
					<td style="width:60px;max-width: 60px;"><input id="txtEmount.*" type="text" style="float:left;width:95%;"  readonly="readonly" /></td>
					<td style="width:60px;max-width: 60px;"><input id="txtEweight.*" type="text" style="float:left;width:95%;"  readonly="readonly" /></td>
					<td style="width:60px;max-width: 60px;"><input id="txtMemo.*" type="text" style="float:left;width:95%;"  readonly="readonly" /></td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/pop_ctrl.inc"-->
	</body>
</html>

