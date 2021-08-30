unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TeEngine, Series, ExtCtrls, TeeProcs, Chart, ComCtrls,Math;
const  VPI=3.14159265358979323846;
       //3,14159265358979323846
       LH0=0.0000000001;
       PRECISION=0.0000000001;
       MAX_BETA=1000000000;
       DEFAULT_MAX=10;
       DEFAULT_MIN=0;
       DEFAULT_DELTA=0.001;
       DEFAULT_R=3;
       DEFAULT_L0=10;
       DEFAULT_BETA=0.01;

       DEFAULT_WIDTH=640;
       DEFAULT_HEIGHT=480;
type

TResultFunction=record
   x: real;
   y: real;
   count: integer;
   exist: boolean;
  end;

//---------------------------------------------------------------------------

TProduceFunction=class(TList)
private
      FMaxValue: real;
      FMinValue: real;
      FDelta: real;
      FFunctionValues: TList;

      function GetDelta: real;
      procedure SetDelta(AValue: real);
      procedure OnChangeValue;

      function IsValid(AValue: real): boolean;

      function GetMaxValue: real;
      procedure SetMaxValue(AValue: real);
      function GetMinValue: real;
      procedure SetMinValue(AValue: real);

      function GetFunctionValues: TList;
      function AddValue(Item:real): integer;
public
      procedure OnCalcValues; virtual;
      constructor Create(AMax,AMin,ADelta:real); overload;
      constructor Create; overload;
      destructor Destroy; override;
published
     property FunctionValues: TList read GetFunctionValues;
     property MaxValue: real read GetMaxValue write SetMaxValue;
     property MinValue: real read GetMinValue write SetMinValue;
     property Delta: real read GetDelta write SetDelta;
end;


//---------------------------------------------------------------------------

TProduceFunctionPula=class(TProduceFunction)
private
      Fr: real;
      Fl0: real;
      FBeta: real;
      procedure OnCalcValues; override;
      function GetR: real;
      procedure SetR(AValue: real);
      function GetL0: real;
      procedure SetL0(AValue: real);
      function GetBeta: real;
      procedure SetBeta(AValue: real);
      function Calc_FI(ABeta: real): real;
      function Calc_Newton(u: real;direction: integer;var cnt: integer;var betan: real): boolean;
public
      constructor Create(AR,AL0,ABeta,AMax,AMin,ADelta: real); overload;
      constructor Create; overload;
      destructor Destroy; override;
published
     property RFunction: real read GetR write SetR;
     property L0Function: real read GetL0 write SetL0;
     property BetaFunction: real read GetBeta write SetBeta;
end;


//---------------------------------------------------------------------------

TFactoryScaler2d=class(TObject)
private
      FWidth,FHeight: integer;
      FPFunction: TList;
      FPoint: TPoint;
      FRfunc: TResultFunction;
      function GetWidth: integer;
      procedure SetWidth(AValue: integer);
      function GetHeight: integer;
      procedure SetHeight(AValue: integer);
      function GetCountFunctions: integer;
      function GetCountFunctionItems(Item: integer): integer;
      function GetFunction(findex: integer): TProduceFunction;
      function GetPointFunction(findex,pindex: integer): TResultFunction;
      function GetPointFunctionScale(findex,pindex:integer): TPoint;

      function GetScaleFactor(fmin,fmax: double;SourceScal: integer): real;

protected
      FScaleP,FScaleM: real;
      pmin,pmax,mmin,mmax: real;
public
      function AddFunction(Item: TProduceFunction): integer;
      procedure ClearFunctions;
      procedure OnCalcScaler;
      constructor Create(AWidth,AHeight: integer); overload;
      property CountFunctionItems[Item: integer]: integer read GetCountFunctionItems;
      property ProduceFunction[findex: integer]: TProduceFunction read GetFunction;
      property PointFunction[findex,pindex: integer]: TResultFunction read GetPointFunction;
      property PointFunctionScale[findex,pindex: integer]: TPoint read GetPointFunctionScale;
      constructor Create; overload;
      destructor Destroy; override;
published
     property Width: integer read GetWidth write SetWidth;
     property Height: integer read GetHeight write SetHeight;
     property CountFunctions: integer read GetCountFunctions;
end;

//---------------------------------------------------------------------------

TGraficFunction2d=class(TFactoryScaler2d)
private
      FCanvas: TCanvas;
      FAxisXDiv,FAxisYDiv: integer;
      FPrecisionDiv: boolean;
      FTerminalDiv: boolean;
      function CalcZone: integer;
      procedure SetCanvas(AValue: TCanvas);
      function GetAxisXDiv: integer;
      procedure SetAxisXDiv(AValue: integer);
      function GetAxisYDiv: integer;
      procedure SetAxisYDiv(AValue: integer);

      function GetPrecisionDiv: boolean;
      procedure SetPrecisionDiv(AValue: boolean);
      function GetTerminalDiv: boolean;
      procedure SetTerminalDiv(AValue: boolean);


      procedure DrawAxisY(y1,y2,x: integer);
      procedure DrawDivAxisY(y1,y2,x: integer);
      procedure DrawDivAxisYTerm(x,precision: integer;AValue: real);
      procedure DrawAxisX(x1,x2,y: integer);
      procedure DrawDivAxisX(x1,x2,y: integer);
      procedure DrawDivAxisXTerm(y,precision: integer;AValue: real);
      procedure DrawDiv(x,y,precision: integer;DValue: real;AxisX: boolean);

      function GetPrecisionDivAxis(AValue: real): integer;
      function GetStepDivAxis(fmin,fmax: real; CntDiv: integer): real;
      function GetAxisCount(fmin,fmax: real; CntDiv: real): integer;
      procedure DrawText(x,y:integer;DValue: String);
public
      FOffset: TPoint;
      procedure UpdateGrafics;
      procedure DrawAxis;
      constructor Create(AOfsset: TPoint;AWidth,AHeight: integer); overload;
      constructor Create; overload;
      destructor Destroy; override;
published
     property Canvas: TCanvas write SetCanvas;
     property AxisXDiv: integer read GetAxisXDiv write SetAxisXDiv;
     property AxisYDiv: integer read GetAxisYDiv write SetAxisYDiv;
     property PrecisionDiv: boolean read GetPrecisionDiv write SetPrecisionDiv;
     property TerminalDiv: boolean read GetTerminalDiv write SetTerminalDiv;

end;

//---------------------------------------------------------------------------

  TForm1 = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Button3: TButton;
    Edit3: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit5: TEdit;
    Edit4: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Edit8: TEdit;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Image1: TImage;
    Edit9: TEdit;
    procedure Button3Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit4Exit(Sender: TObject);
    procedure Edit5Exit(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Edit6Exit(Sender: TObject);
    procedure Edit7Exit(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Edit8Exit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel2Resize(Sender: TObject);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Edit8KeyPress(Sender: TObject; var Key: Char);
    procedure Edit6KeyPress(Sender: TObject; var Key: Char);
    procedure Edit7KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
        pfr: TProduceFunctionPula;
        sc: TGraficFunction2d;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


//===========================================================================
//===========================================================================

function TProduceFunction.IsValid(AValue: real): boolean;
begin
    if (AValue>=FMinValue) and (AValue<=FMaxValue) then result:=true
    else result:=false;
end;

//---------------------------------------------------------------------------
function TProduceFunction.GetMaxValue: real;
begin
    result:=FMaxValue;
end;

//---------------------------------------------------------------------------
function TProduceFunction.GetMinValue: real;
begin
    result:=FMinValue;
end;

//---------------------------------------------------------------------------
function TProduceFunction.AddValue(Item: real): integer;
var
    temp: ^real;
begin
    New(temp);
    temp^:=Item;
    if IsValid(Item) then result:=Add(temp)
    else Raise Exception.Create('Параметр в TVectorValues.AddValue имеет недопустимое значение !');
end;

//---------------------------------------------------------------------------
procedure TProduceFunction.SetMaxValue(AValue: real);
begin
    FMaxValue:=AValue;
    OnChangeValue;
end;

//---------------------------------------------------------------------------
procedure TProduceFunction.SetMinValue(AValue: real);
begin
    FMinValue:=AValue;
    OnChangeValue;
end;

//===========================================================================
//===========================================================================


procedure TProduceFunction.OnChangeValue;
var
   i,cnt: integer;
   l: real;
begin
   if Count<>0 then
   begin
     for i:=0 to Count-1 do Dispose(Items[i]);
     Clear;
   end;
   if Abs(FDelta)>LH0 then
   begin
     cnt:=Trunc(Abs(MaxValue-MinValue)/FDelta);
     l:=MinValue;
     for i:=0 to cnt do
     begin
         AddValue(l);
         l:=l+FDelta;
     end;
     OnCalcValues;
   end;
end;

//---------------------------------------------------------------------------

function TProduceFunction.GetDelta: real;
begin
    result:=FDelta;
end;

//---------------------------------------------------------------------------
procedure TProduceFunction.SetDelta(AValue: real);
begin
    if (AValue<0) Or (Abs(AValue)<LH0) then
    begin
       FDelta:=DEFAULT_DELTA;
       Raise Exception.Create('Дельта имеет недопустимое значение !');
    end
    else FDelta:=AValue;
    OnChangeValue;
end;

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

function TProduceFunction.GetFunctionValues: TList;
begin
   result:=FFunctionValues;
end;

//---------------------------------------------------------------------------

procedure TProduceFunction.OnCalcValues;
begin

end;

//---------------------------------------------------------------------------

constructor TProduceFunction.Create(AMax,AMin,ADelta: real);
begin
  try
     FDelta:=ADelta;
     FMaxValue:=AMax;
     FMinValue:=AMin;
     FFunctionValues:=TList.Create;
     OnChangeValue;
  except
     Raise;
  end;
end;

//---------------------------------------------------------------------------
constructor TProduceFunction.Create;
begin
  inherited;
  try
     FMaxValue:=DEFAULT_MAX;
     FMinValue:=DEFAULT_MIN;
     FFunctionValues:=TList.Create;
     OnChangeValue;
  except
     Raise;
  end;
end;

//---------------------------------------------------------------------------
destructor TProduceFunction.Destroy;
var
   i: integer;
begin
   if Count<>0 then
   begin
     for i:=0 to Count-1 do Dispose(Items[i]);
     Clear;
   end;
   if FFunctionValues.Count<>0 then
   begin
     for i:=0 to FFunctionValues.Count-1 do Dispose(FFunctionValues.Items[i]);
     FFunctionValues.Clear;
   end;
   FFunctionValues.Free;
   inherited;
end;


//===========================================================================
//===========================================================================


procedure TProduceFunctionPula.SetR(AValue: real);
begin
   if AValue<=LH0 then
   begin
       Fr:=DEFAULT_R;
       Raise Exception.Create('Неправильные значение радиуса R !');
   end
   else Fr:=AValue;
   OnCalcValues;
end;

//---------------------------------------------------------------------------
function TProduceFunctionPula.GetR: real;
begin
    result:=Fr;
 end;

//---------------------------------------------------------------------------

procedure TProduceFunctionPula.SetL0(AValue: real);
begin
   try
      if AValue<=LH0 then
      begin
          Fl0:=DEFAULT_L0;
          Raise Exception.Create('Неправильные значение растояния до окружности L0 !');
      end
      else Fl0:=AValue;
      OnCalcValues;
   except
      Raise;
   end;
end;

//---------------------------------------------------------------------------
function TProduceFunctionPula.GetL0: real;
begin
    result:=Fl0;
end;

//---------------------------------------------------------------------------

procedure TProduceFunctionPula.SetBeta(AValue: real);
begin
   try
      if Abs(AValue) > (2*VPI) then
      begin
          FBeta:=DEFAULT_BETA;
          Raise Exception.Create('Неправильные значение растояния начального угла beta !');
      end
      else FBeta:=AValue;
      OnCalcValues;
   except
      Raise;
   end;
end;

//---------------------------------------------------------------------------
function TProduceFunctionPula.GetBeta: real;
begin
    result:=FBeta;
end;


//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
function TProduceFunctionPula.Calc_FI(ABeta: real): real;
var
  b: real;
begin
  b:=2*RFunction*(RFunction+L0Function);
  result:=sqrt(b*(1-cos(ABeta))+L0Function*L0Function);
end;
//---------------------------------------------------------------------------
function TProduceFunctionPula.Calc_Newton(u: real;direction: integer;var cnt: integer;var betan: real): boolean;
var
   a: real;
   b: real;
   betanold: real;
   errold: real;
   err: real;
   i: integer;
begin
   a:=u/RFunction;
   b:=2*RFunction*(RFunction+L0Function);
   betanold:=0;
   errold:=MAX_BETA;
   err:=MAX_BETA;
   result:=False;
   for i:=0 to 1000  do
   //while True do
   begin
      betanold:=betan;
      betan:=betan-(2*betan*Calc_FI(betan)-direction*2*a*Calc_FI(betan)*Calc_FI(betan))/(2*Calc_FI(betan)-direction*a*b*sin(betan));
      if betan>MAX_BETA then break;
      errold:=err;
      err:=Abs(betanold-betan);
      if (err<PRECISION) and (errold>err) then
      begin
         result:=True;
         break;
      end;
   end;
   if result=True then
   begin
     betan:=betan*360/(2*VPI);
     cnt:=0;
     if Abs(betan)>360 then
     begin
        cnt:=Trunc(betan/360);
        betan:=betan-cnt*360;
        cnt:=Abs(cnt);
     end;
   end
   else betan:=0;
end;
//---------------------------------------------------------------------------

procedure TProduceFunctionPula.OnCalcValues;
var
  i: integer;
  PValue: ^real;
  temp: ^TResultFunction;
  betan: real;
  cnt: integer;
begin
  if FunctionValues<>NIL then
  begin
     if FunctionValues.Count<>0 then
     begin
       for i:=0 to FunctionValues.Count-1 do Dispose(FunctionValues.Items[i]);
       FunctionValues.Clear;
     end;
     for i:=0 to Count-1 do
     begin
       PValue:=Items[i];
       New(temp);
       temp.x:=PValue^;
       betan:=BetaFunction;
       cnt:=0;
       temp.exist:=Calc_Newton(PValue^,1,cnt,betan);
       temp.y:=betan;
       temp.count:=cnt;
       FFunctionValues.Add(temp);
       New(temp);
       temp.x:=PValue^;
       betan:=BetaFunction;
       cnt:=0;
       temp.exist:=Calc_Newton(PValue^,-1,cnt,betan);
       temp.y:=betan;
       temp.count:=cnt;
       FFunctionValues.Add(temp);
     end;
  end;
end;

//---------------------------------------------------------------------------

constructor TProduceFunctionPula.Create(AR,AL0,ABeta,AMax,AMin,ADelta: real);
begin
  try
     FFunctionValues:=TList.Create;
     Fr:=AR;
     Fl0:=AL0;
     FBeta:=ABeta;
     inherited Create(AMax,AMin,ADelta);
     OnCalcValues;
  except
     Raise;
  end;
end;

//---------------------------------------------------------------------------
constructor TProduceFunctionPula.Create;
begin
  try
     FFunctionValues:=TList.Create;
     Fr:=DEFAULT_R;
     Fl0:=DEFAULT_L0;
     FBeta:=DEFAULT_BETA;
     inherited;
     OnCalcValues;
  except
     Raise;
  end;
end;

//---------------------------------------------------------------------------
destructor TProduceFunctionPula.Destroy;
var
   i: Integer;
begin
   if Count<>0 then
   begin
     for i:=0 to Count-1 do Dispose(Items[i]);
     Clear;
   end;
   if FFunctionValues.Count<>0 then
   begin
     for i:=0 to FFunctionValues.Count-1 do Dispose(FFunctionValues.Items[i]);
     FFunctionValues.Clear;
   end;
   FFunctionValues.Free;
   inherited;
end;

//===========================================================================
//===========================================================================

function TFactoryScaler2d.GetWidth: integer;
begin
   result:=FWidth;
end;

//---------------------------------------------------------------------------

function TFactoryScaler2d.GetHeight: integer;
begin
   result:=FHeight;
end;

//---------------------------------------------------------------------------

procedure TFactoryScaler2d.SetWidth(AValue: integer);
begin
   if AValue>0 then FWidth:=AValue
   else
   begin
       FWidth:=DEFAULT_WIDTH;
       Raise Exception.Create('Неправильные значение Width !');
   end;
   OnCalcScaler;
end;

//---------------------------------------------------------------------------

procedure TFactoryScaler2d.SetHeight(AValue: integer);
begin
   if AValue>0 then FHeight:=AValue
   else
   begin
       FHeight:=DEFAULT_HEIGHT;
       Raise Exception.Create('Неправильные значение Height !');
   end;
   OnCalcScaler;
end;

//---------------------------------------------------------------------------
constructor TFactoryScaler2d.Create(AWidth,AHeight: integer);
begin
   FPFunction:=TList.Create;
   if AWidth>0 then FWidth:=AWidth
   else
   begin
       FWidth:=DEFAULT_WIDTH;
       Raise Exception.Create('Неправильные значение Width !');
   end;
   if AHeight>0 then FHeight:=AHeight
   else
   begin
       FHeight:=DEFAULT_HEIGHT;
       Raise Exception.Create('Неправильные значение Height !');
   end;
   OnCalcScaler;
end;

//---------------------------------------------------------------------------
constructor TFactoryScaler2d.Create;
begin
   inherited;
   FPFunction:=TList.Create;
   FWidth:=DEFAULT_WIDTH;
   FHeight:=DEFAULT_HEIGHT;
   OnCalcScaler;
end;
//---------------------------------------------------------------------------
destructor TFactoryScaler2d.Destroy;
begin
   FPFunction.Clear;
   OnCalcScaler;
   inherited;
end;

//---------------------------------------------------------------------------
function TFactoryScaler2d.AddFunction(Item: TProduceFunction): integer;
begin
   result:=FPFunction.Add(Item);
   OnCalcScaler;
end;

//---------------------------------------------------------------------------
procedure TFactoryScaler2d.ClearFunctions;
begin
    FPFunction.Clear;
    OnCalcScaler;
end;

//---------------------------------------------------------------------------
function TFactoryScaler2d.GetCountFunctions: integer;
begin
    result:=FPFunction.Count;
end;

//---------------------------------------------------------------------------
function TFactoryScaler2d.GetCountFunctionItems(Item: integer): integer;
var
  temp: TProduceFunction;
begin
   result:=-1;
   if (Item>=0) And (Item<FPFunction.Count) then
   begin
     temp:=FPFunction.Items[Item];
     result:=temp.FunctionValues.Count;
   end
   else Raise Exception.Create('Неправильные значение GetCountFunctionItems !');
end;

//---------------------------------------------------------------------------
function TFactoryScaler2d.GetFunction(findex: integer): TProduceFunction;
begin
   if (findex>=0) And (findex<FPFunction.Count) then
   begin
     result:=FPFunction.Items[findex];
   end
   else Raise Exception.Create('Неправильные значение findex в GetFunction !');
end;

//---------------------------------------------------------------------------
function TFactoryScaler2d.GetPointFunction(findex,pindex: integer): TResultFunction;
var
  temp: TProduceFunction;
  gettemp: ^TResultFunction;
begin
   if (findex>=0) And (findex<FPFunction.Count) then
   begin
     temp:=FPFunction.Items[findex];
     if (pindex>=0) And (pindex<temp.FunctionValues.Count) then
     begin
       gettemp:=temp.FunctionValues.Items[pindex];
       FRfunc.x:=gettemp.x;
       FRfunc.y:=gettemp.y;
       FRfunc.exist:=gettemp.exist;
       FRfunc.count:=gettemp.count;
       result:=FRfunc;
     end
     else Raise Exception.Create('Неправильные значение pindex в GetPointFunction !');
   end
   else Raise Exception.Create('Неправильные значение findex в GetPointFunction !');
end;

//---------------------------------------------------------------------------
function TFactoryScaler2d.GetPointFunctionScale(findex,pindex: integer): TPoint;
var
  temp: TProduceFunction;
  gettemp: ^TResultFunction;
begin
   if (findex>=0) And (findex<FPFunction.Count) then
   begin
     temp:=FPFunction.Items[findex];
     if (pindex>=0) And (pindex<temp.FunctionValues.Count) then
     begin
       gettemp:=temp.FunctionValues.Items[pindex];
       if pmin<0 then FPoint.x:=trunc(Abs(pmin*FScaleP))+trunc(gettemp.x*FScaleP)
       else FPoint.x:=trunc(gettemp.x*FScaleP);
       if mmin<0 then FPoint.y:=trunc(Abs(mmin*FScaleM))+trunc(gettemp.y*FScaleM)
       else FPoint.y:=trunc(gettemp.y*FScaleM);
       FPoint.y:=Height-FPoint.y;
       result:=FPoint;
     end
     else Raise Exception.Create('Неправильные значение pindex в GetPointFunctionScale !');
   end
   else Raise Exception.Create('Неправильные значение findex в GetPointFunctionScale !');
end;

//---------------------------------------------------------------------------
function TFactoryScaler2d.GetScaleFactor(fmin,fmax: double;SourceScal: integer): real;
begin
      result:=1;
      if(Abs(fmax-fmin)>0) then
      begin
           if fmin>=0 then result:=SourceScal/fmax
           else
           begin
             if fmax<0 then result:=SourceScal/Abs(fmin)
             else result:=SourceScal/Abs(fmax-fmin);
           end;
      end;
end;

//---------------------------------------------------------------------------
procedure TFactoryScaler2d.OnCalcScaler;
var
   i,j: integer;
   temp: TProduceFunction;
   gettemp: ^TResultFunction;
begin
   pmin:=0;
   pmax:=0;
   mmin:=0;
   mmax:=0;
   if FPFunction.Count<>0 then
   begin
      for i:=0 to FPFunction.Count-1 do
      begin
            temp:=FPFunction.Items[i];
            for j:=0 to temp.FunctionValues.Count-1 do
            begin
               gettemp:=temp.FunctionValues.Items[j];
               if gettemp.x>pmax then pmax:=gettemp.x;
               if gettemp.x<pmin then pmin:=gettemp.x;
               if gettemp.y>mmax then mmax:=gettemp.y;
               if gettemp.y<mmin then mmin:=gettemp.y;
            end;
      end;
      FScaleP:=GetScaleFactor(pmin,pmax,FWidth);
      FScaleM:=GetScaleFactor(mmin,mmax,FHeight);
   end;
end;


//===========================================================================
//===========================================================================

procedure TGraficFunction2d.SetCanvas(AValue: TCanvas);
begin
   FCanvas:=AValue;
   UpdateGrafics;
end;

//---------------------------------------------------------------------------
constructor TGraficFunction2d.Create(AOfsset: TPoint;AWidth,AHeight: integer);
begin
     inherited Create(AWidth,AHeight);
     FPrecisionDiv:=true;
     FTerminalDiv:=true;
     FAxisYDiv:=5;
     FAxisXDiv:=5;
     FOffset:=AOfsset;
     UpdateGrafics;
end;

//---------------------------------------------------------------------------
constructor TGraficFunction2d.Create;
begin
     FOffset.x:=0;
     FOffset.y:=0;
     FPrecisionDiv:=true;
     FTerminalDiv:=true;
     FAxisYDiv:=5;
     FAxisXDiv:=5;
     UpdateGrafics;
end;

//---------------------------------------------------------------------------
destructor TGraficFunction2d.Destroy;
begin
   inherited;
end;

//---------------------------------------------------------------------------
procedure TGraficFunction2d.DrawText(x,y:integer;DValue: String);
begin
        FCanvas.Font.Name:='Courier New';
        FCanvas.Font.Size:=10;
        if FOffset.x+x-10+Length(DValue)*FCanvas.Font.Size>FOffset.x+Width then
               FCanvas.TextOut(FOffset.x+x-10-Length(DValue)*FCanvas.Font.Size,FOffset.y+y-20,DValue)
        else
               FCanvas.TextOut(FOffset.x+x+10,FOffset.y+y-20,DValue);
end;

//---------------------------------------------------------------------------
procedure TGraficFunction2d.UpdateGrafics;
var
   clr: TColor;
   i,j: integer;
   p: TPoint;
   p1: TResultFunction;
begin
   OnCalcScaler;
   if FCanvas<>NIL then
   begin
      FCanvas.FillRect(FCanvas.ClipRect);
      DrawAxis;
      if CountFunctions<>0 then
      begin
         clr:=FCanvas.Pen.Color;
         for i:=0 to CountFunctions-1 do
         begin
            for j:=0 to CountFunctionItems[i]-1 do
            begin
                  p1:=PointFunction[i,j];
                  if p1.exist=True then
                  begin
                      p:=PointFunctionScale[i,j];
                      FCanvas.Pen.Width:=2;
                      FCanvas.Ellipse(FOffset.x+p.x-1,FOffset.y+p.y-1,FOffset.x+p.x+1,FOffset.y+p.y+1);
//                      DrawText(FOffset.x+trunc(p.x),FOffset.y+trunc(p.y),IntToStr(p1.count));
                  end;
            end;
         end;
         FCanvas.Pen.Color:=clr;
      end;
   end;

end;

//---------------------------------------------------------------------------
function TGraficFunction2d.CalcZone: integer;
begin
   if pmax<0 then
   begin
     if mmax<0 then result:=3
     else
     begin
       if mmin<0 then result:=7
       else result:=1;
     end
   end
   else
   begin
     if pmin<0 then
     begin
        if mmax<0 then result:=6
        else
        begin
           if mmin<0 then result:=9
           else result:=5;
        end;
     end
     else
     begin
        if mmax<0 then result:=4
        else
        begin
           if mmin<0 then result:=8
           else result:=2;
        end;
     end;
   end;
end;

//---------------------------------------------------------------------------
procedure TGraficFunction2d.DrawAxis;
begin
    case CalcZone of
       1:
       begin
          DrawAxisY(0,Height,Width);
          DrawAxisX(0,Width,Height);
       end;
       2:
       begin
          DrawAxisY(0,Height,0);
          DrawAxisX(0,Width,Height);
       end;
       3:
       begin
          DrawAxisY(0,Height,Width);
          DrawAxisX(0,Width,0);
       end;
       4:
       begin
          DrawAxisY(0,Height,0);
          DrawAxisX(0,Width,0);
       end;
       5:
       begin
          DrawAxisY(0,Height,trunc(Abs(pmin*FScaleP)));
          DrawAxisX(0,Width,Height);
       end;
       6:
       begin
          DrawAxisY(0,Height,trunc(Abs(pmin*FScaleP)));
          DrawAxisX(0,Width,0);
       end;
       7:
       begin
          DrawAxisY(0,Height,Width);
          DrawAxisX(0,Width,Height-trunc(Abs(mmin*FScaleM)));
       end;
       8:
       begin
          DrawAxisY(0,Height,0);
          DrawAxisX(0,Width,Height-trunc(Abs(mmin*FScaleM)));
       end;
       9:
       begin
          DrawAxisY(0,Height,trunc(Abs(pmin*FScaleP)));
          DrawAxisX(0,Width,Height-trunc(Abs(mmin*FScaleM)));
       end;
     end;
end;

//---------------------------------------------------------------------------
procedure TGraficFunction2d.DrawAxisY(y1,y2,x: integer);
begin
     FCanvas.Pen.Width:=1;
     FCanvas.MoveTo(FOffset.x+x,FOffset.y+y1);
     FCanvas.LineTo(FOffset.x+x,FOffset.y+y2);
     DrawDivAxisY(y1,y2,x);
end;

//---------------------------------------------------------------------------
procedure TGraficFunction2d.DrawAxisX(x1,x2,y: integer);
begin
     FCanvas.Pen.Width:=1;
     FCanvas.MoveTo(FOffset.x+x1,FOffset.y+y);
     FCanvas.LineTo(FOffset.x+x2,FOffset.y+y);
     DrawDivAxisX(x1,x2,y);
end;

//---------------------------------------------------------------------------
function TGraficFunction2d.GetAxisXDiv: integer;
begin
   result:=FAxisXDiv;
end;
//---------------------------------------------------------------------------
procedure TGraficFunction2d.SetAxisXDiv(AValue: integer);
begin
    FAxisXDiv:=AValue;
    UpdateGrafics;
end;

//---------------------------------------------------------------------------
function TGraficFunction2d.GetAxisYDiv: integer;
begin
   result:=FAxisYDiv;
end;
//---------------------------------------------------------------------------
procedure TGraficFunction2d.SetAxisYDiv(AValue: integer);
begin
    FAxisYDiv:=AValue;
    UpdateGrafics;
end;

//---------------------------------------------------------------------------
function TGraficFunction2d.GetPrecisionDiv: boolean;
begin
   result:=FPrecisionDiv;
end;

//---------------------------------------------------------------------------
procedure TGraficFunction2d.SetPrecisionDiv(AValue: boolean);
begin
    FPrecisionDiv:=AValue;
    UpdateGrafics;
end;

//---------------------------------------------------------------------------
function TGraficFunction2d.GetTerminalDiv: boolean;
begin
   result:=FTerminalDiv;
end;

//---------------------------------------------------------------------------
procedure TGraficFunction2d.SetTerminalDiv(AValue: boolean);
begin
    FTerminalDiv:=AValue;
    UpdateGrafics;
end;


//---------------------------------------------------------------------------
procedure TGraficFunction2d.DrawDiv(x,y,precision: integer;DValue: real;AxisX: boolean);
var
   fmt: String;
begin
        fmt:=FloatToStrF(DValue,ffFixed,4,precision);
        FCanvas.Font.Name:='Courier New';
        FCanvas.Font.Size:=6;
        if not AxisX then
        begin
           if Abs(pmax)>=Abs(pmin) then
           begin
             FCanvas.TextOut(FOffset.x+x+10,FOffset.y+y-10,fmt);
             FCanvas.MoveTo(FOffset.x+x,FOffset.y+y);
             FCanvas.LineTo(FOffset.x+x+5,FOffset.y+y);
           end
           else
           begin
             FCanvas.TextOut(FOffset.x+x-10-Length(fmt)*FCanvas.Font.Size,FOffset.y+y-10,fmt);
             FCanvas.MoveTo(FOffset.x+x-5,FOffset.y+y);
             FCanvas.LineTo(FOffset.x+x,FOffset.y+y);
           end
        end
        else
        begin
           if Abs(mmax)<=Abs(mmin) then
           begin
              FCanvas.TextOut(FOffset.x+x-10,FOffset.y+y+10,fmt);
              FCanvas.MoveTo(FOffset.x+x,FOffset.y+y);
              FCanvas.LineTo(FOffset.x+x,FOffset.y+y+5);
           end
           else
           begin
              FCanvas.TextOut(FOffset.x+x-10,FOffset.y+y-10-FCanvas.Font.Size,fmt);
              FCanvas.MoveTo(FOffset.x+x,FOffset.y+y-5);
              FCanvas.LineTo(FOffset.x+x,FOffset.y+y);
           end;
        end;
end;

//---------------------------------------------------------------------------
procedure TGraficFunction2d.DrawDivAxisXTerm(y,precision: integer;AValue: real);
var
   temp: real;
begin
      if pmin<0 then temp:=Abs(pmin*FScaleP)+AValue*FScaleP
      else temp:=AValue*FScaleP;
      if (AValue>=pmin) And (AValue<=pmax) then DrawDiv(trunc(temp),y,precision,AValue,true);
end;

//---------------------------------------------------------------------------
procedure TGraficFunction2d.DrawDivAxisYTerm(x,precision: integer;AValue: real);
var
     temp: real;
begin
     if mmin<0 then temp:=Abs(mmin*FScaleM)+AValue*FScaleM
     else temp:=AValue*FScaleM;
     temp:=Height-temp;
     if (AValue>=mmin) And (AValue<=mmax) then DrawDiv(x,trunc(temp),precision,AValue,false);
end;

//---------------------------------------------------------------------------
function TGraficFunction2d.GetStepDivAxis(fmin,fmax: real; CntDiv: integer): real;
begin
   result:=0;
   if fmin>=0 then result:=fmax/CntDiv
   else
   begin
      if fmax<0 then result:=Abs(fmin/CntDiv)
      else result:=(fmax-fmin)/CntDiv;
   end;
end;

//---------------------------------------------------------------------------
function TGraficFunction2d.GetAxisCount(fmin,fmax: real; CntDiv: real): integer;
begin
   result:=0;
   if fmin>=0 then result:=trunc(fmax/CntDiv)
   else
   begin
      if fmax<0 then result:=trunc(Abs(fmin/CntDiv))
      else result:=trunc((fmax-fmin)/CntDiv);
   end;
end;

//---------------------------------------------------------------------------
function TGraficFunction2d.GetPrecisionDivAxis(AValue: real): integer;
var
    l: integer;
    res: real;
begin
     l:=0;
     res:=AValue;
     result:=0;
     while res<1 do
     begin
         res:=SimpleRoundTo(AValue,(-1)*l);
         res:=res*Power(10,l);
         l:=l+1;
     end;
     if l>0 then result:=l-1;
end;
//---------------------------------------------------------------------------
procedure TGraficFunction2d.DrawDivAxisY(y1,y2,x: integer);
var
   mas : array of real;
   i,index,precision,axd: integer;
   tmp,temp: real;
begin
   axd:=FAxisYDiv;
   temp:=GetStepDivAxis(mmin,mmax,FAxisYDiv);
   if not FPrecisionDiv then
   begin
      precision:=GetPrecisionDivAxis(temp);
      tmp:=SimpleRoundTo(temp,(-1)*precision);
      if tmp<temp then
      begin
         if GetAxisCount(mmin,mmax,tmp)<=FAxisYDiv then temp:=tmp
         else temp:=2*tmp;
      end
      else temp:=tmp;
      axd:=GetAxisCount(mmin,mmax,temp);
      if axd<FAxisYDiv then axd:=axd+1;
   end
   else precision:=2;
   SetLength(mas,axd);
   if(mmin>=0) then for i:=0 to axd-1 do mas[i]:=i*temp
   else
   begin
       if mmax<0 then for i:=0 to axd-1 do mas[i]:=i*temp
       else
       begin
          index:=trunc(mmin/temp);
          tmp:=index*temp;
          for i:=0 to axd-1 do mas[i]:=tmp+i*temp;
       end;
   end;

   for i:=0 to axd-1 do DrawDivAxisYTerm(x,precision,mas[i]);
   if FTerminalDiv then
   begin
     DrawDivAxisYTerm(x,precision,mmin);
     DrawDivAxisYTerm(x,precision,mmax);
   end;
   if mmin<0 then temp:=Abs(mmin*FScaleM)+mmin*FScaleM
   else temp:=mmin*FScaleM;
   temp:=Height-temp;
   FCanvas.TextOut(FOffset.X+x-10,FOffset.Y+trunc(temp)-10,'B,y');
   if mmin<0 then temp:=Abs(mmin*FScaleM)+mmax*FScaleM
   else temp:=mmax*FScaleM;
   temp:=Height-temp;
   FCanvas.TextOut(FOffset.X+x-10,FOffset.Y+trunc(temp)-10,'B,y');
   Finalize(mas);
end;

//---------------------------------------------------------------------------
procedure TGraficFunction2d.DrawDivAxisX(x1,x2,y: integer);
var
   mas : array of real;
   i,index,precision,axd: integer;
   tmp,temp: real;
begin
  axd:=FAxisXDiv;
  temp:=GetStepDivAxis(pmin,pmax,FAxisXDiv);

  if not FPrecisionDiv then
   begin
      precision:=GetPrecisionDivAxis(temp);
      tmp:=SimpleRoundTo(temp,(-1)*precision);
      if tmp<temp then
      begin
         if GetAxisCount(pmin,pmax,tmp)<=FAxisXDiv then temp:=tmp
         else temp:=2*tmp;
      end
      else temp:=tmp;
      axd:=GetAxisCount(pmin,pmax,temp);
      if axd<FAxisXDiv then axd:=axd+1;
   end
   else precision:=2;
   SetLength(mas,axd);
   if pmin>=0 then for i:=0 to axd-1 do mas[i]:=i*temp
   else
   begin
       if pmax<0 then for i:=0 to axd-1 do mas[i]:=i*temp
       else
       begin
          index:=trunc(pmin/temp);
          tmp:=index*temp;
          for i:=0 to axd-1 do mas[i]:=tmp+i*temp;
       end;
   end;

   for i:=0 to axd-1 do DrawDivAxisXTerm(y,precision,mas[i]);
   if FTerminalDiv then
   begin
     DrawDivAxisXTerm(y,precision,pmin);
     DrawDivAxisXTerm(y,precision,pmax);
   end;
   if pmin<0 then temp:=Abs(pmin*FScaleP)+pmin*FScaleP
   else temp:= pmin*FScaleP;
   FCanvas.TextOut(FOffset.X+trunc(temp)-10,FOffset.Y+y-20,'U,x');
   if pmin<0 then temp:=Abs(pmin*FScaleP)+pmax*FScaleP
   else temp:= pmax*FScaleP;
   FCanvas.TextOut(FOffset.X+trunc(temp)-10,FOffset.Y+y-20,'U,x');
   Finalize(mas);
end;

//---------------------------------------------------------------------------

procedure TForm1.Button1Click(Sender: TObject);
begin
   ShowMessage(IntToStr(Image1.Width));
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
   Edit1.Enabled:=true;
   Edit2.Enabled:=true;
   Edit3.Enabled:=true;
   Edit4.Enabled:=true;
   Edit5.Enabled:=true;
   Edit6.Enabled:=true;
   Edit7.Enabled:=true;
   CheckBox1.Enabled:=true;
   CheckBox2.Enabled:=true;
   sc.Canvas:=Image1.Canvas;
   Edit6.Text:=IntToStr(sc.AxisXDiv);
   Edit7.Text:=IntToStr(sc.AxisYDiv);
   CheckBox1.Checked:=sc.PrecisionDiv;
   CheckBox2.Checked:=sc.TerminalDiv;
   sc.UpdateGrafics;
   Button3.Enabled:=False;
   Edit4.SetFocus;
end;


procedure TForm1.CheckBox1Click(Sender: TObject);
begin
   if CheckBox1.Checked then sc.PrecisionDiv:=true
   else sc.PrecisionDiv:=false;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
   if CheckBox2.Checked then sc.TerminalDiv:=true
   else sc.TerminalDiv:=false;
end;

procedure TForm1.Edit1Exit(Sender: TObject);
var
  t: real;
begin
    if Edit1.Modified then
    begin
       try
          t:=StrToFloat(Edit1.Text);
          pfr.L0Function:=t;
          sc.UpdateGrafics;
       except
         ShowMessage('Неверное значение расстояния до окружности !');
         Edit1.SetFocus;
       end;
    end;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  begin
    SelectNext(ActiveControl,True,True);
  end;
end;

procedure TForm1.Edit2Exit(Sender: TObject);
var
  t: real;
begin
    if Edit2.Modified then
    begin
      try
         t:=StrToFloat(Edit2.Text);
         pfr.Delta:=t;
         sc.UpdateGrafics;
      except
         ShowMessage('Неверное значение шага дискретизации отношения скоростей !');
         Edit2.SetFocus;
      end;
    end;
end;

procedure TForm1.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  begin
    SelectNext(ActiveControl,True,True);
  end;
end;

procedure TForm1.Edit3Exit(Sender: TObject);
var
  t: real;
begin
    if Edit3.Modified then
    begin
      try
         t:=StrToFloat(Edit3.Text);
         pfr.RFunction:=t;
         sc.UpdateGrafics;
      except
         ShowMessage('Неверное значение радиуса окружности !');
         Edit3.SetFocus;
      end;
    end;
end;

procedure TForm1.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  begin
    SelectNext(ActiveControl,True,True);
  end;
end;

procedure TForm1.Edit4Exit(Sender: TObject);
var
  t: real;
begin
    if Edit4.Modified then
    begin
      try
         t:=StrToFloat(Edit4.Text);
         pfr.MinValue:=t;
         sc.UpdateGrafics;
      except
         ShowMessage('Неверное значение минимального отношения скоростей !');
         Edit4.SetFocus;
      end;
    end;
end;

procedure TForm1.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  begin
    SelectNext(ActiveControl,True,True);
  end;
end;

procedure TForm1.Edit5Exit(Sender: TObject);
var
  t: real;
begin
    if Edit5.Modified then
    begin
      try
         t:=StrToFloat(Edit5.Text);
         pfr.MaxValue:=t;
         sc.UpdateGrafics;
      except
         ShowMessage('Неверное значение максимального отношения скоростей !');
         Edit5.SetFocus;
      end;
    end;
end;

procedure TForm1.Edit5KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  begin
    SelectNext(ActiveControl,True,True);
  end;
end;

procedure TForm1.Edit6Exit(Sender: TObject);
var
  t: integer;
begin
    if Edit6.Modified then
    begin
      try
         t:=StrToInt(Edit6.Text);
         sc.AxisXDiv:=t;
         sc.UpdateGrafics;
      except
         ShowMessage('Неверное значение делений по X !');
         Edit6.SetFocus;
      end;
    end;
end;

procedure TForm1.Edit6KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  begin
    SelectNext(ActiveControl,True,True);
  end;
end;

procedure TForm1.Edit7Exit(Sender: TObject);
var
  t: integer;
begin
   if Edit7.Modified then
   begin
     try
         t:=StrToInt(Edit7.Text);
         sc.AxisYDiv:=t;
         sc.UpdateGrafics;
     except
         ShowMessage('Неверное значение делений по Y !');
         Edit7.SetFocus;
     end;
   end;
end;

procedure TForm1.Edit7KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  begin
    SelectNext(ActiveControl,True,True);
  end;
end;

procedure TForm1.Edit8Exit(Sender: TObject);
var
  t: real;
begin
    if Edit8.Modified then
    begin
      try
         t:=StrToFloat(Edit8.Text);
         pfr.BetaFunction:=t*2*VPI/360;
         sc.UpdateGrafics;
      except
         ShowMessage('Неверное значение начального угла beta !');
         Edit8.SetFocus;
      end;
    end;
end;

procedure TForm1.Edit8KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  begin
    SelectNext(ActiveControl,True,True);
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
var
   pnt: TPoint;
begin
   pnt.X:=40;
   pnt.Y:=40;
   pfr:=TProduceFunctionPula.Create(3,10,0,10,0,0.001);
   Edit4.Text:=FloatToStr(pfr.MinValue);
   Edit5.Text:=FloatToStr(pfr.MaxValue);
   Edit2.Text:=FloatToStr(pfr.Delta);
   Edit1.Text:=FloatToStr(pfr.L0Function);
   Edit3.Text:=FloatToStr(pfr.RFunction);
   Edit8.Text:=FloatToStr(pfr.BetaFunction);
   sc:=TGraficFunction2d.Create(pnt,Image1.Width-50,Image1.Height-50);
   sc.AddFunction(pfr);

   pnt.X:=20;
   pnt.Y:=20;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
   aPoint: TPoint;
   i,j,l: integer;
   p: TPoint;
   p1: TResultFunction;
   f: TProduceFunction;
   err: real;
begin
  inherited;
  l:=0;
  Image1.ShowHint := False;
  if sc.CountFunctions<>0 then
  begin
         for i:=0 to sc.CountFunctions-1 do
         begin
            f:=sc.ProduceFunction[i];
            err:=f.Delta-Int(f.Delta);
            if err>0 then
            begin
              l:=1;
              While True do
              begin
                  err:=err*10;
                  if (err-Int(err))=0 then break;
                  inc(l);
              end;
            end;
            for j:=0 to sc.CountFunctionItems[i]-1 do
            begin
                  Application.ProcessMessages;
                  p1:=sc.PointFunction[i,j];
                  if p1.exist=True then
                  begin
                      p:=sc.PointFunctionScale[i,j];
                      if (X>=(sc.FOffset.x+p.x-1)) and (X<=(sc.FOffset.x+p.x+1)) and (Y>=(sc.FOffset.y+p.y-1)) and (Y<=(sc.FOffset.y+p.y+1)) then
                      begin
                         Image1.Hint := 'U='+FloatToStr(SimpleRoundTo(p1.x, -1*l))+';Beta='+FloatToStr(p1.y)+';Count='+IntToStr(p1.count);
                         Image1.ShowHint := True;
                         aPoint.X := X;
                         aPoint.Y := Y;
                         aPoint := ClientToScreen(aPoint);
                         Application.ActivateHint(aPoint);
                         exit;
                      end;
                  end;
            end;
         end;
  end;
end;

procedure TForm1.Panel2Resize(Sender: TObject);
begin
   if Assigned(sc) then
   begin
     sc.Width:=Panel2.Width-50;
     sc.Height:=Panel2.Height-50;
     sc.UpdateGrafics;
   end;
end;

//---------------------------------------------------------------------------





end.
