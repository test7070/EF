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
            var q_name = "driver_s";
			aPop = new Array(['txtNoa', 'lblDriver', 'driver', 'noa,namea', 'txtNoa', 'driver_b.aspx']); 
            $(document).ready(function() {
                main();
            });
            /// end ready

            function main() {
                mainSeek();
                q_gf('', q_name);
            }

            function q_gfPost() {
                q_getFormat();
                q_langShow();

                bbmMask = [['txtBtakeofficedate', r_picd], ['txtEtakeofficedate', r_picd]];
                q_mask(bbmMask);
				q_cmbParse("cmbCartype",'@全部,'+q_getPara('driver.cartype'));
				q_cmbParse("cmbGuild"," @全部,模組一,模組二,模組三");
				
                $('#txtBtakeofficedate').focus();
                
                $('#txtBtakeofficedate').datepicker();
				$('#txtEtakeofficedate').datepicker(); 
            }

            function q_seekStr() {
                t_noa = $.trim($('#txtNoa').val());
                t_btakeofficedate = $.trim($('#txtBtakeofficedate').val());
                t_etakeofficedate = $.trim($('#txtEtakeofficedate').val());
                t_namea = $.trim($('#txtNamea').val());
				t_cartype = $.trim($('#cmbCartype').val());
				t_guild = $('#cmbGuild').val();
				
                var t_where = " 1=1 " 
                + q_sqlPara2("noa", t_noa) 
                + q_sqlPara2("takeofficedate", t_btakeofficedate, t_etakeofficedate) 
                + q_sqlPara2("cartype", t_cartype);
				if (t_namea.length>0)
                    t_where += " and charindex('" + t_namea + "',namea)>0";
                if(t_guild.length>0){
                	t_where += " and guild='" + t_guild + "'";
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
                background-color: #76a2fe
            }
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCartype'></a></td>
					<td>
					<select id="cmbCartype" style="width:215px; font-size:medium;" > </select>
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblDatea'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBtakeofficedate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEtakeofficedate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNamea'></a></td>
					<td>
					<input class="txt" id="txtNamea" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a>運費計算</a></td>
					<td>
					<select class="txt" id="cmbGuild" type="text" style="width:215px; font-size:medium;"> </select>
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
