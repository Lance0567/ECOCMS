unit uPDFCreation;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Skia, FMX.Layouts, FMX.Objects, FMX.Skia, FMX.Effects,
  FMX.Controls.Presentation, uPDFViewer;

type
  TfPDFCreation = class(TFrame)
    rButtonH: TRectangle;
    Rectangle3: TRectangle;
    SkLabel4: TSkLabel;
    btnGeneratePDF: TSpeedButton;
    ShadowEffect2: TShadowEffect;
    rctHeader: TRectangle;
    rctPage: TRectangle;
    ShadowEffect1: TShadowEffect;
    ScrollBox1: TScrollBox;
    rPage1: TRectangle;
    lytPage1: TLayout;
    lytContent1: TLayout;
    rHeader: TRectangle;
    imgLogo: TImage;
    slHeader: TSkLabel;
    lSplitter1: TLine;
    rDate: TRectangle;
    slDateH: TSkLabel;
    lSplitter2: TLine;
    slDate: TSkLabel;
    rClientName: TRectangle;
    slClientName: TSkLabel;
    rClientDetails: TRectangle;
    slClientDetails: TSkLabel;
    rAddress: TRectangle;
    slAddressH: TSkLabel;
    lytPage1Content: TLayout;
    SkLabel11: TSkLabel;
    SkLabel12: TSkLabel;
    SkLabel13: TSkLabel;
    SkLabel6: TSkLabel;
    rBlackH: TRectangle;
    slTitle: TSkLabel;
    rPage3: TRectangle;
    lytPage3: TLayout;
    lytPageContent3: TLayout;
    SkLabel2: TSkLabel;
    SkLabel3: TSkLabel;
    SkLabel5: TSkLabel;
    lytSignatureDetails: TLayout;
    GridPanelLayout1: TGridPanelLayout;
    SkLabel7: TSkLabel;
    SkLabel8: TSkLabel;
    slOwnerName: TSkLabel;
    slClientNameSig: TSkLabel;
    rPage2: TRectangle;
    lytPage2: TLayout;
    lytPage2Content: TLayout;
    SkLabel10: TSkLabel;
    btnExport: TCornerButton;
    procedure btnGeneratePDFClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TfPDFCreation.btnGeneratePDFClick(Sender: TObject);
function GetOutputPath: string;
  begin
    {$IF DEFINED(MACOS) and NOT DEFINED(IOS)}
    Result := TPath.GetTempPath;
    {$ELSEIF DEFINED(IOS) or DEFINED(ANDROID)}
    Result := TPath.GetDocumentsPath;
    {$ELSE}
    Result := ExtractFilePath(ParamStr(0));
    {$ENDIF}
    if (Result <> '') and not Result.EndsWith(PathDelim) then
      Result := Result + PathDelim;
  end;

  procedure LayoutToPDFPage(AControl: TControl; const ACanvas: ISkCanvas);
  var
    LBitmap: TBitmap;
    LImage: ISkImage;
    LSceneScale: Single;
  begin
    if AControl.Scene = nil then
      LSceneScale := 1
    else
      LSceneScale := AControl.Scene.GetSceneScale;

    LBitmap := TBitmap.Create(Round(AControl.Width * AControl.AbsoluteScale.X * LSceneScale), Round(AControl.Height * AControl.AbsoluteScale.Y * LSceneScale));
    try
      LBitmap.BitmapScale := LSceneScale;
      LBitmap.Canvas.BeginScene;
      try
        LBitmap.Canvas.Clear(TAlphaColors.Null);
        AControl.PaintTo(LBitmap.Canvas, AControl.LocalRect, nil);
      finally
        LBitmap.Canvas.EndScene;
      end;
      LImage := LBitmap.ToSkImage;
      ACanvas.DrawImage(LImage, 0, 0);
    finally
      LBitmap.Free;
    end;
  end;

var
  LOutputFileName: string;
  LStream: TMemoryStream;
  LDocument: ISkDocument;
  LCanvas: ISkCanvas;
begin
  LOutputFileName := GetOutputPath + 'output.pdf';
  LStream := TMemoryStream.Create;
  try
    LDocument := TSkDocument.MakePDF(LStream);

    // PAGE 1
    LCanvas := LDocument.BeginPage(Round(lytPage1.Width), Round(lytPage1.Height));
    LayoutToPDFPage(lytPage1, LCanvas);
    LDocument.EndPage;

    // PAGE 2
    LCanvas := LDocument.BeginPage(Round(lytPage2.Width), Round(lytPage2.Height));
    LayoutToPDFPage(lytPage2, LCanvas);
    LDocument.EndPage;

    // PAGE 3
    LCanvas := LDocument.BeginPage(Round(lytPage3.Width), Round(lytPage3.Height));
    LayoutToPDFPage(lytPage3, LCanvas);
    LDocument.EndPage;

    // Finalize document
    LDocument.Close;

    // Save to file
    LStream.SaveToFile(LOutputFileName);
    frmPDFViewer.Show(LOutputFileName);

    {$IFDEF MACOS}
    Close;
    ShowMessage('PDF generated successfully!');
    {$ENDIF}
  finally
    LStream.Free;
  end;
end;

end.
