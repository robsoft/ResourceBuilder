unit du_Mainu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Samples.Spin, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TfmMain = class(TForm)
    pnlLeft: TPanel;
    lvIcons: TListBox;
    pnlRight: TPanel;
    lblSample: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtChars: TEdit;
    btnGlypherise: TButton;
    edtSize: TSpinEdit;
    edtResName: TEdit;
    chkAutoSpace: TCheckBox;
    btnTest: TBitBtn;
    chkEnabled: TCheckBox;
    ColorListBox1: TColorListBox;
    Label1: TLabel;
    lblFileName: TLabel;
    lblSizing: TLabel;
    lblIcons: TLabel;
    btnAddToList: TButton;
    lvResources: TListView;
    btnDelete: TButton;
    bntPNG: TButton;
    btnSaveResources: TButton;
    btnMakeRC: TButton;
    btnMakeRes: TButton;
    btnBitmap: TButton;
    procedure edtCharsChange(Sender: TObject);
    procedure chkEnabledClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGlypheriseClick(Sender: TObject);
    procedure lvIconsDblClick(Sender: TObject);
    procedure edtSizeChange(Sender: TObject);
    procedure lvIconsDrawItem(Control: TWinControl; Index: Integer; Rect: TRect;
      State: TOwnerDrawState);
    procedure btnAddToListClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure lvResourcesDblClick(Sender: TObject);
    procedure btnSaveResourcesClick(Sender: TObject);
    procedure btnMakeRCClick(Sender: TObject);
    procedure btnMakeResClick(Sender: TObject);
    procedure lvIconsKeyPress(Sender: TObject; var Key: Char);
    procedure ColorListBox1Click(Sender: TObject);
    procedure edtResNameChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bntPNGClick(Sender: TObject);
    procedure btnBitmapClick(Sender: TObject);
  private
    procedure UpdateLabel;
    procedure LoadIni;
    procedure LoadFile;
    function GetCodes(const AStr: string): string;
    function GetChars(const ACodes: string): string;
    function GetCommandOutput(CommandLine, Work: string): string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

uses
  IniFiles, StrUtils, ShellAPI, System.UITypes, PNGImage;

const
  BASE_FILENAME = 'buttons';
  FA_LOOKUPS = 'fa_lookups.ini';
  TMP_STREAM_BMP = 'tmp.bmp';

procedure TfmMain.btnDeleteClick(Sender: TObject);
begin
  if assigned(lvResources.Selected) then
    lvResources.Items.Delete(lvResources.Selected.Index);
end;

procedure TfmMain.btnGlypheriseClick(Sender: TObject);
var
  FBmp, FNewBmp:TBitmap;
begin
  // make a bitmap for the graphic
  FBmp:=TBitmap.Create;

  FBmp.SetSize(lblSample.Width, lblSample.Height);
  BitBlt(FBmp.Canvas.Handle, 0, 0, lblSample.Width, lblSample.Height, lblSample.Canvas.Handle, 0, 0, SRCCOPY);

  FNewBmp:=TBitmap.Create;
  FNewBmp.Assign(FBmp);
  FNewBmp.SaveToFile(TMP_STREAM_BMP);
  FNewBmp.free;
  FBmp.Free;

  btnTest.Glyph.LoadFromFile(TMP_STREAM_BMP);
end;


procedure TfmMain.btnMakeRCClick(Sender: TObject);
var
  FRC, FDir:string;
  FBmp, bmp2:TBitmap;
  FFile:TextFile;
  i:integer;
begin
  FDir:=ExtractFilePath(Application.ExeName)+'bmps';
  FRC:=ExtractFilePath(Application.ExeName) + BASE_FILENAME + '.rc';
  try
  RemoveDir(FDir);
  except
  end;
  ForceDirectories(FDir);


  lblSample.Font.Size:=edtSize.Value;
  lblSample.Font.Color:=ColorListBox1.Selected;
  edtChars.Text:='';
  lblSample.Refresh;

  DeleteFile(FRC);
  AssignFile(FFile, FRC);
  Rewrite(FFile);
  // make a bitmap for the graphic
  FBmp:=TBitmap.Create;
  for i:=0 to lvResources.Items.Count-1 do
  begin
    edtResName.Text:=lvResources.Items[i].Caption;
    edtChars.Text:=GetChars(lvResources.Items[i].SubItems[0]);
    lblSample.Refresh;
    FBmp.SetSize(lblSample.Width, lblSample.Height);
    BitBlt(FBmp.Canvas.Handle, 0, 0, lblSample.Width, lblSample.Height, lblSample.Canvas.Handle, 0, 0, SRCCOPY);
    bmp2:=TBitmap.Create;
    bmp2.Assign(Fbmp);
    bmp2.PixelFormat := pf8bit;
    bmp2.SaveToFile(FDir+'\'+edtResName.Text+'.bmp');
    bmp2.free;
    Writeln(FFile, edtResName.Text+' BITMAP ".\BMPS\'+edtResName.Text+'.BMP"');
  end;

  CloseFile(FFile);
  FBmp.Free;

  MessageDlg(FRC+' completed.', mtInformation, [mbok], 0);
end;


procedure TfmMain.btnMakeResClick(Sender: TObject);
var
  fres:string;
begin
  FRes:=GetCommandOutput(ExtractFilePath(Application.ExeName)+'brcc32.exe','-v -32 '+BASE_FILENAME+'.rc');
  MessageDlg(FRes, mtinformation, [mbok],0);
  //ShellExecute(0, nil, 'brcc32.exe', '-v -32 accsl_btns.rc', nil, SW_SHOW);
end;

procedure TfmMain.btnSaveResourcesClick(Sender: TObject);
var
  i:integer;
  FFile:string;
begin
  FFile:=ExtractFilePath(Application.ExeName) + BASE_FILENAME+'.ini';
  with TiniFile.Create(FFile) do
  begin
    EraseSection('resources');

    for i:=0 to lvResources.Items.Count-1 do
      WriteString('resources', Uppercase(lvResources.Items[i].Caption),
        lvResources.Items[i].SubItems[0]);
  end;
  MessageDlg(FFile+' updated.', mtInformation, [mbok], 0);
end;

procedure TfmMain.bntPNGClick(Sender: TObject);
var
  FRC, FDir:string;
  FBmp, bmp2:TBitmap;
  FPNG:TPNGImage;
  FFile:TextFile;
  i:integer;
begin
  FDir:=ExtractFilePath(Application.ExeName)+'pngs';
  try
  RemoveDir(FDir);
  except
  end;
  ForceDirectories(FDir);

  lblSample.Font.Size:=edtSize.Value;
  lblSample.Font.Color:=ColorListBox1.Selected;
  pnlRight.ParentBackground:=false;
  pnlRight.ParentColor:=false;

  pnlRight.Color:=clWhite;
  lblSample.Color:=clWhite;
  pnlRight.Refresh;

  edtChars.Text:='';
  lblSample.Refresh;

  // make a bitmap for the graphic
  FBmp:=TBitmap.Create;

  FBmp.TransparentColor:=clWhite;
  FBmp.Transparent:=false;//true;

  for i:=0 to lvResources.Items.Count-1 do
  begin
    edtResName.Text:=lvResources.Items[i].Caption;
    edtChars.Text:=GetChars(lvResources.Items[i].SubItems[0]);
    lblSample.Refresh;
    FBmp.SetSize(lblSample.Width, lblSample.Height);
    BitBlt(FBmp.Canvas.Handle, 0, 0, lblSample.Width, lblSample.Height, lblSample.Canvas.Handle, 0, 0, SRCCOPY);

    FBmp.PixelFormat := pf8bit;

    FPNG:=TPNGImage.Create;
    FPNG.Assign(FBmp);
    FPNG.TransparentColor:=clWhite;
    FPNG.Transparent:=false;//true;
    FPNG.SaveToFile(FDir+'\'+edtResName.Text+'.png');
    FPNG.Free;
  end;

  FBmp.Free;

  MessageDlg('Completed.', mtInformation, [mbok], 0);
end;

procedure TfmMain.btnBitmapClick(Sender: TObject);
var
  FRC, FDir:string;
  FBmp, bmp2:TBitmap;
  FPNG:TPNGImage;
  FFile:TextFile;
  i:integer;
begin
  FDir:=ExtractFilePath(Application.ExeName)+'bmps';
  try
  RemoveDir(FDir);
  except
  end;
  ForceDirectories(FDir);

  lblSample.Font.Size:=edtSize.Value;
  lblSample.Font.Color:=ColorListBox1.Selected;
  pnlRight.ParentBackground:=false;
  pnlRight.ParentColor:=false;

  pnlRight.Color:=clWhite;
  lblSample.Color:=clWhite;
  pnlRight.Refresh;

  edtChars.Text:='';
  lblSample.Refresh;

  // make a bitmap for the graphic
  FBmp:=TBitmap.Create;

  FBmp.TransparentColor:=clWhite;
  FBmp.Transparent:=false;//true;

  for i:=0 to lvResources.Items.Count-1 do
  begin
    edtResName.Text:=lvResources.Items[i].Caption;
    edtChars.Text:=GetChars(lvResources.Items[i].SubItems[0]);
    lblSample.Refresh;
    FBmp.SetSize(lblSample.Width, lblSample.Height);
    BitBlt(FBmp.Canvas.Handle, 0, 0, lblSample.Width, lblSample.Height, lblSample.Canvas.Handle, 0, 0, SRCCOPY);
    FBmp.PixelFormat := pf8bit;
    FBmp.SaveToFile(FDir+'\'+edtResName.Text+'.bmp');
  end;

  FBmp.Free;

  MessageDlg('Completed.', mtInformation, [mbok], 0);
end;

procedure TfmMain.btnAddToListClick(Sender: TObject);
var
  MyItem:TListItem;
  i:integer;
  FName:string;
begin
  // do a replace or new check here
  FName:=uppercase(trim(edtResName.Text));

  MyItem:=nil;
  for i:=0 to lvResources.Items.Count-1 do
    if uppercase(lvResources.Items[i].Caption) = FName then
    begin
      MyItem:=lvResources.Items[i];
      break;
    end;
  if not assigned(MyItem) then
  begin
    MyItem:=lvResources.Items.Add;
    MyItem.SubItems.Add('');
  end;

  MyItem.Caption:=FName;
  MyItem.SubItems[0]:=GetCodes(edtChars.Text);
  lvResources.Selected:=MyItem;

  edtChars.Clear;
  edtResName.Clear;
  edtResName.SetFocus;
end;


function TfmMain.GetCodes(const AStr:string):string;
var
  ch:char;
begin
  // turn into values
  result:='';
  for ch in AStr do
    result:=result+IntToStr(Ord(ch))+',';
  if result<>'' then
    result:=copy(result,1,length(result)-1);
end;

function TfmMain.GetChars(const ACodes:string):string;
var
  slList:TStringList;
  i:integer;
begin
  // break string into sequence of comma separated values
  result:='';
  slList:=TStringList.Create;
  slList.CommaText:=ACodes;
  for i:=0 to slList.Count-1 do
    result:=result+chr(StrToInt(slList[i]));
  slList.Free;
end;

procedure TfmMain.chkEnabledClick(Sender: TObject);
begin
  btnTest.Enabled:=chkEnabled.checked;
end;

procedure TfmMain.ColorListBox1Click(Sender: TObject);
begin
  UpdateLabel;
end;

procedure TfmMain.edtCharsChange(Sender: TObject);
begin
  UpdateLabel;
end;

procedure TfmMain.edtResNameChange(Sender: TObject);
begin
  btnAddToList.Enabled:=length(trim(edtResName.Text))>1;
end;

procedure TfmMain.edtSizeChange(Sender: TObject);
begin
  UpdateLabel;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  Screen.Cursor:=crHourglass;
  LoadIni;
  LoadFile;
  edtChars.Clear;
  edtResName.Clear;
end;

procedure TfmMain.FormShow(Sender: TObject);
begin
  Screen.Cursor:=crDefault;
  edtResName.SetFocus;
end;

procedure TfmMain.UpdateLabel;
begin
  if (edtSize.Value<>lblSample.Font.Size) then
    lblSample.Font.Size:=edtSize.Value;
  if (trim(edtChars.Text)<>lblSample.Caption) then
    lblSample.Caption:=trim(edtChars.Text);
  if (ColorListBox1.Selected<>lblSample.Font.Color) then
    lblSample.Font.Color:=ColorListBox1.Selected;

  lblSizing.Caption:=Format('width %d height %d',[lblSample.width, lblSample.height]);
end;

procedure TfmMain.LoadIni;
var
  slSection:TStringList;
  i:integer;
  FChar, FStr, FName:string;
  FCode:integer;
begin
  lvIcons.Items.Clear;
  slSection:=TStringList.Create;
  with TIniFile.Create(ExtractFilePath(Application.ExeName)+FA_LOOKUPS) do
  begin
    ReadSectionValues('icons',slSection);
  end;

  slSection.Sort;

  for i:=0 to slSection.Count-1 do
  begin
    FStr:=slSection[i];
    FName:=trim(copy(FStr, 1, pos('=',FStr)-1));
    FChar:=uppercase(trim(copy(FStr, pos('=',FStr)+1,length(FStr))));
    if copy(FChar,1,1)<>'F' then FChar:='F'+FChar;;
    FCode:=StrToInt('$'+FChar);

    lvIcons.Items.Add(chr(FCode)+ '-' +FName);
  end;

  slSection.Free;
  lblIcons.Caption:=Format('%d icons (%s)', [lvIcons.Items.Count, FA_LOOKUPS]);
end;

procedure TfmMain.LoadFile;
var
  i:integer;
  slResources:TStringList;
  MyItem:TListItem;
  FFile, FName, FCodes, FStr:string;
begin
  lvResources.Items.Clear;
  slResources:=TStringList.Create;

  FFile:=ExtractFilePath(Application.ExeName) + BASE_FILENAME + '.ini';

  with TiniFile.Create(FFile) do
  begin
    ReadSectionValues('resources', slResources);
    Free;
  end;

  for i:=0 to slResources.Count-1 do
  begin
    FStr:=slResources[i];
    MyItem:=lvResources.Items.Add;
    FName:=trim(copy(FStr, 1, pos('=',FStr)-1));
    FCodes:=trim(copy(FStr, pos('=',FStr)+1,length(FStr)));
    MyItem.Caption:=FName;
    MyItem.SubItems.Add(FCodes);
  end;
  slResources.Free;

  lblFileName.Caption:=FFile;
end;

procedure TfmMain.lvIconsDblClick(Sender: TObject);
begin
  if lvIcons.ItemIndex>=0 then
  begin
    edtChars.Text:=edtChars.Text+copy(lvIcons.Items[lvIcons.ItemIndex],1,1);
    if (chkAutoSpace.Checked) and (length(edtChars.Text)=1) then
      edtChars.Text:=edtChars.Text+' ';

    if trim(edtResName.Text)='' then
      edtResName.Text:=copy(lvIcons.Items[lvIcons.ItemIndex], 3, 255);
  end;
end;

procedure TfmMain.lvIconsDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  FWidth:integer;
  FStr:string;
begin
  with lvIcons.Canvas do
  begin
    FillRect(Rect);  // clear drawing area

    // draw the FA glyph within the first 36 pixels, in super-quality
    Font.Name:='FontAwesome';
    Font.Quality:=fqAntialiased;
    Font.Size:=18;
    FStr:=copy((Control as TListBox).Items[Index],1,1);
    FWidth:=TextWidth(FStr);
    TextOut(Rect.Left + ((36 - FWidth) div 2), Rect.Top, FStr);

    // and now back to regular quality tahoma for the description
    Font.Name:='Tahoma';
    Font.Quality:=fqDefault;
    Font.Size:=8;
    FStr:=copy((Control as TListBox).Items[Index],3,255);
    TextOut(Rect.Left + 38, Rect.Top+6, FStr);
  end;
end;


procedure TfmMain.lvIconsKeyPress(Sender: TObject; var Key: Char);
var
  FKey:string;
  i:integer;
begin
  FKey:=Uppercase(Key);
  if (FKey>='A') and (FKey<='Z') then
  begin
    i:=0;
    while i<lvIcons.Items.Count do
    begin
      if Uppercase(copy(lvIcons.Items[i],3,1))=FKey then break;
      inc(i);
    end;
    if i<lvIcons.Items.Count-1 then
      lvIcons.ItemIndex:=i;
  end;
end;

procedure TfmMain.lvResourcesDblClick(Sender: TObject);
begin
  if not assigned(lvResources.Selected) then exit;

  edtResName.Text:=lvResources.Selected.Caption;
  edtChars.Text:=GetChars(lvResources.Selected.SubItems[0]);
end;



// straight lift from StackOverflow & subsequently hacked-up, life too short
function TfmMain.GetCommandOutput(CommandLine: string; Work: string): string;
var
  SA: TSecurityAttributes;
  SI: TStartupInfo;
  PI: TProcessInformation;
  StdOutPipeRead, StdOutPipeWrite: THandle;
  WasOK: Boolean;
  Buffer: array[0..255] of AnsiChar;
  BytesRead: Cardinal;
  WorkDir: string;
  ThisDir:string;
  Handle: Boolean;
begin
  Result := '';
  with SA do begin
    nLength := SizeOf(SA);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;
  CreatePipe(StdOutPipeRead, StdOutPipeWrite, @SA, 0);
  try
    with SI do
    begin
      FillChar(SI, SizeOf(SI), 0);
      cb := SizeOf(SI);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow := SW_HIDE;
      hStdInput := GetStdHandle(STD_INPUT_HANDLE); // don't redirect stdin
      hStdOutput := StdOutPipeWrite;
      hStdError := StdOutPipeWrite;
    end;
    WorkDir := Work;
    ThisDir:=ExtractFilePath(Application.ExeName);
    Handle := CreateProcess(nil, PChar(CommandLine + ' '+WorkDir),
                            nil, nil, True, 0, nil,
                            PChar(ThisDir), SI, PI);
    CloseHandle(StdOutPipeWrite);
    if Handle then
      try
        repeat
          WasOK := ReadFile(StdOutPipeRead, Buffer, 255, BytesRead, nil);
          if BytesRead > 0 then
          begin
            Buffer[BytesRead] := #0;
            Result := Result + string(Buffer);
          end;
        until not WasOK or (BytesRead = 0);
        WaitForSingleObject(PI.hProcess, INFINITE);
      finally
        CloseHandle(PI.hThread);
        CloseHandle(PI.hProcess);
      end;
  finally
    CloseHandle(StdOutPipeRead);
  end;
end;

end.
