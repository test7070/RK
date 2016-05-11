<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        //進貨標籤
        //LC-14-00-02-01
        public class ParaIn
        {
            public string stktype="", noa="", noq="";
        }
        
        public class Para
        {
            public string accy,noa,noq;
            public string type,productno,product,size,date,comp,uno,shelflife,unit;
            public float mount, hard;
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
            if (Request.QueryString["stktype"] != null && Request.QueryString["stktype"].Length > 0)
            {
                item.stktype = Request.QueryString["stktype"];
            }
            //參數
            /*System.Text.Encoding encoding = System.Text.Encoding.UTF8;
            Response.ContentEncoding = encoding;
            int formSize = Request.TotalBytes;
            byte[] formData = Request.BinaryRead(formSize);
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            var item = serializer.Deserialize<ParaIn>(encoding.GetString(formData));
			*/
            /*item = new ParaIn();
            item.noa = "B1050420001";
            item.noq = "";
            item.stktype = "A1@金屬底材,A4@皮膜,A5@保護膜,F6@物料,A7@成品,A8@溶劑";
            connectionString = "Data Source=59.125.143.171,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database=st6";    
            */
            
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
		,typea nvarchar(20)
		,productno nvarchar(20)
		,product nvarchar(50)
		,dime float
		,width float
		,lengthb float
		,specno nvarchar(20)
		,spec nvarchar(20)
		,size nvarchar(50)
		,mount float
		,unit nvarchar(20)
		,datea nvarchar(10)
		,tggno nvarchar(20)
		,tgg nvarchar(20)
		,hard float
		,uno nvarchar(30)
		,shelflife nvarchar(20)
	)
	
	insert into @tmp(accy,noa,noq,typea,productno,product,size,mount,unit,datea,tggno,tgg,hard,uno,shelflife
		,dime,width,lengthb,specno,spec)
	select a.accy,a.noa,a.noq,d.item,a.productno,a.product,a.size,a.mount,a.unit,b.datea,b.tggno,b.nick,a.hard,a.uno,a.errmemo
		,a.dime,a.width,a.lengthb,a.spec,e.product
	from view_rc2s a
	left join view_rc2 b on a.accy=b.accy and a.noa=b.noa
	left join ucc c on a.productno=c.noa
	left join dbo.fnSplit(@t_stktype) d on c.typea = d.n
	left join spec e on a.spec=e.noa
	where a.noa=@t_noa
	and (len(@t_noq)=0 or a.noa=@t_noq)
	order by a.noa,a.noq
	
	update @tmp set size= case when spec='mm' then CAST(dime as nvarchar)+'*'+CAST(width as nvarchar)+'mm' 
		else CAST(dime as nvarchar)+'*'+CAST(width as nvarchar)+case when lengthb>0 then '*'+CAST(lengthb as nvarchar) else '' end end
	where len(isnull(size,''))=0
	
	select accy,noa,noq,typea,productno,product,size,mount,unit,datea,tgg,hard,uno,shelflife
	 from @tmp order by sel;";
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                cmd.Parameters.AddWithValue("@t_noa", item.noa);
                cmd.Parameters.AddWithValue("@t_noq", item.noq);
                cmd.Parameters.AddWithValue("@t_stktype", item.stktype);
                adapter.SelectCommand = cmd;
                adapter.Fill(dt);
                connSource.Close();
            }
            ArrayList rc2Label = new ArrayList();
            foreach (System.Data.DataRow r in dt.Rows)
            {
                Para pa = new Para();
                pa.accy = System.DBNull.Value.Equals(r.ItemArray[0]) ? "" : (System.String)r.ItemArray[0];
                pa.noa = System.DBNull.Value.Equals(r.ItemArray[1]) ? "" : (System.String)r.ItemArray[1];
                pa.noq = System.DBNull.Value.Equals(r.ItemArray[2]) ? "" : (System.String)r.ItemArray[2];
                pa.type = System.DBNull.Value.Equals(r.ItemArray[3]) ? "" : (System.String)r.ItemArray[3];
                pa.productno = System.DBNull.Value.Equals(r.ItemArray[4]) ? "" : (System.String)r.ItemArray[4];
                pa.product = System.DBNull.Value.Equals(r.ItemArray[5]) ? "" : (System.String)r.ItemArray[5];
                pa.size = System.DBNull.Value.Equals(r.ItemArray[6]) ? "" : (System.String)r.ItemArray[6];
                pa.mount = System.DBNull.Value.Equals(r.ItemArray[7]) ? 0 : (float)(System.Double)r.ItemArray[7];
                pa.unit = System.DBNull.Value.Equals(r.ItemArray[8]) ? "" : (System.String)r.ItemArray[8];
                pa.date = System.DBNull.Value.Equals(r.ItemArray[9]) ? "" : (System.String)r.ItemArray[9];
                pa.comp = System.DBNull.Value.Equals(r.ItemArray[10]) ? "" : (System.String)r.ItemArray[10];
                pa.hard = System.DBNull.Value.Equals(r.ItemArray[11]) ? 0 : (float)(System.Double)r.ItemArray[11];
                pa.uno = System.DBNull.Value.Equals(r.ItemArray[12]) ? "" : (System.String)r.ItemArray[12];
                pa.shelflife = System.DBNull.Value.Equals(r.ItemArray[13]) ? "" : (System.String)r.ItemArray[13];

                rc2Label.Add(pa);
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
            if (rc2Label.Count == 0)
            {
                cb.SetColorFill(iTextSharp.text.BaseColor.RED);
                cb.BeginText();
                cb.SetFontAndSize(bfChinese, 30);
                cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, "無資料", 20, 20, 0);
                cb.EndText();
            }
            else
            {
                for (int i = 0; i < rc2Label.Count; i++)
                {
                    if (i != 0)
                    {
                        //Insert page
                        doc1.NewPage();
                    }
                    //TEXT
                    cb.SetColorFill(iTextSharp.text.BaseColor.BLACK);
                    cb.BeginText();
                    cb.SetFontAndSize(bfChinese, 16);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)rc2Label[i]).date, 71, doc1.PageSize.Height-150, 270);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)rc2Label[i]).mount.ToString() + " " + ((Para)rc2Label[i]).unit, 113, doc1.PageSize.Height - 150, 270);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)rc2Label[i]).size, 153, doc1.PageSize.Height - 150, 270);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)rc2Label[i]).productno + ((Para)rc2Label[i]).product, 189, doc1.PageSize.Height - 150, 270);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)rc2Label[i]).type, 227, doc1.PageSize.Height - 150, 270);

                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)rc2Label[i]).shelflife, 113, doc1.PageSize.Height - 344, 270);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)rc2Label[i]).uno, 153, doc1.PageSize.Height - 344, 270);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)rc2Label[i]).hard!=0?((Para)rc2Label[i]).hard.ToString():"", 189, doc1.PageSize.Height - 344, 270);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)rc2Label[i]).comp, 227, doc1.PageSize.Height - 344, 270);
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
