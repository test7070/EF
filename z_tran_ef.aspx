<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
            //********************************************
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }
            var t_carkind = null;
            var t_carteam = null;
            var t_calctypes = null;
            aPop = new Array(['txtXcarno', 'lblXcarno', 'car2', 'a.noa,driverno,driver', 'txtXcarno', 'car2_b.aspx'], ['txtXaddr', 'lblXaddr', 'addr', 'noa,addr', 'txtXaddr', 'addr_b.aspx']);
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gt('carteam', '', 0, 0, 0, "load_1");
                
            });
            function q_gfPost() {
                LoadFinish();
            }

            var sssno = '';
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'load_1':
                        t_carteam = '';
                        var as = _q_appendData("carteam", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_carteam += (t_carteam.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
                        }
                        q_gt('calctype2', '', 0, 0, 0, "load_2");
                        break;
                    case 'load_2':
                        t_calctypes = '';
                        var as = _q_appendData("calctypes", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_calctypes += (t_calctypes.length > 0 ? ',' : '') + as[i].noa + as[i].noq + '@' + as[i].typea;
                        }
                        q_gt('carkind', '', 0, 0, 0, "load_3");
                        break;
                    case 'load_3':
                        t_carkind = '';
                        var as = _q_appendData("carkind", "", true);
                        if (as[0] != undefined) {
                            for ( i = 0; i < as.length; i++) {
                                t_carkind += (t_carkind.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].kind;
                            }
                        }
                        q_gf('', 'z_tran_ef');
                        break;
                    default:
                        break;
                }
            }

            function q_boxClose(t_name) {
            }

            function LoadFinish() {
                $('#q_report').q_report({
                    fileName : 'z_tran_ef',
                    options : [{/*[1]-會計年度*/
                        type : '0',
                        name : 'accy',
                        value : q_getId()[4]
                    }, {/*[2]-使用者*/
                        type : '0',
                        name : 'xname',
                        value : r_name
                    }, {/*1-[3],[4]-登錄日期*/
                        type : '1',
                        name : 'date'
                    }, {/*2-[5],[6]-交運日期*/
                        type : '1',
                        name : 'trandate'
                    }, {/*3-[7],[8]-客戶*/
                        type : '2',
                        name : 'cust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {/*4-[9],[10]-起迄地點*/
                        type : '2',
                        name : 'addr',
                        dbf : 'addr',
                        index : 'noa,addr',
                        src : 'addr_b.aspx'
                    }, {/*5-[11],[12]-司機*/
                        type : '2',
                        name : 'driver',
                        dbf : 'driver',
                        index : 'noa,namea',
                        src : 'driver_b.aspx'
                    }, {/*6-[13]-車牌*/
                        type : '6',
                        name : 'xcarno'
                    }, {/*7-[14]-PO*/
                        type : '6',
                        name : 'xpo'
                    }, {/*8-[15]-車種*/
                        type : '8',
                        name : 'xcarkind',
                        value : t_carkind.split(',')
                    }, {/*9-[16]-車隊*/
                        type : '8',
                        name : 'xcarteam',
                        value : t_carteam.split(',')
                    }, {/*10-[17]-計算類別*/
                        type : '8',
                        name : 'xcalctype',
                        value : t_calctypes.split(',')
                    }, {/*11-[18]-耗油比(%)*/
                        type : '6',
                        name : 'xcheckrate'
                    }, {/*12-[19]-其他設定(出車明細、加油明細)*/
                        type : '8',
                        name : 'xfilter01',
                        value : q_getMsg('tfilter01').split('&')
                    }, {/*13-[20]-其他設定(指定車牌)*/
                        type : '8',
                        name : 'xoption01',
                        value : q_getMsg('toption01').split('&')
                    }, {/*14-[21]*/
                        type : '5',
                        name : 'xsort01',
                        value : q_getMsg('tsort01').split('&')
                    }, {/*15-[22]*/
                        type : '5',
                        name : 'xsort03',
                        value : q_getMsg('tsort03').split('&')
                    }, {/*16-[23]*/
                        type : '8',
                        name : 'xfilter04',
                        value : q_getMsg('tfilter04').split('&')
                    }, {/*17-[24]*/
                        type : '5',
                        name : 'xsort04',
                        value : q_getMsg('tsort04').split('&')
                    }, {/*18-[25]*/
                        type : '5',
                        name : 'xsort05',
                        value : q_getMsg('tsort05').split('&')
                    }, {/*19-[26]-其他設定(折扣)*/
                        type : '8',
                        name : 'xoption07',
                        value : q_getMsg('toption07').split('&')
                    }, {/*20-[27]加項金額*///*5-4
                        type : '6',
                        name : 'zplusmoney'
                    }, {/*21-[28]減項金額*///*5-8
                        type : '6',
                        name : 'zminusmoney'
                    }, {/*22-[29]-排序方式*//*08*/
						type : '8',
						name : 'xoption08',
						value : q_getMsg('toption08').split('&')
					}]
                });
                q_popAssign();
                q_langShow();

                $('#txtDate1').mask('999/99/99');
                $('#txtDate1').datepicker();
                $('#txtDate2').mask('999/99/99');
                $('#txtDate2').datepicker();
                $('#txtTrandate1').mask('999/99/99');
                $('#txtTrandate1').datepicker();
                $('#txtTrandate2').mask('999/99/99');
                $('#txtTrandate2').datepicker();

                $('#txtXcheckrate').val(q_getMsg('trate1'));
                $('#chkXcarkind').children('input').attr('checked', 'checked');
                $('#chkXcarteam').children('input').attr('checked', 'checked');
                $('#chkXcalctype').children('input').attr('checked', 'checked');
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>