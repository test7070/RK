<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = "cut_vcc", t_content = "where=^^['','')^^", bbsKey = ['noa','noq'], as;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
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
	            	t_content = "where=^^['"+t_para.vccno+"','"+t_para.custno+"','"+t_para.page+"')^^";
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
                $('#tbbs').find('tr.data').children().hover(function(e){
					$(this).parent().css('background','yellow');
				},function(e){
					$(this).parent().css('background','#cad3ff');
				});
            }
		</script>
		<style type="text/css">
		</style>
	</head>


		
	<body>
		<div  id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;'  >
				<tr style='color:white; background:#003366;' >
					<th align="center" style="width:2%;" rowspan="2"><input type="checkbox" id="checkAllCheckbox"/></th>
					<td align="center" style="width:10%;" rowspan="2">單號</td>
					<td align="center" style="width:20%;" rowspan="2">品名</td>
					<td align="center" style="width:5%;" rowspan="1">厚</td>
					<td align="center" style="width:5%;" rowspan="1">皮膜厚</td>
					<td align="center" style="width:5%;" rowspan="1">寬</td>
					<td align="center" style="width:5%;" rowspan="1">長</td>
					<td align="center" style="width:5%;" rowspan="1">單位</td>
					<td align="center" style="width:10%;" rowspan="2">皮膜</td>
					<td align="center" style="width:5%;" rowspan="2">背面<br>處理</td>
					<td align="center" style="width:5%;" rowspan="2">保護膜</td>
					<td align="center" style="width:5%;" rowspan="2">件數</td>
					<td align="center" style="width:5%;" rowspan="2">數量</td>
					<td align="center" style="width:5%;" rowspan="2">重量</td>
					<td align="center" style="width:5%;" rowspan="2">單價</td>
					<!--<td align="center" style="width:8%;">備註</td>-->
				</tr>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:25%;" colspan="5">備註</td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:450px;" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:100%;' >
				<tr style="display:none;">
					<th align="center" style="width:2%;"></th>
					<td align="center" style="width:10%;">單號</td>
					<td align="center" style="width:20%;">品名</td>
					<td align="center" style="width:5%;">厚</td>
					<td align="center" style="width:5%;">皮膜厚</td>
					<td align="center" style="width:5%;">寬</td>
					<td align="center" style="width:5%;">長</td>
					<td align="center" style="width:5%;">單位</td>
					<td align="center" style="width:10%;">皮膜</td>
					<td align="center" style="width:5%;">背面<br>處理</td>
					<td align="center" style="width:5%;">保護膜</td>
					<td align="center" style="width:5%;">件數</td>
					<td align="center" style="width:5%;">數量</td>
					<td align="center" style="width:5%;">重量</td>
					<td align="center" style="width:5%;">單價</td>
				</tr>
				<tr class="data" style='background:#cad3ff;'>
					<td style="width:2%;"><input type="checkbox" class="ccheck" id="chkSel.*"/></td>
					<td style="width:10%;">
						<input id="txtAccy.*" type="text" style="display:none;"  readonly="readonly" />
						<input id="txtNoa.*" type="text" style="float:left;width:70%;"  readonly="readonly" />
						<input id="txtNo2.*" type="text" style="float:left;width:25%;"  readonly="readonly" />
					</td>
					<td style="width:20%;">
						<input id="txtProductno.*" type="text" style="float:left;width:45%;"  readonly="readonly" />
						<input id="txtProduct.*" type="text" style="float:left;width:55%;"  readonly="readonly" />
					</td>
					<td style="width:25%;" colspan="5">
						<input id="txtDime.*" type="text" style="float:left;width:20%;"  readonly="readonly" />
						<input id="txtRadius.*" type="text" style="float:left;width:20%;"  readonly="readonly" />
						<input id="txtWidth.*" type="text" style="float:left;width:20%;"  readonly="readonly" />
						<input id="txtLengthb.*" type="text" style="float:left;width:20%;"  readonly="readonly" />
						<input id="txtUnit.*" type="text" style="float:left;width:20%;"  readonly="readonly" />
						<input id="txtMemo.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
					</td>
					<!--
					<td style="width:5%;"><input id="txtDime.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:5%;"><input id="txtRadius.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:5%;"><input id="txtWidth.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:5%;"><input id="txtLengthb.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:5%;"><input id="txtUnit.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					-->
					<td style="width:10%;">
						<input id="txtSpec.*" type="text" style="float:left;width:50%;"  readonly="readonly" />
						<input id="txtClass.*" type="text" style="float:left;width:50%;"  readonly="readonly" />
					</td>
					<td style="width:5%;"><input id="txtStyle.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:5%;"><input id="txtSource.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:5%;"><input id="txtLengthc.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:5%;"><input id="txtMount.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:5%;"><input id="txtWeight.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:5%;"><input id="txtPrice.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<!--
					<td style="width:8%;"><input id="txtMemo.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					-->
				</tr>
			</table>
		</div>
		<!--#include file="../inc/pop_ctrl.inc"-->
	</body>
</html>

