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
            var q_name = "ordb_ordc",
                t_content = "where=^^['','')^^",
                bbsKey = ['noa', 'no3'],
                as;
            var isBott = false;
            var txtfield = [],
                afield,
                t_data,
                t_htm,
                t_bbsTag = 'tbbs';
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
                try {
                    t_para = JSON.parse(decodeURIComponent(q_getId()[5]));
                    t_content = "where=^^['"+t_para.ordcno+"','"+t_para.tggno+"','"+t_para.kind+"','"+t_para.page+"')^^";
                } catch(e) {
                }
                brwCount = -1;
                mainBrow(0, t_content);
            }

            function mainPost() {
                $('#btnTop').hide();
                $('#btnPrev').hide();
                $('#btnNext').hide();
                $('#btnBott').hide();

                $('#checkAllCheckbox').click(function(e) {
                    $('.ccheck').prop('checked', $(this).prop('checked'));
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
            }
		</script>
		<style type="text/css">
		</style>
	</head>

	<body>
		<div  id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;'  >
				<tr style='color:white; background:#003366;' >
					<th align="center" style="width:2%;"><input type="checkbox" id="checkAllCheckbox"/></th>
					<td align="center" style="width:15%;">廠商</td>
					<td align="center" style="width:30%;">品名</td>
					<td align="center" style="width:15%;">規格</td>
					<td align="center" style="width:5%;">厚</td>
					<td align="center" style="width:5%;">寬</td>
					<td align="center" style="width:5%;">長</td>
					<td align="center" style="width:5%;">單位</td>
					<td align="center" style="width:5%;">數量</td>
					<td align="center" style="width:5%;">重量</td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:450px;" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:100%;' >
				<tr style="display:none;">
					<th align="center" style="width:2%;"><input type="checkbox" id="checkAllCheckbox"/></th>
					<td align="center" style="width:15%;">廠商</td>
					<td align="center" style="width:30%;">品名</td>
					<td align="center" style="width:15%;">規格</td>
					<td align="center" style="width:5%;">厚</td>
					<td align="center" style="width:5%;">寬</td>
					<td align="center" style="width:5%;">長</td>
					<td align="center" style="width:5%;">單位</td>
					<td align="center" style="width:5%;">數量</td>
					<td align="center" style="width:5%;">重量</td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:2%;">
					<input type="checkbox" class="ccheck" id="chkSel.*"/>
					<input id="txtAccy.*" type="text" style="display:none;"  readonly="readonly" />
					<input id="txtNoa.*" type="text" style="display:none;"  readonly="readonly" />
					<input id="txtNo3.*" type="text" style="display:none;"  readonly="readonly" />
					</td>
					<td style="width:15%;">
					<input id="txtTgg.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
					</td>
					<td style="width:30%;">
						<input id="txtProductno.*" type="text" style="float:left;width:30%;"  readonly="readonly" />
						<input id="txtProduct.*" type="text" style="float:left;width:65%;"  readonly="readonly" />
						<input id="txtProductno1.*" type="text" style="display:none;"  readonly="readonly" />
					</td>
					<td style="width:15%;">
						<input id="txtCspec.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
					</td>
					<td style="width:5%;">
					<input id="txtDime.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
					</td>
					<td style="width:5%;">
					<input id="txtWidth.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
					</td>
					<td style="width:5%;">
					<input id="txtLengthb.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
					</td>
					<td style="width:5%;">
					<input id="txtUnit.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
					</td>
					<td style="width:5%;">
					<input id="txtMount.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
					</td>
					<td style="width:5%;">
					<input id="txtWeight.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
					</td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/pop_ctrl.inc"-->
	</body>
</html>

