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
        <script src="css/jquery/ui/jquery.ui.datepicker.js"></script>
        <script type="text/javascript">
        	
			q_tables = 's';
			var q_name = "ztmp_efimport";
			var q_readonly = ['txtNoa','txtSeq_no','chkIs_read','chkIs_del'];
			var q_readonlys = ['txtSeq_no','txtTd_no','txtSeq','txtNeed_date','txtNeed_time','txtDestination'];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [['txtOrder_date','9999/99/99'],['txtGet_deadline','9999/99/99']];
			var bbsMask = [['txtCtn_eta','99:99']];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			brwCount = 10;
			
			aPop = new Array();
            	
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
				
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
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}
			function mainPost() {
				q_getFormat();
				q_mask(bbmMask);
				q_cmbParse("cmbOrder_type", "1@進口");
				
				$('#buttonDel').click(function(e){
					var t_noa = abbm[q_recno].noa;
					if(t_noa.length==0)
						return;
					if (confirm("是否作廢電腦編號【"+t_noa+"】")) {
						Lock(1,{opacity:0});
            			DeleteCST(t_noa);
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
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}
			function DeleteCST(t_noa){
				//is_del 改為1
				$.ajax({
                    url: 'ef_CST.aspx',
                    type: 'POST',
                    data: JSON.stringify({noa:t_noa,action:"delete"}),
                    dataType: 'text',
                    timeout: 5000,
                    success: function(data){
                        if(data.toLowerCase()=="done"){
                        	abbm[q_recno].is_del=="true";
                        	$('#chkIs_del').prop('checked',true);
                        	$('#vtxdel_'+q_recno).text('*');
                        }else{
                        	alert(data);
                        }
                    },
                    complete: function(){ 
                    	Unlock(1);//解除鎖定                   
                    },
                    error: function(jqXHR, exception) {
                        var errmsg = '';
                        if (jqXHR.status === 0) {
                            alert(errmsg+'Not connect.\n Verify Network.');
                        } else if (jqXHR.status == 404) {
                            alert(errmsg+'Requested page not found. [404]');
                        } else if (jqXHR.status == 500) {
                            alert(errmsg+'Internal Server Error [500].');
                        } else if (exception === 'parsererror') {
                            alert(errmsg+'Requested JSON parse failed.');
                        } else if (exception === 'timeout') {
                            alert(errmsg+'Time out error.');
                        } else if (exception === 'abort') {
                            alert(errmsg+'Ajax request aborted.');
                        } else {
                            alert(errmsg+'Uncaught Error.\n' + jqXHR.responseText);
                        }
                    }
                });
			}
			function InsertCST(t_noa){
				$.ajax({
					noa: t_noa,
                    url: 'ef_CST.aspx',
                    type: 'POST',
                    data: JSON.stringify({noa:t_noa,action:"insert"}),
                    dataType: 'text',
                    timeout: 5000,
                    success: function(data){
                        if(data.toLowerCase().substring(0,5)=="done:"){
                        	var seq_no = data.toLowerCase().replace('done:','');
                        	abbm[q_recno].seq_no = seq_no;
                        	for(var i=0;i<abbs.length;i++){
                        		if(abbs[i].noa == this.noa)
                        			abbs[i].seq_no = seq_no;
                        	}
                        	$('#txtSeq_no').val(seq_no);
                        	for(var i=0;i<q_bbsCount;i++){
                        		$('#txtSeq_no_'+i).val(seq_no);
                        	}
                        }else{
                        	alert(data);
                        }
                    },
                    complete: function(){ 
                    	Unlock(1);//解除btnOk的鎖定                   
                    },
                    error: function(jqXHR, exception) {
                        var errmsg = '';
                        if (jqXHR.status === 0) {
                            alert(errmsg+'Not connect.\n Verify Network.');
                        } else if (jqXHR.status == 404) {
                            alert(errmsg+'Requested page not found. [404]');
                        } else if (jqXHR.status == 500) {
                            alert(errmsg+'Internal Server Error [500].');
                        } else if (exception === 'parsererror') {
                            alert(errmsg+'Requested JSON parse failed.');
                        } else if (exception === 'timeout') {
                            alert(errmsg+'Time out error.');
                        } else if (exception === 'abort') {
                            alert(errmsg+'Ajax request aborted.');
                        } else {
                            alert(errmsg+'Uncaught Error.\n' + jqXHR.responseText);
                        }
                    }
                });
			}
			function UpdateCST(t_noa){
				$.ajax({
					noa: t_noa,
                    url: 'ef_CST.aspx',
                    type: 'POST',
                    data: JSON.stringify({noa:t_noa,action:"update"}),
                    dataType: 'text',
                    timeout: 5000,
                    success: function(data){
                        if(data.toLowerCase().substring(0,5)=="done:"){
                        }else{
                        	alert(data);
                        }
                    },
                    complete: function(){ 
                    	Unlock(1);//解除btnOk的鎖定                   
                    },
                    error: function(jqXHR, exception) {
                        var errmsg = '';
                        if (jqXHR.status === 0) {
                            alert(errmsg+'Not connect.\n Verify Network.');
                        } else if (jqXHR.status == 404) {
                            alert(errmsg+'Requested page not found. [404]');
                        } else if (jqXHR.status == 500) {
                            alert(errmsg+'Internal Server Error [500].');
                        } else if (exception === 'parsererror') {
                            alert(errmsg+'Requested JSON parse failed.');
                        } else if (exception === 'timeout') {
                            alert(errmsg+'Time out error.');
                        } else if (exception === 'abort') {
                            alert(errmsg+'Ajax request aborted.');
                        } else {
                            alert(errmsg+'Uncaught Error.\n' + jqXHR.responseText);
                        }
                    }
                });
			}
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				$('#vtxread_'+q_recno).text(abbm[q_recno].is_read=="true"?'*':'');
				$('#vtxdel_'+q_recno).text(abbm[q_recno].is_del=="true"?'*':'');
				if(q_cur==1){
					InsertCST(abbm[q_recno].noa);//寫入正新資料庫
				}else if(q_cur==2){
					UpdateCST(abbm[q_recno].noa);//寫入正新資料庫
				}else{
					Unlock(1);//解除btnOk的鎖定
				}
			}
			function btnOk() {
				Lock(1,{opacity:0});
				var max = 0;
				for(var i=0;i<q_bbsCount;i++){
					max = max<q_float('txtSeq_'+i)?q_float('txtSeq_'+i):max;
				}
				for(var i=0;i<q_bbsCount;i++){
					if(q_float('txtSeq_'+i)==0){
						$('#txtSeq_'+i).val(max+1);
						max++;
					}
				}
				
				var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtOrder_date').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_efimport') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
			}
			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('ztmp_efimport_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
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
				$('#txtOrder_date').focus();
			}
			function btnModi() {
				alert('【修改】只會更新領櫃地、備註至正新!');
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtNote_date').focus();
			}
			function btnPrint() {
				q_box("z_orde_ef.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";;" + r_accy, 'z_addr', "95%", "95%", q_getMsg("popPrint"));
			}
			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}
			function bbsSave(as) {
				if (!as['container_no']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['td_no']=abbm2['td_no'];
				return true;
			}
			function sum() {
			}
			function refresh(recno) {
				_refresh(recno);
			}
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
                    $('#txtOrder_date').datepicker('destroy');
                    $('#txtGet_deadline').datepicker('destroy');
                    $('#buttonDel').removeAttr('disabled');
                } else {	
                    $('#txtOrder_date').datepicker({dateFormat: 'yy/mm/dd'});
                    $('#txtGet_deadline').datepicker({dateFormat: 'yy/mm/dd'});
                    $('#buttonDel').attr('disabled','disabled');
                }
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
				alert('【刪除】不會同步刪除正新的資料!');
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
                width: 400px;
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
                width: 600px;
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
                width: 12%;
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
                        <td align="center" style="width:100px; color:black;"><a id='vewOrder_date'>訂單日期</a></td>
                        <td align="center" style="width:200px; color:black;"><a id='vewTd_no'>進口單號</a></td>
                        <td align="center" style="width:20px; color:black;"><a id='vewXread'>已讀</a></td>
                        <td align="center" style="width:20px; color:black;"><a id='vewXdel'>作廢</a></td>
                    </tr>
                    <tr>
                        <td><input id="chkBrow.*" type="checkbox" /></td>
                        <td style="text-align: left;" id='order_date'>~order_date</td>
                        <td style="text-align: left;" id='td_no'>~td_no</td>
                        <td style="text-align: left;" id='xread'>~xread</td>
                        <td style="text-align: left;" id='xdel'>~xdel</td>
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
                        <td></td>
                        <td></td>
                        <td class="tdZ"></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblNoa' class="lbl">電腦編號</a></td>
                        <td><input id="txtNoa" type="text" class="txt c1" /></td>
                        <td><span> </span><a id='lblOrder_date' class="lbl">訂單日期</a></td>
                        <td><input id="txtOrder_date" type="text" class="txt c1" /></td>
                        <td><span> </span><a id='lblSeq_no' class="lbl">系統序號</a></td>
                        <td><input id="txtSeq_no" type="text" class="txt c1" /></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblOrder_type" class="lbl">訂單類別</a></td>
                        <td><select id="cmbOrder_type" class="txt c1" > </select></td>
                    	<td><span> </span><a id='lblTd_no' class="lbl">進口單號</a></td>
                        <td><input id="txtTd_no" type="text" class="txt c1" /></td>
                        <td><span> </span><a id='lblContainer_count' class="lbl">貨櫃數量</a></td>
                        <td><input id="txtContainer_count" type="text" class="txt c1 num" /></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblShip_company' class="lbl">船公司</a></td>
                        <td><input id="txtShip_company" type="text" class="txt c1" /></td>
                        <td><span> </span><a id='lblShip_name' class="lbl">船名</a></td>
                        <td><input id="txtShip_name" type="text" class="txt c1" /></td>
                        <td><span> </span><a id='lblShip_number' class="lbl">航次</a></td>
                        <td><input id="txtShip_number" type="text" class="txt c1" /></td>
                    </tr>
 					<tr>
                        <td><span> </span><a id='lblContainer_source' class="lbl">領櫃地</a></td>
                        <td><input id="txtContainer_source" type="text" class="txt c1" /></td>
                        <td><span> </span><a id='lblGet_deadline' class="lbl">領櫃期限</a></td>
                        <td><input id="txtGet_deadline" type="text" class="txt c1" /></td>
                    </tr>
                    <tr> 
                    	<td><span> </span><a id='lblNote' class="lbl">備註</a></td>
                        <td colspan="5"><input id="txtNote" type="text" class="txt c1" /></td>
                	</tr>
                	<tr> 
                    	<td><span> </span><a id='lblIs_read' class="lbl">已讀取</a></td>
                        <td><input id="chkIs_read" type="checkbox" class="txt c1" /></td>
                        <td><span> </span><a id='lblIs_del' class="lbl">作廢</a></td>
                        <td><input id="chkIs_del" type="checkbox" class="txt c1" /></td>
                        <td> </td>
                        <td><input type="button" id="buttonDel" value="作廢"/></td>
                	</tr>
                </table>
            </div>
        </div>
        <div class='dbbs'>
            <table id="tbbs" class='tbbs'>
                <tr style='color:white; background:#003366;' >
                    <td  align="center" style="width:30px;">
                    <input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
                    </td>
                    <td align="center" style="width:20px;"> </td>
                    <td align="center" style="width:80px;">系統序號</td>
                    <td align="center" style="width:120px;">進口單號</td>
                    <td align="center" style="width:50px;">序號</td>
                    <td align="center" style="width:100px;">櫃型</td>
                    <td align="center" style="width:150px;">貨櫃號碼</td>
                    <td align="center" style="width:100px;">需求日期</td>
                    <td align="center" style="width:100px;">需求時間</td>
                    <td align="center" style="width:100px;">送櫃地點</td>
                    <td align="center" style="width:100px;">預計到達時間</td>
                    <td align="center" style="width:100px;">備註</td>
                </tr>
                <tr  style='background:#cad3ff;'>
                    <td align="center">
                    <input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
                    <input id="txtNoq.*" type="text" style="display: none;" />
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a>
                    <td><input type="text" id="txtSeq_no.*" style="width:95%;" /></td>
                    <td><input type="text" id="txtTd_no.*" style="width:95%;" /></td>
                    <td><input type="text" id="txtSeq.*" style="width:95%;" /></td>
                    <td><input type="text" id="txtContainer_type.*" style="width:95%;" /></td>
                    <td><input type="text" id="txtContainer_no.*" style="width:95%;" /></td>
                    <td><input type="text" id="txtNeed_date.*" style="width:95%;" /></td>
                    <td><input type="text" id="txtNeed_time.*" style="width:95%;" /></td>
                    <td><input type="text" id="txtDestination.*" style="width:95%;" /></td>
                    <td><input type="text" id="txtCtn_eta.*" style="width:95%;" /></td>
                    <td><input type="text" id="txtNote.*" style="width:95%;" /></td>
                </tr>
            </table>
        </div>
        <input id="q_sys" type="hidden" />
    </body>
</html>
