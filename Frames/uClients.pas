unit uClients;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, System.Skia, System.Rtti,
  FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, FMX.Skia, FMX.Objects,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope,
  FMX.Menus, FMX.Edit, DateUtils;

type
  TfClients = class(TFrame)
    lytHeader: TLayout;
    lbTitle: TLabel;
    btnTrigger: TCornerButton;
    rContainer: TRectangle;
    Layout2: TLayout;
    SkLabel1: TSkLabel;
    gTableRecord: TGrid;
    ScrollBox1: TScrollBox;
    Layout1: TLayout;
    ScrollBox2: TScrollBox;
    PopupMenuClients: TPopupMenu;
    Edit: TMenuItem;
    Delete: TMenuItem;
    eSearch: TEdit;
    BindSourceDBClients: TBindSourceDB;
    BindingsListClients: TBindingsList;
    LinkGridToClients: TLinkGridToDataSource;
    procedure btnTriggerClick(Sender: TObject);
    procedure gTableRecordResized(Sender: TObject);
    procedure eSearchChange(Sender: TObject);
    procedure rContainerClick(Sender: TObject);
    procedure FrameClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridContentsResponsive;
  end;

implementation

{$R *.fmx}

uses uDm, uMain;

procedure TfClients.btnTriggerClick(Sender: TObject);
begin
  // Reset tag
  frmMain.Tag := 0;

  // visibility show of Add client modal
  frmMain.rBackground.Visible := True;
  frmMain.rModalAdd.Visible := True;

  frmMain.ScrollBox1.ViewportPosition := PointF(0,0);
  frmMain.HideComponents;
  frmMain.ClearItems;
end;

{ Responsive grid procedure }
procedure TfClients.eSearchChange(Sender: TObject);
begin
  GridContentsResponsive;
end;

procedure TfClients.FrameClick(Sender: TObject);
begin
  GridContentsResponsive;
end;

procedure TfClients.GridContentsResponsive;
var
  i: Integer;
  NewWidth: Single;
begin
  NewWidth := gTableRecord.Width / gTableRecord.ColumnCount;
  for i := 0 to gTableRecord.ColumnCount - 1 do
    gTableRecord.Columns[i].Width := NewWidth - 2;
end;

procedure TfClients.gTableRecordResized(Sender: TObject);
begin
  if Self.Tag = 0 then
  begin
    GridContentsResponsive;
    Self.Tag := 1;
  end;
end;

procedure TfClients.rContainerClick(Sender: TObject);
begin
  GridContentsResponsive;
end;

end.
