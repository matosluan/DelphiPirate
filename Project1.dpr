program Project1;
uses
  System.StartUpCopy,
  FMX.Forms,
  Cadastro in 'Cadastro.pas' {FrmCadastro},
  Login in 'Login.pas' {FrmLogin},
  UDM in 'UDM.pas' {dm: TDataModule},
  Lista in 'Lista.pas' {FrmLista};

{$R *.res}
begin
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TFrmCadastro, FrmCadastro);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TFrmLista, FrmLista);
  Application.Run;
end.
