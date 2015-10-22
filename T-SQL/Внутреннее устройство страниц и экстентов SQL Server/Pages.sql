use [Pages_and_Extents_Architecture];
go
--Pages DEMO
if object_id ( N'dbo.page_demo', N'U' ) is not null
drop table dbo.page_demo;
go
create table dbo.page_demo ( id int primary key --4  �����
                           , a  char(10)        --10 ����
                           , b  varchar(50)
                           , c  bigint          --8 ����
                           , d  datetime        --8 ����
                           , e  varbinary(8)
                           );
go
insert into dbo.page_demo
select 1, 'aaa01', 'page_demo', 1111, '20150319', 0x123; 
go
insert into dbo.page_demo
select 2, null, 'sql server', 22222, '20150319 18:00', null;
go 
insert into dbo.page_demo
select 3, 'c3', 'Alexey', 3, '20150319 20:33', 0x99999;
go

select * from dbo.page_demo
  cross apply fn_PhysLocCracker(%%physloc%%);
go

update dbo.page_demo
set c = c + 1
where id = 1;
checkpoint;
----------------------------------------------
-- Header
----------------------------------------------
dbcc traceon(3604);
go
dbcc page([Pages_and_Extents_Architecture], 1, 78, 0) with tableresults;
go

/*
m_pageId = (1:78)                    m_headerVersion = 1                  m_type = 1
m_typeFlagBits = 0x4                 m_level = 0                          m_flagBits = 0x8000
m_objId (AllocUnitId.idObj) = 29     m_indexId (AllocUnitId.idInd) = 256  
Metadata: AllocUnitId = 72057594039828480                                 
Metadata: PartitionId = 72057594038779904                                 Metadata: IndexId = 1
Metadata: ObjectId = 2105058535      m_prevPage = (0:0)                   m_nextPage = (0:0)
pminlen = 34                         m_slotCnt = 3                        m_freeCnt = 7933
m_freeData = 253                     m_reservedCnt = 0                    m_lsn = (21:128:2)
m_xactReserved = 0                   m_xdesId = (0:0)                     m_ghostRecCnt = 0
m_tornBits = 0    
*/


--������������� ��������                
--m_pageId = (1:78)

--������ ��������� ��������, ��� SQL Server 7.0 � ���� ������ 1                             
--m_headerVersion = 1

--��� ��������                   
--m_type = 1 (Data page)

--��� ������� ������ � �������� ������ 4. ��� ��������� ������� 0, ����� PFS (��� ��� ����� ���� �������� 1, 
--����������� �� ghost-������).
--m_typeFlagBits = 0x4 

--������� �������� � B-������ (0 � �������� �������) , ��� ���� ��������, ����� ��������� �������� ������ 0.                                  
--m_level = 0 

--� ���� � ��������� �������, �������� ������� ����������� ����� (0�200) ��� torn-page (0�100),  
--  � ��� �� ����� ��������� ��������� ��� �������� ��������                         
--m_flagBits = 0x8000
select cast(  0x8000 as int ) & cast(  0x100 as int )
     , cast(  0x8000 as int ) & cast(  0x200 as int );
select page_verify_option_desc from sys.databases 
where database_id = db_id ();


--��������� ��� ����������� Allocation Unit ID. ������� ���������: (m_indexId << 48) | (m_objId << 16)
--m_objId (AllocUnitId.idObj) = 29     
--m_indexId (AllocUnitId.idInd) = 256 
select 256 * convert( bigint, power( 2., 48 ) ) | 29 * convert( bigint, power( 2., 16 ) );

select a.container_id as PartitionId
     , p.index_id as IndexId
     , p.object_id as ObjectId
  from sys.system_internals_allocation_units a
    inner join sys.partitions p
      on a.container_id = p.partition_id
  where a.allocation_unit_id = 72057594039828480;
/* 
Metadata: AllocUnitId = 72057594039828480                                 
Metadata: PartitionId = 72057594038779904                                 
Metadata: IndexId = 1
Metadata: ObjectId = 2105058535 
*/


--��������� �� ����������/��������� �������� �-������     
--m_prevPage = (0:0)                   
--m_nextPage = (0:0)

--��������� �� NULL bitmap ( 4 ����� ��������� ������ + ����� ������ ���� ������� ������������� ������ )
--pminlen = 34

--���������� ������� �� ��������                        
--m_slotCnt = 3

--���������� ���������� ������������ �� �������� � ������                        
--m_freeCnt = 7933
select 8060 - ( 54 + 51 + 52 ) + ( 36 - 2 * 3 ) 

--�������� �� ������ �������� �� ������� ���������� �����             
--m_freeData = 253 
select 96 + ( 54 + 51 + 52 ) 

--���������� ���������� ������������ � ������, ����������������� ��� ���������� (��� ����������� ������ ����������)                                     
--m_reservedCnt = 0

--LSN(Log Sequence Number) ������ � ������� ����������, ������� �������� ��������                    
--m_lsn = (19:368:21)

--��������� ��������, ������� ���� ��������� � ���� m_reservedCnt                  
--m_xactReserved = 0  

--���������� ������������� ��������� ����������, ������� �������� ���� m_reservedCnt                                     
--m_xdesId = (0:0) 

--���������� ghost-������� �� ��������                    
--m_ghostRecCnt = 0

--���� ����������� �����, ���� �� 2 ��������� ���� �� �������� 1-15 (��������� ���������� � 0-�� �������) 
--+  2 ���� �������� ������ �������� (��������� ��� torn-page)
--m_tornBits = -47058617               

----------------------------------------------------------------------------------------------



----------------------------------------------
-- Records
----------------------------------------------

dbcc page([Pages_and_Extents_Architecture], 1, 78, 1) with tableresults;
go
--Slot 0
/*
0000000000000000:   30002200 01000000 61616130 31202020 �0.".....aaa01    
0000000000000010:   20205804 00000000 00000000 000060a4 �  ............`� 
0000000000000020:   00000600 00020034 00360070 6167655f �.......4.6.page_ 
0000000000000030:   64656d6f 0123������������������������demo.# 
*/ 

--��������� ������ ( 4 ����� )
--30 00 - ��������� ������, ���������� (TagA + TagB)
--00110000(TagA) 00000000(TagB) 

--TagA (���� 0)
--���������� � ��� 1
--��� 1 - 3 - ���:
/*
            0 = primary record. A data record in a heap that hasn't been forwarded or a data record at the leaf level of a clustered index. 
            1 = forwarded record 
            2 = forwarding record 
            3 = index record 
            4 = blob fragment 
            5 = ghost index record 
            6 = ghost data record 
            7 = ghost version record
*/
--��� 4 (0?10) - ������ ����� NULL bitmap (������� �����)
--��� 5 (0?20) - ������ ����� ������� ���������� ������  
--��� 6 (0�40) - ������� versioning tag (��������� ��� �����������)
--��� 7 (0�80) - ���������, ��� ���� �1 (TagB) �������� ��������

--TagB (���� 1)
--���� 0�00 ���� 0�01 - ��������� �� ghost forwarded record (��������� ������������ ������)

--22 00 - ��������� �� NULL bitmap ( 4 ����� ��������� + ����� ������ ���� ������� ������������� ������ )
select cast( 0x22 as int ); 
select name, type_name( user_type_id ) t, max_length
  from sys.columns
  where object_id = object_id ( N'dbo.page_demo', N'U' )
    and type_name( user_type_id ) in ( 'int', 'char', 'bigint', 'datetime' );

select sum( max_length ) l
  from sys.columns
  where object_id = object_id ( N'dbo.page_demo', N'U' )
    and type_name( user_type_id ) in ( 'int', 'char', 'bigint', 'datetime' );

--int - 4 �����
--01 00 00 00
--char(10) - 10 ����
--61 61 61 30 31 20 20 20 20 20
select cast ( 0x61616130312020202020 as varchar(50) );
select cast( 0x20 as int ), ascii( ' ' ); 
--bigint - 8 ����
--58 04 00 00 00 00 00 00
select cast( 0x0458 as int )
--datetime - 8 ���� 
/*
�������� ���� datetime �������� ������ ���������� SQL Server � ���� 4-�������� ����� �����. 
������ ������ ����� �������� ���������� ���� �� ��� ����� ���� �������: 1 ������ 1900 ����. 
������ ������ ����� �������� ������� �������� �������, ��������������� � ���� ��������� ����� �������, ��������� ����� ��������.
*/
--00 00 00 00 60 a4 00 00
select cast( 0x0000a460 as int )
	   , dateadd( d, 42080, '19000101' );

--NULL bitmap
--06 00 - ���-�� �������� 
--00 --> 000000


--02 00 - ���-�� �������� ���������� ������

--��������� �� ������ ���������� ������
--34 00
select cast( 0x0034 as int ); --52
select 4 + 30 + 2 + 1 + 2 + 4 + 9;
select datalength(b), datalength(e), * from dbo.page_demo;
--36 00 
select cast( 0x0036 as int ); --54
select 4 + 30 + 2 + 1 + 2 + 4 + 9 + 2;

--������� ���������� ������
--70 61 67 65 5f 64 65 6d 6f - 9 ����
select cast( 0x706167655f64656d6f as varchar(50) );
--01 23 - 2 �����


--Slot 1
/*
0000000000000000:   30002200 02000000 05002f84 00000000 �0.".......??.... 
0000000000000010:   0000ce56 00000000 000080a1 280160a4 �..?V......??(.`� 
0000000000000020:   00000600 22010033 0073716c 20736572 �...."..3.sql ser 
0000000000000030:   766572�������������������������������ver  
*/

--30002200 02000000 61616130 31202020 2020ce56 00000000 000080a1 280160a4 00000600 22010033 0073716c 20736572 766572

--��������� ������ ( 4 ����� )
--30 00 - ���  
--22 00 - ��������� �� NULL bitmap ( 4 ����� ��������� + ����� ������ ���� ������� ������������� ������ )

--int - 4 �����
--02 00 00 00
--char(10) - 10 ����
--05 00 2f 84 00 00 00 00 00 00
select cast ( 0x05002f84000000000000 as varchar(50) );
--bigint - 8 ����
--ce 56 00 00 00 00 00 00
select cast ( 0x56ce as int );
--datetime - 8 ����
--80 a1 28 01 60 a4 00 00 
select cast( 0x0000a460 as int )
	  , dateadd( d, 42080, '19000101' );
select cast( 0x0128a180 as int )
	  , dateadd( ms, 19440000*3.33333333333, '19000101' );

--NULL bitmap
--06 00 - ���-�� �������� 
--22 --> 100010

--01 00 - ���-�� �������� ���������� ������
--��������� �� ������ ���������� ������
select datalength(b), datalength(e), * from dbo.page_demo;
--00 33 
select cast( 0x33 as int );
select 4 + 30 + 2 + 1 + 2 + 2 + 10;

--0073716c 20736572 766572
select cast ( 0x73716c20736572766572 as varchar(50) );

--Slot 2
/*
0000000000000000:   30002200 03000000 63332020 20202020 �0.".....c3      
0000000000000010:   20200300 00000000 000050a7 520160a4 �  ........P�R.`�
0000000000000020:   00000600 00020031 00340041 6c657865 �.......1.4.Alexe
0000000000000030:   79099999 ����������������������������y	..
*/  

--��������� ������ ( 4 ����� )
--30 00 - ���  
--22 00 - ��������� �� NULL bitmap ( 4 ����� ��������� + ����� ������ ���� ������� ������������� ������ )

--int - 4 �����
--03 00 00 00
--char(10) - 10 ����
--63 33 20 20 20 20 20 20 20 20
select cast ( 0x63332020202020202020 as varchar(50) );
--bigint - 8 ����
--03 00 00 00 00 00 00 00
select cast ( 0x56ce as int );
--datetime - 8 ����
--50 a7 52 01 60 a4 00 00
select cast( 0x0000a460 as int )
	   , dateadd( d, 42080, '19000101' );
select cast( 0x0152a750 as int )
	   , dateadd( ms, 22194000**3.33333333333, '19000101' );

--NULL bitmap
--06 00 - ���-�� �������� 
--10 --> 010000

--02 00 - ���-�� �������� ���������� ������
--��������� �� ������ ���������� ������
select datalength(b), datalength(e), * from dbo.page_demo;
--0031
select cast( 0x0031 as int );
select 4 + 30 + 2 + 1 + 2 + 4 + 6;
--0034
select cast( 0x0034 as int );
select 4 + 30 + 2 + 1 + 2 + 4 + 6 + 3;


--41 6c 65 78 65 79
select cast ( 0x416c65786579 as varchar(50) );
--09 99 99


----------------------------------------------------------------------------------------------


----------------------------------------------
-- Row Offset 
----------------------------------------------

dbcc page([Pages_and_Extents_Architecture], 1, 78, 1) with tableresults;
go
/*
2 (0x2) - 201 (0xc9) 
1 (0x1) - 150 (0x96) 
0 (0x0) - 96 (0x60) 
*/
delete from dbo.page_demo
where id = 2;

select * from dbo.page_demo;

insert into dbo.page_demo
select 4, 'c4', 'Alexey', 4, null, 0x99999;
go

dbcc page([Pages_and_Extents_Architecture], 1, 78, 0) with tableresults;
go

alter table dbo.page_demo rebuild;

select * from dbo.page_demo
  cross apply fn_PhysLocCracker(%%physloc%%);
go