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
			var q_name = 'cubu', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = ['noa'], t_count = 0, as, brwCount = -1;
			brwCount2 = 0;
			var t_sqlname = 'cubu';
			t_postname = q_name;
			var isBott = false;
			var afield, t_htm;
			var i, s1;
			var decbbs = [];
			var decbbm = [];
			var q_readonly = [];
			var q_readonlys = ['txtProductno','txtProduct'];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			var Parent = window.parent;
			var cubBBsArray = '';
			var cubBBtArray = '';
			
			var currentNoa = '';
			
			if (Parent.q_name && Parent.q_name == 'cub') {
				cubBBsArray = Parent.abbsNow;
				cubBBtArray = Parent.abbtNow;
			}
			aPop = new Array(
				['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx']
				,['txtUcolor_', 'btnUcolor_', 'view_uccc2', 'uno,productno,product,eweight', '0txtUcolor_,txtProductno_,txtProduct_,txtWeight_', 'uccc_seek_b2.aspx?;;;1=0', '95%', '95%']
			);
			$(document).ready(function() {
				bbmKey = [];
				bbsKey = ['noa', 'noq'];
				if (!q_paraChk())
					return;
				main();
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
			}

			function mainPost() {
				q_mask(bbmMask);
				parent.$.fn.colorbox.resize({
					height : "750px"
				});
			}


			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#txtUcolor_' + i).bind('contextmenu', function(e) {
							e.preventDefault();
							if(!(q_cur==1 || q_cur==2))
								return;
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            $('#btnUcolor_'+n).click();
                        });
						$('#txtProductno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            if(!(q_cur==1 || q_cur==2))
								return;
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            $('#btnProduct_'+n).click();
                        });
					}
				}
				_bbsAssign();
			}

			function btnOk() {
                
			}
			function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'get_post.post.post1':
                		//alert('done');
	                    qbtnOk();
	                    parent.$.fn.colorbox.close();
                		break;
                	case 'get_post.post.post0':
                		
                		var t_noa = currentNoa;
						q_func('qtxt.query.cub2get', 'cub.txt,cub2get,'+t_noa+';0');
						break;
                	case 'qtxt.query.cub2get1':
               
                		var t_noa = currentNoa;
                		q_func('qtxt.query.cub2get2', 'cub.txt,cub2get,'+t_noa+';1');
                		break;
            		case 'qtxt.query.cub2get2':
            		
            			var t_noa = currentNoa;
                		q_gt('view_get', "where=^^noa='" + t_noa + "'^^", 0, 0, 0, "isexist_get_modi",1);
                		break;
                    default:
                        break;
                }
            }
            function q_gtPost(t_name) {
				switch (t_name) {
					case 'isexist_get_modi':
						var t_noa = currentNoa;
						var as = _q_appendData("view_get", "", true);
						if(as[0]!=undefined){
							q_func('get_post.post.post1', r_accy + ',' + t_noa + ',1');
						}else{
							//alert('done');
							//存檔
		                    qbtnOk();
		                    parent.$.fn.colorbox.close();
						}
						break;
					case q_name:
						break;
					default:
                    	break;
				}
			}
			
			function bbsSave(as) {
				if (!as['ucolor']) {
					as[bbsKey[0]] = '';
					return;
				}
				q_getId2('', as);
				return true;
			}

			function btnModi() {
				var t_key = q_getHref();
				if (!t_key)
					return;
				_btnModi(1);
				$('#btnOk').before($('#btnOk').clone().attr('id', 'btnOk2').show()).hide();
				$('#btnOk2').click(function() {
					//存檔
            		var t_key = q_getHref();
            		_btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
				});
			}
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				
				is_btnOk = 1; 
				var t_key = q_getHref();
				currentNoa = t_key[1];
				if(currentNoa.length>0){
					q_func('qtxt.query.cub2get1', 'cub.txt,cub2get,'+currentNoa+';0');
				}else{
					//存檔
					//alert('error');
                    qbtnOk();
                    parent.$.fn.colorbox.close();
				}
			}
			
			function refresh() {
				_refresh();
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
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();
			}
		</script>
		<style type="text/css">
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.txt {
				float: left;
			}
			.c1 {
				width: 90%;
			}
			.c2 {
				width: 85%;
			}
			.c3 {
				width: 71%;
			}
			.c4 {
				width: 95%;
			}
			.num {
				text-align: right;
			}
			#dbbs {
				width: 2000px;
			}
			.btn {
				font-weight: bold;
			}
			#lblNo {
				font-size: medium;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="dbbs" style="width:800px;">
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;font-size: medium;'>
				<tr style='color:white; background:#003366;' >
					<td align="center">
					<input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:15px;"></td>
					<td align="center" style="width:250px;">批號</td>
					<td align="center" style="width:600px;">品名</td>
					<td align="center" style="width:100px;">重量</td>
					<td align="center" style="width:200px;">備註</td>
					
				</tr>
				<tr style="background:#cad3ff;font-size: 14px;">
					<td><input class="btn"  id="btnMinus.*" type="button" value="－" style="font-weight: bold;"/></td>
					<td style="text-align:center;">
						<a id="lblNo.*"> </a>
						<input type="text" id="txtNoq.*" style="display:none;"/>
					</td>
					<td>
						<input type="text" id="txtUcolor.*" class="txt c1"/>
						<input type="button" id="btnUcolor.*" style="display:none;"/>
					</td>
					<td>
						<input type="text" id="txtProductno.*" class="txt" style="width:30%;"/>
						<input type="text" id="txtProduct.*" class="txt" style="width:65%;"/>
						<input type="button" id="btnProduct.*" style="display:none;"/>
					</td>
					<td><input type="text" id="txtWeight.*" class="txt c1 num"/></td>
					<td><input type="text" id="txtMemo.*" class="txt c1"/></td>					
				</tr>
			</table>
			<!--#include file="../inc/pop_modi.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>