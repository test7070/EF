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
		
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_driverp_ef');
            });
            function q_gfPost() {
                LoadFinish();
            }
            function q_gtPost(t_name) {
                switch (t_name) {
                    default:
                        break;
                }
            }

            function q_boxClose(t_name) {
            }

            function LoadFinish() {
                $('#q_report').q_report({
                    fileName : 'z_driverp_ef',
                    options : [{/*[1],[2]*/
                        type : '2',
                        name : 'driver',
                        dbf : 'driver',
                        index : 'noa,namea',
                        src : 'driver_b.aspx'
                    },{/*[3],[4]*/
                        type : '2',
                        name : 'cardeal',
                        dbf : 'cardeal',
                        index : 'noa,comp',
                        src : 'cardeal_b.aspx'
                    }, {/*[5]*/
                        type : '8',
                        name : 'cartype',
                        value : q_getPara('driver.cartype').split(',')
                    }, {/*[6]*/
                        type : '8',
                        name : 'mode',
                        value : ('模組一,模組二,模組三').split(',')
                    }, {/*[7]*/
                        type : '5',
                        name : 'exist',
                        value : (' @全部,Y@在職,N@離職').split(',')
                    }]
                });
                q_popAssign();
                q_langShow();
            }
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    default:
                        break;
                }
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