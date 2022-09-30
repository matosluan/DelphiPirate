unit Lista;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, IOUtils,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Objects, FMX.Ani, FMX.Controls.Presentation, FMX.Layouts,
  FMX.TabControl, FMX.MultiView, System.Actions, FMX.ActnList, Data.FMTBcd,
  Data.DB, Data.SqlExpr;

type
  TFrmLista = class(TForm)
    ActionList1: TActionList;
    ChangeTabAction1: TChangeTabAction;
    ChangeTabAction2: TChangeTabAction;
    ChangeTabAction3: TChangeTabAction;
    ChangeTabAction4: TChangeTabAction;
    ChangeTabAction5: TChangeTabAction;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    VertScrollBoxMinhaLista: TVertScrollBox;
    VertScrollBoxFavoritos: TVertScrollBox;
    MultiView1: TMultiView;
    LayoutMenu: TLayout;
    Image1: TImage;
    btnDados: TButton;
    ToolBar1: TToolBar;
    btnMenu: TButton;
    Label1: TLabel;
    Image2: TImage;
    TabItem4: TTabItem;
    VertScrollBoxMeusDados: TVertScrollBox;
    LayoutPrincipal: TLayout;
    LayoutIcon: TLayout;
    Image3: TImage;
    LayoutNome: TLayout;
    Nome: TLabel;
    EdtNome: TEdit;
    LayoutCPF: TLayout;
    CPF: TLabel;
    EdtCpf: TEdit;
    LayoutCelular: TLayout;
    Label2: TLabel;
    EditCelular: TEdit;
    LayoutEmail: TLayout;
    Email: TLabel;
    EdtEmail: TEdit;
    LayoutCidade: TLayout;
    Label4: TLabel;
    EdtCidade: TEdit;
    EdtUf: TEdit;
    LayoutEndereco: TLayout;
    Label5: TLabel;
    EdtEndereco: TEdit;
    LayoutBairro: TLayout;
    Label6: TLabel;
    EdtBairro: TEdit;
    RectSalvar: TRectangle;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure RectSalvarClick(Sender: TObject);
    procedure btnDadosClick(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarListaProdutos(id: integer; nome, descricao: string;
      valor: double);
    procedure GetFavoritos;
    procedure GetProdutosBase;
    procedure GetUsuario;
    procedure AddFavoritos(Sender: TObject);
    procedure RemoveFavoritos(Sender: TObject);
    function favorito(id: integer): boolean;
  public
    { Public declarations }
  end;

var
  FrmLista: TFrmLista;

implementation

{$R *.fmx}

uses UDM, Login;

procedure TFrmLista.AddFavoritos(Sender: TObject);
var
  AId: string;
begin
  AId := (TRectangle(Sender).TagString);
  dm.FDQueryProduto.Locate('id', AId, []);
  dm.FDQueryProduto.Edit;
  dm.FDQueryProdutofavorito.AsString := 'S';
  dm.FDQueryProduto.Post;
  ShowMessage('Adicionado ao seus favoritos');
end;

procedure TFrmLista.RemoveFavoritos(Sender: TObject);
var
  AId: string;
begin
  AId := (TRectangle(Sender).TagString);
  dm.FDQueryProduto.Locate('id', AId, []);
  dm.FDQueryProduto.Edit;
  dm.FDQueryProdutofavorito.AsString := 'N';
  dm.FDQueryProduto.Post;
  ShowMessage('Removido do seus favoritos');
end;

procedure TFrmLista.btnDadosClick(Sender: TObject);
begin
  changetabaction4.Execute;
end;

procedure TFrmLista.CarregarListaProdutos(id: integer; nome, descricao: string;
  valor: double);
var
  rect, rect_barra: TRectangle;
  rect_icone: TCircle;
  lbl: TLabel;
  img: TImage;
  i, valorEstrela: integer;
begin

  // fundo
  rect := TRectangle.Create(VertScrollBoxMinhaLista);
  with rect do
  begin
    Align := TAlignLayout.Top;
    Height := 110;
    Fill.Color := $FFFFFFFF;
    Stroke.Kind := TBrushKind.Solid;
    Stroke.Color := $FFD4D5D7;
    Margins.Top := 10;
    Margins.Left := 10;
    Margins.Right := 10;
    XRadius := 8;
    YRadius := 8;
    TagString := IntToStr(id);
  end;
  // Barra inferior...
  rect_barra := TRectangle.Create(rect);
  with rect_barra do
  begin
    Align := TAlignLayout.Bottom;
    Height := 45;
    Fill.Color := $FFF4F4F4;
    Stroke.Kind := TBrushKind.Solid;
    Stroke.Color := $FFD4D5D7;
    Sides := [TSide.Left, TSide.Bottom, TSide.Right];
    XRadius := 8;
    YRadius := 8;
    Corners := [TCorner.BottomLeft, TCorner.BottomRight];
    HitTest := False;
    rect.AddObject(rect_barra);
  end;

  lbl := TLabel.Create(rect);
  with lbl do
  begin
    StyledSettings := StyledSettings - [TStyledSetting.Size,
      TStyledSetting.FontColor, TStyledSetting.Style];
    TextSettings.FontColor := $FF333333;
    Text := nome;
    font.Size := 16;
    font.Style := [TFontStyle.fsBold];
    Position.x := 50;
    Position.Y := 10;
    Width := 200;
    rect.AddObject(lbl);
  end;
  lbl := TLabel.Create(rect_barra);
  with lbl do
  begin
    StyledSettings := StyledSettings - [TStyledSetting.Size,
      TStyledSetting.FontColor, TStyledSetting.Style];
    TextSettings.FontColor := $FFDF0B0B;
    Text := descricao;
    font.Size := 11;
    font.Style := [TFontStyle.fsBold];
    Position.x := 5;
    Position.Y := 70;
    Width := 500;
    rect.AddObject(lbl);
  end;
  // ImgFavoritos
  img := TImage.Create(rect);
  if not favorito(id) then
  begin
    with img do
    begin
{$IFDEF MSWINDOWS}
      Bitmap.LoadFromFile
        (IOUtils.TPath.Combine
        ('D:\Users\lmsilva7.UNIVEL\Desktop\App_em_delf-master\img',
        'heart_nosel.png'));
{$ENDIF}
{$IF DEFINED(iOS) or DEFINED(ANDROID)}
      Bitmap.LoadFromFile
        (IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,
        'heart_nosel.png'));
{$ENDIF}
      Height := 30;
      Width := 30;
      Position.x := 210;
      Position.Y := 5;
      name := 'imgheartNoSel' + IntToStr(id);
      TagString := IntToStr(id);
      OnClick := AddFavoritos;
      Visible := true;
      rect.AddObject(img);
    end;
  end
  else
  begin

    with img do
    begin
{$IFDEF MSWINDOWS}
      Bitmap.LoadFromFile
        (IOUtils.TPath.Combine
        ('D:\Users\lmsilva7.UNIVEL\Desktop\App_em_delf-master\img',
        'heart_yessel.png'));
{$ENDIF}
{$IF DEFINED(iOS) or DEFINED(ANDROID)}
      Bitmap.LoadFromFile
        (IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,
        'heart_yessel.png'));
{$ENDIF}
      Height := 30;
      Width := 30;
      Position.x := 210;
      Position.Y := 5;
      name := 'imgheartYesSel' + IntToStr(id);
      TagString := IntToStr(id);
      Visible := true;
      rect.AddObject(img);
    end;
  end;
  VertScrollBoxMinhaLista.AddObject(rect);
end;

function TFrmLista.favorito(id: integer): boolean;
begin
  dm.FDQFavoritos.Close;
  dm.FDQFavoritos.ParamByName('pIdProduto').AsInteger := id;
  dm.FDQFavoritos.Open();

  if not dm.FDQFavoritos.IsEmpty then
    Result := True
  else
    Result := False;
end;

procedure TFrmLista.FormCreate(Sender: TObject);
begin
  ChangeTabAction1.Execute;
  GetProdutosBase;
  GetFavoritos;
  GetUsuario;
end;

procedure TFrmLista.GetFavoritos;
var
  rect, rect_barra: TRectangle;
  rect_icone: TCircle;
  lbl: TLabel;
  img: TImage;
  i, valorEstrela: integer;
begin
  dm.FDQueryListaFavoritos.Close;
  dm.FDQueryListaFavoritos.Open();

  while not dm.FDQueryListaFavoritos.Eof do
  begin
    // fundo
    rect := TRectangle.Create(VertScrollBoxMinhaLista);
    with rect do
    begin
      Align := TAlignLayout.Top;
      Height := 110;
      Fill.Color := $FFFFFFFF;
      Stroke.Kind := TBrushKind.Solid;
      Stroke.Color := $FFD4D5D7;
      Margins.Top := 10;
      Margins.Left := 10;
      Margins.Right := 10;
      XRadius := 8;
      YRadius := 8;
      TagString := IntToStr(dm.FDQueryListaFavoritosid.AsInteger);
    end;
    // Barra inferior...
    rect_barra := TRectangle.Create(rect);
    with rect_barra do
    begin
      Align := TAlignLayout.Bottom;
      Height := 45;
      Fill.Color := $FFF4F4F4;
      Stroke.Kind := TBrushKind.Solid;
      Stroke.Color := $FFD4D5D7;
      Sides := [TSide.Left, TSide.Bottom, TSide.Right];
      XRadius := 8;
      YRadius := 8;
      Corners := [TCorner.BottomLeft, TCorner.BottomRight];
      HitTest := False;
      rect.AddObject(rect_barra);
    end;

    lbl := TLabel.Create(rect);
    with lbl do
    begin
      StyledSettings := StyledSettings - [TStyledSetting.Size,
        TStyledSetting.FontColor, TStyledSetting.Style];
      TextSettings.FontColor := $FF333333;
      Text := dm.FDQueryListaFavoritosnome.AsString;
      font.Size := 16;
      font.Style := [TFontStyle.fsBold];
      Position.x := 50;
      Position.Y := 10;
      Width := 200;
      rect.AddObject(lbl);
    end;
    lbl := TLabel.Create(rect_barra);
    with lbl do
    begin
      StyledSettings := StyledSettings - [TStyledSetting.Size,
        TStyledSetting.FontColor, TStyledSetting.Style];
      TextSettings.FontColor := $FFDF0B0B;
      Text := dm.FDQueryListaFavoritosdescricao.AsString;
      font.Size := 11;
      font.Style := [TFontStyle.fsBold];
      Position.x := 5;
      Position.Y := 70;
      Width := 500;
      rect.AddObject(lbl);
    end;
    // ImgFavoritos
    img := TImage.Create(rect);
    with img do
    begin
{$IFDEF MSWINDOWS}
      Bitmap.LoadFromFile
        (IOUtils.TPath.Combine
        ('D:\Users\lmsilva7.UNIVEL\Desktop\App_em_delf-master\img',
        'heart_yessel.png'));
{$ENDIF}
{$IF DEFINED(iOS) or DEFINED(ANDROID)}
      Bitmap.LoadFromFile
        (IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,
        'heart_yessel.png'));
{$ENDIF}
      Height := 30;
      Width := 30;
      Position.x := 210;
      Position.Y := 5;
      name := 'imgheartYesSel' + dm.FDQueryListaFavoritosid.AsString;;
      TagString := IntToStr(dm.FDQueryListaFavoritosid.AsInteger);
      OnClick := RemoveFavoritos;
      Visible := true;
      rect.AddObject(img);
    end;
    VertScrollBoxFavoritos.AddObject(rect);
    dm.FDQueryListaFavoritos.next;

  end;
end;

procedure TFrmLista.GetProdutosBase;
begin
  dm.FDQueryProduto.Close;
  dm.FDQueryProduto.Open();
  while not dm.FDQueryProduto.Eof do
  begin
    CarregarListaProdutos(dm.FDQueryProdutoid.AsInteger, dm.FDQueryProdutonome.AsString,
      dm.FDQueryProdutodescricao.AsString, dm.FDQueryProdutovalor.AsFloat);
    dm.FDQueryProduto.next;
  end;

end;

procedure TFrmLista.GetUsuario;
begin
  dm.FDQueryusuarioLogin.Close;
  dm.FDQueryusuarioLogin.ParamByName('pid').AsInteger := FrmLogin.usuariologado;
  dm.FDQueryusuarioLogin.Open();

  dm.FDQueryPessoa.Locate('email', Frmlogin.Edit1.Text, []);
  EdtNome.Text := dm.FDQueryPessoanome.AsString;
  EdtCpf.Text := dm.FDQueryPessoacpf.AsString;
  editCelular.Text := dm.FDQueryPessoacelular.AsString;
  FrmLogin.Edit1.Text := edtemail.Text;
  edtemail.Text := dm.FDQueryPessoaemail.AsString;
  edtuf.Text := dm.FDQueryPessoauf.AsString;
  Edtcidade.Text := dm.FDQueryPessoacidade.AsString;
  Edtendereco.Text := dm.FDQueryPessoaendereco.AsString;
  Edtbairro.Text := dm.FDQueryPessoabairro.AsString;
end;

procedure TFrmLista.RectSalvarClick(Sender: TObject);
begin
  dm.FDQueryPessoa.Edit;
  dm.FDQueryPessoanome.AsString := EdtNome.Text;
  dm.FDQueryPessoacpf.AsString := EdtCpf.Text;
  dm.FDQueryPessoacelular.AsString := EditCelular.Text;
  dm.FDQueryPessoaemail.AsString := EdtEmail.Text;
  dm.FDQueryPessoauf.AsString := edtuf.Text;
  dm.FDQueryPessoacidade.AsString := Edtcidade.Text;
  dm.FDQueryPessoaendereco.AsString := Edtendereco.Text;
  dm.FDQueryPessoabairro.AsString := Edtbairro.Text;
  dm.FDQueryPessoa.Post;

  ShowMessage('Concluido');
end;

end.
