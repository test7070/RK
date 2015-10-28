<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'z_cub_rkp');       
            });
            function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_cub_rkp',
					options : [{
						type : '0', //[1]
						name : 'path',
						value : location.protocol + '//' +location.hostname + location.pathname.toLowerCase().replace('z_cub_rkp.aspx','')
					},{
						type : '0', //[2]
						name : 'db',
						value : q_db
					},{
						type : '6', //[3]
						name : 'noa'
					},{//[4][5]
                        type : '1',
                        name : 'xmon'
                    }]
				});
				q_popAssign();

	            var t_para = new Array();
	            try{
	            	t_para = JSON.parse(q_getId()[3]);
	            }catch(e){
	            }    
	            if(t_para.length==0 || t_para.noa==undefined){
	            }else{
	            	$('#txtNoa').val(t_para.noa);
	            }
	            $('#txtXmon1').mask('999/99');
                $('#txtXmon2').mask('999/99');
                
	            $('#textBmon').mask('999/99');
                $('#textEmon').mask('999/99');
                
                $('#btnCostbcc').click(function(e) {
                    $('#divExport').toggle();
                });
                $('#btnDivexport').click(function(e) {
                    $('#divExport').hide();
                });
                $('#btnExport').click(function(e) {
                    var t_bmon = $('#textBmon').val();
                    var t_emon = $('#textBmon').val();
                    if (t_bmon.length > 0 && t_emon.length > 0) {
                        Lock(1, {
                            opacity : 0
                        });
                        q_func( 'ucf.bcc' , t_bmon+","+t_emon);
                    } else
                        alert('請輸入月份。');
                });
            }
			function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'ucf.bcc':
                        alert('計算完成。');
                        Unlock(1);
                        break;
                    default:
                        break;
                }
            }
			function q_gtPost(s2) {}
		</script>
		
		<style type="text/css">
			#frameReport table{
					border-collapse: collapse;
				}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<input type="button" id="btnCostbcc" value="物料成本計算"/>
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">			
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
		<div id="divExport" style="display:none;position:absolute;top:100px;left:600px;width:400px;height:120px;background:RGB(237,237,237);">
            <table style="border:4px solid gray; width:100%; height: 100%;">
                <tr style="height:1px;background-color: pink;">
                    <td style="width:25%;"></td>
                    <td style="width:25%;"></td>
                    <td style="width:25%;"></td>
                    <td style="width:25%;"></td>
                </tr>
                <tr>
                    <td style="padding: 2px;text-align: center;border-width: 0px;background-color: pink;color: blue;"><a>月份</a></td>
                    <td colspan="3" style="padding: 2px;text-align: center;border-width: 0px;background-color: pink;">
                    	<input type="text" id="textBmon" style="float:left;width:40%;"/>
                    	<span style="display:block;width:20px;float:left;">～</span>
                    	<input type="text" id="textEmon" style="float:left;width:40%;"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center" style="background-color: pink;">
                    <input type="button" id="btnExport" value="計算"/>
                    </td>
                    <td colspan="2" align="center" style=" background-color: pink;">
                    <input type="button" id="btnDivexport" value="關閉"/>
                    </td>
                </tr>
            </table>
        </div>
	</body>
</html>
           
          