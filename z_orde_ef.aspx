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
            $(document).ready(function() {
                q_gf('', 'z_orde_ef');
                q_getId();
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_orde_ef',
                    options : [{/*1*/
                        type : '1',
                        name : 'ordedate'
                    }]
                });
                q_getFormat();
                q_langShow();
                q_popAssign();

                $('#txtOrdedate1').mask('999/99/99');
                $('#txtOrdedate1').datepicker();
                $('#txtOrdedate2').mask('999/99/99');
                $('#txtOrdedate2').datepicker();
                var t_date,t_year,t_month,t_day;
    			t_date = new Date();
				t_date.setDate(1);
				t_year = t_date.getUTCFullYear() - 1911;
				t_year = t_year > 99 ? t_year + '' : '0' + t_year;
				t_month = t_date.getUTCMonth() + 1;
				t_month = t_month > 9 ? t_month + '' : '0' + t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day > 9 ? t_day + '' : '0' + t_day;
				$('#txtOrdedate1').val(t_year + '/' + t_month + '/' + t_day);

    			t_date = new Date();
                t_date.setDate(35);
                t_date.setDate(0);
                t_year = t_date.getUTCFullYear()-1911;
                t_year = t_year>99?t_year+'':'0'+t_year;
                t_month = t_date.getUTCMonth()+1;
                t_month = t_month>9?t_month+'':'0'+t_month;
                t_day = t_date.getUTCDate();
				t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtOrdedate2').val(t_year + '/' + t_month + '/' + t_day);
                

                $( '<input type="button" id="btnImport" value="匯入訂單" style="float:right;height:30px;">' ).insertAfter( "#txtOrdedate2");
                
                $('#btnImport').click(function(e){
                	Lock(1);
                	var t_bdate = $('#txtOrdedate1').val();
                	var t_edate = $('#txtOrdedate2').val();
                	
                	try{
                		t_bdate = (t_bdate.length==0?"":parseInt(t_bdate.substring(0,3))+1911)+t_bdate.substring(3,t_bdate.length);
                		t_edate = (t_edate.length==0?"":parseInt(t_edate.substring(0,3))+1911)+t_edate.substring(3,t_edate.length);
                	}catch(e){}
                	//alert(t_bdate+'\n'+t_edate);
                	$.ajax({
						url : 'getorde_ct.aspx'
						, type : 'POST'
						, data : JSON.stringify({bdate:t_bdate ,edate:t_edate })
						, dataType : 'text'
						, timeout : 0
						, success : function(data) {
						    if(data.length>0){
						        alert(data);
						    }
						}, complete : function() {
							Unlock(1);
						}, error : function(jqXHR, exception) {
							if (jqXHR.status === 0) {
								alert('Not connect.\n Verify Network.<br>');
							} else if (jqXHR.status == 404) {
								alert( 'Requested page not found. [404]<br>');
							} else if (jqXHR.status == 500) {
								alert( 'Internal Server Error [500].<br>');
							} else if (exception === 'parsererror') {
								alert( 'Requested JSON parse failed.<br>');
							} else if (exception === 'timeout') {
								alert( 'Time out error.<br>');
							} else if (exception === 'abort') {
								alert('Ajax request aborted.<br>');
							} else {
								alert( 'Uncaught Error.<br>' + jqXHR.responseText+'<br>');
							}
						}
					});
                	
                });
            }
        </script>
    </head>
    <body ondragstart="return false" draggable="false"
    ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
    ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
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