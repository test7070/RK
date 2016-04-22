<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
    	//出貨標籤
        //LC-14-00-04-02
        public class ParaIn
        {
            public string noa="", noq="";
        }
        
        public class Para
        {
            public string accy,noa,noq;
            public string productno,product,engpro,typea,spec,uno,pallet,makeno,pdate,custno,cust,ordeno,ordenoq;
            public float nweight,gweight,mount;
            public string unit,datea;
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
		,productno nvarchar(20)
		,product nvarchar(30)
		,engpro nvarchar(max)
		,typea nvarchar(30)
		,spec nvarchar(max)
		,uno nvarchar(30)
		,pallet nvarchar(20)
		,makeno nvarchar(30)
		,pdate nvarchar(20) --製造日期
		,custno nvarchar(20)
		,cust nvarchar(30)
		,ordeno nvarchar(20)
		,ordenoq nvarchar(10)
		,nweight float --淨重
		,gweight float --毛重
		,mount float
		,unit nvarchar(20)
		,datea nvarchar(20)
	)
	insert into @tmp(accy,noa,noq,productno,product,engpro,typea,spec,uno,pallet,makeno,pdate
		,custno,cust,ordeno,ordenoq,nweight,gweight,mount,unit,datea)
	select a.accy,a.noa,a.noq,a.productno,a.product,c.engpro,e.spec+'/'+f.size
		,CAST(a.dime as nvarchar)+'+'+cast(a.radius as nvarchar)+'*'+CAST(a.width as nvarchar)+'*'+CAST(a.lengthb as nvarchar)
		,a.uno,a.itemno,e.cname,e.datea
		,b.custno,b.nick,a.ordeno,a.no2,a.[weight],a.mweight,a.mount,a.unit,b.datea
	from view_vccs a
	left join view_vcc b on a.accy=b.accy and a.noa=b.noa
	left join ucc c on a.productno=c.noa
	left join view_ordes d on a.ordeno=d.noa and a.no2=d.no2
	outer apply(select top 1 * from view_cuts where uno=a.uno) e
	outer apply(select top 1 * from view_cubs where makeno=e.cname) f
	where a.noa=@t_noa
    and (len(@t_noq)=0 or a.noq=@t_noq)
	
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
                pa.accy = System.DBNull.Value.Equals(r.ItemArray[1]) ? "" : (System.String)r.ItemArray[1];
                pa.noa = System.DBNull.Value.Equals(r.ItemArray[2]) ? "" : (System.String)r.ItemArray[2];
                pa.noq = System.DBNull.Value.Equals(r.ItemArray[3]) ? "" : (System.String)r.ItemArray[3];

                pa.productno = System.DBNull.Value.Equals(r.ItemArray[4]) ? "" : (System.String)r.ItemArray[4];
                pa.product = System.DBNull.Value.Equals(r.ItemArray[5]) ? "" : (System.String)r.ItemArray[5];
                pa.engpro = System.DBNull.Value.Equals(r.ItemArray[6]) ? "" : (System.String)r.ItemArray[6];
                pa.typea = System.DBNull.Value.Equals(r.ItemArray[7]) ? "" : (System.String)r.ItemArray[7];
                pa.spec = System.DBNull.Value.Equals(r.ItemArray[8]) ? "" : (System.String)r.ItemArray[8];
                pa.uno = System.DBNull.Value.Equals(r.ItemArray[9]) ? "" : (System.String)r.ItemArray[9];
                pa.pallet = System.DBNull.Value.Equals(r.ItemArray[10]) ? "" : (System.String)r.ItemArray[10];
                pa.makeno = System.DBNull.Value.Equals(r.ItemArray[11]) ? "" : (System.String)r.ItemArray[11];
                pa.pdate = System.DBNull.Value.Equals(r.ItemArray[12]) ? "" : (System.String)r.ItemArray[12];
                pa.custno = System.DBNull.Value.Equals(r.ItemArray[13]) ? "" : (System.String)r.ItemArray[13];
                pa.cust = System.DBNull.Value.Equals(r.ItemArray[14]) ? "" : (System.String)r.ItemArray[14];
                pa.ordeno = System.DBNull.Value.Equals(r.ItemArray[15]) ? "" : (System.String)r.ItemArray[15];
                pa.ordenoq = System.DBNull.Value.Equals(r.ItemArray[16]) ? "" : (System.String)r.ItemArray[16];
                pa.nweight = System.DBNull.Value.Equals(r.ItemArray[17]) ? 0 : (float)(System.Double)r.ItemArray[17];
                pa.gweight = System.DBNull.Value.Equals(r.ItemArray[18]) ? 0 : (float)(System.Double)r.ItemArray[18];
                pa.mount = System.DBNull.Value.Equals(r.ItemArray[19]) ? 0 : (float)(System.Double)r.ItemArray[19];
                pa.unit = System.DBNull.Value.Equals(r.ItemArray[20]) ? "" : (System.String)r.ItemArray[20];
                pa.datea = System.DBNull.Value.Equals(r.ItemArray[21]) ? "" : (System.String)r.ItemArray[21];
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
                    //TEXT
                    cb.SetColorFill(iTextSharp.text.BaseColor.BLACK);
                    cb.BeginText();
                    cb.SetFontAndSize(bfChinese, 12);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).pdate, 31, doc1.PageSize.Height - 156, 270);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).makeno, 62, doc1.PageSize.Height - 156, 270);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).pallet, 92, doc1.PageSize.Height - 156, 270);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).uno, 121, doc1.PageSize.Height - 156, 270);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).spec, 152, doc1.PageSize.Height - 156, 270);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).typea, 180, doc1.PageSize.Height - 156, 270);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).engpro, 205, doc1.PageSize.Height - 156, 270);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).product, 218, doc1.PageSize.Height - 156, 270);

                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).datea, 62, doc1.PageSize.Height - 325, 270);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).mount.ToString() + " " + ((Para)vccLabel[i]).unit, 92, doc1.PageSize.Height - 325, 270);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).gweight.ToString() + " KG", 121, doc1.PageSize.Height - 325, 270);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).nweight.ToString() + " KG", 152, doc1.PageSize.Height - 325, 270);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).ordeno, 180, doc1.PageSize.Height - 325, 270);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).cust, 214, doc1.PageSize.Height - 325, 270);
                    
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
