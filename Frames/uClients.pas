unit uClients;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, System.Skia, System.Rtti,
  FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, FMX.Skia, FMX.Objects,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope,
  FMX.Menus, FMX.Edit;

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
    PopupMenu1: TPopupMenu;
    Edit: TMenuItem;
    Delete: TMenuItem;
    Preview: TMenuItem;
    eSearch: TEdit;
    procedure FrameResize(Sender: TObject);
    procedure gTableRecordResized(Sender: TObject);
    procedure btnTriggerClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses uDm, uMain;

procedure TfClients.btnTriggerClick(Sender: TObject);
begin
  // visibility show of Add client modal
  frmMain.rBackground.Visible := True;
  frmMain.rModalAdd.Visible := True;

  // Set Date component to the current date
  frmMain.dContactDate.Date := now;
  frmMain.dFirstTD.Date := now;
  frmMain.dSecondTD.Date := now;
  frmMain.dThirdTD.Date := now;
end;

procedure TfClients.FrameResize(Sender: TObject);
begin
  if frmMain.ClientWidth >= 1300 then
  begin

  end;
end;

// Responsive grid
procedure TfClients.gTableRecordResized(Sender: TObject);
var
  i: Integer;
  NewWidth: Single;
begin
  NewWidth := gTableRecord.Width / gTableRecord.ColumnCount;
  for i := 0 to gTableRecord.ColumnCount - 1 do
    gTableRecord.Columns[i].Width := NewWidth;
end;

end.
