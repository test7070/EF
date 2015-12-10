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
            var q_name = "trd_s";
            aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno', 'cust_b.aspx']
            				,['txtBaddr', '', 'addr', 'noa,addr', 'txtBaddr', 'addr_b.aspx']
            				,['txtEaddr', '', 'addr', 'noa,addr', 'txtEaddr', 'addr_b.aspx']);

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

                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
                q_mask(bbmMask);
                $('#txtBdate').focus();
            }

            function q_seekStr() {
                t_noa = $.trim($('#txtNoa').val());
                t_custno = $.trim($('#txtCustno').val());
                t_comp = $.trim($('#txtCust').val());
                t_bdate = $.trim($('#txtBdate').val());
                t_edate = $.trim($('#txtEdate').val());
                t_invono = $.trim($('#txtInvono').val());
                t_accno = $.trim($('#txtAccno').val());
                t_tranno = $.trim($('#txtTranno').val());
                
                var t_where = " 1=1 " 
                	+ q_sqlPara2("noa", t_noa) 
                	+ q_sqlPara2("custno", t_custno) 
					+ q_sqlPara2("datea", t_bdate, t_edate)
                 	+ q_sqlPara_or(["accno", "accno2"], t_accno);
               	
                if (t_comp.length > 0)
                    t_where += " and charindex('" + t_comp + "',comp)>0";
                if (t_invono.length > 0)
                    t_where += " and charindex('" + t_invono + "',vccano)>0";
                if(t_tranno.length>0)
		       		t_where += " and exists(select noa from view_trds"+r_accy+" where view_trds"+r_accy+".noa=view_trd"+r_accy+".noa and view_trds"+r_accy+".tranno='"+t_tranno+"')";
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
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a>立帳日期</a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a>單據編號</a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a>客戶編號</a></td>
					<td><input class="txt" id="txtCustno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a>客戶名稱</a></td>
					<td> <input class="txt" id="txtCust" type="text" style="width:215px; font-size:medium;" /> </td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblInvono'>發票號碼</a></td>
					<td><input class="txt" id="txtInvono" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTranno'>出車單號</a></td>
					<td>
					<input class="txt" id="txtTranno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblAccno'></a></td>
					<td>
					<input class="txt" id="txtAccno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
