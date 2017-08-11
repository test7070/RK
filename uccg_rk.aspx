<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        public class ParaIn
        {
            public string date;
        }
        
        System.IO.MemoryStream stream = new System.IO.MemoryStream();
        string connectionString = "";
        public void Page_Load()
        {
        	string db = "st";
        	if(Request.QueryString["db"] !=null && Request.QueryString["db"].Length>0)
        		db= Request.QueryString["db"];
        	connectionString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database="+db;
           // connectionString = "Data Source=125.227.231.15,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database=st";

			var item = new ParaIn();
            if (Request.QueryString["date"] != null && Request.QueryString["date"].Length > 0)
            {
                item.date = Request.QueryString["date"];
            }
            
            //資料
            System.Data.DataTable dt = new System.Data.DataTable();
            using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(connectionString))
            {
                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                connSource.Open();
                string queryString = @"--declare @t_edate nvarchar(20) = [1]
	-------------------------------------------------------------------------------------------
	--鋼捲&皮膜、保護膜
	-------------------------------------------------------------------------------------------
	--rc2
	declare @tmpa table(
		sel int identity(1,1)
		,datea nvarchar(20)
		,accy nvarchar(10)
		,noa nvarchar(20)
		,noq nvarchar(10)
		,uno nvarchar(30)
		,[weight] float
		,[money] float
	)
	insert into @tmpa(datea,accy,noa,noq,uno,[weight],[money])
	select b.datea,a.accy,a.noa,a.noq,a.uno
		,case when b.typea='1' then 1 else -1 end * a.[weight]
		,case when b.typea='1' then 1 else -1 end * a.[total]
	from view_rc2s a
	left join view_rc2 b on a.accy=b.accy and a.noa=b.noa
	where ISNULL(b.datea,'')<=@t_edate
	and len(ISNULL(a.uno,''))>0
	
	--cub
	------生產作業會產生領料單扣鋼捲及物料的庫存
	------皮膜保護膜則是在CUBT扣
	declare @tmpb table(
		sel int identity(1,1)
		,datea nvarchar(20)
		,tablea nvarchar(20)
		,accy nvarchar(10)
		,noa nvarchar(20)
		,noq nvarchar(10)
		,uno nvarchar(30)
		,[weight] float
		,[money] float
	)
	insert into @tmpb(datea,tablea,accy,noa,noq,uno,[weight],[money])
	select a.datea,'gets',b.accy,b.noa,b.noq,b.uno
		,case when ISNULL(b.gweight,0)!=0 then b.gweight else isnull(b.[weight],0) end
		,dbo.scost_rk('get',b.accy,b.noa,b.noq)
	from view_cub a
	left join view_gets b on a.accy=b.accy and a.noa=b.noa
	where b.noa is not null
	and ISNULL(a.datea,'')<=@t_edate
	and len(ISNULL(b.uno,''))>0
	
	insert into @tmpb(datea,tablea,accy,noa,noq,uno,[weight],[money])
	select b.datea,'cubt',a.accy,a.noa,a.noq,a.uno,a.[weight]
		,dbo.scost_rk('cubt',a.accy,a.noa,a.noq)
	from view_cubt a
	left join view_cub b on a.accy=b.accy and a.noa=b.noa
	where ISNULL(b.datea,'')<=@t_edate
	and len(ISNULL(a.uno,''))>0
	
	--get
	------生產作業轉來的忽略
	declare @tmpc table(
		sel int identity(1,1)
		,datea nvarchar(20)
		,tablea nvarchar(20)
		,accy nvarchar(10)
		,noa nvarchar(20)
		,noq nvarchar(10)
		,uno nvarchar(30)
		,[weight] float
		,[money] float
	)
	insert into @tmpc(datea,tablea,accy,noa,noq,uno,[weight],[money])
	select b.datea,'get',a.accy,a.noa,a.noq,a.uno
		,case when ISNULL(a.gweight,0)!=0 then a.gweight else isnull(a.[weight],0) end
		--,dbo.scost_rk('get',a.accy,a.noa,a.noq)
		,0
	from view_gets a
	left join view_get b on a.accy=b.accy and a.noa=b.noa
	left join view_cub c on a.accy=c.accy and a.noa=c.noa
	where c.noa is null
	and ISNULL(b.datea,'')<=@t_edate
	and len(ISNULL(a.uno,''))>0
	
	update @tmpc set [money] = dbo.scost_rk(tablea,accy,noa,noq)
	
	--ina
	------除了買賣，其餘的忽略
	declare @tmpd table(
		sel int identity(1,1)
		,datea nvarchar(20)
		,accy nvarchar(10)
		,noa nvarchar(20)
		,noq nvarchar(10)
		,uno nvarchar(30)
		,[weight] float
		,[money] float
	)
	insert into @tmpd(datea,accy,noa,noq,uno,[weight],[money])
	select b.datea,a.accy,a.noa,a.noq,a.uno,a.[weight]
		,dbo.smoney_rk(a.uno)
	from view_inas a
	left join view_ina b on a.accy=b.accy and a.noa=b.noa
	where ISNULL(b.datea,'')<=@t_edate
	--and ISNULL(b.itype,'') = '1'
	and len(ISNULL(a.uno,''))>0
	
	--cuts 成品進倉
	declare @tmpe table(
		sel int identity(1,1)
		,datea nvarchar(20)
		,accy nvarchar(10)
		,noa nvarchar(20)
		,noq nvarchar(10)
		,uno nvarchar(30)
		,[weight] float
		,[money] float
	)
	insert into @tmpe(datea,accy,noa,noq,uno,[weight],[money])
	select a.datea,a.accy,a.noa,a.noq,a.bno,a.[weight]
	,dbo.smoney_rk(a.bno) 
	from view_cuts a
	where ISNULL(a.datea,'')<=@t_edate
	and len(ISNULL(a.bno,''))>0

	--vcc
	------除了買賣，其餘的忽略
	declare @tmpf table(
		sel int identity(1,1)
		,datea nvarchar(20)
		,accy nvarchar(10)
		,noa nvarchar(20)
		,noq nvarchar(10)
		,uno nvarchar(30)
		,[weight] float
		,[money] float
	)
	insert into @tmpf(datea,accy,noa,noq,uno,[weight],[money])
	select b.datea,a.accy,a.noa,a.noq,a.uno
		,case when b.typea='1' then 1 else -1 end * case when ISNULL(a.gweight,0)!=0 then a.gweight else isnull(a.[weight],0) end
		,case when b.typea='1' then 1 else -1 end * a.[total]
	from view_vccs a
	left join view_vcc b on a.accy=b.accy and a.noa=b.noa
	where ISNULL(b.datea,'')<=@t_edate
	--and ISNULL(b.stype,'') = '1'
	and len(ISNULL(a.uno,''))>0
	------------------------------------------------------------------------
	delete z_uccg_rk
	insert into z_uccg_rk(id,datea,tablea,accy,noa,noq,uno,[weight],[money])
	select 'a',datea,'',accy,noa,noq,uno,[weight],[money] from @tmpa
	union all
	select 'b',datea,tablea,accy,noa,noq,uno,[weight],[money] from @tmpb
	union all
	select 'c',datea,tablea,accy,noa,noq,uno,[weight],[money] from @tmpc
	union all
	select 'd',datea,'',accy,noa,noq,uno,[weight],[money] from @tmpd
	union all
	select 'e',datea,'',accy,noa,noq,uno,[weight],[money] from @tmpe
	union all
	select 'f',datea,'',accy,noa,noq,uno,[weight],[money] from @tmpf
	;";
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                cmd.CommandTimeout = 0;
                cmd.Parameters.AddWithValue("@t_edate", item.date);
                adapter.SelectCommand = cmd;
                cmd.ExecuteNonQuery(); 
                connSource.Close();
            }
            Response.Write("done");
        }
    </script>