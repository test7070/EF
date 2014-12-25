<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">
        
        public class Para
        {
            public string noa;
            public string action;
        }
        /*ztmp_efimport 資料寫入正新*/
        public void Page_Load()
        {   
            //參數
            System.Text.Encoding encoding = System.Text.Encoding.UTF8;
            Response.ContentEncoding = encoding;
            int formSize = Request.TotalBytes;
            byte[] formData = Request.BinaryRead(formSize);
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            var item = serializer.Deserialize<Para>(encoding.GetString(formData));
            
            /*//環境變數
            System.Environment.SetEnvironmentVariable("NLS_LANG", "AMERICAN_AMERICA.ZHT16BIG5", EnvironmentVariableTarget.Process);
            //連接字串
            System.Configuration.Configuration rootWebConfig = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("/127.0.0.1");
            System.Configuration.ConnectionStringSettings CST = null;
            System.Configuration.ConnectionStringSettings DC2 = null;
            if (0 < rootWebConfig.ConnectionStrings.ConnectionStrings.Count)
            {
                CST = rootWebConfig.ConnectionStrings.ConnectionStrings["CSTConnectionString"];
                DC2 = rootWebConfig.ConnectionStrings.ConnectionStrings["DC2ConnectionString"];
            }
            if (null == CST)
            {
                Response.Write("CSTConnectionString Can't find!");
                return;
            }
            if (null == DC2)
            {
                Response.Write("DC2ConnectionString Can't find!");
                return;
            }*/

            //DC2.ConnectionString  峻富資料庫連接字串
            //CST.ConnectionString  正新資料庫連接字串
            string CSTConnectionString = "Provider=msdaora;Data Source=203.75.57.25;Persist Security Info=True;User ID=GF;Password=CSTGF;Unicode=True";
            string DC2ConnectionString = "Data Source=59.125.143.171,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database=DC2";
            //抓資料
            System.Data.DataTable dc2 = new System.Data.DataTable();
            System.Data.DataTable dc2s = new System.Data.DataTable();
            string queryString = "SELECT noa,seq_no,order_type,td_no,container_count,order_date,ship_company,ship_name,ship_number,container_source,get_deadline,note,is_read,is_del FROM dbo.ztmp_efimport where noa='" + item.noa + "'";

            System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter(queryString, DC2ConnectionString);
            adapter.Fill(dc2);

            queryString = "SELECT noa,noq,seq_no,seq,td_no,container_type,container_no,need_date,need_time,destination,ctn_eta,note FROM dbo.ztmp_efimports where noa='" + item.noa + "'";
            adapter = new System.Data.SqlClient.SqlDataAdapter(queryString, DC2ConnectionString);
            adapter.Fill(dc2s);

            //正常一定會有資料,資料應該也只有一筆
            if(dc2.Rows.Count == 0){
                Response.Write("無資料! "+item.noa);
                return;
            }
            if (item.action == "insert")
            {
                //SEQ_NO 若值不為0,表示有資料
                if ((System.Int32)dc2.Rows[0].ItemArray[1] > 0)
                {
                    Response.Write("SEQ_NO已有值! ");
                    return;
                }
                //取得目前最大的SEQ_NO
                queryString = "SELECT MAX(SEQ_NO) AS SEQ_NO FROM GETHER.GF_ORDS";
                System.Data.DataTable tmp = new System.Data.DataTable();
                System.Data.OleDb.OleDbDataAdapter oadapter = new System.Data.OleDb.OleDbDataAdapter(queryString, CSTConnectionString);
                oadapter.Fill(tmp);
                System.Decimal seq_no = (tmp.Rows.Count > 0 ? (System.Decimal)tmp.Rows[0].ItemArray[0] : 0) + 1;
                //回寫ztmp_efimport
                System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(DC2ConnectionString);
                int n = 0;
                try
                {
                    conn.Open();
                    System.Data.SqlClient.SqlCommand cmd =
                            new System.Data.SqlClient.SqlCommand("update ztmp_efimport set seq_no=@seq_no where noa=@noa"
                                + " update ztmp_efimports set seq_no=@seq_no where noa=@noa"
                                , conn);
                    cmd.Parameters.AddWithValue("@seq_no", seq_no);
                    cmd.Parameters.AddWithValue("@noa", item.noa);
                    cmd.ExecuteNonQuery();
                }
                catch (Exception e)
                {
                }
                finally
                {
                    conn.Close();
                }
                //寫到正新
                int nBbm = -2;
                System.Collections.Generic.List<int> nBbs = new System.Collections.Generic.List<int>();
                using (System.Data.OleDb.OleDbConnection connSource = new System.Data.OleDb.OleDbConnection(CSTConnectionString))
                {
                    oadapter = new System.Data.OleDb.OleDbDataAdapter();
                    connSource.Open();
                    //BBM
                    string querySource = @"INSERT INTO GETHER.GF_ORDS
                    (SEQ_NO, ORDER_TYPE, TD_NO,CONTAINER_COUNT,ORDER_DATE,SHIP_COMPANY
                    ,SHIP_NAME,SHIP_NUMBER,CONTAINER_SOURCE,GET_DEADLINE,NOTE)VALUES(?,?,?,?,?,?,?,?,?,?,?)";
                    System.Data.OleDb.OleDbCommand commandSource = new System.Data.OleDb.OleDbCommand(querySource, connSource);
                    //需注意dc2 欄位順序
                    commandSource.Parameters.Add("SEQ_NO", System.Data.OleDb.OleDbType.Decimal).Value = seq_no;
                    commandSource.Parameters.Add("ORDER_TYPE", System.Data.OleDb.OleDbType.Variant, 2).Value = dc2.Rows[0].ItemArray[2];
                    commandSource.Parameters.Add("TD_NO", System.Data.OleDb.OleDbType.Variant, 30).Value = dc2.Rows[0].ItemArray[3];
                    commandSource.Parameters.Add("CONTAINER_COUNT", System.Data.OleDb.OleDbType.Variant, 30).Value = dc2.Rows[0].ItemArray[4];
                    commandSource.Parameters.Add("ORDER_DATE", System.Data.OleDb.OleDbType.Date).Value = dc2.Rows[0].ItemArray[5];
                    commandSource.Parameters.Add("SHIP_COMPANY", System.Data.OleDb.OleDbType.Variant, 30).Value = dc2.Rows[0].ItemArray[6];
                    commandSource.Parameters.Add("SHIP_NAME", System.Data.OleDb.OleDbType.Variant, 35).Value = dc2.Rows[0].ItemArray[7];
                    commandSource.Parameters.Add("SHIP_NUMBER", System.Data.OleDb.OleDbType.Variant, 30).Value = dc2.Rows[0].ItemArray[8];
                    commandSource.Parameters.Add("CONTAINER_SOURCE", System.Data.OleDb.OleDbType.Variant, 30).Value = dc2.Rows[0].ItemArray[9];
                    commandSource.Parameters.Add("GET_DEADLINE", System.Data.OleDb.OleDbType.Date).Value = dc2.Rows[0].ItemArray[10];
                    commandSource.Parameters.Add("NOTE", System.Data.OleDb.OleDbType.Variant, 100).Value = dc2.Rows[0].ItemArray[11];
                    oadapter.InsertCommand = commandSource;
                    nBbm = oadapter.InsertCommand.ExecuteNonQuery();//記錄是否有成功
                    //BBS
                    querySource = "INSERT INTO GETHER.GF_ORDDETAILS(SEQ_NO,SEQ,TD_NO,CONTAINER_TYPE,CONTAINER_NO,CTN_ETA,NOTE)VALUES(?,?,?,?,?,?,?)";
                    foreach (System.Data.DataRow r in dc2s.Rows)
                    {
                        commandSource = new System.Data.OleDb.OleDbCommand(querySource, connSource);
                        commandSource.Parameters.Add("SEQ_NO", System.Data.OleDb.OleDbType.Decimal).Value = seq_no;
                        commandSource.Parameters.Add("SEQ", System.Data.OleDb.OleDbType.Decimal).Value = r.ItemArray[3];
                        commandSource.Parameters.Add("TD_NO", System.Data.OleDb.OleDbType.Variant, 30).Value = r.ItemArray[4];
                        commandSource.Parameters.Add("CONTAINER_TYPE", System.Data.OleDb.OleDbType.Variant, 10).Value = r.ItemArray[5];
                        commandSource.Parameters.Add("CONTAINER_NO", System.Data.OleDb.OleDbType.Variant, 50).Value = r.ItemArray[6];
                        commandSource.Parameters.Add("CTN_ETA", System.Data.OleDb.OleDbType.Variant, 10).Value = r.ItemArray[10];
                        commandSource.Parameters.Add("NOTE", System.Data.OleDb.OleDbType.Variant, 100).Value = r.ItemArray[11];
                        oadapter.InsertCommand = commandSource;
                        nBbs.Add(oadapter.InsertCommand.ExecuteNonQuery());//記錄是否有成功
                    }
                    connSource.Close();
                }
                Response.Write("done:" + seq_no.ToString());
            }
            else if (item.action == "delete")
            {
                //SEQ_NO 若值不為0,表示有資料
                if ((System.Int32)dc2.Rows[0].ItemArray[1] <= 0)
                {
                    Response.Write("SEQ_NO無值! ");
                    return;
                }
                int nBbm = -2;
                //寫到正新
                using (System.Data.OleDb.OleDbConnection connSource = new System.Data.OleDb.OleDbConnection(CSTConnectionString))
                {
                    System.Data.OleDb.OleDbDataAdapter oadapter = new System.Data.OleDb.OleDbDataAdapter();
                    connSource.Open();
                    //BBM
                    string querySource = @"UPDATE GETHER.GF_ORDS SET IS_DEL = 1 WHERE SEQ_NO=?";
                    System.Data.OleDb.OleDbCommand commandSource = new System.Data.OleDb.OleDbCommand(querySource, connSource);
                    //需注意dc2 欄位順序
                    commandSource.Parameters.Add("SEQ_NO", System.Data.OleDb.OleDbType.Decimal).Value = (System.Int32)dc2.Rows[0].ItemArray[1];
                    oadapter.UpdateCommand = commandSource;
                    nBbm = oadapter.UpdateCommand.ExecuteNonQuery();//記錄是否有成功
                    connSource.Close();
                }
                //回寫ztmp_efimport
                System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(DC2ConnectionString);
                int n = 0;
                try
                {
                    conn.Open();
                    System.Data.SqlClient.SqlCommand cmd =
                            new System.Data.SqlClient.SqlCommand("update ztmp_efimport set is_del=1 where noa=@noa", conn);
                    cmd.Parameters.AddWithValue("@noa", item.noa);
                    cmd.ExecuteNonQuery();
                }
                catch (Exception e)
                {
                }
                finally
                {
                    conn.Close();
                }
                Response.Write("done");
            }
        }    
    </script>
