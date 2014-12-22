<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
    <head>
        <title> </title>
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
			q_tables = 's';
			var q_name = "addr";
			var q_readonly = [];
			var q_readonlys = [];
			var bbmNum = [];
			var bbsNum = [['txtCustprice', 10, 1], ['txtDriverprice', 10, 1], ['txtDriverprice2', 10, 1], ['txtCommission', 10, 1]];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			brwCount = 3;
			
			aPop = new Array(['txtCustno_', 'btnCust_', 'cust', 'noa,comp', 'txtCustno_,txtCust_', 'cust_b.aspx']);
            	
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}
			function mainPost() {
				q_getFormat();
				q_mask(bbmMask);
				bbsMask = [['txtDatea', r_picd]];
				$('#txtNoa').change(function(e) {
					$(this).val($.trim($(this).val()).toUpperCase());
					if ($(this).val().length > 0) {
						t_where = "where=^^ noa='" + $(this).val() + "'^^";
						q_gt('addr', t_where, 0, 0, 0, "checkAddrno_change", r_accy);
					}
				});
			}
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'checkAddrno_change':
						var as = _q_appendData("addr", "", true);
						if (as[0] != undefined) {
							alert('已存在 ' + as[0].noa + ' ' + as[0].addr);
						}
						break;
					case 'checkAddrno_btnOk':
						var as = _q_appendData("addr", "", true);
						if (as[0] != undefined) {
							alert('已存在 ' + as[0].noa + ' ' + as[0].addr);
							Unlock();
							return;
						} else {
							wrServer($('#txtNoa').val());
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock();
			}
			function btnOk() {
				Lock(1,{opacity:0});
				$('#txtNoa').val($.trim($('#txtNoa').val()));
				if (q_cur == 1) {
					t_where = "where=^^ noa='" + $('#txtNoa').val() + "'^^";
					q_gt('addr', t_where, 0, 0, 0, "checkAddrno_btnOk", r_accy);
				} else {
					wrServer($('#txtNoa').val());
				}
			}
			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('addr_ef_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
			}
			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#txtCustno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtCustno_', '');
                            $('#btnCust_'+n).click();
                        });
					}
				}
				_bbsAssign();
			}
			function btnIns() {
				_btnIns();
				$('#txtNoa').focus();
			}
			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtNoa').attr('readonly', 'readonly');
				$('#txtAddr').focus();
			}
			function btnPrint() {
				q_box("z_addrp_ef.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";;" + r_accy, 'z_addr', "95%", "95%", q_getMsg("popPrint"));
			}
			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}
			function bbsSave(as) {
				if (!as['datea']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}
			function sum() {
			}
			function refresh(recno) {
				_refresh(recno);
			}
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}
			function btnMinus(id) {
				_btnMinus(id);
			}
			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}
			function q_appendData(t_Table) {
				return _q_appendData(t_Table);
			}
			function btnSeek() {
				_btnSeek();
			}
			function btnTop() {
				_btnTop();
			}
			function btnPrev() {
				_btnPrev();
			}
			function btnPrevPage() {
				_btnPrevPage();
			}
			function btnNext() {
				_btnNext();
			}
			function btnNextPage() {
				_btnNextPage();
			}
			function btnBott() {
				_btnBott();
			}
			function q_brwAssign(s1) {
				_q_brwAssign(s1);
			}
			function btnDele() {
				_btnDele();
			}
			function btnCancel() {
				_btnCancel();
			}
        </script>
        <style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 300px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 450px;
                /*margin: -1px;
                 border: 1px black solid;*/
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                width: 20%;
            }
            .tbbm .tdZ {
                width: 1%;
            }
            td .schema {
                display: block;
                width: 95%;
                height: 0px;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: blue;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            .dbbs {
                width: 950px;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
        </style>
    </head>
    <body ondragstart="return false" draggable="false"
    ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
    ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    >
        <!--#include file="../inc/toolbar.inc"-->
        <div id='dmain'>
            <div class="dview" id="dview" >
                <table class="tview" id="tview">
                    <tr>
                        <td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
                        <td align="center" style="width:100px; color:black;"><a id='vewNoa'> </a></td>
                        <td align="center" style="width:200px; color:black;"><a id='vewAddr'> </a></td>
                    </tr>
                    <tr>
                        <td>
                        <input id="chkBrow.*" type="checkbox" />
                        </td>
                        <td style="text-align: center;" id='noa'>~noa</td>
                        <td style="text-align: left;" id='addr'>~addr</td>
                    </tr>
                </table>
            </div>
            <div class='dbbm'>
                <table class="tbbm"  id="tbbm">
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="tdZ"></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblNoa' class="lbl"> </a></td>
                        <td colspan="2">
                        <input id="txtNoa" type="text" class="txt c1" />
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblAddr' class="lbl"> </a></td>
                        <td colspan="3">
                        <input id="txtAddr" type="text" class="txt c1" />
                        </td>
                    </tr>
                    <tr> </tr>
                </table>
            </div>
        </div>
        <div class='dbbs'>
            <table id="tbbs" class='tbbs'>
                <tr style='color:white; background:#003366;' >
                    <td  align="center" style="width:30px;">
                    <input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
                    </td>
                    <td align="center" style="width:20px;"></td>
                    <td align="center" style="width:80px;">日期</td>
                    <td align="center" style="width:150px;">客戶</td>
                   	<td align="center" style="width:80px;">項目</td>
                   	<td align="center" style="width:80px;">峻富收入</td>
                   	<td align="center" style="width:80px;">峻富支出<BR>對行<BR>(模組一)</td>
                   	<td align="center" style="width:80px;">峻富支出<BR>對個人車<BR>(模組二)</td>
                   	<td align="center" style="width:80px;">峻富支出<BR>對新竹物流及自有車<BR>(模組三)</td>
                   	<td align="center" style="width:80px;">備註</td>
                </tr>
                <tr  style='background:#cad3ff;'>
                    <td align="center">
                    <input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
                    <input id="txtNoq.*" type="text" style="display: none;" />
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a>
                    <td><input type="text" id="txtDatea.*" style="width:95%;" /></td>
                    <td>
                    	<input type="text" id="txtCustno.*" style="width:40%;float:left;" />
                    	<input type="text" id="txtCust.*" style="width:45%;float:left;" />
                    	<input type="button" id="btnCust.*" style="display:none;" />
                    </td>
                    <td><input type="text" id="txtCustunit.*" style="width:95%;" /></td>
                    <td><input type="text" id="txtCustprice.*" style="width:95%;text-align:right;"/></td>
                    <td><input type="text" id="txtDriverprice.*" style="width:95%;text-align:right;"/></td>
                    <td><input type="text" id="txtDriverprice2.*" style="width:95%;text-align:right;" /></td>
                    <td><input type="text" id="txtCommission.*" style="width:95%;text-align:right;" /></td>
                    <td><input type="text" id="txtMemo.*" style="width:95%;" /></td>
                </tr>
            </table>
        </div>
        <input id="q_sys" type="hidden" />
    </body>
</html>
