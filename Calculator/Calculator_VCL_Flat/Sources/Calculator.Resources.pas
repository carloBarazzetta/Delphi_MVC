unit Calculator.Resources;

interface

uses
  System.SysUtils, System.Classes, Vcl.BaseImageCollection, Vcl.ImageCollection;

resourcestring
  UNEXPECTED_ERROR = 'Unexpected Error!';
  DIVISION_BY_ZERO = 'Division by zero';
  INVALID_SQUARE_ROOT = 'Invalid square root';

type
  TdmResources = class(TDataModule)
    ImageCollection: TImageCollection;
    procedure DataModuleCreate(Sender: TObject);
  private
    FIniFileName: TFileName;
  public
    //Variabili che contengono i valori letti dal file .ini
    Application_Theme: string;
    MainFormPos_Left, MainFormPos_Top, MainFormPos_Width, MainFormPos_Height: Integer;
    procedure LoadInifile(const AIniFileName: TFileName);
    procedure SaveInifile;
  end;

var
  dmResources: TdmResources;

implementation

uses
  System.Inifiles;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmResources }

procedure TdmResources.DataModuleCreate(Sender: TObject);
begin
  //Read application configuration
  LoadInifile(ChangeFileExt(GetModuleName(HInstance),'.ini'));
end;

procedure TdmResources.LoadInifile(const AIniFileName: TFileName);
begin
  FIniFileName := AIniFileName;
  var LIniFile := TIniFile.Create(FIniFileName);
  try
    Application_Theme := LIniFile.ReadString('Application', 'Theme', 'Windows10');
    MainFormPos_Left := LIniFile.ReadInteger('MainFormPosition', 'Left', 100);
    MainFormPos_Top  := LIniFile.ReadInteger('MainFormPosition', 'Top', 100);
    MainFormPos_Width := LIniFile.ReadInteger('MainFormPosition', 'Width', 330);
    MainFormPos_Height := LIniFile.ReadInteger('MainFormPosition', 'Height', 450);
  finally
    LIniFile.Free;
  end;
end;

procedure TdmResources.SaveInifile;
begin
  var LIniFile := TIniFile.Create(FIniFileName);
  try
    LIniFile.WriteString('Application', 'Theme', Application_Theme);
    LIniFile.WriteInteger('MainFormPosition', 'Left', MainFormPos_Left);
    LIniFile.WriteInteger('MainFormPosition', 'Top', MainFormPos_Top);
    LIniFile.WriteInteger('MainFormPosition', 'Width', MainFormPos_Width);
    LIniFile.WriteInteger('MainFormPosition', 'Height', MainFormPos_Height);
  finally
    LIniFile.Free;
  end;
end;

end.
