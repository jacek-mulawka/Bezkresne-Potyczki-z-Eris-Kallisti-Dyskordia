unit Wizualizacja__Obiekty__Jednostki;{10.Wrz.2026}

interface

uses
  GLS.GeomObjects,
  GLS.Objects,
  GLS.ThorFX,
  Stage.Color,

  System.Classes,
  System.SysUtils,

  Definicje;

type
  TAnimacja_Cel_Zbli¿_Siê_Etap = ( aczse_brak, aczse_powrót, aczse_w_bok_1, aczse_w_bok_2 );

  TJednostka__Wygl¹d_Aktualizuj = record
    atakowaæ_mo¿e__jwa,
    cel__zbli¿_siê__jwa
      : boolean;

    poziom__jwa,
    w_zwarciu_z_indeks__jwa
      : integer;

    broñ_rodzaj__jwa : Definicje.TJednostka_Broñ_Rodzaj;

    typ__jwa : Definicje.TJednostka_Typ;
  end;//---//TJednostka__Wygl¹d_Aktualizuj = record

  TWizualizacja__Jednostka = class( GLS.Objects.TGLDummyCube )
  private
    { Private declarations }
    animacja__cel__zbli¿_siê__wj,
    animacja__kierunek_powrót__wj,
    animacja__start__wj
      : boolean;

    dominium__numer__wj : smallint;

    id__wj,
    indeks__wj,
    indeks__w_bitwie__wj
      : integer;

    animacja__postêp__wj,
    animacja__wspó³rzêdna_pocz¹tkowa__wj,
    broñ__pozycja_pocz¹tkowa__y__wj,
    kratka__wielkoœæ__wj,
    position__x__pocz¹tkowe__wj
      : single;

    animacja_cel_zbli¿_siê_etap__wj : TAnimacja_Cel_Zbli¿_Siê_Etap;

    broñ_gl_dummy_cube__wj,
    efekt__atak_gl_dummy_cube__wj,
    korpus_gl_dummy_cube__wj
      : GLS.Objects.TGLDummyCube;

    jazda_gl_cube__wj : GLS.Objects.TGLCube;

    piechota_gl_sphere__wj : GLS.Objects.TGLSphere;

    broñ__dystans_gl_cylinder__wj : GLS.GeomObjects.TGLCylinder;
    broñ__zwarcie_gl_cone__wj : GLS.GeomObjects.TGLCone;

    celownicza_linia : GLS.Objects.TGLLines;

    function Widocznoœæ__Odczytaj__Wj() : boolean;
  public
    { Public declarations }
    constructor Create( AOwner : System.Classes.TComponent; const dominium__numer_f : smallint; const kratka__wielkoœæ_f : single );
    destructor Destroy(); override;

    function Id__Porównaj__Wj( const dominium__numer_f : smallint; const id_f : integer ) : boolean;
    procedure Id__Zmieñ__Wj( const id_f : integer );
    procedure Animacja__Wj( const gra_wspó³czynnik_prêdkoœci_f : single );
    function Dominium__Numer__Porównaj__Wj( const dominium__numer_f : smallint ) : boolean;
    procedure Indeks__Zmieñ__Wj( const indeks_f : integer );
    procedure Position__X__Pocz¹tkowe__Zmieñ__Wj( const x_f : single );
    procedure Widocznoœæ__Ustaw__Wj( const widocznoœæ_f : boolean );
    procedure Wygl¹d_Aktualizuj__Wj( const przed_starciem_f : boolean; const bitwa_starcie_etap_f : Definicje.TBitwa_Starcie_Etap; const indeks_f : integer; const jednostka__wygl¹d_aktualizuj_f : TJednostka__Wygl¹d_Aktualizuj );
  end;//---//TWizualizacja__Jednostka = class

const
  jednostka__poziom_skala_c : real = 0.7;

implementation

uses
  Wizualizacja__Efekty_Udostepnij;

constructor TWizualizacja__Jednostka.Create( AOwner : System.Classes.TComponent; const dominium__numer_f : smallint; const kratka__wielkoœæ_f : single );
begin

  inherited Create( AOwner );


  Self.id__wj := Definicje.identyfikator_pusty_c;
  Self.animacja__cel__zbli¿_siê__wj := false;
  Self.animacja_cel_zbli¿_siê_etap__wj := Wizualizacja__Obiekty__Jednostki.aczse_brak;
  Self.animacja__kierunek_powrót__wj := false;
  Self.animacja__postêp__wj := -Random( 1000 );
  Self.animacja__wspó³rzêdna_pocz¹tkowa__wj := 0;
  Self.animacja__start__wj := false;
  Self.dominium__numer__wj := dominium__numer_f;
  Self.kratka__wielkoœæ__wj := kratka__wielkoœæ_f;


  Self.korpus_gl_dummy_cube__wj := GLS.Objects.TGLDummyCube.Create( Self );
  Self.korpus_gl_dummy_cube__wj.Parent := Self;

  Self.broñ_gl_dummy_cube__wj := GLS.Objects.TGLDummyCube.Create( Self.korpus_gl_dummy_cube__wj );
  Self.broñ_gl_dummy_cube__wj.Parent := Self.korpus_gl_dummy_cube__wj;
  Self.broñ_gl_dummy_cube__wj.Position.Y := -Self.kratka__wielkoœæ__wj * 0.5;
  Self.broñ_gl_dummy_cube__wj.Position.Z := Self.broñ_gl_dummy_cube__wj.Position.Y;

  Self.efekt__atak_gl_dummy_cube__wj := GLS.Objects.TGLDummyCube.Create( Self );
  Self.efekt__atak_gl_dummy_cube__wj.Parent := Self.broñ_gl_dummy_cube__wj;
  Self.efekt__atak_gl_dummy_cube__wj.Visible := false;


  Self.broñ__pozycja_pocz¹tkowa__y__wj := Self.broñ_gl_dummy_cube__wj.Position.Y;


  if Self.dominium__numer__wj = Definicje.dominium__numer__gracz__2_c then
    Self.korpus_gl_dummy_cube__wj.RollAngle := 180;

  Self.broñ__dystans_gl_cylinder__wj := nil;
  Self.broñ__zwarcie_gl_cone__wj := nil;
  Self.indeks__wj := Definicje.identyfikator_pusty_c;
  Self.indeks__w_bitwie__wj := Definicje.identyfikator_pusty_c;
  Self.jazda_gl_cube__wj := nil;
  Self.piechota_gl_sphere__wj := nil;
  Self.position__x__pocz¹tkowe__wj := 0;


  if Wizualizacja__Efekty_Udostepnij.B³yskawica( dominium__numer_f ) <> nil then
    begin

      Self.efekt__atak_gl_dummy_cube__wj.RollAngle := 180;
      Self.efekt__atak_gl_dummy_cube__wj.PitchAngle := 15;

      GLS.ThorFX.TGLBThorFX(Self.efekt__atak_gl_dummy_cube__wj.AddNewEffect( TGLBThorFX )).Manager := Wizualizacja__Efekty_Udostepnij.B³yskawica( dominium__numer_f );

    end;
  //---//if Wizualizacja__Efekty_Udostepnij.B³yskawica( dominium__numer_f ) <> nil then


  Self.celownicza_linia := TGLLines.Create( Self );
  Self.celownicza_linia.Parent := Self;
  Self.celownicza_linia.Up.SetVector( 0, 1, 0 );
  Self.celownicza_linia.Direction.SetVector( 0, 0, -1 );
  Self.celownicza_linia.AddNode( -Self.CubeSize * 0.1, 0, 0 );
  Self.celownicza_linia.AddNode( 0, 0, 0 );
  Self.celownicza_linia.NodesAspect := GLS.Objects.lnaInvisible;
  Self.celownicza_linia.LineColor.Color := Stage.Color.clrWhite;
  Self.celownicza_linia.LinePattern := 6553; // 65535
  Self.celownicza_linia.LineWidth := 4;
  Self.celownicza_linia.Position.Z := -Self.CubeSize * 0.1;

end;//---//Konstruktor klasy TWizualizacja__Jednostka.

destructor TWizualizacja__Jednostka.Destroy();
begin

  inherited;

end;//---//Destruktor klasy TWizualizacja__Jednostka.

function TWizualizacja__Jednostka.Id__Porównaj__Wj( const dominium__numer_f : smallint; const id_f : integer ) : boolean;
begin

  Result :=
        ( Self.dominium__numer__wj = dominium__numer_f )
    and ( Self.id__wj = id_f );

end;//---//Funkcja Id__Porównaj__Wj().

procedure TWizualizacja__Jednostka.Id__Zmieñ__Wj( const id_f : integer );
begin

  Self.id__wj := id_f;

end;//---//Funkcja Id__Zmieñ__Wj().

procedure TWizualizacja__Jednostka.Animacja__Wj( const gra_wspó³czynnik_prêdkoœci_f : single );
const
  broñ__amplituda_c_l : single = 0.01;
  broñ__dystans__dystans__c_l : single = 3;
  cel__zbli¿_siê__amplituda_c_l : single = 0.25;
  cel__zbli¿_siê__postêp__skok_c_l : single = 0.01;
  falowanie__amplituda_c_l : single = 0.05;
  falowanie__postêp__skok_c_l : single = 0.01;
  indeks__w_bitwie__skok_c_l : single = 0.05;

var
  ztsi,
  cel__zbli¿_siê____postêp__skok_l,
  falowanie__postêp__skok_l,
  indeks__w_bitwie__skok_l
    : single;
begin

  if Self.animacja__postêp__wj >= 0 then
    begin

      falowanie__postêp__skok_l := falowanie__postêp__skok_c_l * gra_wspó³czynnik_prêdkoœci_f;


      Self.animacja__postêp__wj := Self.animacja__postêp__wj + falowanie__postêp__skok_l;

      if Self.animacja__postêp__wj >= 2 * System.Pi then
        Self.animacja__postêp__wj := 0;

      Self.korpus_gl_dummy_cube__wj.Position.Z := Self.animacja__wspó³rzêdna_pocz¹tkowa__wj + System.Sin( Self.animacja__postêp__wj ) * falowanie__amplituda_c_l;

    end
  else//if Self.animacja__postêp__wj >= 0 then
    Self.animacja__postêp__wj := Self.animacja__postêp__wj
      + 1;


  if Self.broñ__zwarcie_gl_cone__wj <> nil then
    begin

      if Self.broñ_gl_dummy_cube__wj.Position.Y < Self.broñ__pozycja_pocz¹tkowa__y__wj then
        Self.broñ_gl_dummy_cube__wj.Position.Y := Self.broñ_gl_dummy_cube__wj.Position.Y + broñ__amplituda_c_l
      else//if Self.broñ_gl_dummy_cube__wj.Position.Y < Self.broñ__pozycja_pocz¹tkowa__y__wj then
        Self.broñ_gl_dummy_cube__wj.Position.Y := Self.broñ__pozycja_pocz¹tkowa__y__wj;

    end
  else//if Self.broñ__zwarcie_gl_cone__wj <> nil then
  if    ( Self.broñ__dystans_gl_cylinder__wj <> nil )
    and ( Self.animacja__start__wj ) then
    begin

      if not Self.animacja__kierunek_powrót__wj then
        begin

          if Self.broñ_gl_dummy_cube__wj.Position.Y > broñ__dystans__dystans__c_l * Self.broñ__pozycja_pocz¹tkowa__y__wj then
            Self.broñ_gl_dummy_cube__wj.Position.Y := Self.broñ_gl_dummy_cube__wj.Position.Y - broñ__amplituda_c_l * 2
          else//if Self.broñ_gl_dummy_cube__wj.Position.Y > broñ__dystans__dystans__c_l * Self.broñ__pozycja_pocz¹tkowa__y__wj then
            begin

              Self.broñ_gl_dummy_cube__wj.Position.Y := broñ__dystans__dystans__c_l * Self.broñ__pozycja_pocz¹tkowa__y__wj;
              Self.animacja__kierunek_powrót__wj := true;

            end;
          //---//if Self.broñ_gl_dummy_cube__wj.Position.Y >= broñ__dystans__dystans__c_l * Self.broñ__pozycja_pocz¹tkowa__y__wj then

        end
      else//if not Self.animacja__kierunek_powrót__wj then
        begin

          if Self.broñ_gl_dummy_cube__wj.Position.Y < Self.broñ__pozycja_pocz¹tkowa__y__wj then
            Self.broñ_gl_dummy_cube__wj.Position.Y := Self.broñ_gl_dummy_cube__wj.Position.Y + broñ__amplituda_c_l * 2
          else//if Self.broñ_gl_dummy_cube__wj.Position.Y < Self.broñ__pozycja_pocz¹tkowa__y__wj then
            begin

              Self.broñ_gl_dummy_cube__wj.Position.Y := Self.broñ__pozycja_pocz¹tkowa__y__wj;
              Self.animacja__kierunek_powrót__wj := false;
              Self.animacja__start__wj := false;

            end;
          //---//if Self.broñ_gl_dummy_cube__wj.Position.Y < Self.broñ__pozycja_pocz¹tkowa__y__wj then

        end;
      //---//if not Self.animacja__kierunek_powrót__wj then


      if broñ__dystans__dystans__c_l * Self.broñ__pozycja_pocz¹tkowa__y__wj - Self.broñ__pozycja_pocz¹tkowa__y__wj <> 0 then
        ztsi := System.Pi * ( Self.broñ_gl_dummy_cube__wj.Position.Y - Self.broñ__pozycja_pocz¹tkowa__y__wj ) / ( broñ__dystans__dystans__c_l * Self.broñ__pozycja_pocz¹tkowa__y__wj - Self.broñ__pozycja_pocz¹tkowa__y__wj )
      else//if broñ__dystans__dystans__c_l * Self.broñ__pozycja_pocz¹tkowa__y__wj - Self.broñ__pozycja_pocz¹tkowa__y__wj <> 0 then
        ztsi := 0;

      if Self.animacja__kierunek_powrót__wj then
        ztsi := -ztsi;

      Self.broñ_gl_dummy_cube__wj.Position.X := System.Sin( ztsi ) * Self.CubeSize * 0.5;

    end;
  //---//if    ( Self.broñ__dystans_gl_cylinder__wj <> nil ) (...)


  if   ( Self.animacja__cel__zbli¿_siê__wj )
    or ( Self.animacja_cel_zbli¿_siê_etap__wj <> Wizualizacja__Obiekty__Jednostki.aczse_brak ) then
    begin

      cel__zbli¿_siê____postêp__skok_l := cel__zbli¿_siê__postêp__skok_c_l * gra_wspó³czynnik_prêdkoœci_f;


      if Self.animacja_cel_zbli¿_siê_etap__wj = Wizualizacja__Obiekty__Jednostki.aczse_brak then
        begin

          if Self.animacja__cel__zbli¿_siê__wj then
            Self.animacja__cel__zbli¿_siê__wj := false;

          Self.animacja_cel_zbli¿_siê_etap__wj := Wizualizacja__Obiekty__Jednostki.aczse_w_bok_1;

        end;
      //---//if Self.animacja_cel_zbli¿_siê_etap__wj = Wizualizacja__Obiekty__Jednostki.aczse_brak then


      if Self.animacja_cel_zbli¿_siê_etap__wj = Wizualizacja__Obiekty__Jednostki.aczse_w_bok_1 then
        begin

          Self.korpus_gl_dummy_cube__wj.Position.X := Self.korpus_gl_dummy_cube__wj.Position.X
            - cel__zbli¿_siê____postêp__skok_l;

          if Self.korpus_gl_dummy_cube__wj.Position.X <= -cel__zbli¿_siê__amplituda_c_l then
            Self.animacja_cel_zbli¿_siê_etap__wj := Wizualizacja__Obiekty__Jednostki.aczse_w_bok_2;

        end
      else//if Self.animacja_cel_zbli¿_siê_etap__wj = Wizualizacja__Obiekty__Jednostki.aczse_w_bok_1 then
      if Self.animacja_cel_zbli¿_siê_etap__wj = Wizualizacja__Obiekty__Jednostki.aczse_w_bok_2 then
        begin

          Self.korpus_gl_dummy_cube__wj.Position.X := Self.korpus_gl_dummy_cube__wj.Position.X
            + cel__zbli¿_siê____postêp__skok_l;

          if Self.korpus_gl_dummy_cube__wj.Position.X >= cel__zbli¿_siê__amplituda_c_l then
            Self.animacja_cel_zbli¿_siê_etap__wj := Wizualizacja__Obiekty__Jednostki.aczse_powrót;

        end
      else//if Self.animacja_cel_zbli¿_siê_etap__wj = Wizualizacja__Obiekty__Jednostki.aczse_w_bok_2 then
      if Self.animacja_cel_zbli¿_siê_etap__wj = Wizualizacja__Obiekty__Jednostki.aczse_powrót then
        begin

          Self.korpus_gl_dummy_cube__wj.Position.X := Self.korpus_gl_dummy_cube__wj.Position.X
            - cel__zbli¿_siê____postêp__skok_l;

          if Self.korpus_gl_dummy_cube__wj.Position.X <= 0 then
            begin

              Self.korpus_gl_dummy_cube__wj.Position.X := 0;

              Self.animacja_cel_zbli¿_siê_etap__wj := Wizualizacja__Obiekty__Jednostki.aczse_brak;

            end;
          //---//if Self.korpus_gl_dummy_cube__wj.Position.X <= 0 then

        end;
      //---//if Self.animacja_cel_zbli¿_siê_etap__wj = Wizualizacja__Obiekty__Jednostki.aczse_powrót then

    end;
  //---//if   ( Self.animacja__cel__zbli¿_siê__wj ) (...)


  if Self.indeks__w_bitwie__wj * Self.CubeSize < Self.Position.X then
    begin

      indeks__w_bitwie__skok_l := indeks__w_bitwie__skok_c_l * gra_wspó³czynnik_prêdkoœci_f;

      Self.Position.X := Self.Position.X - indeks__w_bitwie__skok_c_l;

    end
  else//if Self.indeks__w_bitwie__wj * Self.CubeSize < Self.Position.X then
    if Self.indeks__w_bitwie__wj * Self.CubeSize <> Self.Position.X then
      Self.Position.X := Self.indeks__w_bitwie__wj * Self.CubeSize;

end;//---//Funkcja Animacja__Wj().

function TWizualizacja__Jednostka.Dominium__Numer__Porównaj__Wj( const dominium__numer_f : smallint ) : boolean;
begin

  Result := Self.dominium__numer__wj = dominium__numer_f;

end;//---//Funkcja Dominium__Numer__Porównaj__Wj().

function TWizualizacja__Jednostka.Widocznoœæ__Odczytaj__Wj() : boolean;
begin

  Result := Self.Visible;

end;//---//Funkcja Widocznoœæ__Odczytaj__Wj().

procedure TWizualizacja__Jednostka.Indeks__Zmieñ__Wj( const indeks_f : integer );
begin

  Self.indeks__wj := indeks_f;

end;//---//Funkcja Indeks__Zmieñ__Wj().

procedure TWizualizacja__Jednostka.Position__X__Pocz¹tkowe__Zmieñ__Wj( const x_f : single );
begin

  Self.position__x__pocz¹tkowe__wj := x_f;

end;//---//Funkcja Position__X__Pocz¹tkowe__Zmieñ__Wj().

procedure TWizualizacja__Jednostka.Widocznoœæ__Ustaw__Wj( const widocznoœæ_f : boolean );
begin

  Self.Visible := widocznoœæ_f;

end;//---//Funkcja Widocznoœæ__Ustaw__Wj().

procedure TWizualizacja__Jednostka.Wygl¹d_Aktualizuj__Wj( const przed_starciem_f : boolean; const bitwa_starcie_etap_f : Definicje.TBitwa_Starcie_Etap; const indeks_f : integer; const jednostka__wygl¹d_aktualizuj_f : TJednostka__Wygl¹d_Aktualizuj );
var
  ztis : single;
begin

  if not Self.Widocznoœæ__Odczytaj__Wj() then
    Self.Widocznoœæ__Ustaw__Wj( true );


  Self.indeks__w_bitwie__wj := indeks_f;


  if jednostka__wygl¹d_aktualizuj_f.w_zwarciu_z_indeks__jwa <> Definicje.jednostka__w_zwarciu_z_indeks__pusty_c then
    begin

      Self.celownicza_linia.Nodes[ 1 ].X := Self.indeks__w_bitwie__wj - jednostka__wygl¹d_aktualizuj_f.w_zwarciu_z_indeks__jwa;
      Self.celownicza_linia.Nodes[ 1 ].Y := 1.5;

      if Self.dominium__numer__wj = Definicje.dominium__numer__gracz__1_c then
        Self.celownicza_linia.Nodes[ 1 ].Y := -Self.celownicza_linia.Nodes[ 1 ].Y;

    end
  else//if jednostka__wygl¹d_aktualizuj_f.w_zwarciu_z_indeks__jwa <> Definicje.jednostka__w_zwarciu_z_indeks__pusty_c then
    begin

      Self.celownicza_linia.Nodes[ 1 ].X := 0;
      Self.celownicza_linia.Nodes[ 1 ].Y := 0;

    end;
  //---//if jednostka__wygl¹d_aktualizuj_f.w_zwarciu_z_indeks__jwa <> Definicje.jednostka__w_zwarciu_z_indeks__pusty_c then

  Self.celownicza_linia.LineColor.Color := Stage.Color.clrWhite;
  Self.celownicza_linia.Visible := not przed_starciem_f;


  if    ( jednostka__wygl¹d_aktualizuj_f.typ__jwa = Definicje.jt_jazda )
    and ( Self.jazda_gl_cube__wj = nil ) then
    begin

      Self.jazda_gl_cube__wj := GLS.Objects.TGLCube.Create( Self.korpus_gl_dummy_cube__wj );
      Self.jazda_gl_cube__wj.Parent := Self.korpus_gl_dummy_cube__wj;
      Self.jazda_gl_cube__wj.CubeHeight := Self.jazda_gl_cube__wj.CubeHeight * 2;

      if Self.dominium__numer__wj = Definicje.dominium__numer__gracz__1_c then
        Self.jazda_gl_cube__wj.Material.FrontProperties.Diffuse.Color := Definicje.kolor__dominium__1_c
      else//if Self.dominium__numer__wj = Definicje.dominium__numer__gracz__1_c then
      if Self.dominium__numer__wj = Definicje.dominium__numer__gracz__2_c then
        Self.jazda_gl_cube__wj.Material.FrontProperties.Diffuse.Color := Definicje.kolor__dominium__2_c;

      Self.jazda_gl_cube__wj.Position.Y := Self.jazda_gl_cube__wj.CubeHeight * 0.25;

    end
  else//if    ( jednostka__wygl¹d_aktualizuj_f.typ__jwa = Definicje.jt_jazda ) (...)
  if    ( jednostka__wygl¹d_aktualizuj_f.typ__jwa = Definicje.jt_piechota )
    and ( Self.piechota_gl_sphere__wj = nil ) then
    begin

      Self.piechota_gl_sphere__wj := GLS.Objects.TGLSphere.Create( Self.korpus_gl_dummy_cube__wj );
      Self.piechota_gl_sphere__wj.Parent := Self.korpus_gl_dummy_cube__wj;

      if Self.dominium__numer__wj = Definicje.dominium__numer__gracz__1_c then
        Self.piechota_gl_sphere__wj.Material.FrontProperties.Diffuse.Color := Definicje.kolor__dominium__1_c
      else//if Self.dominium__numer__wj = Definicje.dominium__numer__gracz__1_c then
      if Self.dominium__numer__wj = Definicje.dominium__numer__gracz__2_c then
        Self.piechota_gl_sphere__wj.Material.FrontProperties.Diffuse.Color := Definicje.kolor__dominium__2_c;

    end;
  //---//if    ( jednostka__wygl¹d_aktualizuj_f.typ__jwa = Definicje.jt_piechota ) (...)


  if    ( jednostka__wygl¹d_aktualizuj_f.broñ_rodzaj__jwa = Definicje.jbr_dystans )
    and ( Self.broñ__dystans_gl_cylinder__wj = nil ) then
    begin

      if Self.broñ__zwarcie_gl_cone__wj <> nil then
        System.SysUtils.FreeAndNil( Self.broñ__zwarcie_gl_cone__wj );


      Self.broñ__dystans_gl_cylinder__wj := GLS.GeomObjects.TGLCylinder.Create( Self.broñ_gl_dummy_cube__wj );
      Self.broñ__dystans_gl_cylinder__wj.Parent := Self.broñ_gl_dummy_cube__wj;
      Self.broñ__dystans_gl_cylinder__wj.BottomRadius := Self.kratka__wielkoœæ__wj * 0.3;
      Self.broñ__dystans_gl_cylinder__wj.Height := Self.kratka__wielkoœæ__wj * 0.05;
      Self.broñ__dystans_gl_cylinder__wj.Material.FrontProperties.Diffuse.RandomColor();
      Self.broñ__dystans_gl_cylinder__wj.PitchAngle := 90;
      Self.broñ__dystans_gl_cylinder__wj.TopRadius := Self.broñ__dystans_gl_cylinder__wj.BottomRadius;

    end
  else//if jednostka__wygl¹d_aktualizuj_f.broñ_rodzaj__jwa = Definicje.jbr_dystans then
  if    ( jednostka__wygl¹d_aktualizuj_f.broñ_rodzaj__jwa = Definicje.jbr_zwarcie )
    and ( Self.broñ__zwarcie_gl_cone__wj = nil ) then
    begin

      if Self.broñ__dystans_gl_cylinder__wj <> nil then
        System.SysUtils.FreeAndNil( Self.broñ__dystans_gl_cylinder__wj );


      Self.broñ__zwarcie_gl_cone__wj := GLS.GeomObjects.TGLCone.Create( Self.broñ_gl_dummy_cube__wj );
      Self.broñ__zwarcie_gl_cone__wj.Parent := Self.broñ_gl_dummy_cube__wj;
      Self.broñ__zwarcie_gl_cone__wj.BottomRadius := Self.kratka__wielkoœæ__wj * 0.2;
      Self.broñ__zwarcie_gl_cone__wj.Material.FrontProperties.Diffuse.RandomColor();
      Self.broñ__zwarcie_gl_cone__wj.RollAngle := 180;

    end;
  //---//if    ( jednostka__wygl¹d_aktualizuj_f.broñ_rodzaj__jwa = Definicje.jbr_zwarcie ) (...)


  ztis :=
      (
          1
        + jednostka__wygl¹d_aktualizuj_f.poziom__jwa
        * Wizualizacja__Obiekty__Jednostki.jednostka__poziom_skala_c
        - Wizualizacja__Obiekty__Jednostki.jednostka__poziom_skala_c
      )
    * Self.kratka__wielkoœæ__wj * 0.1;

  if Self.korpus_gl_dummy_cube__wj.Scale.X <> ztis then
    begin

      Self.korpus_gl_dummy_cube__wj.Scale.X := ztis;
      Self.korpus_gl_dummy_cube__wj.Scale.Y := Self.korpus_gl_dummy_cube__wj.Scale.X;
      Self.korpus_gl_dummy_cube__wj.Scale.Z := Self.korpus_gl_dummy_cube__wj.Scale.X;
      Self.korpus_gl_dummy_cube__wj.Position.Z := -Self.korpus_gl_dummy_cube__wj.Scale.X;
      Self.animacja__wspó³rzêdna_pocz¹tkowa__wj := Self.korpus_gl_dummy_cube__wj.Position.Z;

    end;
  //---//if Self.korpus_gl_dummy_cube__wj.Scale.X <> ztis then


  if Self.broñ_gl_dummy_cube__wj.Count > 0 then
    begin

      if przed_starciem_f then
        begin

          Self.broñ_gl_dummy_cube__wj.Position.X := 0;
          Self.broñ_gl_dummy_cube__wj.Position.Y := Self.broñ__pozycja_pocz¹tkowa__y__wj;
          Self.animacja__kierunek_powrót__wj := false;
          Self.animacja__start__wj := false;
          Self.efekt__atak_gl_dummy_cube__wj.Visible := false;
          Self.Position.X := Self.position__x__pocz¹tkowe__wj;

        end
      else//if przed_starciem_f then
        if    ( bitwa_starcie_etap_f = Definicje.bse_atak__dystans )
          and ( jednostka__wygl¹d_aktualizuj_f.broñ_rodzaj__jwa = Definicje.jbr_dystans ) then
          begin

            if jednostka__wygl¹d_aktualizuj_f.atakowaæ_mo¿e__jwa then
              begin

                //Self.broñ_gl_dummy_cube__wj.Position.Y := 3 * Self.broñ__pozycja_pocz¹tkowa__y__wj;
                Self.animacja__start__wj := true;

                if Self.dominium__numer__wj = Definicje.dominium__numer__gracz__1_c then
                  Self.celownicza_linia.LineColor.Color := Definicje.kolor__dominium__1_c
                else//if Self.dominium__numer__wj = Definicje.dominium__numer__gracz__1_c then
                if Self.dominium__numer__wj = Definicje.dominium__numer__gracz__2_c then
                  Self.celownicza_linia.LineColor.Color := Definicje.kolor__dominium__2_c;

                Self.efekt__atak_gl_dummy_cube__wj.Visible := true;

              end;
            //---//if jednostka__wygl¹d_aktualizuj_f.atakowaæ_mo¿e__jwa then

          end
        else//if    ( bitwa_starcie_etap_f = Definicje.bse_atak__dystans ) (...)
        if    ( bitwa_starcie_etap_f = Definicje.bse_atak__zwarcie )
          and ( jednostka__wygl¹d_aktualizuj_f.broñ_rodzaj__jwa = Definicje.jbr_zwarcie ) then
          begin

            if jednostka__wygl¹d_aktualizuj_f.atakowaæ_mo¿e__jwa then
              begin

                Self.broñ_gl_dummy_cube__wj.Position.Y := 2 * Self.broñ__pozycja_pocz¹tkowa__y__wj;

                if Self.dominium__numer__wj = Definicje.dominium__numer__gracz__1_c then
                  Self.celownicza_linia.LineColor.Color := Definicje.kolor__dominium__1_c
                else//if Self.dominium__numer__wj = Definicje.dominium__numer__gracz__1_c then
                if Self.dominium__numer__wj = Definicje.dominium__numer__gracz__2_c then
                  Self.celownicza_linia.LineColor.Color := Definicje.kolor__dominium__2_c;

                Self.efekt__atak_gl_dummy_cube__wj.Visible := true;

              end;
            //---//if jednostka__wygl¹d_aktualizuj_f.atakowaæ_mo¿e__jwa then

          end
        else//if    ( bitwa_starcie_etap_f = Definicje.bse_atak__zwarcie ) (...)
          begin

            //Self.broñ_gl_dummy_cube__wj.Position.Y := Self.broñ__pozycja_pocz¹tkowa__y__wj;
            Self.efekt__atak_gl_dummy_cube__wj.Visible := false;


            if    ( bitwa_starcie_etap_f = Definicje.bse_d¹¿enie_do_zwarcia )
              and ( jednostka__wygl¹d_aktualizuj_f.cel__zbli¿_siê__jwa ) then
              Self.animacja__cel__zbli¿_siê__wj := true;

          end;
        //---//if    ( bitwa_starcie_etap_f = Definicje.bse_atak__zwarcie ) (...)

    end;
  //---//if Self.broñ_gl_dummy_cube__wj.Count > 0 then

end;//---//Funkcja Wygl¹d_Aktualizuj__Wj().

end.
