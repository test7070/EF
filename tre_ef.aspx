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


            q_tables = 's';
            var q_name = "tre";
            var q_readonly = ['txtCarchgno','txtAccno', 'txtNoa', 'txtMoney', 'txtTotal', 'txtTolls', 'txtWorker2', 'txtWorker', 'txtRc2ano', 'txtPaydate', 'txtPlusmoney', 'txtMinusmoney', 'txtAccno', 'txtAccno2', 'txtYear2', 'txtYear1'];
            var q_readonlys = ['txtOrdeno', 'txtTranno', 'txtTrannoq'];
            var bbmNum = [['txtMoney', 10, 0],  ['txtTotal', 10, 0], ['txtPlusmoney', 10, 0], ['txtMinusmoney', 10, 0]];
            var bbsNum = [['txtMount', 10, 3], ['txtPrice', 10, 3], ['txtDiscount', 10, 3], ['txtMoney', 10, 0], ['txtTolls', 10, 0]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            q_desc = 1;
            aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno,txtDriverno,txtDriver', 'car2_b.aspx']
            , ['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']
            , ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']
            , ['txtBdriverno', '', 'driver', 'noa,namea', 'txtBdriverno', 'driver_b.aspx']
            , ['txtEdriverno', '', 'driver', 'noa,namea', 'txtEdriverno', 'driver_b.aspx']
            , ['txtDriverno_import', 'lblDriverno_import', 'driver', 'noa,namea', 'txtDriverno_import', 'driver_b.aspx']);


            q_xchg = 1;
            brwCount2 = 20;

            function tre() {
            }

            tre.prototype = {
                isLoad : false,
                carchgno : new Array()
            };

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
                bbmMask = [['txtBdate', r_picd],['txtEdate', r_picd],['txtBtrandate', r_picd],['txtEtrandate', r_picd],['txtDatea', r_picd]];
                q_mask(bbmMask);

                $('#lblAccno').click(function() {
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtYear1').val() + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
                });
                $('#lblAccno2').click(function() {
                    q_pop('txtAccno2', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno2').val() + "';" + $('#txtYear2').val() + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
                });

                $('#txtPlusmoney').change(function(e) {
                    sum();
                });
                $('#txtMinusmoney').change(function(e) {
                    sum();
                });
                $('#btnTrans').click(function(e) {
                    if (!(q_cur == 1 || q_cur == 2))
                        return;
                    Lock(1, {
                        opacity : 0
                    });
                    if ($.trim($('#txtDriverno').val()) == 0) {
                        alert('請輸入司機');
                        Unlock(1);
                        return false;
                    }
                    var t_noa = $.trim($('#txtNoa').val());
                    var t_driverno = $.trim($('#txtDriverno').val());
                    var t_bdate = $.trim($('#txtBdate').val());
                    var t_edate = $.trim($('#txtEdate').val());
                    var t_btrandate = $.trim($('#txtBtrandate').val());
                    var t_etrandate = $.trim($('#txtEtrandate').val());
                    
                    q_func('qtxt.query.transef2tre', 'transef.txt,transef2tre,' 
                    	+ encodeURI(t_noa) + ';'+ encodeURI(t_driverno)
                		+ ';' + encodeURI(t_bdate)+ ';' + encodeURI(t_edate)
                		+ ';' + encodeURI(t_btrandate)+ ';' + encodeURI(t_etrandate)); 	
                });
                $("#btnCarchg").click(function(e) {
                	Lock(1,{opacity:0});
                	/*if ($('#txtCarno').val().length == 0) {
                        alert('請輸入車牌!');
                        Unlock(1);
                        return;
                    }*/
                    if ($('#txtDriverno').val().length == 0) {
                        alert('請輸入司機!');
                        Unlock(1);
                        return;
                    }
                    t_carchgno = 'carchgno=' + $('#txtCarchgno').val();
                    t_where = " driverno='" + $('#txtDriverno').val() + "' and  (treno='" + $('#txtNoa').val() + "' or len(isnull(treno,''))=0) ";
                    q_box("carchg_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";;" + t_carchgno + ";", 'carchg', "95%", "650px", q_getMsg('popCarchg'));  
                });
                $('#lblCarchgno').click(function(e){
					var t_where = "1!=1";
					var t_carchgno = $('#txtCarchgno').val().split(',');
					for(var i in t_carchgno){
						if(t_carchgno[i].length>0)
							t_where += " or noa='"+t_carchgno[i]+"'";
					}
					q_box("carchg_ds.aspx?"+ r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy + '_' + r_cno, 'carchg', "95%", "95%", q_getMsg("popCarchg"));
				});
            }

            function q_funcPost(t_func, result) {
                switch(t_func) {
            		case 'qtxt.query.transef2tre':
            			var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                            q_gridAddRow(bbsHtm, 'tbbs', 'txtTranaccy,txtTranno,txtTrannoq,txtTrandate,txtComp,txtStraddr,txtEndaddr,txtMoney,txtMemo'
                        	, as.length, as, 'accy,noa,noq,trandate,comp,straddr,endaddr,tremoney,memo', '','');
                        	sum();
                        } else {
                            alert('無資料!');
                        }
                        Unlock(1);
            			break;
                }

            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case 'carchg':
                        if (b_ret != null) {
                            var t_where = '1!=1';
                            $('#txtCarchgno').val('');           
                            for (var i = 0; i < b_ret.length; i++) {
                                $('#txtCarchgno').val($('#txtCarchgno').val()+($('#txtCarchgno').val().length>0?',':'')+b_ret[i].noa);
                                t_where += " or noa='" + b_ret[i].noa + "'";
                            }
                            q_gt('carchg', "where=^^" + t_where + "^^", 0, 0, 0, "");
                        }else{
                        	Unlock(1);
                        }
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'btnDele':
                		var as = _q_appendData("pays", "", true);
                        if (as[0] != undefined) {
                        	var t_msg = "",t_paysale=0;
                        	for(var i=0;i<as.length;i++){
                        		t_paysale = parseFloat(as[i].paysale.length==0?"0":as[i].paysale);
                        		if(t_paysale!=0)
                        			t_msg += String.fromCharCode(13)+'付款單號【'+as[i].noa+'】 '+FormatNumber(t_paysale);
                        	}
                        	if(t_msg.length>0){
                        		alert('已沖帳:'+ t_msg);
                        		Unlock(1);
                        		return;
                        	}
                        }
                    	_btnDele();
                    	Unlock(1);
                		break;
                	case 'btnModi':
                		var as = _q_appendData("pays", "", true);
                        if (as[0] != undefined) {
                        	var t_msg = "",t_paysale=0;
                        	for(var i=0;i<as.length;i++){
                        		t_paysale = parseFloat(as[i].paysale.length==0?"0":as[i].paysale);
                        		if(t_paysale!=0)
                        			t_msg += String.fromCharCode(13)+'付款單號【'+as[i].noa+'】 '+FormatNumber(t_paysale);
                        	}
                        	if(t_msg.length>0){
                        		alert('已沖帳:'+ t_msg);
                        		Unlock(1);
                        		return;
                        	}
                        }
                    	_btnModi();
		                sum();
		                Unlock(1);
		                $('#txtDatea').focus();
                		break;
                    case 'carchg':
                        var as = _q_appendData("carchg", "", true);
                        var t_plusmoney = 0, t_minusmoney = 0;
                        for ( i = 0; i < as.length; i++) {
                            t_plusmoney += parseFloat(as[i].plusmoney);
                            t_minusmoney += parseFloat(as[i].minusmoney);
                        }
                        $('#txtPlusmoney').val(t_plusmoney);
                        $('#txtMinusmoney').val(t_minusmoney);
                        sum();
                        Unlock(1);
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
                Unlock(1);
            }
            function btnOk() {
            	Lock(1,{opacity:0});
                $('#txtDatea').val($.trim($('#txtDatea').val()));
                if($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())){
					alert(q_getMsg('lblDatea')+'錯誤。');
            		Unlock(1);
            		return;
				}
				if($('#txtDatea').val().substring(0,3)!=r_accy){
					alert('年度異常錯誤，請切換到【'+$('#txtDatea').val().substring(0,3)+'】年度再作業。');
					Unlock(1);
            		return;
				}
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tre') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;

                q_box('tre_ds_s.aspx', q_name + '_s', "530px", "530px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                    $('#lblNo_' + j).text(j + 1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                        $('#txtTranno_' + j).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtTranno_', '');
                            var t_accy = $('#txtTranaccy_' + n).val();
                            q_box("transef.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $(this).val() + "';" + t_accy, 'trans', "95%", "95%", q_getMsg("popTrans"));
                            
                        });
                        $('#txtMoney_'+j).change(function(e){
                            sum();
                        });
                    }
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDriverno').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                Lock(1,{opacity:0});
                var t_where =" where=^^ rc2no='"+ $('#txtNoa').val()+"'^^";
                q_gt('pays', t_where, 0, 0, 0, 'btnModi',r_accy);
            }

            function btnPrint() {
            	if (q_getPara('sys.project') == 'va') {
					q_box('z_tre_va.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
			  	}	
			  	else{
                	q_box('z_tre_ds.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
               }
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['tranno']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                return true;
            }

            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
                var t_money = 0, t_total = 0;
                for ( i = 0; i < q_bbsCount; i++) {
                    t_money += q_float('txtMoney_' + i);
                }
                t_plusmoney = q_float('txtPlusmoney');
                t_minusmoney = q_float('txtMinusmoney');
                t_total = t_money + t_plusmoney - t_minusmoney;
                $('#txtMoney').val(t_money);
                $('#txtTotal').val(t_total);
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (q_cur == 1 || q_cur == 2) {
                    $('#btnCarchg').removeAttr('disabled');
                    $('#btnTrans').removeAttr('disabled');
                    $('#txtDatea').datepicker();
                    $('#txtBdate').datepicker();
                    $('#txtEdate').datepicker();
                    $('#txtBtrandate').datepicker();
                    $('#txtEtrandate').datepicker();
                } else {
                    $('#btnCarchg').attr('disabled', 'disabled');
                    $('#btnTrans').attr('disabled','disabled');
                    $('#txtDatea').datepicker('destroy');
                    $('#txtBdate').datepicker('destroy');
                    $('#txtEdate').datepicker('destroy');
                    $('#txtBtrandate').datepicker('destroy');
                    $('#txtEtrandate').datepicker('destroy');
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
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
                Lock(1,{opacity:0});
                var t_where =" where=^^ rc2no='"+ $('#txtNoa').val()+"'^^";
                q_gt('pays', t_where, 0, 0, 0, 'btnDele',r_accy);
            }

            function btnCancel() {
                _btnCancel();
            }
            function FormatNumber(n) {
            	var xx = "";
            	if(n<0){
            		n = Math.abs(n);
            		xx = "-";
            	}     		
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx+arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 950px;
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
                width: 8%;
            }
            .tbbm .tr1 {
                background-color: #FFEC8B;
            }
            .tbbm .tr_carchg {
                background-color: #DAA520;
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
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:140px; color:black;"><a id='vewDriver'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewMoney'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewPlusmoney'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewMinusmoney'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewTotal'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="driver" style="text-align: center;">~driver</td>
						<td id="money,0,1" style="text-align: right;">~money,0,1</td>
						<td id="plusmoney,0,1" style="text-align: right;">~plusmoney,0,1</td>
						<td id="minusmoney,0,1" style="text-align: right;">~minusmoney,0,1</td>
						<td id="total,0,1" style="text-align: right;">~total,0,1</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr name="schema" style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>			
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDriver" class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtDriverno" type="text" style="float:left;width:45%;"/>
							<input id="txtDriver" type="text" style="float:left;width:55%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">發送日期</a></td>
                        <td colspan="3">
	                        <input id="txtBdate" type="text" style="float:left; width:45%;"/>
	                        <span style="float:left;display: block;width:3%;height:inherit;color:blue;font-size: 14px;text-align: center;">~</span>
	                        <input id="txtEdate" type="text" style="float:left; width:45%;"/>
                        </td>
                        <td><span> </span><a class="lbl">配送日期</a></td>
                        <td colspan="3">
	                        <input id="txtBtrandate" type="text" style="float:left; width:45%;"/>
	                        <span style="float:left;display: block;width:3%;height:inherit;color:blue;font-size: 14px;text-align: center;">~</span>
	                        <input id="txtEtrandate" type="text" style="float:left; width:45%;"/>
                        </td>
						<td><input id="btnTrans" type="button" class="txt c1" value="匯入"/></td>
					</tr>	
					<tr class="tr_carchg">
						<td><span> </span><a id="lblCarchgno" class="lbl btn"> </a></td>
						<td colspan="7"><input id="txtCarchgno" type="text" class="txt c1"/></td>
						<td><input type="button" id="btnCarchg" class="txt c1"/></td>
						<td class="tdZ"> </td>
					</tr>			
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td><input id="txtMoney" type="text"  class="txt c1 num"/></td>
						<td><span> </span><a id="lblPlusmoney" class="lbl"> </a></td>
						<td><input id="txtPlusmoney" type="text" class="txt c1 num" /></td>
						<td><span> </span><a id="lblMinusmoney" class="lbl"> </a></td>
						<td><input id="txtMinusmoney" type="text" class="txt c1 num" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTggno" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtTggno" type="text"  class="txt" style="float:left;width:45%;"/>
							<input id="txtTgg" type="text"  class="txt" style="float:left;width:55%;"/>
						</td>
						<td> </td>
						<td> </td>
						<td><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt c1 num" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="6"><input id="txtMemo" type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1" /></td>
					</tr>
					<tr class="tr8">
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td>
						<input id="txtAccno" type="text"  class="txt c1"/>
						</td>
						<td>
						<input id="txtYear1" type="text"  class="txt c1"/>
						</td>
						<td><span> </span><a id="lblAccno2" class="lbl btn"> </a></td>
						<td>
						<input id="txtAccno2" type="text"  class="txt c1"/>
						</td>
						<td>
						<input id="txtYear2" type="text"  class="txt c1"/>
						</td>
						<td></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td>
						<input id="txtWorker2" type="text"  class="txt c1"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:100px;"><a>配送日期</a></td>
					<td align="center" style="width:200px;"><a>客戶</a></td>
					<td align="center" style="width:100px;"><a>起點</a></td>
					<td align="center" style="width:100px;"><a>迄點</a></td>
					<td align="center" style="width:100px;"><a>運費</a></td>
					<td align="center" style="width:150px;"><a>出車單號</a></td>
					<td align="center" style="width:100px;"><a>備註</a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input type="text" id="txtTrandate.*" style="width:95%;" /></td>
					
					<td><input type="text" id="txtComp.*" style="width:95%;" /></td>
					<td><input type="text" id="txtStraddr.*" style="width:95%;"/></td>
					<td><input type="text" id="txtEndaddr.*" style="width:95%;"/></td>
					<td><input type="text" id="txtMoney.*" style="width:95%;text-align: right;" /></td>
					<td>
						<input type="text" id="txtTranno.*" style="float:left; width: 95%;"/>
						<input type="text" id="txtTranaccy.*" style="display:none;"/>
						<input type="text" id="txtTrannoq.*" style="display:none;"/>
					</td>
					<td><input type="text" id="txtMemo.*" style="float:left; width: 95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>