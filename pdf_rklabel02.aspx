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
		,a.uno,a.itemno,e.cname
		,convert(nvarchar,dbo.ChineseEraName2AD(e.datea),111)
		,b.custno,b.nick,a.ordeno,a.no2,a.[weight],a.mweight,a.mount,a.unit
		,convert(nvarchar,dbo.ChineseEraName2AD(b.datea),111)
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
            // H*W  15 * 10 
            var doc1 = new iTextSharp.text.Document(new iTextSharp.text.Rectangle(422, 283), 0, 0, 0, 0);
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
                    //LINE
                    cb.MoveTo(10, 10);
                    cb.LineTo(412, 10);
                    cb.LineTo(412, 273);
                    cb.LineTo(10, 273);
                    cb.LineTo(10, 10);

                    cb.MoveTo(10, 233);
                    cb.LineTo(412, 233);
                    cb.MoveTo(10, 193);
                    cb.LineTo(412, 193);
                    cb.MoveTo(10, 163);
                    cb.LineTo(412, 163);
                    cb.MoveTo(10, 133);
                    cb.LineTo(412, 133);
                    cb.MoveTo(10, 103);
                    cb.LineTo(412, 103);
                    cb.MoveTo(10, 73);
                    cb.LineTo(412, 73);
                    cb.MoveTo(10, 43);
                    cb.LineTo(412, 43);

                    cb.MoveTo(80, 10);
                    cb.LineTo(80, 233);
                    cb.MoveTo(240, 10);
                    cb.LineTo(240, 233);
                    cb.MoveTo(300, 43);
                    cb.LineTo(300, 233);
                    cb.Stroke();
                    //TEXT
                    cb.SetColorFill(iTextSharp.text.BaseColor.BLACK);
                    cb.BeginText();
                    cb.SetFontAndSize(bfChinese, 12);

                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, "品名", 47, 215, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, "型號", 47, 180, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, "規格", 47, 150, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, "鋼捲編號", 47, 120, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, "棧板編號", 47, 90, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, "製單編號", 47, 60, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, "製造日期", 47, 30, 0);

                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, "客戶", 270, 213, 0);
                    cb.SetFontAndSize(bfChinese, 8);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, "訂單/產品No.", 270, 180, 0);
                    cb.SetFontAndSize(bfChinese, 13);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, "浮重N.W.", 270, 145, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, "毛重G.W.", 270, 115, 0);
                    cb.SetFontAndSize(bfChinese, 12);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, "數量", 270, 90, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, "出貨日期", 270, 60, 0);
                    
                    cb.SetFontAndSize(bfChinese, 8);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, "Description", 47, 200, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, "Type", 47, 168, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, "Specification", 47, 138, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, "Coil serial No.", 47, 108, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, "Pallet No.", 47, 78, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, "Producing No.", 47, 48, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, "Producing Date", 47, 18, 0);

                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, "Customer", 270, 200, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, "Order/Part No.", 270, 168, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, "Q'ty", 270, 78, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, "Shipping Date", 270, 48, 0);

                    cb.SetFontAndSize(bfChinese, 10);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_RIGHT, "表單編號：LC-14-00-04-02", 407, 18, 0);

                    cb.SetFontAndSize(iTextSharp.text.FontFactory.GetFont(iTextSharp.text.FontFactory.HELVETICA_BOLDOBLIQUE).BaseFont, 25);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, "LCM", 25, 243, 0);
                    cb.SetFontAndSize(bfChinese, 20);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, "聯琦金屬股份有限公司", 105, 243, 0);

                    cb.SetFontAndSize(bfChinese, 12);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).product, 155, 215, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).engpro, 155, 200, 0);

                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).typea, 155, 175, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).spec, 155, 145, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).uno, 155, 115, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).pallet, 155, 85, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).makeno, 155, 55, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).pdate, 155, 25, 0);

                    cb.SetFontAndSize(bfChinese, 14);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).cust, 360, 208, 0);
                    cb.SetFontAndSize(bfChinese, 12);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).ordeno, 360, 175, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).nweight.ToString() + " KG", 360, 145, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).gweight.ToString() + " KG", 360, 115, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).mount.ToString() + " " + ((Para)vccLabel[i]).unit, 360, 85, 0);
                    cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_CENTER, ((Para)vccLabel[i]).datea, 360, 55, 0);
                    
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
