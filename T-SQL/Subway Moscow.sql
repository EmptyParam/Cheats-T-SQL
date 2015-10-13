
/*
<description>
   Subway Moscow 06.04.2015
   ������� ����������� �������������
   ������ ��������� �� 06.04.2015
</description>
*/
------------------------------------------------
-- v1.0: Created by �ova Igor 06.04.2015
------------------------------------------------
declare
   @idoc        int
  ,@LineXML     xml
  ,@StationXML  xml

set @LineXML =
 '<?xml version="1.0" encoding="windows-1251"?>
  <Root>
    <row ID="1" Name="��������������" ColorRGB="ED1B35" ColorName="�������"/>
    <row ID="2" Name="��������������" ColorRGB="44B85C" ColorName="������"/>
    <row ID="3" Name="��������-����������" ColorRGB="0078BF" ColorName="�����"/>
    <row ID="4" Name="��������" ColorRGB="19C1F3" ColorName="�������"/>
    <row ID="5" Name="���������" ColorRGB="894E35" ColorName="����������"/>
    <row ID="6" Name="��������-�������" ColorRGB="F58631" ColorName="���������"/>
    <row ID="7" Name="��������-�����������������" ColorRGB="8E479C" ColorName="����������"/>
    <row ID="8" Name="����������-�����������" ColorRGB="FFCB31" ColorName="Ƹ����"/>
    <row ID="9" Name="�����������-�������������" ColorRGB="A1A2A3" ColorName="�����"/>
    <row ID="10" Name="���������-�����������" ColorRGB="B3D445" ColorName="���������"/>
    <row ID="11" Name="���������" ColorRGB="79CDCD" ColorName="���������"/>
    <row ID="12" Name="���������" ColorRGB="ACBFE1" ColorName="����-�������"/>
  </Root>'

set @StationXML =
  '<?xml version="1.0" encoding="windows-1251"?>
  <Root>
    <row LineID="8"  Name="������������"/>
    <row LineID="2"  Name="�������������"/>
    <row LineID="6"  Name="�������������"/>
    <row LineID="4"  Name="��������������� ���"/>
    <row LineID="6"  Name="������������"/>
    <row LineID="2"  Name="����-��������"/>
    <row LineID="9"  Name="���������"/>
    <row LineID="9"  Name="������"/>
    <row LineID="3"  Name="���������"/>
    <row LineID="4"  Name="���������"/>
    <row LineID="2"  Name="��������"/>
    <row LineID="6"  Name="������������"/>
    <row LineID="4"  Name="���������������"/>
    <row LineID="7"  Name="�����������"/>
    <row LineID="3"  Name="����������"/>
    <row LineID="7"  Name="�������"/>
    <row LineID="2"  Name="�����������"/>
    <row LineID="5"  Name="�����������"/>
    <row LineID="6"  Name="�������"/>
    <row LineID="9"  Name="��������"/>
    <row LineID="1"  Name="���������� ��. ������"/>
    <row LineID="12" Name="���������� ����"/>
    <row LineID="12" Name="������������"/>
    <row LineID="10" Name="��������"/>
    <row LineID="9"  Name="����������"/>
    <row LineID="6"  Name="������������ ���"/>
    <row LineID="10" Name="�������������"/>
    <row LineID="12" Name="������� �������� �������"/>
    <row LineID="9"  Name="������� ������� ��������"/>
    <row LineID="1"  Name="������� �������������"/>
    <row LineID="12" Name="��������� �����"/>
    <row LineID="11" Name="����������"/>
    <row LineID="6"  Name="����"/>
    <row LineID="9"  Name="���������"/>
    <row LineID="2"  Name="������ �������"/>
    <row LineID="2"  Name="����������"/>
    <row LineID="7"  Name="������������� ��������"/>
    <row LineID="10" Name="��������"/>
    <row LineID="3"  Name="�������������"/>
    <row LineID="1"  Name="��������� ����"/>
    <row LineID="4"  Name="�����������"/>
    <row LineID="7"  Name="������"/>
    <row LineID="7"  Name="������������� ��������"/>
    <row LineID="8"  Name="������� �����"/>
    <row LineID="2"  Name="������"/>
    <row LineID="9"  Name="�����������"/>
    <row LineID="5"  Name="������������"/>
    <row LineID="2"  Name="�������������"/>
    <row LineID="10" Name="�����������"/>
    <row LineID="10" Name="��������"/>
    <row LineID="10" Name="���������"/>
    <row LineID="3"  Name="������������"/>
    <row LineID="6"  Name="���������"/>
    <row LineID="2"  Name="��������������"/>
    <row LineID="11" Name="���������"/>
    <row LineID="2"  Name="���������"/>
    <row LineID="11" Name="���������"/>
    <row LineID="3"  Name="��������"/>
    <row LineID="4"  Name="��������"/>
    <row LineID="5"  Name="��������"/>
    <row LineID="6"  Name="�����-�����"/>
    <row LineID="7"  Name="�����-�����"/>
    <row LineID="10" Name="�����������"/>
    <row LineID="2"  Name="�����������"/>
    <row LineID="1"  Name="�������������"/>
    <row LineID="5"  Name="�������������"/>
    <row LineID="6"  Name="��������"/>
    <row LineID="2"  Name="�����������������"/>
    <row LineID="5"  Name="�����������������"/>
    <row LineID="1"  Name="��������������"/>
    <row LineID="1"  Name="������� ������"/>
    <row LineID="10" Name="������������ �������"/>
    <row LineID="1"  Name="�������������"/>
    <row LineID="3"  Name="����������"/>
    <row LineID="7"  Name="��������� ����"/>
    <row LineID="7"  Name="���������"/>
    <row LineID="3"  Name="����������"/>
    <row LineID="4"  Name="����������"/>
    <row LineID="3"  Name="�������"/>
    <row LineID="5"  Name="�������"/>
    <row LineID="4"  Name="�����������"/>
    <row LineID="6"  Name="��������� ��������"/>
    <row LineID="1"  Name="�������"/>
    <row LineID="10" Name="�������"/>
    <row LineID="8"  Name="������������"/>
    <row LineID="10" Name="������� ����"/>
    <row LineID="10" Name="�������"/>
    <row LineID="1"  Name="����������"/>
    <row LineID="6"  Name="����������"/>
    <row LineID="4"  Name="�������������"/>
    <row LineID="19" Name="�������������"/>
    <row LineID="3"  Name="������"/>
    <row LineID="3"  Name="����������"/>
    <row LineID="3"  Name="��������"/>
    <row LineID="9"  Name="�����������"/>
    <row LineID="9"  Name="��������"/>
    <row LineID="9"  Name="����������� ��������"/>
    <row LineID="8"  Name="�����������"/>
    <row LineID="8"  Name="����������"/>
    <row LineID="2"  Name="�������������"/>
    <row LineID="1"  Name="���������������"/>
    <row LineID="5"  Name="��������������"/>
    <row LineID="6"  Name="��������������"/>
    <row LineID="6"  Name="����� ��������"/>
    <row LineID="5"  Name="�����������"/>
    <row LineID="6"  Name="�����������"/>
    <row LineID="7"  Name="����������� ����"/>
    <row LineID="1"  Name="����������� �������"/>
    <row LineID="2"  Name="�������"/>
    <row LineID="9"  Name="��������"/>
    <row LineID="1"  Name="������� ���"/>
    <row LineID="2"  Name="����������"/>
    <row LineID="5"  Name="����������"/>
    <row LineID="1"  Name="���� ��������"/>
    <row LineID="5"  Name="���� ��������"/>
    <row LineID="3"  Name="���� ������"/>
    <row LineID="8"  Name="���� ������"/>
    <row LineID="3"  Name="������������"/>
    <row LineID="3"  Name="������������"/>
    <row LineID="8"  Name="������"/>
    <row LineID="9"  Name="���������-�����������"/>
    <row LineID="10" Name="���������"/>
    <row LineID="4"  Name="����������"/>
    <row LineID="7"  Name="���������"/>
    <row LineID="8"  Name="������� ������"/>
    <row LineID="3"  Name="������� ���������"/>
    <row LineID="7"  Name="������������"/>
    <row LineID="9"  Name="�������"/>
    <row LineID="9"  Name="��������"/>
    <row LineID="1"  Name="�������������� �������"/>
    <row LineID="7"  Name="������������"/>
    <row LineID="1"  Name="�������� �����������"/>
    <row LineID="5"  Name="�������� ����"/>
    <row LineID="6"  Name="�������� ����"/>
    <row LineID="6"  Name="�����������"/>
    <row LineID="7"  Name="����������"/>
    <row LineID="3"  Name="��������� �����"/>
    <row LineID="2"  Name="������ ������"/>
    <row LineID="6"  Name="�������"/>
    <row LineID="10" Name="�������"/>
    <row LineID="7"  Name="��������� ��������"/>
    <row LineID="9"  Name="����������"/>
    <row LineID="6"  Name="��������"/>
    <row LineID="9"  Name="���������������"/>
    <row LineID="3"  Name="����������"/>
    <row LineID="9"  Name="������������"/>
    <row LineID="3"  Name="���������� �������"/>
    <row LineID="3"  Name="����������"/>
    <row LineID="4"  Name="����������"/>
    <row LineID="2"  Name="�����"/>
    <row LineID="1"  Name="����������"/>
    <row LineID="1"  Name="����������"/>
    <row LineID="10" Name="���������� �������"/>
    <row LineID="3"  Name="��������"/>
    <row LineID="4"  Name="������������"/>
    <row LineID="6"  Name="�����������"/>
    <row LineID="7"  Name="�����������"/>
    <row LineID="5"  Name="���������"/>
    <row LineID="7"  Name="���������"/>
    <row LineID="7"  Name="�������"/>
    <row LineID="2"  Name="��������"/>
    <row LineID="2"  Name="�����������"/>
    <row LineID="7"  Name="������������"/>
    <row LineID="6"  Name="������ ����"/>
    <row LineID="9"  Name="�������������"/>
    <row LineID="6"  Name="�������������"/>
    <row LineID="8"  Name="�������������"/>
    <row LineID="10" Name="�������"/>
    <row LineID="9"  Name="��������"/>
    <row LineID="6"  Name="������������"/>
    <row LineID="7"  Name="���������"/>
    <row LineID="7"  Name="����� 1905 ����"/>
    <row LineID="9"  Name="����� ��������� ������"/>
    <row LineID="12" Name="����� ���������"/>
    <row LineID="12" Name="����� ������������"/>
    <row LineID="12" Name="����� ����������������"/>
    <row LineID="1"  Name="�����������"/>
    <row LineID="4"  Name="�������� ����"/>
    <row LineID="4"  Name="����"/>
    <row LineID="1"  Name="�����������"/>
    <row LineID="2"  Name="��������"/>
    <row LineID="9"  Name="������� �������"/>
    <row LineID="1"  Name="������������"/>
    <row LineID="9"  Name="������������"/>
    <row LineID="9"  Name="���������"/>
    <row LineID="1"  Name="������ �����"/>
    <row LineID="10" Name="����������"/>
    <row LineID="6"  Name="�����������"/>
    <row LineID="10" Name="�����������"/>
    <row LineID="8"  Name="����� �����������"/>
    <row LineID="3"  Name="ٸ��������"/>
    <row LineID="7"  Name="���������"/>
    <row LineID="3"  Name="����������������"/>
    <row LineID="1"  Name="���-��������"/>
    <row LineID="1"  Name="���������"/>
    <row LineID="9"  Name="�����"/>
    <row LineID="6"  Name="�������"/>
  </Root>'

exec sp_xml_preparedocument @idoc output, @LineXML
declare @Lines table (
     [ID]        int 
    ,[Name]      varchar(256) 
    ,[ColorRGB]  varchar(6) 
    ,[ColorName] varchar(32)
    ,primary key(ID))

insert into @Lines ( 
   [ID]
  ,[Name]
  ,[ColorRGB]
  ,[ColorName])
select
     [ID]
    ,[Name]
    ,[ColorRGB]
    ,[ColorName]
  from openxml(@idoc, '/Root/row', 1)
  with (
     [ID]      int
    ,[Name]    varchar(256) 
    ,ColorRGB  varchar(6) 
    ,ColorName varchar(32))

exec sp_xml_removedocument @idoc
set @idoc = null


exec sp_xml_preparedocument @idoc output, @StationXML
declare @Station table (
     [LineID]  int 
    ,[Name]    varchar(256))

insert into @Station ( 
   [LineID]
  ,[Name])
select
     [LineID]
    ,[Name]
  from openxml(@idoc, '/Root/row', 1)
  with (    
     [LineID] int
    ,[Name]   varchar(256))

exec sp_xml_removedocument @idoc
set @idoc = null

select
     [Station.Name]     = t.Name
    ,[LineID.Name]      = s.Name
    ,[LineID.ColorRGB]  = s.ColorRGB
    ,[LineID.ColorName] = s.ColorName
    ,[Station.DualName] = concat(t.Name, ' (', s.Name, ')')
    ,[Station.FullName] = iif(r.Cnt > 1, concat(t.Name, ' (', s.Name, ')'), t.Name)
  from @Station as t
  join @Lines   as s on s.ID = t.LineID
  outer apply (
    select
         count(*) as Cnt
      from @Station as r
      where r.name = t.name
  ) as r
