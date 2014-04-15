<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
                    options : [{/*[1]-使用者*/
                        type : '0',
                        name : 'xname',
                        value : r_name
                    }, {/*1-[2],[3]-登錄日期*/
                        type : '1',
                        name : 'date'
                    }, {/*2-[4],[5]-交運日期*/
                        type : '1',
                        name : 'trandate'
                    }, {/*3-[6],[7]-交運月份*/
                        type : '1',
                        name : 'xmon'
                    }, {/*4-[8],[9]-客戶*/
                        type : '2',
                        name : 'cust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {/*5-[10],[11]-司機*/
                        type : '2',
                        name : 'driver',
                        dbf : 'driver',
                        index : 'noa,namea',
                        src : 'driver_b.aspx'
                    }, {/*6-[12]-車牌*/
                        type : '6',
                        name : 'xcarno'
                    }, {/*7-[13]-PO*/
                        type : '6',
                        name : 'xpo'
                    }, {/*8-[14]-起點*/
                        type : '6',
                        name : 'xstraddr'
                    }, {/*9-[15]-迄點*/
                        type : '6',
                        name : 'xendaddr'
                    }, {/*10-[16]-車種*/
                        type : '8',
                        name : 'xcarkind',
                        value : t_carkind.split(',')
                    }, {/*11-[17]-車隊*/
                        type : '8',
                        name : 'xcarteam',
                        value : t_carteam.split(',')
                    }, {/*12-[18]-計算類別*/
                        type : '8',
                        name : 'xcalctype',
                        value : t_calctypes.split(',')
                    }, {/*13-[19]明細*/
                        type : '8',
                        name : 'xdetail',
                        value : ['detail@明細']
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
                
                $('#txtXmon1').mask('999/99');
                $('#txtXmon2').mask('999/99');
                $('#textMon').mask('999/99');
                
                $('#btnTrans_sum').click(function(e) {
                    $('#divExport').toggle();
                });
                $('#btnDivexport').click(function(e) {
                    $('#divExport').hide();
                });
                $('#btnExport').click(function(e) {
                    var t_mon = $('#textMon').val();
                    if (t_mon.length > 0) {
                        Lock(1, {
                            opacity : 0
                        });
                        q_func('qtxt.query.trans', 'trans.txt,tran_sum,' + encodeURI(t_mon));
                    } else
                        alert('請輸入交運月份。');
                });
                $('#btnOk').hide();
                $('#btnOk2').click(function(e) {
                    switch($('#q_report').data('info').radioIndex) {
                        case 0:
                            $('#cmbPaperSize').val('A4');
                            $('#chkLandScape').prop('checked',true);
                            break;
                        case 1:
                            $('#cmbPaperSize').val('A3');
                            $('#chkLandScape').prop('checked',true);
                            break;
                        case 2:
                            $('#cmbPaperSize').val('A4');
                            $('#chkLandScape').prop('checked',true);
                            break;
                        case 3:
                            $('#cmbPaperSize').val('A4');
                            $('#chkLandScape').prop('checked',true);
                            break;
                        case 4:
                            $('#cmbPaperSize').val('A4');
                            $('#chkLandScape').prop('checked',false);
                            break;
                        case 5:
                            $('#cmbPaperSize').val('A4');
                            $('#chkLandScape').prop('checked',false);
                            break;
                        case 6:
                            $('#cmbPaperSize').val('A4');
                            $('#chkLandScape').prop('checked',false);
                            break;
                        case 7:
                            $('#cmbPaperSize').val('A4');
                            $('#chkLandScape').prop('checked',false);
                            break;
                    }
                    $('#btnOk').click();
                });
            }
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.trans':
                        alert('結轉完成。');
                        Unlock(1);
                        break;
                    default:
                        break;
                }
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
		    <input type="button" id="btnTrans_sum" value="分析表資料結轉"/>
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
			    <input type="button" id="btnOk2" style="float:left;font-size:16px;font-weight: bold;color: blue;cursor: pointer;width:50px;height:30px;" value="查詢"/>
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
                    <td style="padding: 2px;text-align: center;border-width: 0px;background-color: pink;color: blue;"><a>交運月份</a></td>
                    <td colspan="3" style="padding: 2px;text-align: center;border-width: 0px;background-color: pink;">
                    <input type="text" id="textMon" style="float:left;width:40%;"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center" style="background-color: pink;">
                    <input type="button" id="btnExport" value="結轉"/>
                    </td>
                    <td colspan="2" align="center" style=" background-color: pink;">
                    <input type="button" id="btnDivexport" value="關閉"/>
                    </td>
                </tr>
            </table>
        </div>
	</body>
</html>