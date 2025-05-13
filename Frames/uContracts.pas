unit uContracts;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Skia, System.Rtti, FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, FMX.Skia,
  FMX.Objects, FMX.Layouts, FMX.Menus, FMX.Controls.Presentation, FMX.Edit;

type
  TfContracts = class(TFrame)
    lytHeader: TLayout;
    lbTitle: TLabel;
    btnTrigger: TCornerButton;
    PopupMenu1: TPopupMenu;
    Edit: TMenuItem;
    Delete: TMenuItem;
    Preview: TMenuItem;
    ScrollBox1: TScrollBox;
    rContainer: TRectangle;
    Layout2: TLayout;
    SkLabel1: TSkLabel;
    ScrollBox2: TScrollBox;
    gTableRecord: TGrid;
    Layout1: TLayout;
    eSearch: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridContentsResponsive;
  end;

implementation

{$R *.fmx}

{ Responsive grid procedure }
procedure TfContracts.GridContentsResponsive;
var
  i, ColCount: Integer;
  TotalWidth, ColumnWidth: Single;
begin
  ColCount := gTableRecord.ColumnCount;

  if ColCount = 0 then
    Exit;

  // Adjust for internal padding or scrollbar
  TotalWidth := gTableRecord.Width; // Use ClientWidth instead of Width

  // Subtract 1 pixel to prevent overflow and scrollbar
  ColumnWidth := (TotalWidth - 10) / ColCount;

  // Set all columns to equal width
  for i := 0 to ColCount - 1 do
    gTableRecord.Columns[i].Width := ColumnWidth;;
end;

end.
