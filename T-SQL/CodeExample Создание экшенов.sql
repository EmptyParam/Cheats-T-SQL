

exec dbo.dbo_AUSModule_ReadDict
go
-- ��������(Ctrl + H) #�������� 

exec [ui].[UserAction.CreateLite]
   @Name = 'INSPolicySaleClaim.Card'   
  ,@Caption = '�������� #��������'   
  ,@ModuleName = 'mjs_insurance.dll'
go

exec [ui].[UserAction.CreateLite]
   @Name = 'INSPolicySaleClaim.CardWrite'   
  ,@Caption = '�������� #�������� (���������)'   
  ,@ModuleName = 'mjs_crm.dll'
go

exec [ui].[UserAction.CreateLite]
   @Name = 'INSPolicySaleClaim.New'   
  ,@Caption = '�������� #��������'   
  ,@ModuleName = 'mjs_crm.dll'
go

exec [ui].[UserAction.CreateLite]
   @Name = 'INSPolicySaleClaim.Dict'   
  ,@Caption = '���������� #��������'   
  ,@ModuleName = 'mjs_crm.dll'
go



