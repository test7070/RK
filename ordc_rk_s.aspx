<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
            var q_name = "ordc_rk_s";
			aPop = new Array(['txtTggno', 'lblTgg', 'tgg', 'noa,nick', 'txtTggno', 'tgg_b.aspx']);
            $(document).ready(function() {
                main();
            });
            function main() {
                mainSeek();
                q_gf('', q_name);
            }

            function q_gfPost() {
                q_getFormat();
                q_langShow();
                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd],['txtBodate', r_picd], ['txtEodate', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbKind", '@全部,'+q_getPara('sys.stktype')+',2@物料');
                q_cmbParse("cmbEnda", '@全部,1@已結案,0@未結案');
                $('#txtBdate').datepicker();
				$('#txtEdate').datepicker(); 
				$('#txtBodate').datepicker();
				$('#txtEodate').datepicker(); 
                $('#txtNoa').focus();
            }
            function q_seekStr() {
            	t_kind = $.trim($('#cmbKind').val());
            	t_enda = $.trim($('#cmbEnda').val());
                t_noa = $.trim($('#txtNoa').val());
		        t_tggno = $.trim($('#txtTggno').val());
		        t_tgg = $.trim($('#txtTgg').val());
		        t_ordbno = $.trim($('#txtOrdbno').val());

		        t_bdate = $('#txtBdate').val();
		        t_edate = $('#txtEdate').val();
		        t_bodate = $('#txtBodate').val();
		        t_eodate = $('#txtEodate').val();

		        var t_where = " 1=1 " 
		        + q_sqlPara2("kind", t_kind)
		        + q_sqlPara2("noa", t_noa) 
		        + q_sqlPara2("datea", t_bdate, t_edate) 
		        + q_sqlPara2("odate", t_bodate, t_eodate) 		     
		        + q_sqlPara2("tggno", t_tggno);
		        if (t_tgg.length>0)
                    t_where += " and charindex('" + t_tgg + "',tgg)>0";
                if (t_ordbno.length>0)
                    t_where += " and exists(select noa from view_ordcs"+r_accy+" where view_ordcs"+r_accy+".noa=view_ordc"+r_accy+".noa and view_ordcs"+r_accy+".ordbno='"+t_ordbno+"')";
		       	if(t_enda=='0'){
		       		t_where += " and (enda=0 and exists(select noa from view_ordcs"+r_accy+" where view_ordcs"+r_accy+".noa=view_ordc"+r_accy+".noa and view_ordcs"+r_accy+".enda=0))";
		       	}
		       	if(t_enda=='1'){
		       		t_where += " and (enda=1 or exists(select noa from view_ordcs"+r_accy+" where view_ordcs"+r_accy+".noa=view_ordc"+r_accy+".noa and view_ordcs"+r_accy+".enda=1))";
		       	}
		       	
		        t_where = ' where=^^' + t_where + '^^ ';
		        return t_where;
            }
		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                background-color: #76a2fe;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblKind'>類別</a></td>
					<td><select id="cmbKind" style="width:215px; font-size:medium;" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblEnda'>是否結案</a></td>
					<td><select id="cmbEnda" style="width:215px; font-size:medium;" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'>採購單號</a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblDatea'>有效日期</a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblOdate'>採購日期</a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBodate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEodate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTggno'>廠商編號</a></td>
					<td>
					<input class="txt" id="txtTggno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTgg'>廠商名稱</a></td>
					<td>
					<input class="txt" id="txtTgg" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblOrdbno'>請購單號</a></td>
					<td>
					<input class="txt" id="txtOrdbno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>