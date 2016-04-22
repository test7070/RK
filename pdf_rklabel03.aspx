<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        //LC-14-00-04-02
        public class ParaIn
        {
            public string noa="", noq="";
        }
        
        public class Para
        {
            public int sel;
            public string accy,noa,noq;
            public string pallet;
        }
        
        System.IO.MemoryStream stream = new System.IO.MemoryStream();
        string connectionString = "";
        public void Page_Load()
        {
        	string db = "st";
        	if(Request.QueryString["db"] !=null && Request.QueryString["db"].Length>0)
        		db= Request.QueryString["db"];
        	connectionString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database="+db;
			
			var item = new ParaIn();
			if (Request.QueryString["noa"] != null && Request.QueryString["noa"].Length > 0)
            {
                item.noa = Request.QueryString["noa"];
            }
            if (Request.QueryString["noq"] != null && Request.QueryString["noq"].Length > 0)
            {
                item.noq = Request.QueryString["noq"];
            }
            //資料
            System.Data.DataTable dt = new System.Data.DataTable();
            using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(connectionString))
            {
                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                connSource.Open();
                string queryString = @"declare @tmp table(
		sel int identity(1,1)
		,accy nvarchar(10)
		,noa nvarchar(20)
		,noq nvarchar(10)
		,pallet nvarchar(20)
		
	)
	insert into @tmp(accy,noa,noq,pallet)
	select a.accy,a.noa,a.noq,a.itemno
	from view_vccs a
	where a.noa=@t_noa
	order by a.accy,a.noa,a.noq
	
	if len(@t_noq)>0
	begin
		delete @tmp where noq!=@t_noq
	end
	select * from @tmp";
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                cmd.Parameters.AddWithValue("@t_noa", item.noa);
                cmd.Parameters.AddWithValue("@t_noq", item.noq);
                adapter.SelectCommand = cmd;
                adapter.Fill(dt);
                connSource.Close();
            }
            ArrayList vccLabel = new ArrayList();
            foreach (System.Data.DataRow r in dt.Rows)
            {
                Para pa = new Para();
                pa.sel = System.DBNull.Value.Equals(r.ItemArray[0]) ? 0 : (System.Int32)r.ItemArray[0];
                pa.accy = System.DBNull.Value.Equals(r.ItemArray[1]) ? "" : (System.String)r.ItemArray[1];
                pa.noa = System.DBNull.Value.Equals(r.ItemArray[2]) ? "" : (System.String)r.ItemArray[2];
                pa.noq = System.DBNull.Value.Equals(r.ItemArray[3]) ? "" : (System.String)r.ItemArray[3];
                pa.pallet = System.DBNull.Value.Equals(r.ItemArray[4]) ? "" : (System.String)r.ItemArray[4];

                vccLabel.Add(pa);
            }
            //-----PDF--------------------------------------------------------------------------------------------------
           // 10 * 15 
            var doc1 = new iTextSharp.text.Document(new iTextSharp.text.Rectangle(283, 422), 0, 0, 0, 0);
            iTextSharp.text.pdf.PdfWriter pdfWriter = iTextSharp.text.pdf.PdfWriter.GetInstance(doc1, stream);
            //font
            iTextSharp.text.pdf.BaseFont bfChinese = iTextSharp.text.pdf.BaseFont.CreateFont(@"C:\windows\fonts\msjh.ttf", iTextSharp.text.pdf.BaseFont.IDENTITY_H, iTextSharp.text.pdf.BaseFont.NOT_EMBEDDED);
            iTextSharp.text.pdf.BaseFont bfNumber = iTextSharp.text.pdf.BaseFont.CreateFont(@"C:\windows\fonts\ariblk.ttf", iTextSharp.text.pdf.BaseFont.IDENTITY_H, iTextSharp.text.pdf.BaseFont.NOT_EMBEDDED);
            
            doc1.Open();
            iTextSharp.text.pdf.PdfContentByte cb = pdfWriter.DirectContent;
            if (vccLabel.Count == 0)
            {
                cb.SetColorFill(iTextSharp.text.BaseColor.RED);
                cb.BeginText();
                cb.SetFontAndSize(bfChinese, 30);
                cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, "無資料", 20, 20, 0);
                cb.EndText();
            }
            else
            {
                for (int i = 0; i < vccLabel.Count; i++)
                {
                    if (i != 0)
                    {
                        //Insert page
                        doc1.NewPage();
                    }
                    //Line
                    cb.SetColorStroke(iTextSharp.text.BaseColor.BLACK);
                    cb.SetLineWidth(1);
                    
                    //211,325
                    //161,215
                    //261,215
                    //211.105
                    //橫線
                    cb.MoveTo(211, 325);
                    cb.LineTo(161, 215);
                    cb.LineTo(211, 105);
                    cb.LineTo(267, 215);
                    cb.LineTo(211, 325);
                    cb.Stroke();
                    //TEXT
                    cb.SetColorFill(iTextSharp.text.BaseColor.BLACK);
                    cb.BeginText();
                    cb.SetFontAndSize(bfChinese,24);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, "SHLC", 211-8, 215, 270);
                    cb.SetFontAndSize(bfChinese, 16);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, "C/NO：", 100, 311, 270);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).sel.ToString(),100, 212, 270);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, "MADE IN TAIWAN", 60, 311, 270);
                    cb.SetFontAndSize(bfChinese, 10);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).pallet, 30, 100, 270);
                   
                    cb.EndText();
                }
            }
            doc1.Close();
            Response.ContentType = "application/octec-stream;";
            Response.AddHeader("Content-transfer-encoding", "binary");
            Response.AddHeader("Content-Disposition", "attachment;filename=label" + item.noa + ".pdf");
            Response.BinaryWrite(stream.ToArray());
            Response.End();
        }
    </script>
