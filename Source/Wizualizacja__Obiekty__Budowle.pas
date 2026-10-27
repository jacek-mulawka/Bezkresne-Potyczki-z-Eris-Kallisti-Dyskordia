unit Wizualizacja__Obiekty__Budowle;{26.Sie.2026}

interface

uses
  GLS.GeomObjects,
  GLS.Material,
  GLS.Objects,
  GLS.ParticleFX,
  GLS.Scene,
  GLS.ThorFX,
  Stage.Color,
  Stage.Coordinates,

  System.Classes,
  System.SysUtils,
  Winapi.Windows,

  Definicje;

type
  TWizualizacja_Obiekt = class( GLS.Objects.TGLDummyCube )
  private
    { Private declarations }
    id__wo : integer;

    wytrzyma³oœæ_punkty__aktualne__wo,
    wytrzyma³oœæ_punkty__ca³kowite__wo
      : real;

    wytrzyma³oœæ_punkty__wskaŸnik__wielkoœæ__wo : single;

    przynale¿noœæ__kolor__wo : GLS.GeomObjects.TGLTorus;

    wytrzyma³oœæ_punkty__wskaŸnik__oœ__wo,
    wytrzyma³oœæ_punkty__wskaŸnik__wo
      : GLS.GeomObjects.TGLCylinder;
  public
    { Public declarations }
    constructor Create( AOwner : System.Classes.TComponent; const id_f : integer );
    destructor Destroy(); override;

    function Id__Odczytaj__Wo() : integer;
    function Id__Porównaj__Wo( const id_f : integer ) : boolean;

    procedure Przynale¿noœæ__Zmieñ__Wo( const dominium__numer_f : smallint );

    procedure Wytrzyma³oœæ_Punkty__Wartoœæ__Zmieñ__Wo( const wartoœæ_f : real );
  end;//---//TWizualizacja_Obiekt = class

  TWizualizacja__Budowla = class( Wizualizacja__Obiekty__Budowle.TWizualizacja_Obiekt )
  private
    { Private declarations }
    budowla__rodzaj__wbu : Definicje.TBudowla_Rodzaj;

    animacja__kierunek_powrót__wbu : boolean;

    animacja__oczekiwanie__wbu : integer;

    animacja__wspó³rzêdna_pocz¹tkowa__wbu : single;

    budowla_gl_dummy_cube__wbu,
    efekt__atak_gl_dummy_cube__wbu,
    efekt__obra¿enia_gl_dummy_cube__wbu
      : GLS.Objects.TGLDummyCube;

    animacja_gl_scene_object : GLS.Scene.TGLSceneObject;
  public
    { Public declarations }
    constructor Create( AOwner : System.Classes.TComponent; const dominium__numer_f : smallint; const id_f : integer; const budowla__rodzaj_f : Definicje.TBudowla_Rodzaj; const wytrzyma³oœæ_punkty__ca³kowite_f : real );
    destructor Destroy(); override;

    procedure Animacja__Wbu( const gra_wspó³czynnik_prêdkoœci_f : single );
    function Budowla__Rodzaj__Odczytaj__Wbu() : Definicje.TBudowla_Rodzaj;

    procedure Efekt__Atak__Zmieñ__Wbu( const aktywny_f : boolean; const atak__cel__wspó³rzêdna__y_f : integer = 0; const atak__cel__wspó³rzêdna__x_f : integer = 0 );
    procedure Efekt__Obra¿enia__Zmieñ__Wbu( const aktywny_f : boolean );
  end;//---//TWizualizacja__Budowla = class

  TWizualizacja__Surowiec = class( Wizualizacja__Obiekty__Budowle.TWizualizacja_Obiekt )
  private
    { Private declarations }
    surowiec__rodzaj__wsu : Definicje.TSurowiec_Rodzaj;

    domki__iloœæ__1__wsu,
    domki__iloœæ__2__wsu
      : GLS.Objects.TGLSphere;

    surowiec_gl_dummy_cub__wsu : GLS.Objects.TGLDummyCube;
  public
    { Public declarations }
    constructor Create( AOwner : System.Classes.TComponent; const id_f : integer; const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj );
    destructor Destroy(); override;

    procedure Domki__Iloœæ__Zmieñ__Wsu( const iloœæ_f : integer );
  end;//---//TWizualizacja__Surowiec = class

implementation

uses
  Wizualizacja__Efekty_Udostepnij;

constructor TWizualizacja_Obiekt.Create( AOwner : System.Classes.TComponent; const id_f : integer );
begin

  inherited Create( AOwner );


  Self.id__wo := id_f;
  Self.wytrzyma³oœæ_punkty__aktualne__wo := 0;
  Self.wytrzyma³oœæ_punkty__ca³kowite__wo := 0;

  Self.przynale¿noœæ__kolor__wo := GLS.GeomObjects.TGLTorus.Create( Self );
  Self.przynale¿noœæ__kolor__wo.Parent := Self;
  Self.przynale¿noœæ__kolor__wo.Position.Z := Self.CubeSize * 0.5;
  Self.przynale¿noœæ__kolor__wo.MinorRadius := Self.CubeSize * 0.03;

  Self.wytrzyma³oœæ_punkty__wskaŸnik__wo := GLS.GeomObjects.TGLCylinder.Create( Self );
  Self.wytrzyma³oœæ_punkty__wskaŸnik__wo.Parent := Self;
  Self.wytrzyma³oœæ_punkty__wskaŸnik__wo.BottomRadius := Self.CubeSize * 0.03;
  Self.wytrzyma³oœæ_punkty__wskaŸnik__wo.Height := Self.CubeSize * 0.5;
  Self.wytrzyma³oœæ_punkty__wskaŸnik__wielkoœæ__wo := Self.wytrzyma³oœæ_punkty__wskaŸnik__wo.Height;
  Self.wytrzyma³oœæ_punkty__wskaŸnik__wo.Material.FrontProperties.Diffuse.Color := Definicje.kolor__budowla__wytrzyma³oœæ_punkty__wskaŸnik_c;
  Self.wytrzyma³oœæ_punkty__wskaŸnik__wo.Position.Z := -Self.CubeSize * 0.5;
  Self.wytrzyma³oœæ_punkty__wskaŸnik__wo.RollAngle := 90;
  Self.wytrzyma³oœæ_punkty__wskaŸnik__wo.TopRadius := Self.wytrzyma³oœæ_punkty__wskaŸnik__wo.BottomRadius;

  Self.wytrzyma³oœæ_punkty__wskaŸnik__oœ__wo := GLS.GeomObjects.TGLCylinder.Create( Self );
  Self.wytrzyma³oœæ_punkty__wskaŸnik__oœ__wo.Parent := Self;
  Self.wytrzyma³oœæ_punkty__wskaŸnik__oœ__wo.BottomRadius := Self.wytrzyma³oœæ_punkty__wskaŸnik__wo.BottomRadius * 0.5;
  Self.wytrzyma³oœæ_punkty__wskaŸnik__oœ__wo.Height := Self.wytrzyma³oœæ_punkty__wskaŸnik__wo.Height * 0.999;
  Self.wytrzyma³oœæ_punkty__wskaŸnik__oœ__wo.Material.FrontProperties.Diffuse.Color := Stage.Color.clrWhite;
  Self.wytrzyma³oœæ_punkty__wskaŸnik__oœ__wo.Position.Z := Self.wytrzyma³oœæ_punkty__wskaŸnik__wo.Position.Z;
  Self.wytrzyma³oœæ_punkty__wskaŸnik__oœ__wo.RollAngle := Self.wytrzyma³oœæ_punkty__wskaŸnik__wo.RollAngle;
  Self.wytrzyma³oœæ_punkty__wskaŸnik__oœ__wo.TopRadius := Self.wytrzyma³oœæ_punkty__wskaŸnik__oœ__wo.BottomRadius;


  Self.Przynale¿noœæ__Zmieñ__Wo( Definicje.dominium__numer__puste_c );
  Self.Wytrzyma³oœæ_Punkty__Wartoœæ__Zmieñ__Wo( Self.wytrzyma³oœæ_punkty__ca³kowite__wo );

end;//---//Konstruktor klasy TWizualizacja_Obiekt.

destructor TWizualizacja_Obiekt.Destroy();
begin

  if Self.przynale¿noœæ__kolor__wo <> nil then
    System.SysUtils.FreeAndNil( Self.przynale¿noœæ__kolor__wo );

  if Self.wytrzyma³oœæ_punkty__wskaŸnik__wo <> nil then
    System.SysUtils.FreeAndNil( Self.wytrzyma³oœæ_punkty__wskaŸnik__wo );

  if Self.wytrzyma³oœæ_punkty__wskaŸnik__oœ__wo <> nil then
    System.SysUtils.FreeAndNil( Self.wytrzyma³oœæ_punkty__wskaŸnik__oœ__wo );

  inherited;

end;//---//Destruktor klasy TWizualizacja_Obiekt.

function TWizualizacja_Obiekt.Id__Odczytaj__Wo() : integer;
begin

  Result := Self.id__wo;

end;//---//Funkcja Id__Odczytaj__Wo().

function TWizualizacja_Obiekt.Id__Porównaj__Wo( const id_f : integer ) : boolean;
begin

  Result := Self.id__wo = id_f;

end;//---//Funkcja Id__Porównaj__Wo().

procedure TWizualizacja_Obiekt.Przynale¿noœæ__Zmieñ__Wo( const dominium__numer_f : smallint );
var
  zt_gs_color_vector : Stage.Color.TGSColorVector;
begin

  if dominium__numer_f = Definicje.dominium__numer__gracz__1_c then
    begin

      zt_gs_color_vector:= Definicje.kolor__dominium__1_c;

    end
  else//if dominium__numer_f = Definicje.dominium__numer__gracz__1_c then
  if dominium__numer_f = Definicje.dominium__numer__gracz__2_c then
    begin

      zt_gs_color_vector:= Definicje.kolor__dominium__2_c;

    end
  else//if dominium__numer_f = Definicje.dominium__numer__gracz__2_c then
    begin

      zt_gs_color_vector:= Definicje.kolor__dominium__brak_c;

    end;
  //---//if dominium__numer_f = Definicje.dominium__numer__gracz__2_c then


  Self.przynale¿noœæ__kolor__wo.Material.FrontProperties.Diffuse.Color := zt_gs_color_vector;

end;//---//Funkcja Przynale¿noœæ__Zmieñ__Wo().

procedure TWizualizacja_Obiekt.Wytrzyma³oœæ_Punkty__Wartoœæ__Zmieñ__Wo( const wartoœæ_f : real );
var
  ztr : real;
begin

  Self.wytrzyma³oœæ_punkty__aktualne__wo := wartoœæ_f;

  if Self.wytrzyma³oœæ_punkty__aktualne__wo < 0 then
    Self.wytrzyma³oœæ_punkty__aktualne__wo := 0;


  if Self.wytrzyma³oœæ_punkty__ca³kowite__wo = 0 then
    ztr := 0
  else//if Self.wytrzyma³oœæ_punkty__ca³kowite__wo = 0 then
    ztr :=
        100
      * Self.wytrzyma³oœæ_punkty__aktualne__wo
      / Self.wytrzyma³oœæ_punkty__ca³kowite__wo;


  Self.wytrzyma³oœæ_punkty__wskaŸnik__wo.Visible := ztr <> 0;
  Self.wytrzyma³oœæ_punkty__wskaŸnik__oœ__wo.Visible := Self.wytrzyma³oœæ_punkty__wskaŸnik__wo.Visible;

  Self.wytrzyma³oœæ_punkty__wskaŸnik__wo.Height := Self.wytrzyma³oœæ_punkty__wskaŸnik__wielkoœæ__wo * ztr * 0.01;

end;//---//Funkcja Wytrzyma³oœæ_Punkty__Wartoœæ__Zmieñ__Wo().

constructor TWizualizacja__Budowla.Create( AOwner : System.Classes.TComponent; const dominium__numer_f : smallint; const id_f : integer; const budowla__rodzaj_f : Definicje.TBudowla_Rodzaj; const wytrzyma³oœæ_punkty__ca³kowite_f : real );
var
  i,
  zti
    : integer;

  ztsi : single;

  zt_gs_coordinates : Stage.Coordinates.TGSCoordinates;

  zt_gl_scene_object : GLS.Scene.TGLSceneObject;

  zt_gl_dummy_cube__efekt : GLS.Objects.TGLDummyCube;
begin

  inherited Create( AOwner, id_f );


  Self.animacja_gl_scene_object := nil;
  Self.animacja__kierunek_powrót__wbu := false;
  Self.animacja__oczekiwanie__wbu := 0;
  Self.animacja__wspó³rzêdna_pocz¹tkowa__wbu := 0;
  Self.budowla__rodzaj__wbu := budowla__rodzaj_f;
  Self.wytrzyma³oœæ_punkty__ca³kowite__wo := wytrzyma³oœæ_punkty__ca³kowite_f;
  Self.wytrzyma³oœæ_punkty__aktualne__wo := Self.wytrzyma³oœæ_punkty__ca³kowite__wo;
  Self.Wytrzyma³oœæ_Punkty__Wartoœæ__Zmieñ__Wo( Self.wytrzyma³oœæ_punkty__ca³kowite__wo );

  Self.budowla_gl_dummy_cube__wbu := GLS.Objects.TGLDummyCube.Create( Self );
  Self.budowla_gl_dummy_cube__wbu.Parent := Self;

  Self.efekt__atak_gl_dummy_cube__wbu := GLS.Objects.TGLDummyCube.Create( Self );
  Self.efekt__atak_gl_dummy_cube__wbu.Parent := Self.budowla_gl_dummy_cube__wbu;

  Self.efekt__obra¿enia_gl_dummy_cube__wbu := GLS.Objects.TGLDummyCube.Create( Self );
  Self.efekt__obra¿enia_gl_dummy_cube__wbu.Parent := Self.budowla_gl_dummy_cube__wbu;


  if Wizualizacja__Efekty_Udostepnij.Ogieñ() <> nil then
    with GLS.ParticleFX.GetOrCreateSourcePFX( Self.efekt__obra¿enia_gl_dummy_cube__wbu ) do
      begin

        Manager := Wizualizacja__Efekty_Udostepnij.Ogieñ();
        EffectScale := 0.25;

      end;
    //---//with GLS.ParticleFX.GetOrCreateSourcePFX( Self.efekt__obra¿enia_gl_dummy_cube__wbu ) do


  if Self.budowla__rodzaj__wbu = Definicje.br_domek then
    begin

      Self.budowla_gl_dummy_cube__wbu.RollAngle := Random( 360 );


      GLS.Objects.TGLCube(zt_gl_scene_object) := GLS.Objects.TGLCube.Create( Self );
      GLS.Objects.TGLCube(zt_gl_scene_object).Parent := Self.budowla_gl_dummy_cube__wbu;
      GLS.Objects.TGLCube(zt_gl_scene_object).CubeDepth := Self.CubeSize * 0.15;
      GLS.Objects.TGLCube(zt_gl_scene_object).CubeHeight := GLS.Objects.TGLCube(zt_gl_scene_object).CubeDepth * 2;
      GLS.Objects.TGLCube(zt_gl_scene_object).CubeWidth := GLS.Objects.TGLCube(zt_gl_scene_object).CubeHeight;
      GLS.Objects.TGLCube(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color := Stage.Color.clrKhaki;
      GLS.Objects.TGLCube(zt_gl_scene_object).Position.X := -Self.CubeSize * 0.2;
      GLS.Objects.TGLCube(zt_gl_scene_object).Position.Y := GLS.Objects.TGLCube(zt_gl_scene_object).Position.X;
      GLS.Objects.TGLCube(zt_gl_scene_object).Position.Z := Self.CubeSize * 0.5 - GLS.Objects.TGLCube(zt_gl_scene_object).CubeDepth * 0.5;


      ztsi := GLS.Objects.TGLCube(zt_gl_scene_object).CubeDepth;
      zt_gs_coordinates := GLS.Objects.TGLCube(zt_gl_scene_object).Position;


      for i := 1 to 3 do
        begin

          //   1
          // 2 3

          zt_gl_scene_object := GLS.Objects.TGLCube.Create( Self );
          GLS.Objects.TGLCube(zt_gl_scene_object).Parent := Self.budowla_gl_dummy_cube__wbu;
          GLS.Objects.TGLCube(zt_gl_scene_object).CubeDepth := ztsi;
          GLS.Objects.TGLCube(zt_gl_scene_object).CubeHeight := Self.CubeSize * 0.05;
          GLS.Objects.TGLCube(zt_gl_scene_object).CubeWidth := GLS.Objects.TGLCube(zt_gl_scene_object).CubeHeight;
          GLS.Objects.TGLCube(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color := Stage.Color.clrWhite;

          if i in [ 1, 3 ] then
            zti := -1
          else//if i in [ 1, 3 ] then
            zti := 1;

          GLS.Objects.TGLCube(zt_gl_scene_object).Position.X := zti * zt_gs_coordinates.X;

          if i in [ 1 ] then
            zti := 1
          else//if i in [ 1 ] then
            zti := -1;

          GLS.Objects.TGLCube(zt_gl_scene_object).Position.Y := zti * zt_gs_coordinates.Y;
          GLS.Objects.TGLCube(zt_gl_scene_object).Position.Z := Self.CubeSize * 0.5 - GLS.Objects.TGLCube(zt_gl_scene_object).CubeDepth * 0.5;

        end;
      //---//for i := 1 to 3 do


      GLS.GeomObjects.TGLFrustrum(zt_gl_scene_object) := GLS.GeomObjects.TGLFrustrum.Create( Self );
      GLS.GeomObjects.TGLFrustrum(zt_gl_scene_object).Parent := Self.budowla_gl_dummy_cube__wbu;
      GLS.GeomObjects.TGLFrustrum(zt_gl_scene_object).Height := ztsi * 0.2;
      GLS.GeomObjects.TGLFrustrum(zt_gl_scene_object).BaseDepth := Self.CubeSize * 0.7;
      GLS.GeomObjects.TGLFrustrum(zt_gl_scene_object).BaseWidth := GLS.GeomObjects.TGLFrustrum(zt_gl_scene_object).BaseDepth;
      GLS.GeomObjects.TGLFrustrum(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color := Stage.Color.clrDustyRose;
      GLS.GeomObjects.TGLFrustrum(zt_gl_scene_object).PitchAngle := 90;
      GLS.GeomObjects.TGLFrustrum(zt_gl_scene_object).Position.Z := Self.CubeSize * 0.5 - GLS.GeomObjects.TGLFrustrum(zt_gl_scene_object).Height * 0.5 - ztsi * 0.5;


      //Self.animacja_gl_scene_object := zt_gl_scene_object;
      //Self.animacja__oczekiwanie__wbu := Random( 1300 );
      //Self.animacja__wspó³rzêdna_pocz¹tkowa__wbu := 0;


      if Wizualizacja__Efekty_Udostepnij.Œwiat³a_Wie¿( dominium__numer_f ) <> nil then
        begin

          zt_gl_dummy_cube__efekt := GLS.Objects.TGLDummyCube.Create( Self );
          zt_gl_dummy_cube__efekt.Parent := zt_gl_scene_object;
          zt_gl_dummy_cube__efekt.Position.Y := ztsi * 0.5;

          with GLS.ParticleFX.GetOrCreateSourcePFX( GLS.GeomObjects.TGLCylinder(zt_gl_dummy_cube__efekt) ) do
            begin

              Manager := Wizualizacja__Efekty_Udostepnij.Œwiat³a_Wie¿( dominium__numer_f );
              EffectScale := Wizualizacja__Efekty_Udostepnij.Œwiat³a_Wie¿( dominium__numer_f ).Friction * 0.5;

            end;
          //---//with GLS.ParticleFX.GetOrCreateSourcePFX( GLS.GeomObjects.TGLCylinder(zt_gl_scene_object) ) do

        end;
      //---//if Wizualizacja__Efekty_Udostepnij.Œwiat³a_Wie¿( dominium__numer_f ) <> nil then

    end
  else//if Self.budowla__rodzaj__wbu = Definicje.br_domek then
  if Self.budowla__rodzaj__wbu = Definicje.br_koszary then
    begin

      GLS.Objects.TGLSphere(zt_gl_scene_object) := GLS.Objects.TGLSphere.Create( Self );
      GLS.Objects.TGLSphere(zt_gl_scene_object).Parent := Self.budowla_gl_dummy_cube__wbu;
      GLS.Objects.TGLSphere(zt_gl_scene_object).Radius := Self.CubeSize * 0.4;
      GLS.Objects.TGLSphere(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color := Stage.Color.clrOldGold;
      GLS.Objects.TGLSphere(zt_gl_scene_object).Position.Z := Self.CubeSize * 0.5;

    end
  else//if Self.budowla__rodzaj__wbu = Definicje.br_koszary then
  if Self.budowla__rodzaj__wbu = Definicje.br_wie¿a__obronna then
    begin

      GLS.GeomObjects.TGLCone(zt_gl_scene_object) := GLS.GeomObjects.TGLCone.Create( Self );
      GLS.GeomObjects.TGLCone(zt_gl_scene_object).Parent := Self.budowla_gl_dummy_cube__wbu;
      GLS.GeomObjects.TGLCone(zt_gl_scene_object).BottomRadius := Self.CubeSize * 0.2;
      GLS.GeomObjects.TGLCone(zt_gl_scene_object).Height := Self.CubeSize * 0.75;
      GLS.GeomObjects.TGLCone(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color := Stage.Color.clrDarkTurquoise;
      GLS.GeomObjects.TGLCone(zt_gl_scene_object).PitchAngle := 90;
      GLS.GeomObjects.TGLCone(zt_gl_scene_object).Position.Z := Self.CubeSize * 0.5 - GLS.GeomObjects.TGLCone(zt_gl_scene_object).Height * 0.5;

      if Wizualizacja__Efekty_Udostepnij.B³yskawica( dominium__numer_f ) <> nil then
        GLS.ThorFX.TGLBThorFX(Self.efekt__atak_gl_dummy_cube__wbu.AddNewEffect( TGLBThorFX )).Manager := Wizualizacja__Efekty_Udostepnij.B³yskawica( dominium__numer_f );

    end
  else//if Self.budowla__rodzaj__wbu = Definicje.br_wie¿a__obronna then
  if Self.budowla__rodzaj__wbu = Definicje.br_wie¿a__zwiadowcza then
    begin

      GLS.GeomObjects.TGLCylinder(zt_gl_scene_object) := GLS.GeomObjects.TGLCylinder.Create( Self );
      GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Parent := Self.budowla_gl_dummy_cube__wbu;
      GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).BottomRadius := Self.CubeSize * 0.05;
      GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Height := Self.CubeSize * 0.5;
      GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color := Stage.Color.clrAquamarine;
      GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).PitchAngle := 90;
      GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Position.Z := GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Height * 0.5;
      GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).TopRadius := GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).BottomRadius;


      ztsi := GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).BottomRadius;


      for i := 1 to 3 do
        begin

          // 3
          // 2
          // 1

          zt_gl_scene_object := GLS.GeomObjects.TGLCylinder.Create( Self );
          GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Parent := Self.budowla_gl_dummy_cube__wbu;
          GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).BottomRadius := ztsi * 2 + Self.CubeSize * 0.05 * i;
          GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Height := Self.CubeSize * 0.03;
          GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color := Stage.Color.clrThistle;
          GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).PitchAngle := 90;
          GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Position.Z := Self.CubeSize * 0.51 - Self.CubeSize * 0.25 - i * Self.CubeSize * 0.075;
          GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).TopRadius := GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).BottomRadius;


          if i = 1 then
            begin

              Self.animacja_gl_scene_object := zt_gl_scene_object;
              Self.animacja__oczekiwanie__wbu := Random( 3000 );
              Self.animacja__wspó³rzêdna_pocz¹tkowa__wbu := GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Position.Z;

            end;
          //---//if i = 1 then

        end;
      //---//for i := 1 to 3 do

    end
  else//if Self.budowla__rodzaj__wbu = Definicje.br_wie¿a__zwiadowcza then
  if Self.budowla__rodzaj__wbu = Definicje.br_zamek then
    begin

      GLS.GeomObjects.TGLFrustrum(zt_gl_scene_object) := GLS.GeomObjects.TGLFrustrum.Create( Self );
      GLS.GeomObjects.TGLFrustrum(zt_gl_scene_object).Parent := Self.budowla_gl_dummy_cube__wbu;
      GLS.GeomObjects.TGLFrustrum(zt_gl_scene_object).Material.FrontProperties.Diffuse.SetColor( Definicje.kolor__zamek_c.rgbtRed, Definicje.kolor__zamek_c.rgbtGreen, Definicje.kolor__zamek_c.rgbtBlue );
      GLS.GeomObjects.TGLFrustrum(zt_gl_scene_object).PitchAngle := 90;
      GLS.GeomObjects.TGLFrustrum(zt_gl_scene_object).Position.Z := Self.CubeSize * 0.5 - GLS.GeomObjects.TGLFrustrum(zt_gl_scene_object).Height * 0.5;
      Self.przynale¿noœæ__kolor__wo.MajorRadius := Self.przynale¿noœæ__kolor__wo.MajorRadius * 1.5;

      if Wizualizacja__Efekty_Udostepnij.Œwiat³a_Wie¿( dominium__numer_f ) <> nil then
        begin

          zt_gl_dummy_cube__efekt := GLS.Objects.TGLDummyCube.Create( Self );
          zt_gl_dummy_cube__efekt.Parent := zt_gl_scene_object;
          zt_gl_dummy_cube__efekt.Position.Y := GLS.GeomObjects.TGLFrustrum(zt_gl_scene_object).Position.Z;

          with GLS.ParticleFX.GetOrCreateSourcePFX( GLS.GeomObjects.TGLCylinder(zt_gl_dummy_cube__efekt) ) do
            begin

              Manager := Wizualizacja__Efekty_Udostepnij.Œwiat³a_Wie¿( dominium__numer_f );
              EffectScale := Wizualizacja__Efekty_Udostepnij.Œwiat³a_Wie¿( dominium__numer_f ).Friction * 1;

            end;
          //---//with GLS.ParticleFX.GetOrCreateSourcePFX( GLS.GeomObjects.TGLCylinder(zt_gl_scene_object) ) do

        end;
      //---//if Wizualizacja__Efekty_Udostepnij.Œwiat³a_Wie¿( dominium__numer_f ) <> nil then


      for i := 1 to 4 do
        begin

          // 1 2
          // 3 4

          zt_gl_scene_object := GLS.GeomObjects.TGLCylinder.Create( Self );
          GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Parent := Self.budowla_gl_dummy_cube__wbu;
          GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).BottomRadius := Self.CubeSize * 0.1;
          GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Height := Self.CubeSize * 0.75;
          GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color := Stage.Color.clrWhite;
          GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).PitchAngle := 90;

          if i in [ 1, 3 ] then
            zti := -1
          else//if i in [ 1, 3 ] then
            zti := 1;

          GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Position.X := zti * Self.CubeSize * 0.4;

          if i in [ 1, 4 ] then
            zti := 1
          else//if i in [ 1, 4 ] then
            zti := -1;

          GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Position.Y := zti * GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Position.X;
          GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Position.Z := GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Height * 0.5;
          GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).TopRadius := GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).BottomRadius;

          if Wizualizacja__Efekty_Udostepnij.Œwiat³a_Wie¿( dominium__numer_f ) <> nil then
            begin

              zt_gl_dummy_cube__efekt := GLS.Objects.TGLDummyCube.Create( Self );
              zt_gl_dummy_cube__efekt.Parent := zt_gl_scene_object;
              zt_gl_dummy_cube__efekt.Position.Y := GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Height * 0.5;

              with GLS.ParticleFX.GetOrCreateSourcePFX( GLS.GeomObjects.TGLCylinder(zt_gl_dummy_cube__efekt) ) do
                begin

                  Manager := Wizualizacja__Efekty_Udostepnij.Œwiat³a_Wie¿( dominium__numer_f );
                  EffectScale := Wizualizacja__Efekty_Udostepnij.Œwiat³a_Wie¿( dominium__numer_f ).Friction * 0.5;

                end;
              //---//with GLS.ParticleFX.GetOrCreateSourcePFX( GLS.GeomObjects.TGLCylinder(zt_gl_scene_object) ) do

            end;
          //---//if Wizualizacja__Efekty_Udostepnij.Œwiat³a_Wie¿( dominium__numer_f ) <> nil then

        end;
      //---//for i := 1 to 4 do

    end;
  //---//if Self.budowla__rodzaj__wbu = Definicje.br_zamek then


  Self.Efekt__Atak__Zmieñ__Wbu( false );
  Self.Efekt__Obra¿enia__Zmieñ__Wbu( false );

end;//---//Konstruktor klasy TWizualizacja__Budowla.

destructor TWizualizacja__Budowla.Destroy();
begin

  System.SysUtils.FreeAndNil( Self.efekt__atak_gl_dummy_cube__wbu );
  System.SysUtils.FreeAndNil( Self.efekt__obra¿enia_gl_dummy_cube__wbu );
  System.SysUtils.FreeAndNil( Self.budowla_gl_dummy_cube__wbu );


  inherited;

end;//---//Destruktor klasy TWizualizacja__Budowla.

procedure TWizualizacja__Budowla.Animacja__Wbu( const gra_wspó³czynnik_prêdkoœci_f : single );
const
  skok_c_l : single = 0.001;

var
  skok_l : single;
begin

  if Self.animacja_gl_scene_object = nil then
    Exit;


  skok_l := skok_c_l * gra_wspó³czynnik_prêdkoœci_f;


  if Self.animacja__oczekiwanie__wbu > 0 then
    dec( Self.animacja__oczekiwanie__wbu )
  else//if Self.animacja__oczekiwanie__wbu > 0 then
    //if Self.budowla__rodzaj__wbu = Definicje.br_domek then
    //  begin
    //
    //    Self.animacja__wspó³rzêdna_pocz¹tkowa__wbu := Self.animacja__wspó³rzêdna_pocz¹tkowa__wbu + skok_c_l * 5;
    //
    //    if Self.animacja__wspó³rzêdna_pocz¹tkowa__wbu >= 2 * System.Pi then
    //      Self.animacja__wspó³rzêdna_pocz¹tkowa__wbu := 0;
    //
    //    Self.animacja_gl_scene_object.RollAngle := System.Sin( Self.animacja__wspó³rzêdna_pocz¹tkowa__wbu ) * 5;
    //
    //  end
    //else//if Self.budowla__rodzaj__wbu = Definicje.br_domek then
    if Self.budowla__rodzaj__wbu = Definicje.br_wie¿a__zwiadowcza then
      begin

        if not Self.animacja__kierunek_powrót__wbu then
          begin

            if Self.animacja_gl_scene_object.Position.Z < Self.CubeSize * 0.5 then
              Self.animacja_gl_scene_object.Position.Z := Self.animacja_gl_scene_object.Position.Z + skok_l
            else//if Self.animacja_gl_scene_object.Position.Z < Self.CubeSize * 0.5 then
              begin

                Self.animacja__kierunek_powrót__wbu := true;

                Self.animacja__oczekiwanie__wbu := 300 + Random( 200 );

              end;
            //---//if Self.animacja_gl_scene_object.Position.Z < Self.CubeSize * 0.5 then

          end
        else//if not Self.animacja__kierunek_powrót__wbu then
          begin

            if Self.animacja_gl_scene_object.Position.Z > Self.animacja__wspó³rzêdna_pocz¹tkowa__wbu then
              Self.animacja_gl_scene_object.Position.Z := Self.animacja_gl_scene_object.Position.Z - skok_l
            else//if Self.animacja_gl_scene_object.Position.Z > Self.animacja__wspó³rzêdna_pocz¹tkowa__wbu then
              begin

                Self.animacja__kierunek_powrót__wbu := false;

                Self.animacja__oczekiwanie__wbu := 500 + Random( 300 );

              end;
            //---//if Self.animacja_gl_scene_object.Position.Z > Self.animacja__wspó³rzêdna_pocz¹tkowa__wbu then

          end;
        //---//if not Self.animacja__kierunek_powrót__wbu then

      end;
    //---//if Self.budowla__rodzaj__wbu = Definicje.br_wie¿a__zwiadowcza then

end;//---//Funkcja Animacja__Wbu().

function TWizualizacja__Budowla.Budowla__Rodzaj__Odczytaj__Wbu() : Definicje.TBudowla_Rodzaj;
begin

  Result := Self.budowla__rodzaj__wbu;

end;//---//Funkcja Budowla__Rodzaj__Odczytaj__Wbu()

procedure TWizualizacja__Budowla.Efekt__Atak__Zmieñ__Wbu( const aktywny_f : boolean; const atak__cel__wspó³rzêdna__y_f : integer = 0; const atak__cel__wspó³rzêdna__x_f : integer = 0 );
begin

  //
  //    180
  //  90   270
  //    0
  //
  // x +>
  //  y
  //  +
  //  v
  //

  Self.efekt__atak_gl_dummy_cube__wbu.PitchAngle := 0;
  Self.efekt__atak_gl_dummy_cube__wbu.RollAngle := 0;

  Self.efekt__atak_gl_dummy_cube__wbu.Visible := aktywny_f;

  if aktywny_f then
    begin

      if    ( atak__cel__wspó³rzêdna__x_f = Self.Position.X )
        and ( atak__cel__wspó³rzêdna__y_f = Self.Position.Y ) then
        Self.efekt__atak_gl_dummy_cube__wbu.PitchAngle := 270
      else
      if    ( atak__cel__wspó³rzêdna__x_f = Self.Position.X )
        and ( atak__cel__wspó³rzêdna__y_f > Self.Position.Y ) then
        Self.efekt__atak_gl_dummy_cube__wbu.RollAngle := 0
      else
      if    ( atak__cel__wspó³rzêdna__x_f < Self.Position.X )
        and ( atak__cel__wspó³rzêdna__y_f > Self.Position.Y ) then
        Self.efekt__atak_gl_dummy_cube__wbu.RollAngle := 45
      else
      if    ( atak__cel__wspó³rzêdna__x_f < Self.Position.X )
        and ( atak__cel__wspó³rzêdna__y_f = Self.Position.Y ) then
        Self.efekt__atak_gl_dummy_cube__wbu.RollAngle := 90
      else
      if    ( atak__cel__wspó³rzêdna__x_f < Self.Position.X )
        and ( atak__cel__wspó³rzêdna__y_f < Self.Position.Y ) then
        Self.efekt__atak_gl_dummy_cube__wbu.RollAngle := 135
      else
      if    ( atak__cel__wspó³rzêdna__x_f = Self.Position.X )
        and ( atak__cel__wspó³rzêdna__y_f < Self.Position.Y ) then
        Self.efekt__atak_gl_dummy_cube__wbu.RollAngle := 180
      else
      if    ( atak__cel__wspó³rzêdna__x_f > Self.Position.X )
        and ( atak__cel__wspó³rzêdna__y_f < Self.Position.Y ) then
        Self.efekt__atak_gl_dummy_cube__wbu.RollAngle := 225
      else
      if    ( atak__cel__wspó³rzêdna__x_f > Self.Position.X )
        and ( atak__cel__wspó³rzêdna__y_f = Self.Position.Y ) then
        Self.efekt__atak_gl_dummy_cube__wbu.RollAngle := 270
      else
      if    ( atak__cel__wspó³rzêdna__x_f > Self.Position.X )
        and ( atak__cel__wspó³rzêdna__y_f > Self.Position.Y ) then
        Self.efekt__atak_gl_dummy_cube__wbu.RollAngle := 315
      else
        Self.efekt__atak_gl_dummy_cube__wbu.RollAngle := Random( 360 );


      if Self.efekt__atak_gl_dummy_cube__wbu.PitchAngle = 0 then
        Self.efekt__atak_gl_dummy_cube__wbu.RollAngle := Self.efekt__atak_gl_dummy_cube__wbu.RollAngle + Random( 44 ) - 22;

    end;
  //---//if aktywny_f then

end;//---//Funkcja Efekt__Atak__Zmieñ__Wbu()

procedure TWizualizacja__Budowla.Efekt__Obra¿enia__Zmieñ__Wbu( const aktywny_f : boolean );
begin

  if Wizualizacja__Efekty_Udostepnij.Ogieñ() <> nil then
    with GLS.ParticleFX.GetOrCreateSourcePFX( Self.efekt__obra¿enia_gl_dummy_cube__wbu ) do
      begin

        Enabled := aktywny_f;

      end;
    //---//with GLS.ParticleFX.GetOrCreateSourcePFX( Self.efekt__obra¿enia_gl_dummy_cube__wbu ) do

end;//---//Funkcja Efekt__Obra¿enia__Zmieñ__Wbu()

constructor TWizualizacja__Surowiec.Create( AOwner : System.Classes.TComponent; const id_f : integer; const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj );
var
  x_l,
  y_l
    : integer;

  ztsi : single;

  zt_gs_color_vector : TGSColorVector;

  zt_gl_scene_object : GLS.Scene.TGLSceneObject;
begin

  inherited Create( AOwner, id_f );


  Self.surowiec__rodzaj__wsu := surowiec__rodzaj_f;

  Self.surowiec_gl_dummy_cub__wsu := GLS.Objects.TGLDummyCube.Create( Self );
  Self.surowiec_gl_dummy_cub__wsu.Parent := Self;

  Self.surowiec_gl_dummy_cub__wsu.RollAngle := Random( 360 );


  GLS.GeomObjects.TGLCylinder(zt_gl_scene_object) := GLS.GeomObjects.TGLCylinder.Create( Self );
  GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Parent := Self;
  GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).PitchAngle := 90;
  GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).BottomRadius := Self.CubeSize * 0.5 * 0.75;
  GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Height := Self.CubeSize * 0.01;
  GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Position.Z := Self.CubeSize * 0.5 - GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Height;
  GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).TopRadius := GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).BottomRadius;


  if Self.surowiec__rodzaj__wsu = Definicje.sr_kryszta³ then
    begin

      GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color := Stage.Color.ConvertWinColor(  Definicje.RGBTriple_To_Color( Definicje.kolor__surowiec__kryszta³_c )  );
      //GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Material.FrontProperties.Diffuse.SetColor( Definicje.kolor__surowiec__kryszta³_c.rgbtRed, Definicje.kolor__surowiec__kryszta³_c.rgbtGreen, Definicje.kolor__surowiec__kryszta³_c.rgbtBlue );
      zt_gs_color_vector := GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color;

      for x_l := 0 to 6 do
        for y_l := 0 to 6 do
          if   ( // Œrodek.
                     ( x_l >= 1 )
                 and ( x_l <= 5 )
                 and ( y_l >= 1 )
                 and ( y_l <= 5 )
               )
            or ( // Lewo prawo.
                     (
                          ( x_l < 1 )
                       or ( x_l > 5 )
                     )
                 and ( y_l >= 2 )
                 and ( y_l <= 4 )
               )
            or ( // Góra dó³.
                     ( x_l >= 2 )
                 and ( x_l <= 4 )
                 and (
                          ( y_l < 1 )
                       or ( y_l > 5 )
                     )
               ) then
            begin

              zt_gl_scene_object := GLS.Objects.TGLCube.Create( Self );
              GLS.Objects.TGLCube(zt_gl_scene_object).Parent := Self.surowiec_gl_dummy_cub__wsu;
              GLS.Objects.TGLCube(zt_gl_scene_object).CubeDepth := Self.CubeSize * 0.3;
              GLS.Objects.TGLCube(zt_gl_scene_object).CubeHeight := Self.CubeSize * 0.05;
              GLS.Objects.TGLCube(zt_gl_scene_object).CubeWidth := GLS.Objects.TGLCube(zt_gl_scene_object).CubeHeight;

              if Random( 10 ) <= 3 then
                GLS.Objects.TGLCube(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color := Stage.Color.clrWhite
              else
                GLS.Objects.TGLCube(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color := zt_gs_color_vector;

              GLS.Objects.TGLCube(zt_gl_scene_object).Position.X := -( Self.CubeSize / 3 ) + ( Self.CubeSize / 9 ) * x_l;
              GLS.Objects.TGLCube(zt_gl_scene_object).Position.Y := -( Self.CubeSize / 3 ) + ( Self.CubeSize / 9 ) * y_l;
              GLS.Objects.TGLCube(zt_gl_scene_object).Position.Z := Self.CubeSize * 0.5 - GLS.Objects.TGLCube(zt_gl_scene_object).CubeDepth * 0.5;

            end;
          //---//if   ( (...)

    end
  else//if Self.surowiec__rodzaj__wsu = Definicje.sr_kryszta³ then
  if Self.surowiec__rodzaj__wsu = Definicje.sr_kwiatki then
    begin

      GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color := Stage.Color.ConvertWinColor(  Definicje.RGBTriple_To_Color( Definicje.kolor__surowiec__kwiatki_c )  );
      zt_gs_color_vector := GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color;

      for x_l := 0 to 12 do
        for y_l := 0 to 12 do
          if   ( // Œrodek.
                     ( x_l >= 2 )
                 and ( x_l <= 10 )
                 and ( y_l >= 2 )
                 and ( y_l <= 10 )
               )
            or ( // Lewo prawo wewn¹trz.
                     ( x_l >= 1 )
                 and ( x_l <= 11 )
                 and ( y_l >= 4 )
                 and ( y_l <= 8 )
               )
            or ( // Lewo prawo zewn¹trz.
                     ( x_l >= 0 )
                 and ( x_l <= 12 )
                 and ( y_l >= 5 )
                 and ( y_l <= 7 )
               )
            or ( // Góra dó³ wewn¹trz.
                     ( x_l >= 4 )
                 and ( x_l <= 8 )
                 and ( y_l >= 1 )
                 and ( y_l <= 11 )
               )
            or ( // Góra dó³ zewn¹trz.
                     ( x_l >= 5 )
                 and ( x_l <= 7 )
                 and ( y_l >= 0 )
                 and ( y_l <= 12 )
               ) then
            begin

              zt_gl_scene_object := GLS.Objects.TGLSphere.Create( Self );
              GLS.Objects.TGLSphere(zt_gl_scene_object).Parent := Self.surowiec_gl_dummy_cub__wsu;
              GLS.Objects.TGLSphere(zt_gl_scene_object).Radius := Self.CubeSize * 0.015;
              GLS.Objects.TGLSphere(zt_gl_scene_object).Material.FrontProperties.Diffuse.RandomColor();
              GLS.Objects.TGLSphere(zt_gl_scene_object).Position.X := -( Self.CubeSize / 3 ) + ( Self.CubeSize / 18 ) * x_l;
              GLS.Objects.TGLSphere(zt_gl_scene_object).Position.Y := -( Self.CubeSize / 3 ) + ( Self.CubeSize / 18 ) * y_l;
              GLS.Objects.TGLSphere(zt_gl_scene_object).Position.Z := Self.CubeSize * 0.5 - GLS.Objects.TGLSphere(zt_gl_scene_object).Radius * 0.5 - GLS.Objects.TGLSphere(zt_gl_scene_object).Radius * 2;

              zt_gl_scene_object := GLS.GeomObjects.TGLCylinder.Create( Self );
              GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Parent := Self.surowiec_gl_dummy_cub__wsu;
              GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).BottomRadius := Self.CubeSize * 0.015;
              GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Height := Self.CubeSize * 0.03;
              GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Material.FrontProperties.Diffuse.RandomColor();
              GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).PitchAngle := 90;
              GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Position.X := -( Self.CubeSize / 3 ) + ( Self.CubeSize / 18 ) * x_l;
              GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Position.Y := -( Self.CubeSize / 3 ) + ( Self.CubeSize / 18 ) * y_l;
              GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Position.Z := Self.CubeSize * 0.5 - GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Height * 0.5;
              GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).TopRadius := GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).BottomRadius;

            end;
          //---//if   ( (...)

    end
  else//if Self.surowiec__rodzaj__wsu = Definicje.sr_kwiatki then
  if Self.surowiec__rodzaj__wsu = Definicje.sr_magma then
    begin

      GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color := Stage.Color.ConvertWinColor(  Definicje.RGBTriple_To_Color( Definicje.kolor__surowiec__magma_c )  );
      zt_gs_color_vector := GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color;

      for x_l := 0 to 3 do
        for y_l := 0 to 3 do
          begin

            zt_gl_scene_object := GLS.Objects.TGLSphere.Create( Self );
            GLS.Objects.TGLSphere(zt_gl_scene_object).Parent := Self.surowiec_gl_dummy_cub__wsu;
            GLS.Objects.TGLSphere(zt_gl_scene_object).Radius := Self.CubeSize * 0.05;

            ztsi := Random( 10 );

            if    ( ztsi >= 0 )
              and ( ztsi <= 2 ) then
              GLS.Objects.TGLSphere(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color := Stage.Color.clrOrange
            else
            if    ( ztsi >= 3 )
              and ( ztsi <= 5 ) then
              GLS.Objects.TGLSphere(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color := Stage.Color.clrYellow
            else
              GLS.Objects.TGLSphere(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color := zt_gs_color_vector;

            GLS.Objects.TGLSphere(zt_gl_scene_object).Position.X := -( Self.CubeSize / 4 ) + ( Self.CubeSize / 6 ) * x_l;
            GLS.Objects.TGLSphere(zt_gl_scene_object).Position.Y := -( Self.CubeSize / 4 ) + ( Self.CubeSize / 6 ) * y_l;
            GLS.Objects.TGLSphere(zt_gl_scene_object).Position.Z := Self.CubeSize * 0.5 - GLS.Objects.TGLSphere(zt_gl_scene_object).Radius * 0.5;

          end;
        //---//for y_l := 0 to 3 do

    end
  else//if Self.surowiec__rodzaj__wsu = Definicje.sr_magma then
  if Self.surowiec__rodzaj__wsu = Definicje.sr_woda then
    begin

      GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color := Stage.Color.ConvertWinColor(  Definicje.RGBTriple_To_Color( Definicje.kolor__surowiec__woda_c )  );
      zt_gs_color_vector := GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color;

      for y_l := 0 to 3 do
        begin

          zt_gl_scene_object := GLS.GeomObjects.TGLCylinder.Create( Self );
          GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Parent := Self.surowiec_gl_dummy_cub__wsu;
          GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).BottomRadius := Self.CubeSize * 0.05;

          if y_l in [ 0, 3 ] then
            ztsi := -Self.CubeSize * 0.2
          else//if y_l in [ 0, 3 ] then
            ztsi := 0;

          GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Height := Self.CubeSize * 0.75 + ztsi;

          ztsi := Random( 10 );

          if    ( ztsi >= 0 )
            and ( ztsi <= 2 ) then
            GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color := Stage.Color.clrSummerSky
          else
          if    ( ztsi >= 3 )
            and ( ztsi <= 7 ) then
            GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color := Stage.Color.clrDarkTurquoise
          else
            GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color := zt_gs_color_vector;

          GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).RollAngle := 90;
          GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Position.Y := -( Self.CubeSize / 4 ) + ( Self.CubeSize / 6 ) * y_l;
          GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Position.Z := Self.CubeSize * 0.5;
          GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).TopRadius := GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).BottomRadius;

        end;
      //---//for y_l := 0 to 3 do

    end
  else//if Self.surowiec__rodzaj__wsu = Definicje.sr_woda then
  if Self.surowiec__rodzaj__wsu = Definicje.sr_¿ywio³ then
    begin

      GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color := Stage.Color.ConvertWinColor(  Definicje.RGBTriple_To_Color( Definicje.kolor__surowiec__¿ywio³_c )  );
      zt_gs_color_vector := GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color;
      ztsi := GLS.GeomObjects.TGLCylinder(zt_gl_scene_object).BottomRadius;

      zt_gl_scene_object := GLS.Objects.TGLSphere.Create( Self );
      GLS.Objects.TGLSphere(zt_gl_scene_object).Parent := Self;
      GLS.Objects.TGLSphere(zt_gl_scene_object).Radius := ztsi;
      GLS.Objects.TGLSphere(zt_gl_scene_object).Material.BlendingMode := GLS.Material.bmCustom; // bmCustom bmModulate bmTransparency
      GLS.Objects.TGLSphere(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color := zt_gs_color_vector;
      GLS.Objects.TGLSphere(zt_gl_scene_object).Material.FrontProperties.Diffuse.Alpha := 0.5;
      GLS.Objects.TGLSphere(zt_gl_scene_object).Position.Z := Self.CubeSize * 0.5 - GLS.Objects.TGLSphere(zt_gl_scene_object).Radius * 0.5;

    end;
  //---//if Self.surowiec__rodzaj__wsu = Definicje.sr_¿ywio³ then



  Self.domki__iloœæ__1__wsu := GLS.Objects.TGLSphere.Create( Self );
  Self.domki__iloœæ__1__wsu.Parent := Self;
  Self.domki__iloœæ__1__wsu.Material.FrontProperties.Diffuse.Color := Stage.Color.clrWhite;
  Self.domki__iloœæ__1__wsu.Position.Z := -Self.CubeSize * 0.01;
  Self.domki__iloœæ__1__wsu.Radius := Self.CubeSize * 0.1;
  Self.domki__iloœæ__1__wsu.Position.X := Self.domki__iloœæ__1__wsu.Radius * 2;

  Self.domki__iloœæ__2__wsu := GLS.Objects.TGLSphere.Create( Self );
  Self.domki__iloœæ__2__wsu.Parent := Self;
  Self.domki__iloœæ__2__wsu.Material.FrontProperties.Diffuse.Color := Self.domki__iloœæ__1__wsu.Material.FrontProperties.Diffuse.Color;
  Self.domki__iloœæ__2__wsu.Position.X := -Self.domki__iloœæ__1__wsu.Position.X;
  Self.domki__iloœæ__2__wsu.Position.Z := Self.domki__iloœæ__1__wsu.Position.Z;
  Self.domki__iloœæ__2__wsu.Radius := Self.domki__iloœæ__1__wsu.Radius;


  Self.Domki__Iloœæ__Zmieñ__Wsu( 0 );

end;//---//Konstruktor klasy TWizualizacja__Surowiec.

destructor TWizualizacja__Surowiec.Destroy();
begin

  System.SysUtils.FreeAndNil( Self.domki__iloœæ__1__wsu );
  System.SysUtils.FreeAndNil( Self.domki__iloœæ__2__wsu );

  System.SysUtils.FreeAndNil( Self.surowiec_gl_dummy_cub__wsu );


  inherited;

end;//---//Destruktor klasy TWizualizacja__Surowiec.

procedure TWizualizacja__Surowiec.Domki__Iloœæ__Zmieñ__Wsu( const iloœæ_f : integer );
begin

  Self.domki__iloœæ__1__wsu.Visible := iloœæ_f >= 1;
  Self.domki__iloœæ__2__wsu.Visible := iloœæ_f >= 2;

end;//---//Funkcja Domki__Iloœæ__Zmieñ__Wsu().

end.
