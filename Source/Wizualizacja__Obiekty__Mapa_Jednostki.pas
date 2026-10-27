unit Wizualizacja__Obiekty__Mapa_Jednostki;{18.Wrz.2026}

interface

uses
  GLS.Objects,
  GLS.ParticleFX,
  GLS.Scene,
  GLS.ThorFX,

  System.Classes,
  System.SysUtils,

  Definicje;

type
  TWizualizacja__Mapa_Jednostka = class( GLS.Objects.TGLDummyCube )
  private
    { Private declarations }
    dominium__numer__wmj : smallint;

    id__wmj : integer;

    wspó³rzêdna__x__wmj,
    wspó³rzêdna__y__wmj
      : single;

    mapa_jednostka_gl_dummy_cube__wmj,
    efekt__atak_gl_dummy_cube__wmj,
    efekt__obra¿enia_gl_dummy_cube__wmj
      : GLS.Objects.TGLDummyCube;
  public
    { Public declarations }
    constructor Create( AOwner : System.Classes.TComponent; const dominium__numer_f : smallint; const id_f : integer );
    destructor Destroy(); override;

    function Id__Odczytaj__Wmj() : integer;
    function Id__Porównaj__Wmj( const id_f : integer ) : boolean;

    procedure Efekt__Atak__Zmieñ__Wmj( const aktywny_f : boolean );
    procedure Efekt__Obra¿enia__Zmieñ__Wmj( const aktywny_f : boolean );

    procedure Ruch__Wmj( const gra_wspó³czynnik_prêdkoœci_f : single );

    procedure Wspó³rzêdne__Ustaw__Wmj( const wspó³rzêdna__y_f, wspó³rzêdna__x_f : single );
  end;//---//TWizualizacja__Mapa_Jednostka = class

implementation

uses
  Wizualizacja__Efekty_Udostepnij;

constructor TWizualizacja__Mapa_Jednostka.Create( AOwner : System.Classes.TComponent; const dominium__numer_f : smallint; const id_f : integer );
var
  zt_gl_scene_object : GLS.Scene.TGLSceneObject;
begin

  inherited Create( AOwner );


  Self.id__wmj := id_f;
  Self.dominium__numer__wmj := dominium__numer_f;


  Self.mapa_jednostka_gl_dummy_cube__wmj := GLS.Objects.TGLDummyCube.Create( Self );
  Self.mapa_jednostka_gl_dummy_cube__wmj.Parent := Self;

  Self.efekt__atak_gl_dummy_cube__wmj := GLS.Objects.TGLDummyCube.Create( Self );
  Self.efekt__atak_gl_dummy_cube__wmj.Parent := Self.mapa_jednostka_gl_dummy_cube__wmj;

  Self.efekt__obra¿enia_gl_dummy_cube__wmj := GLS.Objects.TGLDummyCube.Create( Self );
  Self.efekt__obra¿enia_gl_dummy_cube__wmj.Parent := Self.mapa_jednostka_gl_dummy_cube__wmj;
  Self.efekt__obra¿enia_gl_dummy_cube__wmj.Position.Z := Self.CubeSize * 0.5;


  GLS.Objects.TGLSphere(zt_gl_scene_object) := GLS.Objects.TGLSphere.Create( Self );
  GLS.Objects.TGLSphere(zt_gl_scene_object).Parent := Self.mapa_jednostka_gl_dummy_cube__wmj;
  GLS.Objects.TGLSphere(zt_gl_scene_object).Radius := Self.CubeSize * 0.1;


  if Self.dominium__numer__wmj = Definicje.dominium__numer__gracz__1_c then
    begin

      GLS.Objects.TGLSphere(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color := Definicje.kolor__dominium__1_c;

    end
  else//if Self.dominium__numer__wmj = Definicje.dominium__numer__gracz__1_c then
  if Self.dominium__numer__wmj = Definicje.dominium__numer__gracz__2_c then
    begin

      GLS.Objects.TGLSphere(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color:= Definicje.kolor__dominium__2_c;

    end
  else//if Self.dominium__numer__wmj = Definicje.dominium__numer__gracz__2_c then
    begin

      GLS.Objects.TGLSphere(zt_gl_scene_object).Material.FrontProperties.Diffuse.Color:= Definicje.kolor__dominium__brak_c;

    end;
  //---//if Self.dominium__numer__wmj = Definicje.dominium__numer__gracz__2_c then

  GLS.Objects.TGLSphere(zt_gl_scene_object).Position.X := -Self.CubeSize * 0.5 + Self.CubeSize * Random( 10 ) * 0.1;
  GLS.Objects.TGLSphere(zt_gl_scene_object).Position.Y := -Self.CubeSize * 0.5 + Self.CubeSize * Random( 10 ) * 0.1;
  GLS.Objects.TGLSphere(zt_gl_scene_object).Position.Z := Self.CubeSize * 0.5 - GLS.Objects.TGLSphere(zt_gl_scene_object).Radius;


  Self.efekt__obra¿enia_gl_dummy_cube__wmj.Position := GLS.Objects.TGLSphere(zt_gl_scene_object).Position;
  Self.efekt__obra¿enia_gl_dummy_cube__wmj.Position.Z := Self.efekt__obra¿enia_gl_dummy_cube__wmj.Position.Z - 2 * GLS.Objects.TGLSphere(zt_gl_scene_object).Radius;


  if Wizualizacja__Efekty_Udostepnij.B³yskawica( dominium__numer_f ) <> nil then
    begin

      Self.efekt__atak_gl_dummy_cube__wmj.PitchAngle := 270;
      Self.efekt__atak_gl_dummy_cube__wmj.Position := GLS.Objects.TGLSphere(zt_gl_scene_object).Position;

      GLS.ThorFX.TGLBThorFX(Self.efekt__atak_gl_dummy_cube__wmj.AddNewEffect( TGLBThorFX )).Manager := Wizualizacja__Efekty_Udostepnij.B³yskawica( dominium__numer_f );

    end;
  //---//if Wizualizacja__Efekty_Udostepnij.B³yskawica( dominium__numer_f ) <> nil then

  if Wizualizacja__Efekty_Udostepnij.Ogieñ() <> nil then
    with GLS.ParticleFX.GetOrCreateSourcePFX( Self.efekt__obra¿enia_gl_dummy_cube__wmj ) do
      begin

        Manager := Wizualizacja__Efekty_Udostepnij.Ogieñ();
        EffectScale := 0.1;

      end;
    //---//with GLS.ParticleFX.GetOrCreateSourcePFX( Self.efekt__obra¿enia_gl_dummy_cube__wmj ) do


  Self.Efekt__Atak__Zmieñ__Wmj( false );
  Self.Efekt__Obra¿enia__Zmieñ__Wmj( false );

end;//---//Konstruktor klasy TWizualizacja__Mapa_Jednostka.

destructor TWizualizacja__Mapa_Jednostka.Destroy();
begin

  System.SysUtils.FreeAndNil( Self.efekt__atak_gl_dummy_cube__wmj );
  System.SysUtils.FreeAndNil( Self.efekt__obra¿enia_gl_dummy_cube__wmj );
  System.SysUtils.FreeAndNil( Self.mapa_jednostka_gl_dummy_cube__wmj );


  inherited;

end;//---//Destruktor klasy TWizualizacja__Mapa_Jednostka.

procedure TWizualizacja__Mapa_Jednostka.Efekt__Atak__Zmieñ__Wmj( const aktywny_f : boolean );
begin

  Self.efekt__atak_gl_dummy_cube__wmj.Visible := aktywny_f;

end;//---//Funkcja Efekt__Atak__Zmieñ__Wmj()

procedure TWizualizacja__Mapa_Jednostka.Efekt__Obra¿enia__Zmieñ__Wmj( const aktywny_f : boolean );
begin

  // Nie wywo³a siê je¿eli jednostka zostanie zwolniona (straci punkty wytrzyma³oœci) przed odœwie¿eniem wizualizacji.

  if Wizualizacja__Efekty_Udostepnij.Ogieñ() <> nil then
    with GLS.ParticleFX.GetOrCreateSourcePFX( Self.efekt__obra¿enia_gl_dummy_cube__wmj ) do
      begin

        Enabled := aktywny_f;

      end;
    //---//with GLS.ParticleFX.GetOrCreateSourcePFX( Self.efekt__obra¿enia_gl_dummy_cube__wmj ) do

end;//---//Funkcja Efekt__Obra¿enia__Zmieñ__Wmj()

function TWizualizacja__Mapa_Jednostka.Id__Odczytaj__Wmj() : integer;
begin

  Result := Self.id__wmj;

end;//---//Funkcja Id__Odczytaj__Wmj().

function TWizualizacja__Mapa_Jednostka.Id__Porównaj__Wmj( const id_f : integer ) : boolean;
begin

  Result := Self.id__wmj = id_f;

end;//---//Funkcja Id__Porównaj__Wmj().

procedure TWizualizacja__Mapa_Jednostka.Ruch__Wmj( const gra_wspó³czynnik_prêdkoœci_f : single );
const
  skok_c_l : single = 0.02;

var
  skok_l : single;
begin

  skok_l := skok_c_l * gra_wspó³czynnik_prêdkoœci_f;


  if Abs( Self.Position.X - Self.wspó³rzêdna__x__wmj ) > skok_c_l then
    begin

      if Self.Position.X > Self.wspó³rzêdna__x__wmj then
        Self.Position.X := Self.Position.X - skok_l
      else//if Self.Position.X > Self.wspó³rzêdna__x__wmj then
      if Self.Position.X < Self.wspó³rzêdna__x__wmj then
        Self.Position.X := Self.Position.X + skok_l;

    end
  else//if Abs( Self.Position.X - Self.wspó³rzêdna__x__wmj ) > skok_c_l then
    Self.Position.X := Self.wspó³rzêdna__x__wmj;


  if Abs( Self.Position.Y - Self.wspó³rzêdna__y__wmj ) > skok_c_l then
    begin

      if Self.Position.Y > Self.wspó³rzêdna__y__wmj then
        Self.Position.Y := Self.Position.Y - skok_l
      else//if Self.Position.Y > Self.wspó³rzêdna__y__wmj then
      if Self.Position.Y < Self.wspó³rzêdna__y__wmj then
        Self.Position.Y := Self.Position.Y + skok_l;

    end
  else//if Abs( Self.Position.Y - Self.wspó³rzêdna__y__wmj ) > skok_c_l then
    Self.Position.Y := Self.wspó³rzêdna__y__wmj;

end;//---//Funkcja Ruch__Wmj().

procedure TWizualizacja__Mapa_Jednostka.Wspó³rzêdne__Ustaw__Wmj( const wspó³rzêdna__y_f, wspó³rzêdna__x_f : single );
begin

  Self.wspó³rzêdna__x__wmj := wspó³rzêdna__x_f;
  Self.wspó³rzêdna__y__wmj := wspó³rzêdna__y_f;

end;//---//Funkcja Wspó³rzêdne__Ustaw__Wmj().

end.
