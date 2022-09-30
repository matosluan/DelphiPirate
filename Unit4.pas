unit Unit4;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.TabControl, System.Actions, FMX.ActnList, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Objects;

type
  TFrmPrincipal = class(TForm)
    LayoutInferior: TLayout;
    LayoutCentral: TLayout;
    ToolBar1: TToolBar;
    ActionList1: TActionList;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    ChangeTabAction1: TChangeTabAction;
    ChangeTabAction2: TChangeTabAction;
    ChangeTabAction3: TChangeTabAction;
    Image4: TImage;
    Button1: TButton;
    procedure Image4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}




procedure TFrmPrincipal.Button1Click(Sender: TObject);
begin
ChangeTabAction3.Execute;
end;

procedure TFrmPrincipal.Image4Click(Sender: TObject);
begin
case TabControl1.TabIndex of
    0:
      ChangeTabAction2.Execute;
    1:
      ChangeTabAction3.Execute;
    2:
      ChangeTabAction1.Execute;
end;
end;

end.



