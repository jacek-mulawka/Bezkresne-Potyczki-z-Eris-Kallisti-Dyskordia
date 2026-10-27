unit Wizualizacja__Obiekty__Mapa;{25.Sie.2026}

interface

uses
  GLS.GeomObjects,
  GLS.Material,
  GLS.Objects,
  Stage.Color,

  System.Classes,
  System.SysUtils,

  Definicje;

type
  TMapa_Kratka = class( GLS.Objects.TGLDummyCube )
  private
    { Private declarations }
    id__x__mk,
    id__y__mk
      : integer;

    teren__jednostki__obszar__wykupiony__mk : GLS.GeomObjects.TGLCylinder;

    teren__rodzaj__mk : GLS.Objects.TGLCube;
  public
    { Public declarations }
    constructor Create( AOwner : System.Classes.TComponent );
    destructor Destroy(); override;

    function Id__Porównaj__Mk( const id__x_f, id__y_f : integer ) : boolean;
    procedure Id__Zmieñ__Mk( const id__x_f, id__y_f : integer );
    procedure Teren__Rodzaj__Zmieñ__Mk( const teren__rodzaj_f : integer );
  end;//---//TMapa_Kratka = class

implementation

constructor TMapa_Kratka.Create( AOwner : System.Classes.TComponent );
begin

  inherited Create( AOwner );


  Self.id__x__mk := Definicje.identyfikator_pusty_c;
  Self.id__y__mk := Definicje.identyfikator_pusty_c;
  Self.teren__rodzaj__mk := nil;


  Self.Scale.Z := 0.1;
  Self.Position.Z := Self.Scale.Z * 0.5;
  Self.VisibleAtRunTime := true;

end;//---//Konstruktor klasy TMapa_Kratka.

destructor TMapa_Kratka.Destroy();
begin

  if teren__jednostki__obszar__wykupiony__mk <> nil then
    System.SysUtils.FreeAndNil( Self.teren__jednostki__obszar__wykupiony__mk);

  if Self.teren__rodzaj__mk <> nil then
    System.SysUtils.FreeAndNil( Self.teren__rodzaj__mk );


  inherited;

end;//---//Destruktor klasy TMapa_Kratka.

function TMapa_Kratka.Id__Porównaj__Mk( const id__x_f, id__y_f : integer ) : boolean;
begin

  Result :=
        ( Self.id__x__mk = id__x_f )
    and ( Self.id__y__mk = id__y_f );

end;//---//Funkcja Id__Porównaj__Mk().

procedure TMapa_Kratka.Id__Zmieñ__Mk( const id__x_f, id__y_f : integer );
begin

  Self.id__x__mk := id__x_f;
  Self.id__y__mk := id__y_f;


  Self.Position.X := Self.id__x__mk;
  Self.Position.Y := Self.id__y__mk;

end;//---//Funkcja Id__Zmieñ__Mk().

procedure TMapa_Kratka.Teren__Rodzaj__Zmieñ__Mk( const teren__rodzaj_f : integer );
begin

  if teren__rodzaj_f = Definicje.mapa__teren__dostêpny_c then
    Self.EdgeColor.Color := Stage.Color.clrYellowGreen
  else
  if teren__rodzaj_f = Definicje.mapa__teren__jednostki__obszar_c then
    Self.EdgeColor.Color := Stage.Color.clrGray80
  else
  if teren__rodzaj_f = Definicje.mapa__teren__jednostki__obszar__wykupiony_c then
    begin

      Self.EdgeColor.Color := Stage.Color.clrLightBlue;

      if Self.teren__jednostki__obszar__wykupiony__mk = nil then
        Self.teren__jednostki__obszar__wykupiony__mk := GLS.GeomObjects.TGLCylinder.Create( Self );

      Self.teren__jednostki__obszar__wykupiony__mk.Parent := Self;
      Self.teren__jednostki__obszar__wykupiony__mk.PitchAngle := 90;
      Self.teren__jednostki__obszar__wykupiony__mk.Material.FrontProperties.Diffuse.Color := Self.EdgeColor.Color;

    end
  else//if teren__rodzaj_f = Definicje.mapa__teren__jednostki__obszar__wykupiony_c then
  if teren__rodzaj_f = Definicje.mapa__teren__niedostêpny_c then
    begin

      Self.EdgeColor.Color := Stage.Color.clrCopper;

      if Self.teren__rodzaj__mk = nil then
        Self.teren__rodzaj__mk := GLS.Objects.TGLCube.Create( Self );

      Self.teren__rodzaj__mk.Parent := Self;
      Self.teren__rodzaj__mk.Material.FrontProperties.Diffuse.Color := Self.EdgeColor.Color;

    end
  else//if teren__rodzaj_f = Definicje.mapa__teren__niedostêpny_c then
  if teren__rodzaj_f = Definicje.dominium__numer__gracz__1_c then
    begin

      Self.EdgeColor.Color := Definicje.kolor__dominium__1_c;


      //if Self.teren__rodzaj__mk = nil then
      //  Self.teren__rodzaj__mk := GLS.Objects.TGLCube.Create( Self );
      //
      //Self.teren__rodzaj__mk.Parent := Self;
      //Self.teren__rodzaj__mk.Material.BlendingMode := GLS.Material.bmCustom; // bmCustom bmModulate bmTransparency
      //Self.teren__rodzaj__mk.Material.FrontProperties.Diffuse.Color := Self.EdgeColor.Color;
      //Self.teren__rodzaj__mk.Material.FrontProperties.Diffuse.Alpha := 0.15;

    end
  else//if teren__rodzaj_f = Definicje.dominium__numer__gracz__1_c then
  if teren__rodzaj_f = Definicje.dominium__numer__gracz__2_c then
    begin

      Self.EdgeColor.Color := Definicje.kolor__dominium__2_c;


      //if Self.teren__rodzaj__mk = nil then
      //  Self.teren__rodzaj__mk := GLS.Objects.TGLCube.Create( Self );
      //
      //Self.teren__rodzaj__mk.Parent := Self;
      //Self.teren__rodzaj__mk.Material.BlendingMode := GLS.Material.bmCustom; // bmCustom bmModulate bmTransparency
      //Self.teren__rodzaj__mk.Material.FrontProperties.Diffuse.Color := Self.EdgeColor.Color;
      //Self.teren__rodzaj__mk.Material.FrontProperties.Diffuse.Alpha := 0.15;

    end
  else//if teren__rodzaj_f = Definicje.dominium__numer__gracz__2_c then
    Self.EdgeColor.Color := Stage.Color.clrWhite;


  if    ( teren__rodzaj_f <> Definicje.mapa__teren__niedostêpny_c )
    //and ( teren__rodzaj_f <> Definicje.dominium__numer__gracz__1_c )
    //and ( teren__rodzaj_f <> Definicje.dominium__numer__gracz__2_c )
    and ( Self.teren__rodzaj__mk <> nil ) then
    System.SysUtils.FreeAndNil( Self.teren__rodzaj__mk );

end;//---//Funkcja Teren__Rodzaj__Zmieñ__Mk().

end.
