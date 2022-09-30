unit Unit6;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, IOUtils,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Objects, FMX.Ani, FMX.Controls.Presentation, FMX.Layouts,
  FMX.TabControl, FMX.MultiView, System.Actions, FMX.ActnList;

type
  TFrmLista = class(TForm)
    ButonH: TButton;
    MultiView1: TMultiView;
    Layout1: TLayout;
    CircleFoto: TCircle;
    LabelNomeUser: TLabel;
    VertScrollBox1: TVertScrollBox;
    RectFavoritos: TRoundRect;
    Label2: TLabel;
    RoundProfissionais: TRoundRect;
    LabelProfissionais: TLabel;
    ActionList1: TActionList;
    ChangeTabAction1: TChangeTabAction;
    ChangeTabAction2: TChangeTabAction;
    Rectangle1: TRectangle;
    Label3: TLabel;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    LayoutCorpoDoCadastro: TLayout;
    Image1: TImage;
    LayoutNome: TLayout;
    Edit1: TEdit;
    Nome: TLabel;
    LayoutCpf: TLayout;
    Edit2: TEdit;
    Label4: TLabel;
    Layoutcelular: TLayout;
    Edit3: TEdit;
    Celuar: TLabel;
    Layout2: TLayout;
    Edit4: TEdit;
    Genero: TLabel;
    Layout3: TLayout;
    Edit5: TEdit;
    Label5: TLabel;
    Layout4: TLayout;
    Edit6: TEdit;
    Label6: TLabel;
    Layout5: TLayout;
    Edit7: TEdit;
    Label7: TLabel;
    Layout6: TLayout;
    Edit8: TEdit;
    Label8: TLabel;
    Layout7: TLayout;
    Edit9: TEdit;
    Label9: TLabel;
    Layout8: TLayout;
    Edit10: TEdit;
    Label10: TLabel;
    Layout9: TLayout;
    Edit11: TEdit;
    Complemento: TLabel;
    Layout10: TLayout;
    Edit12: TEdit;
    Label11: TLabel;
    Layout11: TLayout;
    Edit13: TEdit;
    Label12: TLabel;
    Button1: TButton;
    TabItem3: TTabItem;
    VertScrollBoxMinhaLista: TVertScrollBox;
    VertScrollBoxFavoritos: TVertScrollBox;
    ChangeTabAction3: TChangeTabAction;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarListaProdutos(id: integer; nome, descricao: string;
      valor: double);
    procedure GetProdutosBase;
    procedure AddFavoritos(Sender: TObject);
    function favorito(id: integer): boolean;
     procedure FormCreate(Sender: TObject);
    procedure img_aba2Click(Sender: TObject);
  public
    { Public declarations }
  end;

var
  FrmLista: TFrmLista;

implementation

{$R *.fmx}

uses unit5;

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

procedure TFrmLista.Button1Click(Sender: TObject);
begin
  ChangeTabAction2.Execute;
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
        ('D:\Users\lmsilva7.UNIVEL\Desktop\DelphiMobile-master\img',
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
        ('D:\Users\lmsilva7.UNIVEL\Desktop\DelphiMobile-master\img',
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

procedure TFrmLista.img_aba2Click(Sender: TObject);
begin
  ChangeTabAction2.Execute;
end;

end.
