unit Cadastro;
interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.Objects, idHashSHA;
type
  TFrmCadastro = class(TForm)
    LayoutCentral: TLayout;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Edit1: TEdit;
    Button1: TButton;
    Image1: TImage;
    ToolBarSuperior: TToolBar;
    LayoutInferior: TLayout;
    LayoutIcon: TLayout;
    Layout2: TLayout;
    image_esconde: TImage;
    image_exibe: TImage;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure image_escondeClick(Sender: TObject);
    procedure image_exibeClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function SHA1(AString:string):string;
  end;
var
  FrmCadastro: TFrmCadastro;
implementation
{$R *.fmx}
uses Login, UDM, Lista;

procedure TFrmCadastro.Button1Click(Sender: TObject);
begin
  FrmLogin.Show();
  FrmCadastro.Hide();
  dm.FDQueryPessoa.Close;
  dm.FDQueryPessoa.Open();
  if(Edit1.text = EmptyStr) or(Edit2.text = EmptyStr) then
  Abort;
  dm.FDQueryPessoa.Append;
  dm.FDQueryPessoaemail.AsString:= Edit1.Text;
  dm.FDQueryPessoaSenha.AsString:= SHA1(Edit2.text);
  dm.FDQueryPessoa.Post;

  end;
procedure TFrmCadastro.Button2Click(Sender: TObject);
begin
         FrmLogin.Show();
  FrmCadastro.Hide();
  dm.FDQueryPessoa.Close;
  dm.FDQueryPessoa.Open();
  if(Edit1.text = EmptyStr) or(Edit2.text = EmptyStr) then
  Abort;
  dm.FDQueryPessoa.Append;
  dm.FDQueryPessoaemail.AsString:= Edit1.Text;
  dm.FDQueryPessoaSenha.AsString:= SHA1(Edit2.text);
  dm.FDQueryPessoa.Post;
end;

procedure TFrmCadastro.image_escondeClick(Sender: TObject);
begin
  Image_esconde.Visible := false;
  Image_exibe.Visible := True;
  Edit2.Password := false;
end;



procedure TFrmCadastro.image_exibeClick(Sender: TObject);
begin
Image_esconde.Visible := True;
  Image_exibe.Visible := false;
  Edit2.Password := True;
end;

function TFrmCadastro.SHA1(AString: string): string;
var
SenhaSH1: TIDhASHsha1;
begin
SenhaSH1 := TIDhASHsha1.Create;
  TRY
    Result:= SenhaSH1.HashStringAsHex(AString);
  FINALLY
    SenhaSH1.Free;
  END;
end;
end.
