
-- ������� ���������� sql �������
exec [ui].[UserActionSqlObject.CreateLite]
 	 @UserActionName = 'CrmNewWantCloseReason.Card'  -- ��� action (��������� ��������, ����������)
  ,@SqlObjectName  = 'dbo.dbo_CrmNewWantCloseReason_ReadInstance' -- �������� ���������(������ �������� ������)
go

exec [ui].[UserActionSqlObject.CreateLite]
 	 @UserActionName = 'CrmNewWantCloseReason.Card'  -- ��� action (��������� ��������, ����������)
  ,@SqlObjectName  = 'dbo.dbo_CrmNewWantCloseReason_Create' -- �������� ���������(������ �������� ������) 
go

exec [ui].[UserActionSqlObject.CreateLite]
 	 @UserActionName = 'CrmNewWantCloseReason.Card'  -- ��� action (��������� ��������, ����������)
  ,@SqlObjectName  = 'dbo.dbo_CrmNewWantCloseReason_Write' -- �������� ���������(������ �������� ������)
go

-- ������� ���������� sql �������
exec [ui].[UserActionSqlObject.CreateLite]
 	 @UserActionName = 'CrmNewWantCloseReason.Dict'  -- ��� action (��������� ��������, ����������)
  ,@SqlObjectName  = 'dbo.dbo_CrmNewWantCloseReason_ReadDict' -- �������� ���������(������ �������� ������)
go