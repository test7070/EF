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
		<script src="css/jquery/ui/jquery.ui.datepicker.js"> </script>
		<script type="text/javascript">
            var q_name = "ztmp_efimport_s";
            $(document).ready(function() {
                main();
                $.datepicker.regional['zh-TW']={
				   dayNames:["星期日","星期一","星期二","星期三","星期四","星期五","星期六"],
				   dayNamesMin:["日","一","二","三","四","五","六"],
				   monthNames:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
				   monthNamesShort:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
				   prevText:"上月",
				   nextText:"次月",
				   weekHeader:"週"
				};
				//將預設語系設定為中文
				$.datepicker.setDefaults($.datepicker.regional["zh-TW"]);
            });
            function main() {
                mainSeek();
                q_gf('', q_name);
            }

            function q_gfPost() {
                q_getFormat();
                q_langShow();

                bbmMask = [['txtBorder_date', '9999/99/99'], ['txtEorder_date', r_picd]
                	,['txtBget_deadline', '9999/99/99'], ['txtEget_deadline', r_picd]];
                q_mask(bbmMask);
				
				$('#txtBorder_date').datepicker({dateFormat: 'yy/mm/dd'});
				$('#txtEorder_date').datepicker({dateFormat: 'yy/mm/dd'});
				$('#txtBget_deadline').datepicker({dateFormat: 'yy/mm/dd'});
				$('#txtEget_deadline').datepicker({dateFormat: 'yy/mm/dd'});
				
                $('#txtBorder_date').focus();
            }

            function q_seekStr() {
                t_noa = $.trim($('#txtNoa').val());
                t_border_date = $.trim($('#txtBorder_date').val());
                t_eorder_date = $.trim($('#txtEorder_date').val());
                t_bget_deadline = $.trim($('#txtBget_deadline').val());
				t_eget_deadline = $.trim($('#txtEget_deadline').val());
               	t_td_no = $.trim($('#txtTd_no').val());
               	t_seq_no = $.trim($('#txtSeq_no').val());
				
                var t_where = " 1=1 " 
                + q_sqlPara2("noa", t_noa) 
                + q_sqlPara2("order_date", t_border_date, t_eorder_date) 
                + q_sqlPara2("get_deadline", t_bget_deadline, t_eget_deadline) 
                + q_sqlPara2("td_no", t_td_no) 
                + q_sqlPara2("seq_no", t_seq_no);
                t_where = ' where=^^' + t_where + '^^ ';
                return t_where;
            }
		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                background-color: #76a2fe
            }
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblOrder_date'>訂單日期</a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBorder_date" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEorder_date" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblGet_deadline'>領櫃期限</a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBget_deadline" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEget_deadline" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'>電腦編號</a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTd_no'>進口單號</a></td>
					<td>
					<input class="txt" id="txtTd_no" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblSeq_no'>系統序號</a></td>
					<td>
					<input class="txt" id="txtSeq_no" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
