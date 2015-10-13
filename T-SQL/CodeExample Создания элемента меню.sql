declare
   @Name           varchar(256)
  ,@Caption        varchar(256)
  ,@ActionName     varchar(128)
  ,@ParentName     varchar(256)
  ,@IconOID        oid
  ,@ParentOID      oid
  ,@IsGroup        bool
  ,@ActionOID      oid

----------------------------------------------------------------------------
-- ������ ��� �������� ������ ������ ����
select
     @Caption    = '�������� ������� ��������' -- ���������
    ,@Name       = 'FuncMenuRoot.CRM.NewCrmClientContact.CrmNewWantCloseReason->New' -- ��������
    ,@ActionName = 'CrmNewWantCloseReason.Card' -- �����
    ,@ParentName = 'FuncMenuRoot.CRM.NewCrmClientContact' -- �������� �� �������� �������� ����, ������� ������ ��������� ������ �������� ����
    ,@IconOID    = 281483566645250 -- ������ ������� ��������
    ,@IsGroup    = 0
----------------------------------------------------------------------------
select
    @ParentOID = t.[OID]
  from ui.MenuItem as t
  where t.Name = @ParentName

select
     @ActionOID = t.[OID]
  from ui.UserAction as t
  where t.Name = @ActionName

if (@ActionOID is not null)
  and (@ParentOID is not null)
begin
  exec dbo.ui_MenuItem_Create @ParentOID = @ParentOID   
    ,@Name = @Name   
    ,@Caption = @Caption   
    ,@IconOID = @IconOID   
    ,@IsGroup = @IsGroup   
    ,@ActionOID = @ActionOID
  
  select
       '�����'
      ,@Caption    as '@Caption'
      ,@ParentOID  as '@ParentOID'
      ,@ActionOID  as '@ActionOID'
end
else
  select
       '������'
      ,@Caption    as '@Caption'
      ,@ParentOID  as '@ParentOID'
      ,@ActionOID  as '@ActionOID'
go
----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------

declare
   @Name           varchar(256)
  ,@Caption        varchar(256)
  ,@ActionName     varchar(128)
  ,@ParentName     varchar(256)
  ,@IconOID        oid
  ,@ParentOID      oid
  ,@IsGroup        bool
  ,@ActionOID      oid
----------------------------------------------------------------------------
-- ������ ��� �������� ������ ������ ����
select
     @Caption = '������� ��������' -- ���������
    ,@Name           = 'FuncMenuRoot.CRM.NewCrmClientContact.CrmNewWantCloseReason->Dict' -- ��������
    ,@ActionName     = 'CrmNewWantCloseReason.Dict' -- �����
    ,@ParentName     = 'FuncMenuRoot.CRM.NewCrmClientContact' -- �������� �� �������� �������� ����, ������� ������ ��������� ������ �������� ����
    ,@IconOID        = 281483566645250 -- ������ ������� ��������
    ,@IsGroup        = 0
----------------------------------------------------------------------------
select
     @ParentOID = t.[OID]
  from ui.MenuItem as t
  where t.Name = @ParentName

select
     @ActionOID = t.[OID]
  from ui.UserAction as t
  where t.Name = @ActionName

if (@ActionOID is not null)
  and (@ParentOID is not null)
begin
  exec dbo.ui_MenuItem_Create @ParentOID = @ParentOID   
    ,@Name = @Name   
    ,@Caption = @Caption   
    ,@IconOID = @IconOID   
    ,@IsGroup = @IsGroup   
    ,@ActionOID = @ActionOID
  
  select
       '�����'
      ,@Caption    as '@Caption'
      ,@ParentOID  as '@ParentOID'
      ,@ActionOID  as '@ActionOID'
end
else
  select
       '������'
      ,@Caption    as '@Caption'
      ,@ParentOID  as '@ParentOID'
      ,@ActionOID  as '@ActionOID'
----------------------------------------------------------------------------
go