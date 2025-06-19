unit uContracts;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Skia, System.Rtti, FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, FMX.Skia,
  FMX.Objects, FMX.Layouts, FMX.Menus, FMX.Controls.Presentation, FMX.Edit, uDm,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope;

type
  TfContracts = class(TFrame)
    lytHeader: TLayout;
    lbTitle: TLabel;
    btnTrigger: TCornerButton;
    PopupMenuContracts: TPopupMenu;
    Edit: TMenuItem;
    Delete: TMenuItem;
    ScrollBox1: TScrollBox;
    rContainer: TRectangle;
    Layout2: TLayout;
    SkLabel1: TSkLabel;
    ScrollBox2: TScrollBox;
    gTableRecord: TGrid;
    Layout1: TLayout;
    eSearch: TEdit;
    BindSourceDBContracts: TBindSourceDB;
    BindingsListContracts: TBindingsList;
    LinkGridToContracts: TLinkGridToDataSource;
    procedure gTableRecordResized(Sender: TObject);
    procedure FrameClick(Sender: TObject);
    procedure rContainerClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridContentsResponsive;
  end;

implementation

{$R *.fmx}

uses uMain;

{ Responsive grid procedure }
procedure TfContracts.FrameClick(Sender: TObject);
begin
//  GridContentsResponsive;
end;

procedure TfContracts.GridContentsResponsive;
var
  i: Integer;
  NewWidth: Single;
begin
  NewWidth := gTableRecord.Width / gTableRecord.ColumnCount;
  for i := 0 to gTableRecord.ColumnCount - 1 do
    gTableRecord.Columns[i].Width := NewWidth - 2;
end;

{ Resized Reponsiveness }
procedure TfContracts.gTableRecordResized(Sender: TObject);
begin
  if Self.Tag = 0 then
  begin
//    GridContentsResponsive;
    Self.Tag := 1;
  end;
end;

procedure TfContracts.rContainerClick(Sender: TObject);
begin
//  GridContentsResponsive;
end;

end.
