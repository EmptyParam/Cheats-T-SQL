/*
� ����� SQL Server 2011 (Denali) ����������� ����������� ������� Order By � ������� ���� ������������ �������������� ������:
    Offset (��������)
    Fetch First ��� Fetch Next (����� ������ ��� ����� ���������)

Offset
������������� ������ ������� ��������� ���������� ��������� ���������� ����� ����� ��� ��� �������� ���������� �������. ��� ��� ���� ���������������: ��������, � ��� ���� 100 ������� � ������� � ����� ���������� ������ 10 ����� � ������� ������ � 11 �� 100. ������ ��� ����� �������� ��������� ��������:

Select *
From  <SomeTable>
Order by  <SomeColumn>
Offset 10 Rows

��� ��� ���������, ������� ���������� .Net ������ ���� ������ ����� ���������� ��� ��������� Skip, ������� ���������� ��������� ���������� �����. ��� ��� ��������� Offset �������� ����� ��� ��. ����� ���� ��� ������ ����������� �����-���� �������, ����� ��������� ��������� Offset.

��������, � ������� ����� ���� ������������ ��������� Offset
�� ���� ����������� �������� �� Offset ����� ������������ ����� ������ ����������� � ���������� ������� �������:
*/
-- ���������� ��������� ����������
declare @tblSample table (
   PersonName varchar(50) 
  ,Age        int 
  ,[address]  varchar(100))

-- ���������� �������
insert into @tblSample ( 
   PersonName
  ,Age
  ,[address] 
)
select
     'Person Name' + cast(t.Number as varchar) as PersonName
    ,Number                                    as Age
    ,'Address' + cast(t.Number as varchar)     as [address]
  from master..spt_values as t
  where t.[type] = 'p' 
    and t.Number between 1 and 5

--������ 1. ���������� ������ 10 ������� � �������� ���������.

--������ ����� �������.

select
     *
  from @tblSample       
  order by
     Age
  offset 10 Row

--���
select
     *
  from @tblSample       
  order by
     Age
  offset (10) rows

--����� ����������� ����� �����:
/*
Person Name      Age      Address
Person Name11    11       Address11
Person Name12    12       Address12
. . . . .  . . . . . . . . .
. . . . . .. . . . . . . . .
Person Name49    49       Address49
Person Name50    50       Address50
*/

--�������, ����� ����� ������������ ����� �������� ���������� �����: Row ��� Rows � ��� �������� � ������ ������.

--������ 2. �������� ���������� ����� ��� �������� � ���� ����������

-- ��������� ���������� � ������� ����� ����������� ���-�� ����� ��� ��������
declare @RowSkip as int
-- ���������� ���������� ����� ��� ��������
set @RowSkip = 10

-- �������� ���������
select
     *
  from @tblSample       
  order by
     Age
  offset @RowSkip Row

--������ 3. ������ ���������� ����� ��� �������� � ���� ���������

-- �������� ������ � 14 �� 50
select
     *
  from @tblSample       
  order by
     Age
  offset ( select
                max(number) / 99999999
             from master..spt_values) rows


--��������� select MAX(number)/99999999 from master..spt_values ������ ����� 14.

--������ 4. ������ ���������� ����� ��� �������� � ���� ���������������� �������
select
     *
  from @tblSample       
  order by
     Age
  offset ( select dbo.fn_test()) rows

---��� ��� ��������� ���������������� �������

create function fn_test()
returns int
as
begin
  declare @ResultVar as int
  set @ResultVar = 10
  return @ResultVar
end
go

---������ 5. ������������� Offset � Order by ������ ������������� (view), �������, �����������, ��������� ��������, ����� ���������� ��� ������ (Common Table Expressions � CTE).

--��������, ������������� � ���������� ��������� ����������.
;with Cte as
( select
        *
    from @tblSample       
    order by
        Age
    offset 10 rows)
select
    *
  from Cte

--������ ���� ���������� ������������� Offset � Order by ������ ��������� �������.

select
     *
  from ( select
              *
           from @tblSample  
           where Age > 10       
           order by
              Age
           offset 10 rows) as PersonDerivedTable

--� ��� ������ �� ������ Offset � Order � ���������������.
/*
-- �������� view
create view vwPersonRecord as
select
     *
  from @tblSample
go
*/
-- ������� ������ �� view
select
     *
  from vwPersonRecord  
  where Age > 10       
  order by
     Age
  offset 10 rows
/*go

drop view vwPersonRecord
go
drop function fn_test
go
*/

--- ������������� Fetch First / Fetch Next

/*
��� �������� ����� ������������ ��� ��������� ���������� ������������ ����� ����� �������� ������� ����� �� ��������� Offset. �����������, ��� � ��� ���� 100 ����� � ��� ���� ���������� ������ 10 � �������� ��������� 5 �����. �.�. ���� �������� ������ � 11 �� 15.

select
     *
  from <SomeTable >       
  order by
     <SomeColumn >
  offset 10 rows
  fetch next 5 rows only; -- ��� Fetch First 5 Rows Only
 */

select
     *
  from @tblSample       
  order by
     Age
  offset 10 Row
  fetch first 5 rows only

-- ���������� ��� �������� ��������
declare @RowSkip as int
-- ���������� ��� �������� ���-�� ������������ �����
declare @RowFetch as int

-- ���-�� ����� ��� ��������
set @RowSkip = 10
-- ���-�� ����� ��� ��������
set @RowFetch = 5

-- ����� ����� � 11 �� 15
select
     *
  from @tblSample       
  order by
     Age
  offset @RowSkip rows
  fetch next @RowFetch rows only
 
--� ����� � �����, � ����� ��������� ������� ����� ������ ��� �� �� �����, ��� � � Offset. ����������, �������������, ������� � �.�.
