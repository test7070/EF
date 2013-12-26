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
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            var q_name = "trans";
            var q_readonly = ['txtWeight3', 'txtMiles', 'txtTotal', 'txtTotal2', 'txtNoa', 'txtOrdeno', 'txtWorker', 'txtWorker2'];
            var bbmNum = [['txtGross', 10, 3, 1], ['txtWeight', 10, 3, 1], ['txtWeight3', 10, 3, 1], ['txtWeight2', 10, 3, 1], ['txtInmount', 10, 3, 1], ['txtPton', 10, 3, 1], ['txtPrice', 10, 3, 1], ['txtTotal', 10, 0, 1], ['txtOutmount', 10, 3, 1], ['txtPton2', 10, 3, 1], ['txtPrice2', 10, 3, 1], ['txtPrice3', 10, 3, 1], ['txtDiscount', 10, 3, 1], ['txtTotal2', 10, 0, 1], ['txtTolls', 10, 0, 1], ['txtReserve', 10, 0, 1], ['txtBmiles', 10, 0, 1], ['txtEmiles', 10, 0, 1]];
            var bbmMask = [['txtDatea', '999/99/99'], ['txtTrandate', '999/99/99'], ['txtMon', '999/99'], ['txtMon2', '999/99'], ['txtLtime', '99:99'], ['txtStime', '99:99'], ['txtDtime', '99:99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            q_xchg = 1;
            brwCount2 = 15;
            //不能彈出瀏覽視窗
            aPop = new Array(['txtCarno', '', 'car2', 'a.noa,driver,driverno', 'txtCarno,txtDriver,txtDriverno', 'car2_b.aspx'], ['txtCustno', '', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx'], ['txtDriverno', '', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx'], ['txtUccno', '', 'ucc', 'noa,product', 'txtUccno,txtProduct', 'ucc_b.aspx'], ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'], ['txtStraddrno', '', 'addr', 'noa,addr,productno,product,salesno,sales', 'txtStraddrno,txtStraddr,txtUccno,txtProduct,txtSalesno,txtSales,txtStraddr', 'addr_b.aspx']);
            function currentData() {
            }


            currentData.prototype = {
                data : [],
                /*新增時複製的欄位*/
                include : ['txtDatea', 'txtTrandate', 'txtMon', 'txtMon2', 'txtCarno', 'txtDriverno', 'txtDriver', 'txtCustno', 'txtComp', 'txtNick', 'cmbCalctype', 'cmbCarteamno', 'txtStraddrno', 'txtStraddr', 'txtUccno', 'txtProduct', 'txtInmount', 'txtPrice', 'txtTotal', 'txtOutmount', 'txtPrice2', 'txtPrice3', 'txtTotal2', 'txtDiscount', 'txtTolls', 'txtPo', 'txtCustorde', 'txtSalesno', 'txtSales'],
                /*記錄當前的資料*/
                copy : function() {
                    this.data = new Array();
                    for (var i in fbbm) {
                        var isInclude = false;
                        for (var j in this.include) {
                            if (fbbm[i] == this.include[j]) {
                                isInclude = true;
                                break;
                            }
                        }
                        if (isInclude) {
                            this.data.push({
                                field : fbbm[i],
                                value : $('#' + fbbm[i]).val()
                            });
                        }
                    }
                },
                /*貼上資料*/
                paste : function() {
                    for (var i in this.data) {
                        $('#' + this.data[i].field).val(this.data[i].value);
                    }
                }
            };
            var curData = new currentData();
            function transData() {
            }


            transData.prototype = {
                calctype : new Array(),
                isInit : false,
                isTrd : null,
                isTre : null,
                isoutside : null,
                init : function() {
                    Lock(1, {
                        opacity : 0
                    });
                    q_gt('carteam', '', 0, 0, 0, 'transInit_1');
                },
                refresh : function() {
                    if (!this.isInit)
                        return;
                    $('#lblPrice2').hide();
                    $('#txtPrice2').hide();
                    $('#lblPrice3').hide();
                    $('#txtPrice3').hide();
                    for (var i in this.calctype) {
                        if (this.calctype[i].noa == $('#cmbCalctype').val()) {
                            if (this.calctype[i].isoutside) {
                                $('#lblPrice3').show();
                                $('#txtPrice3').show();
                            } else {
                                $('#lblPrice2').show();
                                $('#txtPrice2').show();
                            }
                        }
                    }

                },
                calctypeChange : function() {
                    if (!this.isTre) {
                        for (var i in this.calctype) {
                            if (this.calctype[i].noa == $('#cmbCalctype').val()) {
                                $('#txtDiscount').val(FormatNumber(this.calctype[i].discount));
                                this.isoutside = this.calctype[i].isoutside;
                            }
                        }
                        this.priceChange_afterCalctypeChange();
                    }
                },
                priceChange_afterCalctypeChange : function() {
                    var t_addrno = $.trim($('#txtStraddrno').val());
                    var t_date = $.trim($('#txtTrandate').val());
                    q_gt('addrs', "where=^^ noa='" + t_addrno + "' and datea<='" + t_date + "' ^^", 0, 0, 0, 'getPrice2');
                },
                priceChange : function() {
                    var t_addrno = $.trim($('#txtStraddrno').val());
                    var t_date = $.trim($('#txtTrandate').val());
                    q_gt('addrs', "where=^^ noa='" + t_addrno + "' and datea<='" + t_date + "' ^^", 0, 0, 0, 'getPrice');
                },
                checkData : function() {
                    this.isTrd = false;
                    this.isTre = false;
                    this.isoutside = false;
                    for (var i in this.calctype) {
                        if (this.calctype[i].noa == $('#cmbCalctype').val()) {
                            this.isoutside = this.calctype[i].isoutside;
                        }
                    }
                    $('#txtDatea').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtTrandate').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');

                    $('#txtCustno').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtComp').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtStraddrno').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtStraddr').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtInmount').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtPton').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtPrice').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');

                    $('#txtCarno').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtDriverno').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtDriver').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtOutmount').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtPton2').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtPrice2').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtPrice3').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtDiscount').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtTolls').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#cmbCalctype').attr('disabled', 'disabled');
                    $('#cmbCarteamno').attr('disabled', 'disabled');
                    /*if ($('#txtOrdeno').val().length > 0) {
                        //轉來的一律不可改日期
                    } else {*/
                        var t_tranno = $.trim($('#txtNoa').val());
                        var t_trannoq = $.trim($('#txtNoq').val());
                        var t_datea = $.trim($('#txtDatea').val());
                        if (q_cur == 2 && (t_tranno.length == 0 || t_trannoq.length == 0 || t_datea.length == 0)) {
                            alert('資料異常。 code:1');
                        } else {
                            //檢查是否已立帳
                            q_gt('view_trds', "where=^^ tranno='" + t_tranno + "' and trannoq='" + t_trannoq + "' ^^", 0, 0, 0, 'checkTrd_' + t_tranno + '_' + t_trannoq + '_' + t_datea, r_accy);
                        }
                   // }
                }
            };
            trans = new transData();

            function tranorde() {
            }


            tranorde.prototype = {
                data : null,
                tbCount : 5,
                curPage : -1,
                totPage : 0,
                curIndex : '',
                curCaddr : null,
                lock : function() {
                    for (var i = 0; i < this.tbCount; i++) {
                        if ($('#tranorde_chk' + i).attr('disabled') != 'disabled') {
                            $('#tranorde_chk' + i).addClass('lock').attr('disabled', 'disabled');
                        }
                    }
                },
                unlock : function() {
                    for (var i = 0; i < this.tbCount; i++) {
                        if ($('#tranorde_chk' + i).hasClass('lock')) {
                            $('#tranorde_chk' + i).removeClass('lock').removeAttr('disabled');
                        }
                    }
                },
                load : function() {
                    var string = '<table id="tranorde_table">';
                    string += '<tr id="tranorde_header">';
                    string += '<td id="tranorde_chk" align="center" style="width:20px; color:black;"></td>';
                    string += '<td id="tranorde_sel" align="center" style="width:20px; color:black;"></td>';
                    string += '<td id="tranorde_noa" onclick="tranorde.sort(\'noa\',false)" title="訂單編號" align="center" style="width:120px; color:black;">訂單編號</td>';
                    string += '<td id="tranorde_ctype" onclick="tranorde.sort(\'ctype\',false)" title="類型" align="center" style="width:50px; color:black;">類型</td>';
                    string += '<td id="tranorde_strdate" onclick="tranorde.sort(\'strdate\',false)" title="開工日期" align="center" style="width:100px; color:black;">開工日</td>';
                    string += '<td id="tranorde_strdate" onclick="tranorde.sort(\'dldate\',false)" title="完工日期" align="center" style="width:100px; color:black;">完工日</td>';
                    string += '<td id="tranorde_nick" onclick="tranorde.sort(\'custno\',false)" title="客戶" align="center" style="width:100px; color:black;">客戶</td>';
                    string += '<td id="tranorde_addr" onclick="tranorde.sort(\'addrno\',false)" title="起迄地點" align="center" style="width:200px; color:black;">起迄地點</td>';
                    string += '<td id="tranorde_product" onclick="tranorde.sort(\'productno\',false)" title="品名" align="center" style="width:100px; color:black;">品名</td>';
                    string += '<td id="tranorde_mount" onclick="tranorde.sort(\'mount\',true)" align="center" style="width:80px; color:black;">收數量</td>';
                    string += '<td id="tranorde_vccecount" onclick="tranorde.sort(\'vccecount\',true)" align="center" style="width:80px; color:black;">已派數量</td>';
                    string += '<td id="tranorde_empdock" onclick="tranorde.sort(\'empdock\',false)" title="領,S/O" align="center" style="width:120px; color:black;">出口櫃</td>';
                    string += '<td id="tranorde_port2" onclick="tranorde.sort(\'port2\',false)" title="領櫃碼頭,自檢/追蹤" align="center" style="width:120px; color:black;">進口櫃</td>';
                    string += '</tr>';

                    var t_color = ['DarkBlue', 'DarkRed'];
                    for (var i = 0; i < this.tbCount; i++) {
                        string += '<tr id="tranorde_tr' + i + '">';
                        string += '<td style="text-align: center;">';
                        string += '<input id="tranorde_chk' + i + '" class="tranorde_chk" type="checkbox"/></td>';
                        string += '<td style="text-align: center; font-weight: bolder; color:black;">' + (i + 1) + '</td>';
                        string += '<td id="tranorde_noa' + i + '" onclick="tranorde.browNoa(this)" style="text-align: center;color:' + t_color[i % t_color.length] + '"></td>';
                        string += '<td id="tranorde_ctype' + i + '" style="text-align: center;color:' + t_color[i % t_color.length] + '"></td>';
                        string += '<td id="tranorde_strdate' + i + '" style="text-align: center;color:' + t_color[i % t_color.length] + '"></td>';
                        string += '<td id="tranorde_dldate' + i + '" style="text-align: center;color:' + t_color[i % t_color.length] + '"></td>';
                        string += '<td id="tranorde_nick' + i + '" style="text-align: center;color:' + t_color[i % t_color.length] + '"></td>';
                        string += '<td id="tranorde_addr' + i + '" style="text-align: left;color:' + t_color[i % t_color.length] + '"></td>';
                        string += '<td id="tranorde_product' + i + '" style="text-align: left;color:' + t_color[i % t_color.length] + '"></td>';
                        string += '<td id="tranorde_mount' + i + '" style="text-align: right;color:' + t_color[i % t_color.length] + '"></td>';
                        string += '<td id="tranorde_vccecount' + i + '" style="text-align: right;color:' + t_color[i % t_color.length] + '"></td>';
                        string += '<td id="tranorde_empdock' + i + '" style="text-align: left;color:' + t_color[i % t_color.length] + '"></td>';
                        string += '<td id="tranorde_port2' + i + '" style="text-align: left;color:' + t_color[i % t_color.length] + '"></td>';
                        string += '</tr>';
                    }
                    string += '</table>';

                    $('#tranorde').append(string);

                    string = '<input id="btnTranorde_refresh"  type="button" style="float:left;width:100px;" value="訂單刷新"/>';
                    string += '<input id="btnTranorde_previous" onclick="tranorde.previous()" type="button" style="float:left;width:100px;" value="上一頁"/>';
                    string += '<input id="btnTranorde_next" onclick="tranorde.next()" type="button" style="float:left;width:100px;" value="下一頁"/>';
                    string += '<input id="textCurPage" onchange="tranorde.page(parseInt($(this).val()))" type="text" style="float:left;width:100px;text-align: right;"/>';
                    string += '<span style="float:left;display:block;width:10px;font-size: 25px;">/</span>';
                    string += '<input id="textTotPage"  type="text" readonly="readonly" style="float:left;width:100px;color:green;"/>';
                    string += '<select id="combCtype" style="float:left;width:100px;"> </select>';
                    string += '<select id="combDtype" style="float:left;width:100px;"> </select>';
                    $('#tranorde_control').append(string);
                },
                init : function(obj) {
                    $('.tranorde_chk').click(function(e) {
                        $(".tranorde_chk").not(this).prop('checked', false);
                        $(".tranorde_chk").not(this).parent().parent().find('td').css('background', 'pink');
                        $(this).prop('checked', true);
                        $(this).parent().parent().find('td').css('background', '#FF8800');
                    });
                    this.data = new Array();
                    if (obj[0] != undefined) {
                        for (var i in obj)
                        if (obj[i]['noa'] != undefined && obj[i]['caddr'] != undefined) {
                            var t_caddr = obj[i]['caddr'].split(',');
                            var t_item, t_str, t_addr = '';
                            for (var j = 0; j < t_caddr.length; j++) {
                                t_str = '';
                                t_item = t_caddr[j].split(' ');
                                for (var k = 0; k < t_item.length; k++) {
                                    if (t_item[k].length > 0)
                                        t_str += String.fromCharCode(parseInt(t_item[k]));
                                }
                                if (j % 2 == 0) {
                                    //addrno
                                } else {
                                    //addr
                                    if (t_str.length > 0)
                                        t_addr += (t_addr.length > 0 ? '<br>' : '') + t_str;
                                }
                            }
                            obj[i]['addr'] = t_addr;
                            this.data.push(obj[i]);
                        }
                    }
                    this.totPage = Math.ceil(this.data.length / this.tbCount);
                    $('#textTotPage').val(this.totPage);
                    this.sort('noa', false);
                    Unlock();
                },
                sort : function(index, isFloat) {
                    //訂單排序
                    this.curIndex = index;

                    if (isFloat) {
                        this.data.sort(function(a, b) {
                            var m = parseFloat(a[tranorde.curIndex] == undefined ? "0" : a[tranorde.curIndex]);
                            var n = parseFloat(b[tranorde.curIndex] == undefined ? "0" : b[tranorde.curIndex]);
                            if (m == n) {
                                if (a['noa'] < b['noa'])
                                    return 1;
                                if (a['noa'] > b['noa'])
                                    return -1;
                                return 0;
                            } else
                                return n - m;
                        });
                    } else {
                        this.data.sort(function(a, b) {
                            var m = a[tranorde.curIndex] == undefined ? "" : a[tranorde.curIndex];
                            var n = b[tranorde.curIndex] == undefined ? "" : b[tranorde.curIndex];
                            if (m == n) {
                                if (a['noa'] < b['noa'])
                                    return 1;
                                if (a['noa'] > b['noa'])
                                    return -1;
                                return 0;
                            } else {
                                if (m < n)
                                    return 1;
                                if (m > n)
                                    return -1;
                                return 0;
                            }
                        });
                    }
                    this.page(1);
                },
                next : function() {
                    if (this.curPage == this.totPage) {
                        alert('最末頁。');
                        return;
                    }
                    this.curPage++;
                    $('#textCurPage').val(this.curPage);
                    this.refresh();
                },
                previous : function() {
                    if (this.curPage == 1) {
                        alert('最前頁。');
                        return;
                    }
                    this.curPage--;
                    $('#textCurPage').val(this.curPage);
                    this.refresh();
                },
                page : function(n) {
                    if (n <= 0 || n > this.totPage) {
                        this.curPage = 1;
                        $('#textCurPage').val(this.curPage);
                        this.refresh();
                        return;
                    }
                    this.curPage = n;
                    $('#textCurPage').val(this.curPage);
                    this.refresh();
                },
                refresh : function() {
                    if(this.data==undefined || this.data.length==0){
                        return;
                    }
                    //頁面更新
                    var n = (this.curPage - 1) * this.tbCount;
                    for (var i = 0; i < this.tbCount; i++) {
                        if ((n + i) < this.data.length) {
                            $('#tranorde_chk' + i).removeAttr('disabled');
                            $('#tranorde_noa' + i).html(this.data[n+i]['noa']);
                            $('#tranorde_ctype' + i).html(this.data[n+i]['ctype']);
                            $('#tranorde_strdate' + i).html(this.data[n+i]['strdate']);
                            //結關日cldate,到期日madate,預計完工日dldate
                            t_date = this.data[n+i]['cldate'].length > 0 ? this.data[n+i]['cldate'] : this.data[n+i]['madate'];
                            t_date = t_date.length > 0 ? t_date : this.data[n+i]['dldate'];
                            $('#tranorde_dldate' + i).html(t_date);
                            $('#tranorde_nick' + i).html(this.data[n+i]['nick']);
                            $('#tranorde_addr' + i).html(this.data[n+i]['addr']);
                            $('#tranorde_product' + i).html(this.data[n+i]['product']);
                            //只顯示到小數位第一位
                            if (this.data[n+i]['mount'].indexOf('.') < 0)
                                $('#tranorde_mount' + i).html(this.data[n+i]['mount'] + '.0');
                            else
                                $('#tranorde_mount' + i).html(this.data[n+i]['mount'].replace(/(\d*)\.(\d)(\d)*$/g, '$1.$2'));
                            if (this.data[n+i]['vccecount'].indexOf('.') < 0)
                                $('#tranorde_vccecount' + i).html(this.data[n+i]['vccecount'] + '.0');
                            else
                                $('#tranorde_vccecount' + i).html(this.data[n+i]['vccecount'].replace(/(\d*)\.(\d)(\d)*$/g, '$1.$2'));
                            $('#tranorde_empdock' + i).html('<a style="float:left;display:block;width:40px;">' + this.data[n+i]['empdock'] + '</a>' + '<a style="float:left;display:block;width:80px;">' + this.data[n+i]['so'] + '</a>');
                            $('#tranorde_port2' + i).html('<a style="float:left;display:block;width:40px;">' + this.data[n+i]['port2'] + '</a>' + '<a style="float:left;display:block;width:80px;">' + this.data[n+i]['checkself'] + this.data[n+i]['trackno'] + '</a>');
                        } else {
                            $('#tranorde_chk' + i).attr('disabled', 'disabled');
                            $('#tranorde_noa' + i).html('');
                            $('#tranorde_ctype' + i).html('');
                            $('#tranorde_strdate' + i).html('');
                            $('#tranorde_dldate' + i).html('');
                            $('#tranorde_nick' + i).html('');
                            $('#tranorde_addr' + i).html('');
                            $('#tranorde_product' + i).html('');
                            $('#tranorde_mount' + i).html('');
                            $('#tranorde_vccecount' + i).html('');
                            $('#tranorde_empdock' + i).html('');
                            $('#tranorde_port2' + i).html('');
                        }
                    }
                    $('#tranorde_chk0').click();
                    $('#tranorde_chk0').prop('checked', 'true');
                },
                browNoa : function(obj) {
                    //瀏覽訂單
                    var noa = $.trim($(obj).html());
                    if (noa.length > 0)
                        q_box("tranorde.aspx?;;;noa='" + noa + "';" + r_accy, 'tranorde', "95%", "95%", q_getMsg("popTranorde"));
                },
                paste : function() {
                    //複製資料
                    if (this.totPage <= 0)
                        return;
                    var n = (this.curPage - 1) * this.tbCount;
                    for (var i = 0; i < this.tbCount; i++) {
                        if ($('#tranorde_chk' + i).prop('checked')) {
                            $('#txtOrdeno').val(this.data[n+i]['noa']);
                            $('#txtCustno').val(this.data[n+i]['custno']);
                            $('#txtComp').val(this.data[n+i]['comp']);
                            $('#txtNick').val(this.data[n+i]['nick']);
                            $('#txtMemo').val(this.data[n+i]['memo']);
                            $('#txtUccno').val(this.data[n+i]['productno']);
                            $('#txtProduct').val(this.data[n+i]['product']);
                        }
                    }
                },
                paste2 : function(ordeno, sel) {
                    //複製資料
                    if (ordeno.length == 0)
                        return;
                    var t_where = "where=^^ noa='" + ordeno + "'^^";
                    q_gt('view_tranorde_ef', t_where, 0, 0, 0, 'ddd_' + ordeno + '_' + sel, r_accy);
                },
                loadcaddr : function(ordeno) {
                    this.curCaddr = new Array();
                    for (var i = 0; i < q_bbsCount; i++)
                        $('#combCaddr_' + i).html('');
                    if (ordeno.length == 0)
                        return;
                    var t_where = "where=^^ noa='" + ordeno + "'^^";
                    q_gt('view_tranorde_ef', t_where, 0, 0, 0, 'loadcaddr', r_accy);
                }
            };
            tranorde = new tranorde();

            $(document).ready(function() {
            	tranorde.load();
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
                $('#btnUnpresent').click(function() {
                    q_pop('', "carpresent.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";;" + r_accy + '_' + r_cno, '', '', '', "92%", "1054px", q_getMsg('popCarpresent'), true);
                });
            });
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                q_modiDay = q_getPara('sys.modiday2');
                /// 若未指定， d4=  q_getPara('sys.modiday');
                $('#btnIns').val($('#btnIns').val() + "(F8)");
                $('#btnOk').val($('#btnOk').val() + "(F9)");
                q_mask(bbmMask);
                q_cmbParse("cmbCasetype", "20'',40''");
                q_cmbParse("combCtype", ('').concat(new Array( '全部','貨櫃','平板','散裝')));
                q_cmbParse("combDtype", ('').concat(new Array( '全部','出口','進口')));
                trans.init();
                $("#cmbCalctype").focus(function() {
                    var len = $("#cmbCalctype").children().length > 0 ? $("#cmbCalctype").children().length : 1;
                    $("#cmbCalctype").attr('size', len + "");
                    $(this).data('curValue', $(this).val());
                }).blur(function() {
                    $("#cmbCalctype").attr('size', '1');
                }).change(function(e) {
                    trans.refresh();
                    trans.calctypeChange();
                }).click(function(e) {
                    if ($(this).data('curValue') != $(this).val()) {
                        trans.refresh();
                        trans.calctypeChange();
                    }
                    $(this).data('curValue', $(this).val());
                });
                $("#cmbCarteamno").focus(function() {
                    var len = $("#cmbCarteamno").children().length > 0 ? $("#cmbCarteamno").children().length : 1;
                    $("#cmbCarteamno").attr('size', len + "");
                }).blur(function() {
                    $("#cmbCarteamno").attr('size', '1');
                });
                $("#cmbCasetype").focus(function() {
                    var len = $("#cmbCasetype").children().length > 0 ? $("#cmbCasetype").children().length : 1;
                    $("#cmbCasetype").attr('size', len + "");
                }).blur(function() {
                    $("#cmbCasetype").attr('size', '1');
                });

                $('#txtInmount').change(function() {
                    if (!trans.isTre)
                        $('#txtOutmount').val($('#txtInmount').val());
                    sum();
                });
                $('#txtPton').change(function() {
                    sum();
                });
                $('#txtPrice').change(function() {
                    sum();
                });
                $('#txtOutmount').change(function() {
                    sum();
                });
                $('#txtPton2').change(function() {
                    sum();
                });
                $('#txtPrice2').change(function() {
                    sum();
                });
                $('#txtPrice3').change(function() {
                    sum();
                });
                $('#txtDiscount').change(function() {
                    sum();
                });
                $('#txtBmiles').change(function() {
                    sum();
                });
                $('#txtEmiles').change(function() {
                    sum();
                });
                $('#txtWeight2').change(function() {
                    sum();
                });
                $("#txtStraddrno").focus(function() {
                    var input = document.getElementById("txtStraddrno");
                    if ( typeof (input.selectionStart) != 'undefined') {
                        input.selectionStart = $(input).val().replace(/^(\w+\u002D).*$/g, '$1').length;
                        input.selectionEnd = $(input).val().length;
                    }
                });
                q_xchgForm();
                //--------------------------------------------------
                $('#btnTranorde_refresh').click(function(e) {
                    t_where = " (isnull(mount,0)>isnull(vccecount,0)) and enda!=1 ";
                    var t_ctype = $('#combCtype>option:selected').text();
                    var t_dtype = $('#combDtype>option:selected').text();
                    if(t_ctype!='全部')
                    	t_where += (t_where.length>0?' and ':'') + "isnull(ctype,'')='"+t_ctype+"'";
                    if(t_dtype=='出口')
                    	t_where += (t_where.length>0?' and ':'') + "len(isnull(empdock,''))>0";
                    if(t_dtype=='進口')
                    	t_where += (t_where.length>0?' and ':'') + "len(isnull(port2,''))>0";	
                    t_where="where=^^"+t_where+"^^";
                    Lock();
                    q_gt('view_tranorde_ef', t_where, 0, 0, 0,'aaa', r_accy);
                });    
                //自動載入訂單
                $('#btnTranorde_refresh').click(); 
            }

            function sum() {
                if (q_cur != 1 && q_cur != 2)
                    return;

                if (!trans.isTrd) {
                    var t_mount = q_float('txtInmount').add(q_float('txtPton'));
                    var t_total = t_mount.mul(q_float('txtPrice')).round(0);
                    $('#txtMount').val(FormatNumber(t_mount));
                    $('#txtTotal').val(FormatNumber(t_total));
                }
                if (!trans.isTre) {
                    var t_mount2 = q_float('txtOutmount').add(q_float('txtPton2'));
                    var t_total2 = t_mount2.mul(trans.isoutside ? q_float('txtPrice3') : q_float('txtPrice2')).mul(q_float('txtDiscount')).round(0);
                    $('#txtMount2').val(FormatNumber(t_mount2));
                    $('#txtTotal2').val(FormatNumber(t_total2));
                }

                var bmiles = q_float('txtBmiles');
                var emiles = q_float('txtEmiles');
                $('#txtMiles').val(FormatNumber(emiles.sub(bmiles)));

                if (q_float('txtWeight2') == 0)
                    $('#txtWeight3').val(0);
                else
                    $('#txtWeight3').val(FormatNumber(q_float('txtInmount').sub(q_float('txtWeight2')).round(3)));
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'aaa':
                        var GG = _q_appendData("view_tranorde_ef", "", true);
                        if (GG[0] != undefined)
                            tranorde.init(GG);
                        else{
                        	Unlock();
                        	alert('無資料。');
                        }
                        break;
                    case 'isTre':
                        var as = _q_appendData("view_tres", "", true);
                        if (as[0] != undefined) {
                            alert('已立帳，付款立帳單號【' + as[0].noa + '】');
                            Unlock(1);
                            return;
                        }
                        _btnDele();
                        Unlock(1);

                        break;
                    case 'isCarsal':
                        var as = _q_appendData("carsal", "", true);
                        if (as[0] != undefined) {
                            if (as[0].lock == "true" || as[0].lock == "1") {
                                alert('【' + as[0].noa + '】司機薪資已鎖定。');
                                Unlock(1);
                                return;
                            }
                        }
                        _btnDele();
                        Unlock(1);
                        break;
                    case 'isTrd':
                        var as = _q_appendData("view_trds", "", true);
                        if (as[0] != undefined) {
                            alert('已立帳，請款立帳單號【' + as[0].noa + '】');
                            Unlock(1);
                            return;
                        } else {
                            var t_isoutside = false;
                            for (var i in trans.calctype) {
                                if (trans.calctype[i].noa == $('#cmbCalctype').val()) {
                                    t_isoutside = trans.calctype[i].isoutside;
                                }
                            }
                            if (t_isoutside)
                                q_gt('view_tres', "where=^^ tranno='" + $('#txtNoa').val() + "' ^^", 0, 0, 0, 'isTre', r_accy);
                            else
                                q_gt('carsal', "where=^^ noa='" + $('#txtDatea').val().substring(0, 6) + "' ^^", 0, 0, 0, 'isCarsal', r_accy);
                        }
                        break;
                    case 'btnDele':
                        var as = _q_appendData("trans", "", true);
                        if (as[0] != undefined) {
                           /* if (as[0].ordeno.length > 0) {
                                alert('轉來的單據禁止刪除。');
                                Unlock(1);
                                return;
                            }*/
                            q_gt('view_trds', "where=^^ tranno='" + $('#txtNoa').val() + "' and trannoq='" + $('#txtNoq').val() + "' ^^", 0, 0, 0, 'isTrd', r_accy);
                        } else {
                            alert('資料異常。');
                        }
                        break;
                    case 'btnModi':
                        var as = _q_appendData("trans", "", true);
                        /*if (as[0] != undefined) {
                            if (as[0].ordeno.length > 0) {
                                alert('轉來的單據禁止修改。');
                                Unlock(1);
                                return;
                            }
                        }*/
                        Unlock(1);
                        Lock(1, {
                            opacity : 0
                        });
                        _btnModi();
                        trans.refresh();
                        trans.checkData();
                        $('#txtDatea').focus();
                        break;
                    case 'getPrice2':
                        var t_price = 0;
                        var t_price2 = 0;
                        var t_price3 = 0;
                        var as = _q_appendData("addrs", "", true);
                        if (as[0] != undefined) {
                            t_price = as[0].custprice;
                            t_price2 = as[0].driverprice;
                            t_price3 = as[0].driverprice2;
                        }
                        if (!trans.isTrd) {
                            $('#txtPrice').val(t_price);
                        }
                        if (!trans.isTre) {
                            $('#txtPrice2').val(t_price2);
                            $('#txtPrice3').val(t_price3);
                        }
                        sum();
                        break;
                    case 'getPrice':
                        var t_price = 0;
                        var t_price2 = 0;
                        var t_price3 = 0;
                        var as = _q_appendData("addrs", "", true);
                        if (as[0] != undefined) {
                            t_price = as[0].custprice;
                            t_price2 = as[0].driverprice;
                            t_price3 = as[0].driverprice2;
                        }
                        if (!trans.isTrd) {
                            $('#txtPrice').val(t_price);
                        }
                        if (!trans.isTre) {
                            $('#txtPrice2').val(t_price2);
                            $('#txtPrice3').val(t_price3);
                        }
                        sum();
                        break;
                    case 'transInit_1':
                        var as = _q_appendData("carteam", "", true);
                        var t_item = "";
                        for ( i = 0; i < as.length; i++) {
                            t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
                        }
                        q_cmbParse("cmbCarteamno", t_item);
                        if (abbm[q_recno] != undefined)
                            $("#cmbCarteamno").val(abbm[q_recno].carteamno);
                        q_gt('calctype2', '', 0, 0, 0, 'transInit_2');
                        break;
                    case 'transInit_2':
                        var as = _q_appendData("calctypes", "", true);
                        var t_item = "";
                        for ( i = 0; i < as.length; i++) {
                            t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + as[i].noq + '@' + as[i].typea;
                            trans.calctype.push({
                                noa : as[i].noa + as[i].noq,
                                typea : as[i].typea,
                                discount : as[i].discount,
                                discount2 : as[i].discount2,
                                isoutside : as[i].isoutside.length == 0 ? false : (as[i].isoutside == "false" || as[i].isoutside == "0" || as[i].isoutside == "undefined" ? false : true)
                            });
                        }
                        q_cmbParse("cmbCalctype", t_item);
                        if (abbm[q_recno] != undefined)
                            $("#cmbCalctype").val(abbm[q_recno].calctype);
                        trans.isInit = true;
                        trans.refresh();
                        Unlock(1);
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                        if (t_name.substring(0, 8) == 'checkTrd') {
                            var t_tranno = t_name.split('_')[1];
                            var t_trannoq = t_name.split('_')[2];
                            var t_datea = t_name.split('_')[3];
                            var as = _q_appendData("view_trds", "", true);
                            if (as[0] != undefined) {
                                trans.isTrd = true;
                            } else {
                                $('#txtCustno').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#txtComp').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#txtStraddrno').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#txtStraddr').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#txtInmount').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#txtPton').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#txtPrice').removeAttr('readonly').css('color', 'black').css('background', 'white');
                            }
                            if (trans.isoutside) {
                                //外車
                                q_gt('view_tres', "where=^^ tranno='" + t_tranno + "' ^^", 0, 0, 0, 'checkTre', r_accy);
                            } else {
                                //公司車
                                q_gt('carsal', "where=^^ noa='" + t_datea.substring(0, 6) + "' ^^", 0, 0, 0, 'checkCarsal', r_accy);
                            }
                        } else if (t_name.substring(0, 8) == 'checkTre') {
                            var as = _q_appendData("view_tres", "", true);
                            if (as[0] != undefined) {
                                trans.isTre = true;
                            } else {
                                $('#txtCarno').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#txtDriverno').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#txtDriver').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#txtOutmount').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#txtPton2').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#txtPrice2').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#txtPrice3').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#txtDiscount').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#txtTolls').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#cmbCalctype').removeAttr('disabled');
                                $('#cmbCarteamno').removeAttr('disabled');
                            }
                            if (!trans.isTrd && !trans.isTre) {
                                $('#txtDatea').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#txtTrandate').removeAttr('readonly').css('color', 'black').css('background', 'white');
                            }
                            sum();
                            Unlock(1);
                        } else if (t_name.substring(0, 11) == 'checkCarsal') {
                            var as = _q_appendData("carsal", "", true);
                            if (as[0] != undefined) {
                                if (as[0].lock == "true" || as[0].lock == "1")
                                    trans.isTre = true;
                            }
                            if (!trans.isTre) {
                                $('#txtCarno').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#txtDriverno').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#txtDriver').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#txtOutmount').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#txtPton2').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#txtPrice2').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#txtPrice3').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#txtDiscount').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#txtTolls').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#cmbCalctype').removeAttr('disabled');
                                $('#cmbCarteamno').removeAttr('disabled');
                            }
                            if (!trans.isTrd && !trans.isTre) {
                                $('#txtDatea').removeAttr('readonly').css('color', 'black').css('background', 'white');
                                $('#txtTrandate').removeAttr('readonly').css('color', 'black').css('background', 'white');
                            }
                            sum();
                            Unlock(1);
                        }else if(t_name.substring(0,3)=='bbb'){ 
                            //計算已派數量,並更新頁面顯示資料
                            var t_noa = t_name.split('_')[1];
                            var t_ordeno = t_name.split('_')[2];
                            var t_mount = parseFloat(t_name.split('_')[3]);
                            var GG = _q_appendData("view_tranorde_ef", "", true);
                            if (GG[0] != undefined){
                                t_vccecount = (GG[0]['vccecount']==undefined?"0":GG[0]['vccecount']);
                                t_vccecount = (t_vccecount.length==0?"0":t_vccecount);
                                t_where=" noa='"+t_noa+"'";
                                t_where="where=^^"+t_where+"^^";
                                q_gt('trans', t_where, 0, 0, 0, "ccc_"+t_noa+"_"+t_ordeno+"_"+t_mount+"_"+t_vccecount, r_accy);             
                            }else{
                                //查無訂單,直接存檔
                                SaveData();
                            }                           
                        }else if(t_name.substring(0,3)=='ccc'){
                            //回寫已收數量
                            var t_noa = t_name.split('_')[1];
                            var t_ordeno = t_name.split('_')[2];
                            var t_mount = parseFloat(t_name.split('_')[3]);
                            var t_vccecount = parseFloat(t_name.split('_')[4]);
                            var t_curVccecount = t_vccecount + t_mount;
                            var GG = _q_appendData("trans", "", true);
                            if (GG[0] != undefined){            
                                t_curVccecount -= parseFloat(GG[0]['mount']==undefined?"0":GG[0]['mount']);
                            }
                            for(var i in tranorde.data){
                                if(tranorde.data[i]['noa']==t_ordeno){
                                    tranorde.data[i]['vccecount'] = ''+t_curVccecount;
                                    break;
                                }
                            }
                            tranorde.refresh();
                            SaveData();
                        }
                        break;
                }
            }

            function q_popPost(id) {
                switch(id) {
                    /*case 'txtCarno':
                     if(q_cur==1 || q_cur==2){
                     $('#txtDriverno').focus();
                     }
                     break;*/
                    case 'txtCustno':
                        if (q_cur == 1 || q_cur == 2) {
                            if (!trans.isTrd) {
                                $('#txtCaseuseno').val($('#txtCustno').val());
                                $('#txtCaseuse').val($('#txtComp').val());
                                if ($("#txtCustno").val().length > 0) {
                                    $("#txtStraddrno").val($("#txtCustno").val() + '-');
                                    $("#txtStraddr").val("");
                                }
                            }
                        }
                        break;
                    case 'txtStraddrno':
                        if (!trans.isTrd) {
                            trans.priceChange();
                        }
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('trans_s.aspx', q_name + '_s', "550px", "95%", q_getMsg("popSeek"));
            }

            function btnIns() {
               /* Lock(1, {
                    opacity : 0
                });*/
               // curData.copy();
                tranorde.lock();
                _btnIns();
               // curData.paste();
                tranorde.paste(); 
                $('#txtNoa').val('AUTO');
                $('#txtNoq').val('001');
                if ($('#cmbCalctype').val().length == 0) {
                    $('#cmbCalctype').val(trans.calctype[0].noa);
                    trans.calctypeChange();
                }
                trans.refresh();
                trans.checkData();
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                if (q_chkClose())
                    return;
                //避免資料不同步
               /* if ($.trim($('#txtOrdeno').val()).length > 0) {
                    alert('轉來的單據禁止修改。');
                } else {*/
                    Lock(1, {
                        opacity : 0
                    });
                    t_where = " where=^^ noa='" + $('#txtNoa').val() + "'^^";
                    q_gt('trans', t_where, 0, 0, 0, "btnModi", r_accy);
                //}
            }

            function btnPrint() {
                q_box('z_trans.aspx' + "?;;;;" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                if(tranorde.data==undefined){
                    $('#btnTranorde_refresh').click(); 
                    return;
                }
                Unlock(1);
            }

            function btnOk() {
                Lock(1, {
                    opacity : 0
                });
                //日期檢查
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    Unlock(1);
                    return;
                }
                if ($('#txtTrandate').val().length == 0 || !q_cd($('#txtTrandate').val())) {
                    alert(q_getMsg('lblTrandate') + '錯誤。');
                    Unlock(1);
                    return;
                }
                if ($('#txtDatea').val().substring(0, 3) != r_accy) {
                    alert('年度異常錯誤，請切換到【' + $('#txtDatea').val().substring(0, 3) + '】年度再作業。');
                    Unlock(1);
                    return;
                }
                var t_days = 0;
                var t_date1 = $('#txtDatea').val();
                var t_date2 = $('#txtTrandate').val();
                t_date1 = new Date(dec(t_date1.substr(0, 3)) + 1911, dec(t_date1.substring(4, 6)) - 1, dec(t_date1.substring(7, 9)));
                t_date2 = new Date(dec(t_date2.substr(0, 3)) + 1911, dec(t_date2.substring(4, 6)) - 1, dec(t_date2.substring(7, 9)));
                t_days = Math.abs(t_date2 - t_date1) / (1000 * 60 * 60 * 24) + 1;
                if (t_days > 60) {
                    alert(q_getMsg('lblDatea') + '、' + q_getMsg('lblTrandate') + '相隔天數不可多於60天。');
                    Unlock(1);
                    return;
                }
                //---------------------------------------------------------------
                for (var i in trans.calctype) {
                    if (trans.calctype[i].noa == $('#cmbCalctype').val()) {
                        if (trans.calctype[i].isoutside) {
                            $('#txtPrice2').val(0);
                        } else {
                            $('#txtPrice3').val(0);
                        }
                    }
                }
                sum();
                //---------------------------------------------------------------
                if (q_cur == 1) {
                    $('#txtWorker').val(r_name);
                } else if (q_cur == 2) {
                    $('#txtWorker2').val(r_name);
                } else {
                    alert("error: btnok!");
                }
                
                t_noa = $.trim($('#txtNoa').val());
                t_ordeno = $.trim($('#txtOrdeno').val());
                t_mount = $.trim($('#txtMount').val()).length ==0 ? '0':$.trim($('#txtMount').val());
                t_where = "noa='"+t_ordeno+"'";
                t_where="where=^^"+t_where+"^^";
                q_gt('view_tranorde_ef', t_where, 0, 0, 0, "bbb_"+t_noa+"_"+t_ordeno+"_"+t_mount, r_accy);
            }
            function SaveData(){
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (q_cur == 1)
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_trans') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }
            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
                trans.refresh();
                /*t_color = ['darkred','darkblue'];
                 var obj=$('#dview').find('tr');
                 for(var i=1;i<obj.length;i++){
                 objs = obj.eq(i).find('td');
                 for(var j=0;j<objs.length;j++){
                 objs.eq(j).css('color',t_color[i%t_color.length]);
                 }
                 }*/
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
                if (q_chkClose())
                    return;
               /* if ($.trim($('#txtOrdeno').val()).length > 0) {
                    alert('轉來的單據禁止刪除。');
                } else {*/
                    Lock(1, {
                        opacity : 0
                    });
                    var t_where = " where=^^ noa='" + $('#txtNoa').val() + "'^^";
                    q_gt('trans', t_where, 0, 0, 0, 'btnDele', r_accy);
                //}
            }

            function btnCancel() {
                _btnCancel();
            }

            function FormatNumber(n) {
                var xx = "";
                if (n < 0) {
                    n = Math.abs(n);
                    xx = "-";
                }
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx + arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }


            Number.prototype.round = function(arg) {
                return Math.round(this.mul(Math.pow(10, arg))).div(Math.pow(10, arg));
            };
            Number.prototype.div = function(arg) {
                return accDiv(this, arg);
            };
            function accDiv(arg1, arg2) {
                var t1 = 0, t2 = 0, r1, r2;
                try {
                    t1 = arg1.toString().split(".")[1].length;
                } catch (e) {
                }
                try {
                    t2 = arg2.toString().split(".")[1].length;
                } catch (e) {
                }
                with (Math) {
                    r1 = Number(arg1.toString().replace(".", ""));
                    r2 = Number(arg2.toString().replace(".", ""));
                    return (r1 / r2) * pow(10, t2 - t1);
                }
            }


            Number.prototype.mul = function(arg) {
                return accMul(arg, this);
            };
            function accMul(arg1, arg2) {
                var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
                try {
                    m += s1.split(".")[1].length;
                } catch (e) {
                }
                try {
                    m += s2.split(".")[1].length;
                } catch (e) {
                }
                return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
            }


            Number.prototype.add = function(arg) {
                return accAdd(arg, this);
            };
            function accAdd(arg1, arg2) {
                var r1, r2, m;
                try {
                    r1 = arg1.toString().split(".")[1].length;
                } catch (e) {
                    r1 = 0;
                }
                try {
                    r2 = arg2.toString().split(".")[1].length;
                } catch (e) {
                    r2 = 0;
                }
                m = Math.pow(10, Math.max(r1, r2));
                return (Math.round(arg1 * m) + Math.round(arg2 * m)) / m;
            }


            Number.prototype.sub = function(arg) {
                return accSub(this, arg);
            };
            function accSub(arg1, arg2) {
                var r1, r2, m, n;
                try {
                    r1 = arg1.toString().split(".")[1].length;
                } catch (e) {
                    r1 = 0;
                }
                try {
                    r2 = arg2.toString().split(".")[1].length;
                } catch (e) {
                    r2 = 0;
                }
                m = Math.pow(10, Math.max(r1, r2));
                n = (r1 >= r2) ? r1 : r2;
                return parseFloat(((Math.round(arg1 * m) - Math.round(arg2 * m)) / m).toFixed(n));
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 100%;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #cad3ff;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 950px;
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
                width: 9%;
            }
            .tbbm .tdZ {
                width: 2%;
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
            }
            .tbbs input[type="text"] {
                width: 98%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
                font-size: medium;
            }
            #tranorde_table {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #tranorde_table tr {
                height: 30px;
            }
            #tranorde_table td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: pink;
                color: blue;
            }
            #tranorde_header td:hover {
                background: yellow;
                cursor: pointer;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div style="overflow: auto;display:block;width:1400px;">
			<!--#include file="../inc/toolbar.inc"-->
			<input type="button" id="btnUnpresent" value="未出車"/>
		</div>
		<div id="dmain">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewDatea"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewTrandate"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewCarno"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewDriver"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewNick"> </a></td>
						<td align="center" style="width:40px; color:black;"><a id="vewFill"> </a></td>
						<td align="center" style="width:120px; color:black;"><a id="vewStraddr"> </a></td>
						<td align="center" style="width:60px; color:black;"><a id="vewMount"> </a></td>
						<td align="center" style="width:60px; color:black;"><a id="vewPrice"> </a></td>
						<td align="center" style="width:60px; color:black;"><a id="vewMount2"> </a></td>
						<td align="center" style="width:60px; color:black;"><a id="vewPrice2"> </a></td>
						<td align="center" style="width:60px; color:black;"><a id="vewPrice3"> </a></td>
						<td align="center" style="width:60px; color:black;"><a id="vewDiscount"> </a></td>
						<td align="center" style="width:120px; color:black;"><a id="vewPo"> </a></td>
						<td align="center" style="width:120px; color:black;"><a id="vewCaseno"> </a></td>
						<td align="center" style="width:120px; color:black;"><a id="vewCustorde"> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox"/>
						</td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="trandate" style="text-align: center;">~trandate</td>
						<td id="carno" style="text-align: center;">~carno</td>
						<td id="driver" style="text-align: center;">~driver</td>
						<td id="nick" style="text-align: center;">~nick</td>
						<td id="fill" style="text-align: center;">~fill</td>
						<td id="straddr" style="text-align: center;">~straddr</td>
						<td id="mount" style="text-align: right;">~mount</td>
						<td id="price" style="text-align: right;">~price</td>
						<td id="mount2" style="text-align: right;">~mount2</td>
						<td id="price2" style="text-align: right;">~price2</td>
						<td id="price3" style="text-align: right;">~price3</td>
						<td id="discount" style="text-align: right;">~discount</td>
						<td id="po" style="text-align: left;">~po</td>
						<td id="caseno" style="text-align: left;">~caseno</td>
						<td id="custorde" style="text-align: left;">~custorde</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<div id="tranorde" style="float:left;width:1500px;"></div>
				<div id="tranorde_control" style="width:950px;"></div>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td>
						<input id="txtDatea"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblTrandate" class="lbl"> </a></td>
						<td>
						<input id="txtTrandate"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblMon" class="lbl"> </a></td>
						<td>
						<input id="txtMon"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblMon2" class="lbl"> </a></td>
						<td>
						<input id="txtMon2"  type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCarno" class="lbl"> </a></td>
						<td>
						<input id="txtCarno"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblDriver" class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtDriverno"  type="text" style="float:left;width:50%;"/>
						<input id="txtDriver"  type="text" style="float:left;width:50%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl"> </a></td>
						<td colspan="3">
						<input id="txtCustno"  type="text" style="float:left;width:30%;"/>
						<input id="txtComp"  type="text" style="float:left;width:70%;"/>
						<input id="txtNick" type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id="lblCalctype" class="lbl"> </a></td>
						<td><select id="cmbCalctype" class="txt c1"></select></td>
						<td><span> </span><a id="lblCarteam" class="lbl"> </a></td>
						<td><select id="cmbCarteamno" class="txt c1"></select>
						<input id="txtCarteam" type="text" style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblStraddr" class="lbl"> </a></td>
						<td colspan="3">
						<input id="txtStraddrno"  type="text" style="float:left;width:30%;"/>
						<input id="txtStraddr"  type="text" style="float:left;width:70%;"/>
						</td>
						<td><span> </span><a id="lblUcc" class="lbl"> </a></td>
						<td colspan="3">
						<input id="txtUccno"  type="text" style="float:left;width:30%;"/>
						<input id="txtProduct"  type="text" style="float:left;width:70%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblInmount" class="lbl"> </a></td>
						<td>
						<input id="txtInmount"  type="text" class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblPrice" class="lbl"> </a></td>
						<td>
						<input id="txtPrice"  type="text" class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td>
						<input id="txtMount"  type="text" style="display:none;"/>
						<input id="txtTotal"  type="text" class="txt c1 num"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblOutmount" class="lbl"> </a></td>
						<td>
						<input id="txtOutmount"  type="text" class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblPrice2" class="lbl"> </a><a id="lblPrice3" class="lbl"> </a></td>
						<td>
						<input id="txtPrice2"  type="text" class="txt c1 num"/>
						<input id="txtPrice3"  type="text" class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblDiscount" class="lbl"> </a></td>
						<td>
						<input id="txtDiscount"  type="text" class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblTotal2" class="lbl"> </a></td>
						<td>
						<input id="txtMount2"  type="text" style="display:none;"/>
						<input id="txtTotal2"  type="text" class="txt c1 num"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblPton" class="lbl"> </a></td>
						<td>
						<input id="txtPton"  type="text" class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblPton2" class="lbl"> </a></td>
						<td>
						<input id="txtPton2"  type="text" class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblTolls" class="lbl"> </a></td>
						<td>
						<input id="txtTolls"  type="text" class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblReserve" class="lbl"> </a></td>
						<td>
						<input id="txtReserve"  type="text" class="txt c1 num"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblGross" class="lbl"> </a></td>
						<td>
						<input id="txtGross" type="text"  class="txt num c1"/>
						</td>
						<td><span> </span><a id="lblWeight" class="lbl"> </a></td>
						<td>
						<input id="txtWeight" type="text"  class="txt num c1"/>
						</td>
						<td><span> </span><a id="lblWeight2" class="lbl"> </a></td>
						<td>
						<input id="txtWeight2" type="text"  class="txt num c1"/>
						</td>
						<td><span> </span><a id="lblWeight3" class="lbl"> </a></td>
						<td>
						<input id="txtWeight3" type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCaseno" class="lbl"> </a></td>
						<td colspan="3">
						<input id="txtCaseno"  type="text" style="float:left;width:50%;"/>
						<input id="txtCaseno2"  type="text" style="float:left;width:50%;"/>
						</td>
						<td><span> </span><a id="lblCasetype" class="lbl"> </a></td>
						<td><select id="cmbCasetype" class="txt c1"></select></td>
						<td><span> </span><a id="lblFill" class="lbl"> </a></td>
                        <td><input id="txtFill" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblPo" class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtPo"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblCustorde" class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtCustorde" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblBmiles" class="lbl"> </a></td>
						<td>
						<input id="txtBmiles"  type="text" class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblEmiles" class="lbl"> </a></td>
						<td>
						<input id="txtEmiles"  type="text" class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblMiles" class="lbl"> </a></td>
						<td>
						<input id="txtMiles"  type="text" class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblGps" class="lbl"> </a></td>
						<td>
						<input id="txtGps"  type="text" class="txt c1 num"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblLtime" class="lbl"> </a></td>
						<td>
						<input id="txtLtime"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblStime" class="lbl"> </a></td>
						<td>
						<input id="txtStime"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblDtime" class="lbl"> </a></td>
						<td>
						<input id="txtDtime"  type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td colspan="2">
						<input id="txtSalesno"  type="text" style="float:left; width:50%;"/>
						<input id="txtSales"  type="text" style="float:left; width:50%;"/>
						</td>
						<td></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="7">
						<input id="txtMemo"  type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td>
						<input id="txtNoa"  type="text" class="txt c1"/>
						<input id="txtNoq"  type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id="lblOrdeno" class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtOrdeno"  type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td>
						<input id="txtWorker" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td>
						<input id="txtWorker2" type="text" class="txt c1"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
