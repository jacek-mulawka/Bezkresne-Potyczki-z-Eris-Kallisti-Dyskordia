unit Gra_Okno;{27.Sie.2026}

  //
  // Kierunki wspó³rzêdnych uk³adu g³ównego.
  //
  //     góra z
  //     przód -y
  // lewo -x
  //     ty³ y
  //

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids,

  GLS.SceneViewer, GLS.Objects, GLS.Scene, GLS.Cadencer, Stage.Coordinates, Stage.BaseClasses, GLS.SpaceText,
  GLS.HUDObjects, GLS.BitmapFont, GLS.WindowsFont, GLS.ParticleFX, GLS.PerlinPFX, GLS.ThorFX,
  Stage.Color,
  Stage.VectorGeometry,

  Bitwa_Dominia,
  Definicje,
  Wizualizacja__Obiekty__Budowle;

type
  TGra_Okno_Etap = ( goe_bitwa__dominia, goe_bitwa__jednostki__starcie, goe_bitwa__jednostki__wynik__prezentacja, goe_bitwa__jednostki__zakup, goe_koniec );

  TGra_Okno_Form = class( TForm )
    Gra_GLSceneViewer: TGLSceneViewer;
    Gra_GLScene: TGLScene;
    Gra_GLCamera: TGLCamera;
    Dó³_GLLightSource: TGLLightSource;
    Zero_GLSphere: TGLSphere;
    Lewo_GLCube: TGLCube;
    GLCadencer1: TGLCadencer;
    Gra_Obiekty_GLDummyCube: TGLDummyCube;
    Ziemia_GLPlane: TGLPlane;
    Tura_Timer: TTimer;
    Informacje_Panel: TPanel;
    Informacje_Splitter: TSplitter;
    Tura_Panel: TPanel;
    Gracz__1_RadioGroup: TRadioGroup;
    Gracz_Panel: TPanel;
    Gracz__2_RadioGroup: TRadioGroup;
    Surowce_Panel: TPanel;
    Przyciski_Panel: TPanel;
    Surowce_Przeciwnik_Podgl¹d_CheckBox: TCheckBox;
    Zakup__Jednostki_Panel: TPanel;
    Zakup__Budynki_Panel: TPanel;
    Zakup__Jednostki__Automatycznie_Button: TButton;
    Mapa_T³o_GLPlane: TGLPlane;
    Pauza_GLHUDText: TGLHUDText;
    GLWindowsBitmapFont1: TGLWindowsBitmapFont;
    Pauza_GLHUDSprite: TGLHUDSprite;
    Bitwa__Jednostki__Wynik__Ustal_Button: TButton;
    Bitwa_Jednostki_Timer: TTimer;
    Jednostki_Obszar_T³o_GLPlane: TGLPlane;
    Jednostki__Wytrzyma³oœæ_Punkty__Panel: TPanel;
    Jednostki__Wytrzyma³oœæ_Punkty__Gracz__1_Panel: TPanel;
    Jednostki__Wytrzyma³oœæ_Punkty__Gracz__2_Panel: TPanel;
    Gracz__1__T³o_Panel: TPanel;
    Gracz__2__T³o_Panel: TPanel;
    Gra_Wspó³czynnik_Prêdkoœci_Label: TLabel;
    Gracz__1_Panel: TPanel;
    Gracz__2_Panel: TPanel;
    Zakup__Jednostki__Automatycznie__Zawsze_CheckBox: TCheckBox;
    Góra_GLLightSource: TGLLightSource;
    Œwiat³a_Wie¿__1_GLPerlinPFXManager: TGLPerlinPFXManager;
    GLParticleFXRenderer1: TGLParticleFXRenderer;
    Œwiat³a_Wie¿__2_GLPerlinPFXManager: TGLPerlinPFXManager;
    B³yskawica__1_GLThorFXManager: TGLThorFXManager;
    B³yskawica__2_GLThorFXManager: TGLThorFXManager;
    Ogieñ_GLPolygonPFXManager: TGLPolygonPFXManager;
    procedure FormCreate( Sender: TObject );
    procedure FormShow( Sender: TObject );
    procedure FormClose( Sender: TObject; var Action: TCloseAction );
    procedure FormResize( Sender: TObject );
    procedure GLCadencer1Progress( Sender: TObject; const deltaTime, newTime: Double );
    procedure Gra_GLSceneViewerClick( Sender: TObject );

    procedure Gra_GLSceneViewerMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
    procedure Gra_GLSceneViewerMouseMove( Sender: TObject; Shift: TShiftState; X, Y: Integer );
    procedure Gra_GLSceneViewerMouseUp( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
    procedure Gra_GLSceneViewerMouseWheel( Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean );
    procedure Gra_GLSceneViewerKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Bitwa_Jednostki_TimerTimer( Sender: TObject );
    procedure Bitwa__Jednostki__Wynik__Ustal_ButtonClick( Sender: TObject );
    procedure Surowce_Przeciwnik_Podgl¹d_CheckBoxClick( Sender: TObject );
    procedure Tura_TimerTimer( Sender: TObject );
    procedure Zakup__Jednostki__Automatycznie_ButtonClick( Sender: TObject );
  private
    { Private declarations }
    class var zakup__jednostki__automatycznie__zawsze__kopia_g : boolean;

    class var bitwa_jednostki_timer__interval__kopia_g,
              tura_timer__interval__kopia_g
      : cardinal;

    budowa__tryb_g,
    kamera__resetowanie_g,
    kamera__ruch_g,
    mapa_t³o_ustawione_g
      : boolean;

    tury__przeliczenia_g : integer;

    jednostki__wytrzyma³oœæ_punkty__procent_100_g : real;

    mysz_start_punkt_g,
    kamera__punkt_kopia_g
      : TPointFloat;

    kamera_pozycja_kopia_g : Stage.VectorGeometry.TAffineVector;

    budowa__tryb__budowla_g : Wizualizacja__Obiekty__Budowle.TWizualizacja__Budowla;

    gra_okno_etap_g : Gra_Okno.TGra_Okno_Etap;

    function Komunikat_Wyœwietl( const text_f, caption_f : string; const flags_f : integer ) : integer;
    procedure Kamera__Resetuj( const czy_kamera_pozycja_kopia_f : boolean = false );
    procedure Kamera__Ruch( delta_czasu_f : double );

    function Czy_Pauza() : boolean;
    procedure Pauza();

    procedure Gra_Wspó³czynnik_Prêdkoœci__Informacja__Wyœwietl__Go();
    procedure Gra_Wspó³czynnik_Prêdkoœci__Zmieñ__Go( const zmiana_kierunek_f : smallint );

    procedure Budowa__Tryb__Ustaw__Go( const budowa__tryb_f : boolean; const budowla_rodzaj_f : Definicje.TBudowla_Rodzaj = Definicje.br_domek );
    procedure Budowa__Tryb__Zmieñ__Go( const budowla_rodzaj_f : Definicje.TBudowla_Rodzaj );
    procedure Gra_Okno_Etap__Interfejs__Dostosuj__Go();
    procedure Jednostki__Obszar__T³o__Ustaw__Go();
    procedure Jednostki__Wytrzyma³oœæ_Punkty__Wyœwietl__Go( const procent_100_zapamiêtaj_f : boolean = false );
    procedure Jednostki__Zakup__Obs³uga__Go( const jednostki_po³¹cz_f, teren_kup_f : boolean; const jednostka_typ_f : Definicje.TJednostka_Typ; const jednostka_typ__po³¹cz_f : Definicje.TJednostka_Typ = Definicje.jt_pusta );
    procedure Surowce__Zasoby__Informacja__Wyœwietl__Go();
    procedure Œwiat³o__Pozycja__Zmieñ__Go();
    procedure Tury_Wyœwietl__Go();
  public
    { Public declarations }
    bitwa_dominia_we : Bitwa_Dominia.TBitwa_Dominia;
  end;//---//TGra_Okno_Form = class

const
  ranking__wyœwietl__kolumna_indeks__id_c : integer = 3;
  ranking__wyœwietl__kolumna_indeks__l_p_c : integer = 0;
  ranking__wyœwietl__kolumna_indeks__nazwa_gracza_c : integer = 2;
  ranking__wyœwietl__kolumna_indeks__ranking_c : integer = 1;

var
  Gra_Okno_Form: TGra_Okno_Form;

implementation

uses
  Stage.Keyboard,
  System.Math,

  Gra_Okno__Surowiec_Informacja,
  Gra_Okno__Zakup_Przycisk,
  Wizualizacja,
  Wizualizacja__Efekty_Udostepnij,
  Wizualizacja__Obiekty__Mapa;

{$R *.dfm}

//      ***      Funkcje      ***      //

function TGra_Okno_Form.Komunikat_Wyœwietl( const text_f, caption_f : string; const flags_f : integer ) : integer;
var
  czy_pauza_l : boolean;
begin

  czy_pauza_l := Self.Czy_Pauza();

  if not czy_pauza_l then
    Self.Pauza();


  Result := Application.MessageBox( PChar(text_f), PChar(caption_f), flags_f );


  if not czy_pauza_l then
    Self.Pauza();

end;//---//Funkcja Komunikat_Wyœwietl().

procedure TGra_Okno_Form.Kamera__Resetuj( const czy_kamera_pozycja_kopia_f : boolean = false );
const
  mapa_t³o_margines_c_l : single = 100;
begin

  Self.kamera__resetowanie_g := true;


  Gra_GLCamera.ResetRotations();
  Gra_GLCamera.Direction.Z := 1;
  Gra_GLCamera.Up.Y := -1;

  if Self.gra_okno_etap_g = Gra_Okno.goe_bitwa__dominia then
    begin

      if czy_kamera_pozycja_kopia_f then
        Gra_GLCamera.Position.AsAffineVector := Self.kamera_pozycja_kopia_g
      else//if czy_kamera_pozycja_kopia_f then
        Gra_GLCamera.Position.SetPoint(  Wizualizacja.TWizualizacja.mapa__œrodek__x__wi, Wizualizacja.TWizualizacja.mapa__œrodek__y__wi, -System.Math.Max( Self.bitwa_dominia_we.Teren__Wielkoœæ__X__Odczytaj__Bd(), Self.bitwa_dominia_we.Teren__Wielkoœæ__Y__Odczytaj__Bd() ) * 0.3  );

    end
  else//if Self.gra_okno_etap_g = Gra_Okno.goe_bitwa__dominia then
    Gra_GLCamera.Position.SetPoint( Wizualizacja.TWizualizacja.mapa__œrodek__x__wi * Wizualizacja.jednostki__obszar__przesuniêcie__x_c + Self.bitwa_dominia_we.Dominia__Jednostki__Obszar__Wielkoœæ__Odczytaj__Bd() * 0.5, Wizualizacja.TWizualizacja.mapa__œrodek__y__wi, -1 - Self.bitwa_dominia_we.Dominia__Jednostki__Obszar__Wielkoœæ__Odczytaj__Bd() * 0.2 );


  Góra_GLLightSource.Position.X := Gra_GLCamera.Position.X;
  Góra_GLLightSource.Position.Y := Gra_GLCamera.Position.Y;

  Self.Œwiat³o__Pozycja__Zmieñ__Go();


  if Self.mapa_t³o_ustawione_g then
    Exit;


  Dó³_GLLightSource.Position.Z := -10;

  Ziemia_GLPlane.Height := Self.bitwa_dominia_we.Teren__Wielkoœæ__Y__Odczytaj__Bd();
  Ziemia_GLPlane.Width := Self.bitwa_dominia_we.Teren__Wielkoœæ__X__Odczytaj__Bd();
  Ziemia_GLPlane.Position.X := Wizualizacja.TWizualizacja.mapa__œrodek__x__wi - Wizualizacja.kratka__wielkoœæ_c * 0.5;
  Ziemia_GLPlane.Position.Y := Wizualizacja.TWizualizacja.mapa__œrodek__y__wi - Wizualizacja.kratka__wielkoœæ_c * 0.5;

  Mapa_T³o_GLPlane.Height := Ziemia_GLPlane.Height + Wizualizacja.kratka__wielkoœæ_c * mapa_t³o_margines_c_l;
  Mapa_T³o_GLPlane.Width := Ziemia_GLPlane.Width + Wizualizacja.kratka__wielkoœæ_c * mapa_t³o_margines_c_l;
  Mapa_T³o_GLPlane.Position.X := Ziemia_GLPlane.Position.X;
  Mapa_T³o_GLPlane.Position.Y:= Ziemia_GLPlane.Position.Y;

  Self.mapa_t³o_ustawione_g := true;

end;//---//Funkcja Komunikat_Wyœwietl().

procedure TGra_Okno_Form.Kamera__Ruch( delta_czasu_f : double );
const
  ruch_c_l : single = 40;
begin

  if Stage.Keyboard.IsKeyDown( 'R' ) then // Góra. // uses GLKeyboard.
    Gra_GLCamera.Move( ruch_c_l * delta_czasu_f );

  if Stage.Keyboard.IsKeyDown( 'F' ) then // Dó³.
    Gra_GLCamera.Move( -ruch_c_l * delta_czasu_f );

  if Stage.Keyboard.IsKeyDown( 'A' ) then
    Gra_GLCamera.Slide( -ruch_c_l * delta_czasu_f );

  if Stage.Keyboard.IsKeyDown( 'D' ) then
    Gra_GLCamera.Slide( ruch_c_l * delta_czasu_f );


  if Stage.Keyboard.IsKeyDown( 'W' ) then
    Gra_GLCamera.Lift( ruch_c_l * delta_czasu_f );

  if Stage.Keyboard.IsKeyDown( 'S' ) then
    Gra_GLCamera.Lift( -ruch_c_l * delta_czasu_f );


  if Stage.Keyboard.IsKeyDown( 'Q' ) then // Beczka w lewo.
    Gra_GLCamera.Roll( ruch_c_l * delta_czasu_f * 10 );

  if Stage.Keyboard.IsKeyDown( 'E' ) then // Beczka w prawo.
    Gra_GLCamera.Roll( -ruch_c_l * delta_czasu_f * 10 );


  if Stage.Keyboard.IsKeyDown( 'Z' ) then // Obrót w lewo.
    Gra_GLCamera.Turn( -ruch_c_l * delta_czasu_f * 10 );

  if Stage.Keyboard.IsKeyDown( 'X' ) then // Obrót w prawo.
    Gra_GLCamera.Turn( ruch_c_l * delta_czasu_f * 10 );


  Self.Œwiat³o__Pozycja__Zmieñ__Go();

end;//---//Funkcja Kamera__Ruch().

function TGra_Okno_Form.Czy_Pauza() : boolean;
begin

  //
  // Funkcja sprawdza czy jest aktywna pauza.
  //
  // Zwraca prawdê gdy jest aktywna pauza.
  //

  Result := not GLCadencer1.Enabled;

end;//---//Funkcja Czy_Pauza().

procedure TGra_Okno_Form.Pauza();
begin

  GLCadencer1.Enabled := not GLCadencer1.Enabled;


  if GLCadencer1.Enabled then
    begin

      // Nie pauza.

      Bitwa_Jednostki_Timer.Enabled :=
           ( Self.gra_okno_etap_g = Gra_Okno.goe_bitwa__jednostki__starcie )
        or ( Self.gra_okno_etap_g = Gra_Okno.goe_bitwa__jednostki__wynik__prezentacja );

      Tura_Timer.Enabled := Self.gra_okno_etap_g = Gra_Okno.goe_bitwa__dominia;

    end
  else//if GLCadencer1.Enabled then
    begin

      // Pauza.

      Bitwa_Jednostki_Timer.Enabled := false;
      Tura_Timer.Enabled := false;

      Self.FormResize( nil );

    end;
  //---//if GLCadencer1.Enabled then


  Pauza_GLHUDText.Visible := Self.Czy_Pauza();
  Pauza_GLHUDSprite.Visible := Pauza_GLHUDText.Visible;

end;//---//Funkcja Pauza().

procedure TGra_Okno_Form.Gra_Wspó³czynnik_Prêdkoœci__Informacja__Wyœwietl__Go();
begin

  Gra_Wspó³czynnik_Prêdkoœci_Label.Caption :=
    'Pt: ' + Trim(  FormatFloat( '### ### ##0', Tura_Timer.Interval )  ) +
    '| Pb: ' +
    Trim(  FormatFloat( '### ### ##0', Bitwa_Jednostki_Timer.Interval )  ) +
    ' [ms]';

end;//---//Funkcja Gra_Wspó³czynnik_Prêdkoœci__Informacja__Wyœwietl__Go().

procedure TGra_Okno_Form.Gra_Wspó³czynnik_Prêdkoœci__Zmieñ__Go( const zmiana_kierunek_f : smallint );
const
  interwa³_zmiana_skok_c_l : cardinal = 100;
begin

  //
  // Funkcja zmienia prêdkoœæ gry.
  //
  // Parametry:
  //   zmiana_kierunek_f:
  //     -1 - spowalnia.
  //     0 - normalna prêdkoœæ gry.
  //     1 - przyœpiesza.
  //

  if zmiana_kierunek_f = 0 then
    begin

      if Self.gra_okno_etap_g in [ Gra_Okno.goe_bitwa__jednostki__starcie, Gra_Okno.goe_bitwa__jednostki__wynik__prezentacja, Gra_Okno.goe_bitwa__jednostki__zakup ] then
        Bitwa_Jednostki_Timer.Interval := 1000;

      if Self.gra_okno_etap_g in [ Gra_Okno.goe_bitwa__dominia ] then
        Tura_Timer.Interval := 1000;

    end
  else//if zmiana_kierunek_f = 0 then
    begin

      if zmiana_kierunek_f >= 1 then
        begin

          if Self.gra_okno_etap_g in [ Gra_Okno.goe_bitwa__jednostki__starcie, Gra_Okno.goe_bitwa__jednostki__wynik__prezentacja, Gra_Okno.goe_bitwa__jednostki__zakup ] then
            Bitwa_Jednostki_Timer.Interval := Bitwa_Jednostki_Timer.Interval
              - interwa³_zmiana_skok_c_l;

          if Self.gra_okno_etap_g in [ Gra_Okno.goe_bitwa__dominia ] then
            Tura_Timer.Interval := Tura_Timer.Interval
              - interwa³_zmiana_skok_c_l;

        end
      else//if zmiana_kierunek_f >= 1 then
        begin

          if Self.gra_okno_etap_g in [ Gra_Okno.goe_bitwa__jednostki__starcie, Gra_Okno.goe_bitwa__jednostki__wynik__prezentacja, Gra_Okno.goe_bitwa__jednostki__zakup ] then
            Bitwa_Jednostki_Timer.Interval := Bitwa_Jednostki_Timer.Interval
              + interwa³_zmiana_skok_c_l;

          if Self.gra_okno_etap_g in [ Gra_Okno.goe_bitwa__dominia ] then
            Tura_Timer.Interval := Tura_Timer.Interval
              + interwa³_zmiana_skok_c_l;

        end;
      //---//if zmiana_kierunek_f >= 1 then

    end;
  //---//if zmiana_kierunek_f = 0 then


  if Bitwa_Jednostki_Timer.Interval < 100 then
    Bitwa_Jednostki_Timer.Interval := 100;

  if Tura_Timer.Interval < 100 then
    Tura_Timer.Interval := 100;


  Gra_Okno.TGra_Okno_Form.bitwa_jednostki_timer__interval__kopia_g := Bitwa_Jednostki_Timer.Interval;
  Gra_Okno.TGra_Okno_Form.tura_timer__interval__kopia_g := Tura_Timer.Interval;


  Self.Gra_Wspó³czynnik_Prêdkoœci__Informacja__Wyœwietl__Go();

end;//---//Funkcja Gra_Wspó³czynnik_Prêdkoœci__Zmieñ__Go().

procedure TGra_Okno_Form.Budowa__Tryb__Ustaw__Go( const budowa__tryb_f : boolean; const budowla_rodzaj_f : Definicje.TBudowla_Rodzaj = Definicje.br_domek );
var
  x_l,
  y_l,
  obserwacja__zasiêg_l
    : integer;

  zt_mapa_kratka : Wizualizacja__Obiekty__Mapa.TMapa_Kratka;
begin

  if Self.budowa__tryb_g = budowa__tryb_f then
    Exit;


  Self.budowa__tryb_g := budowa__tryb_f;


  if Self.budowa__tryb_g then
    begin

      Self.budowa__tryb__budowla_g := Wizualizacja__Obiekty__Budowle.TWizualizacja__Budowla.Create( Self.Gra_Obiekty_GLDummyCube, Definicje.dominium__numer__puste_c, Definicje.identyfikator_pusty_c, budowla_rodzaj_f, 0 );
      Self.budowa__tryb__budowla_g.Parent := Self.Gra_Obiekty_GLDummyCube;
      Self.budowa__tryb__budowla_g.CubeSize := Wizualizacja.kratka__wielkoœæ_c;
      Self.budowa__tryb__budowla_g.Position.X := Wizualizacja.TWizualizacja.mapa__œrodek__x__wi - Wizualizacja.kratka__wielkoœæ_c * 0.5;
      Self.budowa__tryb__budowla_g.Position.Y := Wizualizacja.TWizualizacja.mapa__œrodek__y__wi - Wizualizacja.kratka__wielkoœæ_c * 0.5;
      Self.budowa__tryb__budowla_g.Position.Z := -Self.budowa__tryb__budowla_g.CubeSize * 0.5;
      Self.budowa__tryb__budowla_g.Position.Z := Self.budowa__tryb__budowla_g.Position.Z - 0.1;

      if budowla_rodzaj_f in [ Definicje.br_wie¿a__obronna, Definicje.br_wie¿a__zwiadowcza ] then
        begin

          if budowla_rodzaj_f in [ Definicje.br_wie¿a__zwiadowcza ] then
            obserwacja__zasiêg_l := Definicje.obserwacja__zasiêg___wie¿a__zwiadowcza_c
          else
            obserwacja__zasiêg_l := Definicje.obserwacja__zasiêg___wie¿a__obronna_c;

          for y_l := -obserwacja__zasiêg_l to obserwacja__zasiêg_l do
            for x_l := -obserwacja__zasiêg_l to obserwacja__zasiêg_l do
              begin

                zt_mapa_kratka := Wizualizacja__Obiekty__Mapa.TMapa_Kratka.Create( Self.budowa__tryb__budowla_g );
                zt_mapa_kratka.Parent := Self.budowa__tryb__budowla_g;
                zt_mapa_kratka.Id__Zmieñ__Mk( x_l, y_l );
                zt_mapa_kratka.CubeSize := Wizualizacja.kratka__wielkoœæ_c;
                zt_mapa_kratka.Position.Z := Self.budowa__tryb__budowla_g.CubeSize * 0.45;

              end;
            //---//for x_l := obserwacja__zasiêg_l to obserwacja__zasiêg_l do

        end;
      //---//if budowla_rodzaj_f in [ Definicje.br_wie¿a__obronna, Definicje.br_wie¿a__zwiadowcza ] then


      Self.Gra_GLSceneViewerMouseMove( nil, [], Mouse.CursorPos.X, Mouse.CursorPos.Y );

    end
  else//if Self.budowa__tryb_g then
    begin

      if Self.budowa__tryb__budowla_g <> nil then
        FreeAndNil( Self.budowa__tryb__budowla_g );

    end;
  //---//if Self.budowa__tryb_g then

end;//---//Funkcja Budowa__Tryb__Ustaw__Go().

procedure TGra_Okno_Form.Budowa__Tryb__Zmieñ__Go( const budowla_rodzaj_f : Definicje.TBudowla_Rodzaj );
begin

  if     ( Self.budowa__tryb_g )
     and ( Self.budowa__tryb__budowla_g <> nil )
     and ( Self.budowa__tryb__budowla_g.Budowla__Rodzaj__Odczytaj__Wbu() <> budowla_rodzaj_f ) then
    begin

      Self.Budowa__Tryb__Ustaw__Go( not Self.budowa__tryb_g, budowla_rodzaj_f );
      Self.Budowa__Tryb__Ustaw__Go( not Self.budowa__tryb_g, budowla_rodzaj_f );

    end
  else//if     ( Self.budowa__tryb_g ) (...)
    begin

      Self.Budowa__Tryb__Ustaw__Go( not Self.budowa__tryb_g, budowla_rodzaj_f );

    end;
  //---//if     ( Self.budowa__tryb_g ) (...)

end;//---//Funkcja Budowa__Tryb__Zmieñ__Go().

procedure TGra_Okno_Form.Gra_Okno_Etap__Interfejs__Dostosuj__Go();
begin

  Jednostki__Wytrzyma³oœæ_Punkty__Panel.Visible :=
       ( Self.gra_okno_etap_g = Gra_Okno.goe_bitwa__jednostki__starcie )
    or ( Self.gra_okno_etap_g = Gra_Okno.goe_bitwa__jednostki__wynik__prezentacja )
    or ( Self.gra_okno_etap_g = Gra_Okno.goe_bitwa__jednostki__zakup );

  Zakup__Budynki_Panel.Visible := Self.gra_okno_etap_g = Gra_Okno.goe_bitwa__dominia;
  Zakup__Jednostki_Panel.Visible := Self.gra_okno_etap_g = Gra_Okno.goe_bitwa__jednostki__zakup;

end;//---//Funkcja Gra_Okno_Etap__Interfejs__Dostosuj__Go().

procedure TGra_Okno_Form.Jednostki__Obszar__T³o__Ustaw__Go();
begin

  Jednostki_Obszar_T³o_GLPlane.Width := Self.bitwa_dominia_we.Dominia__Jednostki__Obszar__Wielkoœæ__Odczytaj__Bd() + 2;

  Jednostki_Obszar_T³o_GLPlane.Position.X :=
      Wizualizacja.TWizualizacja.mapa__œrodek__x__wi
    * Wizualizacja.jednostki__obszar__przesuniêcie__x_c
    - Wizualizacja.kratka__wielkoœæ_c
    * 0.5
    + Self.bitwa_dominia_we.Dominia__Jednostki__Obszar__Wielkoœæ__Odczytaj__Bd()
    * 0.5;
  Jednostki_Obszar_T³o_GLPlane.Position.Y := Wizualizacja.TWizualizacja.mapa__œrodek__y__wi - Wizualizacja.kratka__wielkoœæ_c * 0.5;

end;//---//Funkcja Jednostki__Obszar__T³o__Ustaw__Go().

procedure TGra_Okno_Form.Jednostki__Wytrzyma³oœæ_Punkty__Wyœwietl__Go( const procent_100_zapamiêtaj_f : boolean = false );
var
  ztr_1,
  ztr_2
    : real;
begin

  ztr_1 := Self.bitwa_dominia_we.Bitwa__Jednostki__Jednostki__Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Bd( Definicje.dominium__numer__gracz__1_c );
  ztr_2 := Self.bitwa_dominia_we.Bitwa__Jednostki__Jednostki__Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Bd( Definicje.dominium__numer__gracz__2_c );


  if procent_100_zapamiêtaj_f then
    Self.jednostki__wytrzyma³oœæ_punkty__procent_100_g := System.Math.Max( ztr_1, ztr_2 );


  Jednostki__Wytrzyma³oœæ_Punkty__Gracz__1_Panel.Caption := Trim(  FormatFloat( '### ### ##0.0', ztr_1 )  );
  Jednostki__Wytrzyma³oœæ_Punkty__Gracz__1_Panel.Hint := Jednostki__Wytrzyma³oœæ_Punkty__Gracz__1_Panel.Caption;

  Jednostki__Wytrzyma³oœæ_Punkty__Gracz__2_Panel.Caption := Trim(  FormatFloat( '### ### ##0.0', ztr_2 )  );
  Jednostki__Wytrzyma³oœæ_Punkty__Gracz__2_Panel.Hint := Jednostki__Wytrzyma³oœæ_Punkty__Gracz__2_Panel.Caption;


  if Self.jednostki__wytrzyma³oœæ_punkty__procent_100_g <> 0 then
    begin

      ztr_1 := 100 * ztr_1 / Self.jednostki__wytrzyma³oœæ_punkty__procent_100_g;
      ztr_2 := 100 * ztr_2 / Self.jednostki__wytrzyma³oœæ_punkty__procent_100_g;


    end
  else//if Self.jednostki__wytrzyma³oœæ_punkty__procent_100_g <> 0 then
    begin

      ztr_1 := 1;
      ztr_2 := 1;

    end;
  //---//if Self.jednostki__wytrzyma³oœæ_punkty__procent_100_g <> 0 then


  ztr_1 := ( Jednostki__Wytrzyma³oœæ_Punkty__Panel.Width - 10 ) * ztr_1 * 0.01;
  ztr_2 := ( Jednostki__Wytrzyma³oœæ_Punkty__Panel.Width - 10 ) * ztr_2 * 0.01;

  if ztr_1 <= 0 then
    ztr_1 := 1;

  if ztr_2 <= 0 then
    ztr_2 := 1;

  Jednostki__Wytrzyma³oœæ_Punkty__Gracz__1_Panel.Width := Round( ztr_1 );
  Jednostki__Wytrzyma³oœæ_Punkty__Gracz__2_Panel.Width := Round( ztr_2 );

end;//---//Funkcja Jednostki__Wytrzyma³oœæ_Punkty__Wyœwietl__Go().

procedure TGra_Okno_Form.Jednostki__Zakup__Obs³uga__Go( const jednostki_po³¹cz_f, teren_kup_f : boolean; const jednostka_typ_f : Definicje.TJednostka_Typ; const jednostka_typ__po³¹cz_f : Definicje.TJednostka_Typ = Definicje.jt_pusta );
begin

  if Self.bitwa_dominia_we.Jednostki__Zakup__Obs³uga__Bd( jednostki_po³¹cz_f, teren_kup_f, jednostka_typ_f, jednostka_typ__po³¹cz_f ) then
    begin

      Self.Surowce__Zasoby__Informacja__Wyœwietl__Go();

      Self.bitwa_dominia_we.Bitwa__Jednostki___Starcie__Zwolnij__Bd();
      Self.bitwa_dominia_we.Bitwa__Jednostki___Starcie__Przygotuj__Bd();

      Self.Jednostki__Wytrzyma³oœæ_Punkty__Wyœwietl__Go( true );

      Self.bitwa_dominia_we.Wizualizacja__Rysuj__Bd( Self.bitwa_dominia_we, [ Bitwa_Dominia.wrz_jednostki__jednostki, Bitwa_Dominia.wrz_jednostki__obszar ], 1, true );


      if teren_kup_f then
        Self.Jednostki__Obszar__T³o__Ustaw__Go();

    end;
  //---//if Self.bitwa_dominia_we.Jednostki__Zakup__Obs³uga__Bd( jednostki_po³¹cz_f, teren_kup_f, jednostka_typ_f, jednostka_typ__po³¹cz_f ) then

end;//---//Funkcja Jednostki__Zakup__Obs³uga__Go().

procedure TGra_Okno_Form.Surowce__Zasoby__Informacja__Wyœwietl__Go();
var
  ztb : boolean;

  ztsi : smallint;

  i,
  j,
  surowiec__iloœæ__kryszta³_l,
  surowiec__iloœæ__magma_l,
  surowiec__iloœæ__¿ywio³_l
    : integer;

  jednostka_typ__po³¹cz_l : Definicje.TJednostka_Typ;

  surowce_zasoby_t : Definicje.TSurowce_Zasoby;
begin

  if Self.bitwa_dominia_we = nil then
    Exit;


  if   (
             ( Self.bitwa_dominia_we.Dominium__Gra_Gracz__1__Bd() )
         and ( not Surowce_Przeciwnik_Podgl¹d_CheckBox.Checked )
       )
    or (
             ( not Self.bitwa_dominia_we.Dominium__Gra_Gracz__1__Bd() )
         and ( Surowce_Przeciwnik_Podgl¹d_CheckBox.Checked )
       ) then
    ztsi := Definicje.dominium__numer__gracz__1_c
  else//if   ( (...)
    ztsi := Definicje.dominium__numer__gracz__2_c;


  surowce_zasoby_t := Self.bitwa_dominia_we.Dominium__Surowce__Zasoby__Odczytaj__Bd( ztsi );


  surowiec__iloœæ__kryszta³_l := 0;
  surowiec__iloœæ__magma_l := 0;
  surowiec__iloœæ__¿ywio³_l := 0;


  for i := 0 to Length( surowce_zasoby_t ) - 1 do
    begin

      if surowce_zasoby_t[ i ].surowiec__rodzaj__sz = Definicje.sr_kryszta³ then
        surowiec__iloœæ__kryszta³_l := surowce_zasoby_t[ i ].surowiec__iloœæ__sz;

      if surowce_zasoby_t[ i ].surowiec__rodzaj__sz = Definicje.sr_magma then
        surowiec__iloœæ__magma_l := surowce_zasoby_t[ i ].surowiec__iloœæ__sz;


      for j := 0 to Surowce_Panel.ControlCount - 1 do
        if    ( Surowce_Panel.Controls[ j ].ClassType = TSurowiec_Informacja )
          and ( TSurowiec_Informacja(Surowce_Panel.Controls[ j ]).Surowiec__Rodzaj__Odczytaj__Si() = surowce_zasoby_t[ i ].surowiec__rodzaj__sz ) then
          begin

            TSurowiec_Informacja(Surowce_Panel.Controls[ j ]).Iloœæ_Ustaw__Si( surowce_zasoby_t[ i ].surowiec__iloœæ__sz );


            Break;

          end;
        //---//if    ( Surowce_Panel.Controls[ j ].ClassType = TSurowiec_Informacja ) (...)

    end;
  //---//for i := 0 to Length( surowce_zasoby_t ) - 1 do


  for i := 0 to Zakup__Jednostki_Panel.ControlCount - 1 do
    if Zakup__Jednostki_Panel.Controls[ i ].ClassType = Gra_Okno__Zakup_Przycisk.TZakup_Przycisk then
      begin

        if Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Jednostki_Panel.Controls[ i ]).Jednostki_Po³¹cz__Odczytaj__Zp() then
          begin

            jednostka_typ__po³¹cz_l := Definicje.jt_jazda;

            ztb := Self.bitwa_dominia_we.Jednostki__Po³¹cz__Bd( jednostka_typ__po³¹cz_l, surowiec__iloœæ__¿ywio³_l, true );

            if not ztb then
              begin

                jednostka_typ__po³¹cz_l := Definicje.jt_piechota;

                ztb := Self.bitwa_dominia_we.Jednostki__Po³¹cz__Bd( jednostka_typ__po³¹cz_l, surowiec__iloœæ__¿ywio³_l, true );

              end;
            //---//if not ztb then

            if not Self.bitwa_dominia_we.Jednostki__Po³¹cz__Jednostki__Dostêpne__Bd( Definicje.jt_pusta ) then
              jednostka_typ__po³¹cz_l := Definicje.jt_pusta;


            Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Jednostki_Panel.Controls[ i ]).Aktywnoœæ__Ustaw__Zp(  ztb, Self.bitwa_dominia_we.Jednostki__Po³¹cz__Surowce__Wystarczy__Bd( jednostka_typ__po³¹cz_l )  );

            Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Jednostki_Panel.Controls[ i ]).Wartoœci__Ustaw__Zp( jednostka_typ__po³¹cz_l, surowiec__iloœæ__¿ywio³_l );

          end
        else//if Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Jednostki_Panel.Controls[ i ]).Jednostki_Po³¹cz__Odczytaj__Zp() then
        if Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Jednostki_Panel.Controls[ i ]).Teren_Kup__Odczytaj__Zp() then
          begin

            Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Jednostki_Panel.Controls[ i ]).Aktywnoœæ__Ustaw__Zp(  Self.bitwa_dominia_we.Jednostki__Obszar__Wolny__Zakup__Bd( surowiec__iloœæ__kryszta³_l, surowiec__iloœæ__magma_l, true )  );
            Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Jednostki_Panel.Controls[ i ]).Wartoœci__Ustaw__Zp( surowiec__iloœæ__kryszta³_l, surowiec__iloœæ__magma_l );

          end
        else//if Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Jednostki_Panel.Controls[ i ]).Teren_Kup__Odczytaj__Zp() then
        if   ( Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Jednostki_Panel.Controls[ i ]).Jednostka_Typ__Odczytaj__Zp() = Definicje.jt_jazda )
          or ( Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Jednostki_Panel.Controls[ i ]).Jednostka_Typ__Odczytaj__Zp() = Definicje.jt_piechota ) then
          begin

            ztb :=
                  Self.bitwa_dominia_we.Jednostki__Obszar__Wolny__Dostêpnoœæ__SprawdŸ__Bd()
              and Self.bitwa_dominia_we.Jednostka__Zakup__Jedn¹__Mo¿na__SprawdŸ__Bd( Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Jednostki_Panel.Controls[ i ]).Jednostka_Typ__Odczytaj__Zp() );


            Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Jednostki_Panel.Controls[ i ]).Aktywnoœæ__Ustaw__Zp
              (
                ztb,
                Self.bitwa_dominia_we.Jednostka__Zakup__Jedn¹__Mo¿na__SprawdŸ__Bd( Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Jednostki_Panel.Controls[ i ]).Jednostka_Typ__Odczytaj__Zp() )
              );

          end;
        //---//if   ( Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Jednostki_Panel.Controls[ i ]).Jednostka_Typ__Odczytaj__Zp() = Definicje.jt_jazda ) (...)

      end;
    //---//if Zakup__Jednostki_Panel.Controls[ i ].ClassType = Gra_Okno__Zakup_Przycisk.TZakup_Przycisk then


  for i := 0 to Zakup__Budynki_Panel.ControlCount - 1 do
    if Zakup__Budynki_Panel.Controls[ i ].ClassType = Gra_Okno__Zakup_Przycisk.TZakup_Przycisk then
      Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Budynki_Panel.Controls[ i ]).Aktywnoœæ__Ustaw__Zp(  Self.bitwa_dominia_we.Budowla__Surowce__Zmniejsz__Zbuduj__Bd( ztsi, Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Budynki_Panel.Controls[ i ]).Budowla__Rodzaj__Odczytaj__Zp(), true )  );

end;//---//Funkcja Surowce__Zasoby__Informacja__Wyœwietl__Go().

procedure TGra_Okno_Form.Œwiat³o__Pozycja__Zmieñ__Go();
begin

  Dó³_GLLightSource.Position.X := Gra_GLCamera.Position.X;
  Dó³_GLLightSource.Position.Y := Gra_GLCamera.Position.Y;

end;//---//Œwiat³o__Pozycja__Zmieñ__Go().

procedure TGra_Okno_Form.Tury_Wyœwietl__Go();
begin

  if Self.gra_okno_etap_g <> Gra_Okno.goe_bitwa__dominia then
    begin

      Tura_Panel.Caption := '---';

      Exit;

    end;
  //---//if Self.gra_okno_etap_g <> Gra_Okno.goe_bitwa__dominia then


  Tura_Panel.Caption :=
    Trim(  FormatFloat( '### ### ##0', Self.tury__przeliczenia_g )  ) +
    ' / ' +
    Trim(  FormatFloat( '### ### ##0', Self.bitwa_dominia_we.Przeliczeñ_W_Turze__Odczytaj__Bd() )  );


  if    ( Self.gra_okno_etap_g = Gra_Okno.goe_bitwa__dominia )
    and ( Self.bitwa_dominia_we.Przeliczeñ_W_Turze__Odczytaj__Bd() - Self.tury__przeliczenia_g <= 10 ) then
    begin

      if Tura_Panel.Color <> clBtnFace then
        Tura_Panel.Color := clBtnFace
      else//if Tura_Panel.Color <> clBtnFace then
        Tura_Panel.Color := clYellow;

    end
  else//if    ( Self.gra_okno_etap_g = Gra_Okno.goe_bitwa__dominia ) (...)
    if Tura_Panel.Color <> clBtnFace then
      Tura_Panel.Color := clBtnFace;

end;//---//Funkcja Tury_Wyœwietl__Go().

//---//      ***      Funkcje      ***      //---//

procedure TGra_Okno_Form.FormCreate( Sender: TObject );
begin

  Self.bitwa_dominia_we := nil;
  Self.gra_okno_etap_g := Gra_Okno.goe_bitwa__dominia;
  Self.mapa_t³o_ustawione_g := false;


  Gracz__1__T³o_Panel.Color := Stage.Color.ConvertColorVector( Definicje.kolor__dominium__1_c );
  Gracz__2__T³o_Panel.Color := Stage.Color.ConvertColorVector( Definicje.kolor__dominium__2_c );

  Jednostki__Wytrzyma³oœæ_Punkty__Gracz__1_Panel.Color := Gracz__1__T³o_Panel.Color;
  Jednostki__Wytrzyma³oœæ_Punkty__Gracz__2_Panel.Color := Gracz__2__T³o_Panel.Color;


  Wizualizacja__Efekty_Udostepnij.TWizualizacja__Efekty_Udostepnij.gra_okno_form__weu := Self;

end;//---//FormCreate().

procedure TGra_Okno_Form.FormShow( Sender: TObject );
var
  i : integer;
begin

  if Self.bitwa_dominia_we = nil then
    begin

      Tura_Timer.Interval := 100;
      Tura_Timer.Enabled := true;

      Exit;

    end;
  //---//if Self.bitwa_dominia_we = nil then


  Self.budowa__tryb__budowla_g := nil;
  Self.Budowa__Tryb__Ustaw__Go( false );
  Self.kamera__resetowanie_g := false;
  Self.kamera__ruch_g := false;
  Self.tury__przeliczenia_g := 1;

  GLCadencer1.CurrentTime := 0;

  B³yskawica__1_GLThorFXManager.CoreColor.Color := Definicje.kolor__dominium__1_c;
  B³yskawica__1_GLThorFXManager.GlowSize := 0.01;
  B³yskawica__1_GLThorFXManager.Target.Z := Wizualizacja.kratka__wielkoœæ_c * 0.5;
  B³yskawica__1_GLThorFXManager.Wildness := 0.5;

  B³yskawica__2_GLThorFXManager.CoreColor.Color := Definicje.kolor__dominium__2_c;
  B³yskawica__2_GLThorFXManager.GlowSize := B³yskawica__1_GLThorFXManager.GlowSize;
  B³yskawica__2_GLThorFXManager.Target.Z := B³yskawica__1_GLThorFXManager.Target.Z;
  B³yskawica__2_GLThorFXManager.Wildness := B³yskawica__1_GLThorFXManager.Wildness;

  Ogieñ_GLPolygonPFXManager.Acceleration.SetVector( 0, 0, -0.2 );
  Ogieñ_GLPolygonPFXManager.Friction := 0.5;

  Œwiat³a_Wie¿__1_GLPerlinPFXManager.Acceleration.Z := -0.2;
  Œwiat³a_Wie¿__1_GLPerlinPFXManager.ColorInner.Color := Definicje.kolor__dominium__1_c;
  Œwiat³a_Wie¿__1_GLPerlinPFXManager.Friction := Abs( Œwiat³a_Wie¿__1_GLPerlinPFXManager.Acceleration.Z );

  Œwiat³a_Wie¿__2_GLPerlinPFXManager.Acceleration.Z := Œwiat³a_Wie¿__1_GLPerlinPFXManager.Acceleration.Z;
  Œwiat³a_Wie¿__2_GLPerlinPFXManager.ColorInner.Color := Definicje.kolor__dominium__2_c;
  Œwiat³a_Wie¿__2_GLPerlinPFXManager.Friction := Œwiat³a_Wie¿__1_GLPerlinPFXManager.Friction;


  Lewo_GLCube.Visible := false;
  Zero_GLSphere.Visible := false;


  if Gra_Okno.TGra_Okno_Form.bitwa_jednostki_timer__interval__kopia_g = 0 then
    begin

      Gra_Okno.TGra_Okno_Form.zakup__jednostki__automatycznie__zawsze__kopia_g := Zakup__Jednostki__Automatycznie__Zawsze_CheckBox.Checked;
      Gra_Okno.TGra_Okno_Form.bitwa_jednostki_timer__interval__kopia_g := Bitwa_Jednostki_Timer.Interval;
      Gra_Okno.TGra_Okno_Form.tura_timer__interval__kopia_g := Tura_Timer.Interval;

    end
  else//if Gra_Okno.TGra_Okno_Form.bitwa_jednostki_timer__interval__kopia_g = 0 then
    begin

      Bitwa_Jednostki_Timer.Interval := Gra_Okno.TGra_Okno_Form.bitwa_jednostki_timer__interval__kopia_g;
      Tura_Timer.Interval := Gra_Okno.TGra_Okno_Form.tura_timer__interval__kopia_g;
      Zakup__Jednostki__Automatycznie__Zawsze_CheckBox.Checked := Gra_Okno.TGra_Okno_Form.zakup__jednostki__automatycznie__zawsze__kopia_g;

    end;
  //---//if Gra_Okno.TGra_Okno_Form.bitwa_jednostki_timer__interval__kopia_g = 0 then

  Self.Gra_Wspó³czynnik_Prêdkoœci__Informacja__Wyœwietl__Go();


  Wizualizacja.TWizualizacja.Inicjuj__Wi( Self.Gra_Obiekty_GLDummyCube );
  Wizualizacja.TWizualizacja.Kamera__Resetuj__Wi := Kamera__Resetuj;


  Gra_GLSceneViewer.Align := alClient;
  Surowce_Panel.Align := alClient;


  Self.Tury_Wyœwietl__Go();


  Gracz__1_RadioGroup.Caption := Self.bitwa_dominia_we.Dominium__Gracz__Nazwa__Odczytaj__Bd( Definicje.dominium__numer__gracz__1_c );
  Gracz__2_RadioGroup.Caption := Self.bitwa_dominia_we.Dominium__Gracz__Nazwa__Odczytaj__Bd( Definicje.dominium__numer__gracz__2_c );

  Gracz__1__T³o_Panel.Hint := Self.bitwa_dominia_we.Dominium__Gracz__Parametry__Odczytaj__Bd( Definicje.dominium__numer__gracz__1_c );
  Gracz__2__T³o_Panel.Hint := Self.bitwa_dominia_we.Dominium__Gracz__Parametry__Odczytaj__Bd( Definicje.dominium__numer__gracz__2_c );

  Gracz__1_RadioGroup.Columns := Self.bitwa_dominia_we.Dominium__Wytrzyma³oœæ_Punkty__Odczytaj__Bd( Definicje.dominium__numer__gracz__1_c );
  Gracz__2_RadioGroup.Columns := Self.bitwa_dominia_we.Dominium__Wytrzyma³oœæ_Punkty__Odczytaj__Bd( Definicje.dominium__numer__gracz__2_c );

  Gracz__1_RadioGroup.Items.Clear();
  Gracz__2_RadioGroup.Items.Clear();

  for i := 1 to Self.bitwa_dominia_we.Dominium__Wytrzyma³oœæ_Punkty__Odczytaj__Bd( Definicje.dominium__numer__gracz__1_c ) do
    Gracz__1_RadioGroup.Items.Add( '' );

  for i := 1 to Self.bitwa_dominia_we.Dominium__Wytrzyma³oœæ_Punkty__Odczytaj__Bd( Definicje.dominium__numer__gracz__2_c ) do
    Gracz__2_RadioGroup.Items.Add( '' );


  for i := Ord(  High( Definicje.TSurowiec_Rodzaj )  ) downto Ord(  Low( Definicje.TSurowiec_Rodzaj )  ) do
    Gra_Okno__Surowiec_Informacja.TSurowiec_Informacja.Create( Self, Surowce_Panel, Definicje.TSurowiec_Rodzaj(i) );


  Zakup__Budynki_Panel.Align := alTop;
  Zakup__Jednostki_Panel.Align := alTop;

  Zakup__Jednostki_Panel.Height :=
      Bitwa__Jednostki__Wynik__Ustal_Button.Height
    + Bitwa__Jednostki__Wynik__Ustal_Button.Margins.Bottom
    + Bitwa__Jednostki__Wynik__Ustal_Button.Margins.Top
    + Zakup__Jednostki__Automatycznie_Button.Height
    + Zakup__Jednostki__Automatycznie_Button.Margins.Bottom
    + Zakup__Jednostki__Automatycznie_Button.Margins.Top
    + 1;
  Gra_Okno__Zakup_Przycisk.TZakup_Przycisk.Create( Self, Zakup__Jednostki_Panel, Definicje.jt_pusta, false, true, Self.Jednostki__Zakup__Obs³uga__Go );
  Gra_Okno__Zakup_Przycisk.TZakup_Przycisk.Create( Self, Zakup__Jednostki_Panel, Definicje.jt_pusta, true, false, Self.Jednostki__Zakup__Obs³uga__Go );
  Gra_Okno__Zakup_Przycisk.TZakup_Przycisk.Create( Self, Zakup__Jednostki_Panel, Definicje.jt_jazda, false, false, Self.Jednostki__Zakup__Obs³uga__Go );
  Gra_Okno__Zakup_Przycisk.TZakup_Przycisk.Create( Self, Zakup__Jednostki_Panel, Definicje.jt_piechota, false, false, Self.Jednostki__Zakup__Obs³uga__Go );

  Zakup__Budynki_Panel.Height := 1;
  Gra_Okno__Zakup_Przycisk.TZakup_Przycisk.Create( Self, Zakup__Budynki_Panel, Definicje.br_koszary, Self.Budowa__Tryb__Zmieñ__Go );
  Gra_Okno__Zakup_Przycisk.TZakup_Przycisk.Create( Self, Zakup__Budynki_Panel, Definicje.br_wie¿a__obronna, Self.Budowa__Tryb__Zmieñ__Go );
  Gra_Okno__Zakup_Przycisk.TZakup_Przycisk.Create( Self, Zakup__Budynki_Panel, Definicje.br_domek, Self.Budowa__Tryb__Zmieñ__Go );
  Gra_Okno__Zakup_Przycisk.TZakup_Przycisk.Create( Self, Zakup__Budynki_Panel, Definicje.br_wie¿a__zwiadowcza, Self.Budowa__Tryb__Zmieñ__Go );

  Zakup__Budynki_Panel.Align := alBottom;
  Zakup__Jednostki_Panel.Align := alBottom;


  Self.Surowce__Zasoby__Informacja__Wyœwietl__Go();


  Self.GLWindowsBitmapFont1.EnsureString( Pauza_GLHUDText.Text );


  Self.Gra_Okno_Etap__Interfejs__Dostosuj__Go();


  Self.WindowState := TWindowState.wsMaximized;

  Wizualizacja.TWizualizacja.Wizualizacja__Zwolnij__Wi();

  Self.bitwa_dominia_we.Wizualizacja__Rysuj__Bd( Self.bitwa_dominia_we, [ Bitwa_Dominia.wrz_budowle, Bitwa_Dominia.wrz_jednostki__obszar, Bitwa_Dominia.wrz_mapa, Bitwa_Dominia.wrz_surowce ], 1, true );

  Self.Jednostki__Obszar__T³o__Ustaw__Go();


  if Self.Czy_Pauza() then
    Self.Pauza();


  Screen.Cursor := crDefault;


  Gra_GLSceneViewer.SetFocus();

end;//---//FormShow().

procedure TGra_Okno_Form.FormClose( Sender: TObject; var Action: TCloseAction );
begin

  if not Self.Czy_Pauza() then
    Self.Pauza();


  if    ( Self.bitwa_dominia_we <> nil )
    and (  not Self.bitwa_dominia_we.Bitwa__Dominia__Koniec__Warunek__SprawdŸ__Bd( Self.bitwa_dominia_we )  ) then
    {$IFNDEF DEBUG}
    if Self.Komunikat_Wyœwietl( 'Poddaæ bitwê?' + #13 + #13 + '<Den Kampf aufgeben?>' + #13 + #13 + '<Give up the battle?>', 'Potwierdzenie', MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    {$ELSE abc}
    if false then
    {$ENDIF}
      begin

        Action := caNone;
        Exit;

      end
    else//if Self.Komunikat_Wyœwietl( 'Poddaæ bitwê?' + #13 + #13 + '<Den Kampf aufgeben?>' + #13 + #13 + '<Give up the battle?>', 'Potwierdzenie', MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
      begin

        Tura_Timer.Enabled := false;

        Self.bitwa_dominia_we.Bitwa__Dominia__Gracz__Poddaje_Siê__Bd();

        {$IFNDEF DEBUG}
        Self.Komunikat_Wyœwietl( 'Pora¿ka.' + #13 + #13 + '<Misserfolg.>' + #13 + #13 + '<Defeat.>', 'Informacja', MB_ICONSTOP );
        {$ENDIF}

      end;
    //---//if Self.Komunikat_Wyœwietl( 'Poddaæ bitwê?' + #13 + #13 + '<Den Kampf aufgeben?>' + #13 + #13 + '<Give up the battle?>', 'Potwierdzenie', MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then


  Gra_Okno.TGra_Okno_Form.zakup__jednostki__automatycznie__zawsze__kopia_g := Zakup__Jednostki__Automatycznie__Zawsze_CheckBox.Checked;


  Self.bitwa_dominia_we.Bitwa__Jednostki___Starcie__Zwolnij__Bd();


  if Self.budowa__tryb__budowla_g <> nil then
    FreeAndNil( Self.budowa__tryb__budowla_g );

  Wizualizacja.TWizualizacja.Zwolnij__Wszystko__Wi();


  Wizualizacja__Efekty_Udostepnij.TWizualizacja__Efekty_Udostepnij.gra_okno_form__weu := nil;

end;//---//FormClose().

procedure TGra_Okno_Form.FormResize( Sender: TObject );
begin

  if not Pauza_GLHUDText.Visible then
    Exit;


  Pauza_GLHUDText.Position.Y := Gra_GLSceneViewer.Height * 0.5;
  Pauza_GLHUDText.Position.X := Gra_GLSceneViewer.Width * 0.5;
  Pauza_GLHUDSprite.Position := Pauza_GLHUDText.Position;

end;//---//FormResize().

procedure TGra_Okno_Form.GLCadencer1Progress( Sender: TObject; const deltaTime, newTime: Double );
const
 delta_czasu_modyfikator_c : single = 40;

var
  gra_wspó³czynnik_prêdkoœci_l : single;
begin

  if Gra_GLSceneViewer.Focused then
    Self.Kamera__Ruch( deltaTime );


  if Self.gra_okno_etap_g = Gra_Okno.goe_bitwa__dominia then
    gra_wspó³czynnik_prêdkoœci_l := Tura_Timer.Interval * 0.001
  else//if Self.gra_okno_etap_g = Gra_Okno.goe_bitwa__dominia then
    gra_wspó³czynnik_prêdkoœci_l := Bitwa_Jednostki_Timer.Interval * 0.001;

  if gra_wspó³czynnik_prêdkoœci_l <> 0 then
    gra_wspó³czynnik_prêdkoœci_l := 1 / gra_wspó³czynnik_prêdkoœci_l
  else//if gra_wspó³czynnik_prêdkoœci_l <> 0 then
    gra_wspó³czynnik_prêdkoœci_l := 1;

  gra_wspó³czynnik_prêdkoœci_l := gra_wspó³czynnik_prêdkoœci_l
    * delta_czasu_modyfikator_c
    * deltaTime;


  if Self.gra_okno_etap_g = Gra_Okno.goe_bitwa__dominia then
    Self.bitwa_dominia_we.Wizualizacja__Rysuj__Bd( Self.bitwa_dominia_we, [ Bitwa_Dominia.wrz_animacje___mapa ], gra_wspó³czynnik_prêdkoœci_l );

  Self.bitwa_dominia_we.Wizualizacja__Rysuj__Bd( Self.bitwa_dominia_we, [ Bitwa_Dominia.wrz_animacje__jednostki ], gra_wspó³czynnik_prêdkoœci_l );

end;//---//GLCadencer1Progress().

procedure TGra_Okno_Form.Gra_GLSceneViewerClick( Sender: TObject );
begin

  Gra_GLSceneViewer.SetFocus();

end;//---//Gra_GLSceneViewerClick().

procedure TGra_Okno_Form.Gra_GLSceneViewerMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
var
  ztsi : smallint;

  surowiec__rodzaj_l : Definicje.TSurowiec_Rodzaj;
begin

  if    ( Shift = [ ssLeft ] )
    and ( Self.budowa__tryb_g )
    and ( Self.budowa__tryb__budowla_g <> nil ) then
    begin

      //if Self.bitwa_dominia_we.Dominium__Gra_Gracz__1__Bd() then
      //  ztsi := Definicje.dominium__numer__gracz__1_c
      //else//if Self.bitwa_dominia_we.Dominium__Gra_Gracz__1__Bd() then
      //  ztsi := Definicje.dominium__numer__gracz__2_c;
      if   (
                 ( Self.bitwa_dominia_we.Dominium__Gra_Gracz__1__Bd() )
             and ( not Surowce_Przeciwnik_Podgl¹d_CheckBox.Checked )
           )
        or (
                 ( not Self.bitwa_dominia_we.Dominium__Gra_Gracz__1__Bd() )
             and ( Surowce_Przeciwnik_Podgl¹d_CheckBox.Checked )
           ) then
        ztsi := Definicje.dominium__numer__gracz__1_c
      else//if   ( (...)
        ztsi := Definicje.dominium__numer__gracz__2_c;


      if    (  Self.bitwa_dominia_we.Budowla__Surowce__Zmniejsz__Zbuduj__Bd( ztsi, Self.budowa__tryb__budowla_g.Budowla__Rodzaj__Odczytaj__Wbu(), true )  )
        and (   Self.bitwa_dominia_we.Teren__Punkt__Budowaæ__Mo¿na__SprawdŸ__Bd(  ztsi, Round( Self.budowa__tryb__budowla_g.Position.Y ), Round( Self.budowa__tryb__budowla_g.Position.X ), Self.budowa__tryb__budowla_g.Budowla__Rodzaj__Odczytaj__Wbu(), surowiec__rodzaj_l  )   )
        and (  Self.bitwa_dominia_we.Budowla__Zbuduj__Bd(  ztsi, Self.budowa__tryb__budowla_g.Budowla__Rodzaj__Odczytaj__Wbu(), surowiec__rodzaj_l, Round( Self.budowa__tryb__budowla_g.Position.Y ), Round( Self.budowa__tryb__budowla_g.Position.X ), true  )   )
        and (
                 ( Self.budowa__tryb__budowla_g.Budowla__Rodzaj__Odczytaj__Wbu() <> Definicje.br_domek )
              or (
                       ( Self.budowa__tryb__budowla_g.Budowla__Rodzaj__Odczytaj__Wbu() = Definicje.br_domek )
                   and (  Self.bitwa_dominia_we.Dominium__Domek__Iloœæ__Zwiêksz__Bd( ztsi, surowiec__rodzaj_l, true )  )
                 )
            ) then
        begin

          if Self.budowa__tryb__budowla_g.Budowla__Rodzaj__Odczytaj__Wbu() <> Definicje.br_domek then
            Self.bitwa_dominia_we.Budowla__Surowce__Zmniejsz__Zbuduj__Bd( ztsi, Self.budowa__tryb__budowla_g.Budowla__Rodzaj__Odczytaj__Wbu() );

          if Self.budowa__tryb__budowla_g.Budowla__Rodzaj__Odczytaj__Wbu() = Definicje.br_domek then
            Self.bitwa_dominia_we.Dominium__Domek__Iloœæ__Zwiêksz__Bd( ztsi, surowiec__rodzaj_l );


          Self.Surowce__Zasoby__Informacja__Wyœwietl__Go();

          Self.bitwa_dominia_we.Budowla__Zbuduj__Bd(  ztsi, Self.budowa__tryb__budowla_g.Budowla__Rodzaj__Odczytaj__Wbu(), surowiec__rodzaj_l, Round( Self.budowa__tryb__budowla_g.Position.Y ), Round( Self.budowa__tryb__budowla_g.Position.X )  );

          Self.Budowa__Tryb__Ustaw__Go( false );

          Bitwa_Dominia.TBitwa_Dominia.Wizualizacja__Rysuj__Bd( Self.bitwa_dominia_we, [ Bitwa_Dominia.wrz_budowle, Bitwa_Dominia.wrz_mapa, Bitwa_Dominia.wrz_surowce ] );

        end;
      //---//if    (  Self.bitwa_dominia_we.Budowla__Surowce__Zmniejsz__Zbuduj__Bd( ztsi, Self.budowa__tryb__budowla_g.Budowla__Rodzaj__Odczytaj__Wbu(), true )  ) (...)

    end;
  //---//if    ( Shift = [ ssLeft ] ) (...)


  if Shift = [ ssRight ] then
    begin

      Self.kamera__ruch_g := true;


      mysz_start_punkt_g.X := X;
      mysz_start_punkt_g.Y := Y;

      kamera__punkt_kopia_g.X := Gra_GLCamera.Position.X;
      kamera__punkt_kopia_g.Y := Gra_GLCamera.Position.Y;


      if Self.kamera__resetowanie_g then
        Self.kamera__resetowanie_g := false;

    end;
  //---//if Shift = [ ssRight ] then

end;//---//Gra_GLSceneViewerMouseDown().

procedure TGra_Okno_Form.Gra_GLSceneViewerMouseMove( Sender: TObject; Shift: TShiftState; X, Y: Integer );
const
  ruch_c_l : single = 20;
var
  ztsi : smallint;

  zt_affine_vector : Stage.VectorGeometry.TAffineVector;
begin

  if    ( Self.Active )
    and ( Gra_GLSceneViewer.Focused ) then
    begin

      if    ( Self.budowa__tryb_g )
        and ( Self.budowa__tryb__budowla_g <> nil ) then
        begin

          zt_affine_vector := Gra_GLSceneViewer.Buffer.PixelRayToWorld( x, y );
          zt_affine_vector.X := System.Math.Floor( zt_affine_vector.X + Wizualizacja.kratka__wielkoœæ_c * 0.5 );
          zt_affine_vector.Y := System.Math.Floor( zt_affine_vector.Y + Wizualizacja.kratka__wielkoœæ_c * 0.5 );

          if zt_affine_vector.X < 0 then
            zt_affine_vector.X := 0
          else//if zt_affine_vector.X < 0 then
          if zt_affine_vector.X > Self.bitwa_dominia_we.Teren__Wielkoœæ__X__Odczytaj__Bd() - 1 then
            zt_affine_vector.X := Self.bitwa_dominia_we.Teren__Wielkoœæ__X__Odczytaj__Bd() - 1;


          if zt_affine_vector.Y < 0 then
            zt_affine_vector.Y := 0
          else//if zt_affine_vector.Y < 0 then
          if zt_affine_vector.Y > Self.bitwa_dominia_we.Teren__Wielkoœæ__Y__Odczytaj__Bd() - 1 then
            zt_affine_vector.Y := Self.bitwa_dominia_we.Teren__Wielkoœæ__Y__Odczytaj__Bd() - 1;

          Self.budowa__tryb__budowla_g.Position.X := zt_affine_vector.X;
          Self.budowa__tryb__budowla_g.Position.Y := zt_affine_vector.Y;


          //if Self.bitwa_dominia_we.Dominium__Gra_Gracz__1__Bd() then
          //  ztsi := Definicje.dominium__numer__gracz__1_c
          //else//if Self.bitwa_dominia_we.Dominium__Gra_Gracz__1__Bd() then
          //  ztsi := Definicje.dominium__numer__gracz__2_c;
          if   (
                     ( Self.bitwa_dominia_we.Dominium__Gra_Gracz__1__Bd() )
                 and ( not Surowce_Przeciwnik_Podgl¹d_CheckBox.Checked )
               )
            or (
                     ( not Self.bitwa_dominia_we.Dominium__Gra_Gracz__1__Bd() )
                 and ( Surowce_Przeciwnik_Podgl¹d_CheckBox.Checked )
               ) then
            ztsi := Definicje.dominium__numer__gracz__1_c
          else//if   ( (...)
            ztsi := Definicje.dominium__numer__gracz__2_c;

          if Self.bitwa_dominia_we.Teren__Punkt__Budowaæ__Mo¿na__SprawdŸ__Bd(  ztsi, Round( zt_affine_vector.Y ), Round( zt_affine_vector.X ), Self.budowa__tryb__budowla_g.Budowla__Rodzaj__Odczytaj__Wbu()  ) then
            Self.budowa__tryb__budowla_g.Przynale¿noœæ__Zmieñ__Wo( ztsi )
          else
            Self.budowa__tryb__budowla_g.Przynale¿noœæ__Zmieñ__Wo( Definicje.dominium__numer__puste_c );

        end;
      //---//if    ( Self.Active ) (...)


      if    ( Shift = [ ssRight ] )
        and ( not Self.kamera__resetowanie_g )
        and ( Self.kamera__ruch_g ) then
        begin

          Gra_GLCamera.Position.X := kamera__punkt_kopia_g.X + ( mysz_start_punkt_g.X - X ) / 1000 * ruch_c_l;
          Gra_GLCamera.Position.Y := kamera__punkt_kopia_g.Y + ( mysz_start_punkt_g.Y - Y ) / 1000 * ruch_c_l;


          Self.Œwiat³o__Pozycja__Zmieñ__Go();

        end;
      //---//if    ( Shift = [ ssRight ] ) (...)

    end;
  //---//if    ( Self.Active ) (...)

end;//---//Gra_GLSceneViewerMouseMove().

procedure TGra_Okno_Form.Gra_GLSceneViewerMouseUp( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
begin

  if Self.kamera__ruch_g then
    Self.kamera__ruch_g := false;

end;//---//Gra_GLSceneViewerMouseUp().

procedure TGra_Okno_Form.Gra_GLSceneViewerMouseWheel( Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean );
const
  ruch_c_l : single = 2;
begin

  if WheelDelta >= 0 then
    Gra_GLCamera.Move( ruch_c_l )
  else//if WheelDelta >= 0 then
    Gra_GLCamera.Move( -ruch_c_l );

end;//---//Gra_GLSceneViewerMouseWheel().

procedure TGra_Okno_Form.Gra_GLSceneViewerKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
var
  i : integer;
begin

  if Stage.Keyboard.IsKeyDown( VK_BACK ) then
    Surowce_Przeciwnik_Podgl¹d_CheckBox.Checked := not Surowce_Przeciwnik_Podgl¹d_CheckBox.Checked
  else//if Stage.Keyboard.IsKeyDown( VK_BACK ) then
  if Stage.Keyboard.IsKeyDown( VK_OEM_3 ) then // `
    Self.Budowa__Tryb__Ustaw__Go( false )
  else//if Stage.Keyboard.IsKeyDown( VK_OEM_3 ) then
  if   (  Stage.Keyboard.IsKeyDown( '1' )  )
    or (  Stage.Keyboard.IsKeyDown( '2' )  )
    or (  Stage.Keyboard.IsKeyDown( '3' )  )
    or (  Stage.Keyboard.IsKeyDown( '4' )  ) then
    begin


      if Self.gra_okno_etap_g = Gra_Okno.goe_bitwa__dominia then
        begin

          for i := 0 to Zakup__Budynki_Panel.ControlCount - 1 do
            if    ( Zakup__Budynki_Panel.Controls[ i ].ClassType = Gra_Okno__Zakup_Przycisk.TZakup_Przycisk )
              and (
                       (
                             (  Stage.Keyboard.IsKeyDown( '1' )  )
                         and ( Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Budynki_Panel.Controls[ i ]).Budowla__Rodzaj__Odczytaj__Zp() = Definicje.br_wie¿a__zwiadowcza )
                       )
                    or (
                             (  Stage.Keyboard.IsKeyDown( '2' )  )
                         and ( Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Budynki_Panel.Controls[ i ]).Budowla__Rodzaj__Odczytaj__Zp() = Definicje.br_domek )
                       )
                    or (
                             (  Stage.Keyboard.IsKeyDown( '3' )  )
                         and ( Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Budynki_Panel.Controls[ i ]).Budowla__Rodzaj__Odczytaj__Zp() = Definicje.br_wie¿a__obronna )
                       )
                    or (
                             (  Stage.Keyboard.IsKeyDown( '4' )  )
                         and ( Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Budynki_Panel.Controls[ i ]).Budowla__Rodzaj__Odczytaj__Zp() = Definicje.br_koszary )
                       )
                  ) then
              begin

                Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Budynki_Panel.Controls[ i ]).On_Click__Zp( Sender );

                Break;

              end;
            //---//if    ( Zakup__Budynki_Panel.Controls[ i ].ClassType = Gra_Okno__Zakup_Przycisk.TZakup_Przycisk ) (...)

        end
      else//if Self.gra_okno_etap_g = Gra_Okno.goe_bitwa__dominia then
      if Self.gra_okno_etap_g = Gra_Okno.goe_bitwa__jednostki__zakup then
        begin

          for i := 0 to Zakup__Jednostki_Panel.ControlCount - 1 do
            if    ( Zakup__Jednostki_Panel.Controls[ i ].ClassType = Gra_Okno__Zakup_Przycisk.TZakup_Przycisk )
              and (
                       (
                             (  Stage.Keyboard.IsKeyDown( '1' )  )
                         and ( Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Jednostki_Panel.Controls[ i ]).Jednostka_Typ__Odczytaj__Zp() = Definicje.jt_piechota )
                       )
                    or (
                             (  Stage.Keyboard.IsKeyDown( '2' )  )
                         and ( Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Jednostki_Panel.Controls[ i ]).Jednostka_Typ__Odczytaj__Zp() = Definicje.jt_jazda )
                       )
                    or (
                             (  Stage.Keyboard.IsKeyDown( '3' )  )
                         and ( Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Jednostki_Panel.Controls[ i ]).Jednostki_Po³¹cz__Odczytaj__Zp() )
                       )
                    or (
                             (  Stage.Keyboard.IsKeyDown( '4' )  )
                         and ( Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Jednostki_Panel.Controls[ i ]).Teren_Kup__Odczytaj__Zp() )
                       )
                  ) then
              begin

                Gra_Okno__Zakup_Przycisk.TZakup_Przycisk(Zakup__Jednostki_Panel.Controls[ i ]).On_Click__Zp( Sender );

                Break;

              end;
            //---//if    ( Zakup__Jednostki_Panel.Controls[ i ].ClassType = Gra_Okno__Zakup_Przycisk.TZakup_Przycisk ) (...)

        end;
      //---//if Self.gra_okno_etap_g = Gra_Okno.goe_bitwa__jednostki__zakup then

    end
  else//if   (  Stage.Keyboard.IsKeyDown( '1' ) (...)


  if Stage.Keyboard.IsKeyDown( VK_ESCAPE ) then
    begin

      Self.Close();
      Exit; // Potwierdzenie pytania Enterem wyzwala funkcjonalnoœæ dla klawisza Enter.

    end
  else//if Stage.Keyboard.IsKeyDown( VK_ESCAPE ) then


  if Stage.Keyboard.IsKeyDown( VK_RETURN ) then // W GLCadencer1Progress() nie dzia³a podczas pauzy.
    begin

      // Pe³ny ekran.

      if Self.BorderStyle <> bsNone then
        begin

          // Pe³ny ekran.

          // Po ustawieniu pe³nego ekranu mog¹ znikaæ elementy po³o¿one na formie (jak panel), które nie s¹ wyrównywane do boków okna..

          Self.BorderStyle := bsNone;

          if Self.WindowState = wsMaximized then
            Self.WindowState := wsNormal; // Zmaksymalizowane okno czasami nie zas³ania paska start.

          Self.WindowState := wsMaximized;

        end
      else//if Self.BorderStyle <> bsNone then
        begin

          // Normalny ekran.

          Self.BorderStyle := bsSizeable;
          Self.WindowState := wsNormal;

        end;
      //---//if Self.BorderStyle <> bsNone then

    end
  else//if Stage.Keyboard.IsKeyDown( VK_RETURN ) then

  if Stage.Keyboard.IsKeyDown( 'K' ) then
    begin

      Self.Kamera__Resetuj();

    end
  else//if Stage.Keyboard.IsKeyDown( 'K' ) then


  if   (  Stage.Keyboard.IsKeyDown( 'P' )  ) // Pauza podczas wy³¹czania przeskakuje widokiem kamery gdy obracanie mysz¹ jest w³¹czone.
    or (  Stage.Keyboard.IsKeyDown( VK_PAUSE )  ) then
    Self.Pauza()
  else


  if Stage.Keyboard.IsKeyDown( '/' ) then
    Self.Komunikat_Wyœwietl( Definicje.pomoc_c, 'Informacja', MB_ICONINFORMATION )
  else


  if Stage.Keyboard.IsKeyDown( VK_F1 ) then
    Zakup__Jednostki__Automatycznie_ButtonClick( Sender )
  else
  if Stage.Keyboard.IsKeyDown( VK_F3 ) then
    Zakup__Jednostki__Automatycznie__Zawsze_CheckBox.Checked := not Zakup__Jednostki__Automatycznie__Zawsze_CheckBox.Checked
  else
  if Stage.Keyboard.IsKeyDown( VK_F5 ) then
    Bitwa__Jednostki__Wynik__Ustal_ButtonClick( Sender )
  else


  if Stage.Keyboard.IsKeyDown( VK_F11 ) then
    begin

      if Informacje_Panel.Width <> 200 then
        Informacje_Panel.Width := 200
      else//if Informacje_Panel.Width <> 200 then
        Informacje_Panel.Width := 1; // 1. Gdy równe 0 to po schowaniu nie da siê rozwin¹æ poprzez Splitter.

      if not Informacje_Splitter.Visible then
        Informacje_Splitter.Visible := true;

    end
  else//if Stage.Keyboard.IsKeyDown( VK_F12 ) then

  if Stage.Keyboard.IsKeyDown( VK_F12 ) then
    begin

      if Informacje_Panel.Width <> 200 then
        Informacje_Panel.Width := 200
      else//if Informacje_Panel.Width <> 200 then
        Informacje_Panel.Width := 0; // 1. Gdy równe 0 to po schowaniu nie da siê rozwin¹æ poprzez Splitter.

      Informacje_Splitter.Visible := Informacje_Panel.Width > 0;

    end
  else//if Stage.Keyboard.IsKeyDown( VK_F12 ) then


  if Stage.Keyboard.IsKeyDown( VK_ADD ) then
    Gra_Wspó³czynnik_Prêdkoœci__Zmieñ__Go( 1 )
  else
  if Stage.Keyboard.IsKeyDown( VK_SUBTRACT ) then
    Gra_Wspó³czynnik_Prêdkoœci__Zmieñ__Go( -1 )
  else
  if Stage.Keyboard.IsKeyDown( VK_MULTIPLY ) then
    Gra_Wspó³czynnik_Prêdkoœci__Zmieñ__Go( 0 );


  // Gdy pauza jest aktywna.
  if Self.Czy_Pauza() then
    Self.Kamera__Ruch( 0.03 );

end;//---//Gra_GLSceneViewerKeyDown().

procedure TGra_Okno_Form.Bitwa_Jednostki_TimerTimer( Sender: TObject );
var
  zt_bitwa_jednostki_wynik__gracz__1 : Definicje.TBitwa_Jednostki_Wynik;
begin

  Bitwa_Jednostki_Timer.Enabled := false;


  if Self.bitwa_dominia_we = nil then
    begin

      Self.Close();

      Exit;

    end;
  //---//if Self.bitwa_dominia_we = nil then


  if    ( Self.gra_okno_etap_g <> Gra_Okno.goe_bitwa__jednostki__starcie )
    and ( Self.gra_okno_etap_g <> Gra_Okno.goe_bitwa__jednostki__wynik__prezentacja ) then
    Exit;


  if Self.gra_okno_etap_g <> Gra_Okno.goe_bitwa__jednostki__wynik__prezentacja then
    begin

      if not Self.bitwa_dominia_we.Bitwa__Jednostki___Koniec__Warunek__SprawdŸ__Bd() then
        begin

          Self.bitwa_dominia_we.Bitwa__Jednostki___Starcie__Przelicz__Bd();

          Self.Jednostki__Wytrzyma³oœæ_Punkty__Wyœwietl__Go();

        end
      else//if not Self.bitwa_dominia_we.Bitwa__Jednostki___Koniec__Warunek__SprawdŸ__Bd() then
        begin

          Self.gra_okno_etap_g := Gra_Okno.goe_bitwa__jednostki__wynik__prezentacja;


          zt_bitwa_jednostki_wynik__gracz__1 := Self.bitwa_dominia_we.Bitwa__Jednostki___Wynik__Zastosuj__Bd();


          Self.bitwa_dominia_we.Wizualizacja__Rysuj__Bd( Self.bitwa_dominia_we, [ Bitwa_Dominia.wrz_jednostki__jednostki ] );


          if zt_bitwa_jednostki_wynik__gracz__1 = Definicje.bjw_remis then
            begin

              if Gracz__1_RadioGroup.Items.Count > 0 then
                Gracz__1_RadioGroup.Items.Delete( 0 );

              if Gracz__2_RadioGroup.Items.Count > 0 then
                Gracz__2_RadioGroup.Items.Delete( 0 );

            end
          else//if zt_bitwa_jednostki_wynik__gracz__1 = Definicje.bjw_remisthen
          if zt_bitwa_jednostki_wynik__gracz__1 = Definicje.bjw_zwyciêstwo then
            begin

              if Gracz__2_RadioGroup.Items.Count > 0 then
                Gracz__2_RadioGroup.Items.Delete( 0 );

            end
          else//if zt_bitwa_jednostki_wynik__gracz__1 = Definicje.bjw_zwyciêstwo then
            begin

              if Gracz__1_RadioGroup.Items.Count > 0 then
                Gracz__1_RadioGroup.Items.Delete( 0 );

            end;
          //---//if zt_bitwa_jednostki_wynik__gracz__1 = Definicje.bjw_zwyciêstwo then

        end;
      //---//if not Self.bitwa_dominia_we.Bitwa__Jednostki___Koniec__Warunek__SprawdŸ__Bd() then


      Bitwa_Jednostki_Timer.Enabled := true;

    end
  else//if Self.gra_okno_etap_g <> Gra_Okno.goe_bitwa__jednostki__wynik__prezentacja then
    begin

      Self.gra_okno_etap_g := Gra_Okno.goe_bitwa__dominia;


      Self.Surowce__Zasoby__Informacja__Wyœwietl__Go();

      Self.Gra_Okno_Etap__Interfejs__Dostosuj__Go();

      Self.tury__przeliczenia_g := 1;

      Self.Tury_Wyœwietl__Go();

      Self.Kamera__Resetuj( true );


      Self.bitwa_dominia_we.Bitwa__Jednostki___Starcie__Zwolnij__Bd();
      Self.bitwa_dominia_we.Bitwa__Jednostki___Starcie__Przygotuj__Bd();


      Self.bitwa_dominia_we.Wizualizacja__Rysuj__Bd( Self.bitwa_dominia_we, [ Bitwa_Dominia.wrz_jednostki__jednostki ], 1, true );


      if   ( Gracz__1_RadioGroup.Items.Count <= 0 )
        or ( Gracz__2_RadioGroup.Items.Count <= 0 ) then
        Self.Tura_TimerTimer( Sender )
      else//if   ( Gracz__1_RadioGroup.Items.Count <= 0 ) (...)
        Tura_Timer.Enabled := true;

    end;
  //---//if Self.gra_okno_etap_g <> Gra_Okno.goe_bitwa__jednostki__wynik__prezentacja then

end;//---//Bitwa_Jednostki_TimerTimer().

procedure TGra_Okno_Form.Bitwa__Jednostki__Wynik__Ustal_ButtonClick( Sender: TObject );
begin

  if Self.gra_okno_etap_g <> Gra_Okno.goe_bitwa__jednostki__zakup then
    Exit;


  Self.gra_okno_etap_g := Gra_Okno.goe_bitwa__jednostki__starcie;


  Self.Gra_Okno_Etap__Interfejs__Dostosuj__Go();


  Self.bitwa_dominia_we.Wizualizacja__Rysuj__Bd( Self.bitwa_dominia_we, [ Bitwa_Dominia.wrz_jednostki__jednostki ] );


  Bitwa_Jednostki_Timer.Enabled := not Self.Czy_Pauza();

end;//---//Bitwa__Jednostki__Wynik__Ustal_ButtonClick().

procedure TGra_Okno_Form.Surowce_Przeciwnik_Podgl¹d_CheckBoxClick( Sender: TObject );
begin

  Zakup__Budynki_Panel.Enabled := not Surowce_Przeciwnik_Podgl¹d_CheckBox.Checked;


  Self.Surowce__Zasoby__Informacja__Wyœwietl__Go();

end;//---//Surowce_Przeciwnik_Podgl¹d_CheckBoxClick().

procedure TGra_Okno_Form.Tura_TimerTimer( Sender: TObject );
var
  zt_bitwa_dominia_wynik__gracz__1 : Bitwa_Dominia.TBitwa_Dominia_Wynik;
begin

  Tura_Timer.Enabled := false;


  if Self.bitwa_dominia_we = nil then
    begin

      Self.Close();

      Exit;

    end;
  //---//if Self.bitwa_dominia_we = nil then


  if Self.gra_okno_etap_g <> Gra_Okno.goe_bitwa__dominia then
    Exit;


  if Self.bitwa_dominia_we.Bitwa__Dominia__Koniec__Warunek__SprawdŸ__Bd( bitwa_dominia_we ) then
    begin

      Self.gra_okno_etap_g := Gra_Okno.goe_koniec;

      Self.Gra_Okno_Etap__Interfejs__Dostosuj__Go();


      zt_bitwa_dominia_wynik__gracz__1 := Self.bitwa_dominia_we.Bitwa__Dominia__Wynik__Ustal__Bd();


      if zt_bitwa_dominia_wynik__gracz__1 = Bitwa_Dominia.bdw_remis then
        Self.Komunikat_Wyœwietl( 'Remis.' + #13 + #13 + '<Remis.>' + #13 + #13 + '<Draw.>', 'Informacja', MB_ICONEXCLAMATION )
      else//if zt_bitwa_dominia_wynik__gracz__1 = Bitwa_Dominia.bdw_remis then
        begin

          if Self.bitwa_dominia_we.Dominium__Gra_Gracz__1__Bd() then
            begin

              if zt_bitwa_dominia_wynik__gracz__1 = Bitwa_Dominia.bdw_pora¿ka then
                Self.Komunikat_Wyœwietl( 'Pora¿ka.' + #13 + #13 + '<Misserfolg.>' + #13 + #13 + '<Defeat.>', 'Informacja', MB_ICONSTOP )
              else//if zt_bitwa_dominia_wynik__gracz__1 = Bitwa_Dominia.bdw_pora¿ka then
                Self.Komunikat_Wyœwietl( 'Zwyciêstwo.' + #13 + #13 + '<Sieg.>' + #13 + #13 + '<Victory.>', 'Informacja', MB_ICONINFORMATION );

            end
          else//if Self.bitwa_dominia_we.Dominium__Gra_Gracz__1__Bd() then
            begin

              if zt_bitwa_dominia_wynik__gracz__1 = Bitwa_Dominia.bdw_pora¿ka then
                Self.Komunikat_Wyœwietl( 'Zwyciêstwo.' + #13 + #13 + '<Sieg.>' + #13 + #13 + '<Victory.>', 'Informacja', MB_ICONINFORMATION )
              else//if zt_bitwa_dominia_wynik__gracz__1 = Bitwa_Dominia.bdw_pora¿ka then
                Self.Komunikat_Wyœwietl( 'Pora¿ka.' + #13 + #13 + '<Misserfolg.>' + #13 + #13 + '<Defeat.>', 'Informacja', MB_ICONSTOP );

            end;
          //---//if Self.bitwa_dominia_we.Dominium__Gra_Gracz__1__Bd() then

        end;
      //---//if zt_bitwa_dominia_wynik__gracz__1 = Bitwa_Dominia.bdw_remis then


      Self.Close();

      Exit;


    end
  else//if Self.bitwa_dominia_we.Bitwa__Dominia__Koniec__Warunek__SprawdŸ__Bd( bitwa_dominia_we ) then
    begin

      inc( Self.tury__przeliczenia_g );

      Self.Tury_Wyœwietl__Go();


      if Self.tury__przeliczenia_g <= Self.bitwa_dominia_we.Przeliczeñ_W_Turze__Odczytaj__Bd() then
        begin

          Self.bitwa_dominia_we.Surowce__Produkcja_Przelicz__Bd();

          Self.Surowce__Zasoby__Informacja__Wyœwietl__Go();

          Self.bitwa_dominia_we.Buduj__Bd( Self.tury__przeliczenia_g, true );

          Self.bitwa_dominia_we.Atak__Obra¿enia__W_Trakcie__Zeruj__Bd();

          Self.bitwa_dominia_we.Mapa__Atak__Przelicz__Bd();


          Self.bitwa_dominia_we.Wizualizacja__Rysuj__Bd( Self.bitwa_dominia_we, [ Bitwa_Dominia.wrz_budowle, Bitwa_Dominia.wrz_mapa, Bitwa_Dominia.wrz_mapa__jednostki, Bitwa_Dominia.wrz_surowce ] );

          Tura_Timer.Enabled := true;

        end
      else//if Self.tury__przeliczenia_g <= Self.bitwa_dominia_we.Przeliczeñ_W_Turze__Odczytaj__Bd() then
        begin

          Self.gra_okno_etap_g := Gra_Okno.goe_bitwa__jednostki__zakup;


          Self.kamera_pozycja_kopia_g := Gra_GLCamera.Position.AsAffineVector;


          Self.bitwa_dominia_we.Atak__Obra¿enia__W_Trakcie__Zeruj__Bd();

          Self.bitwa_dominia_we.Wizualizacja__Rysuj__Bd( Self.bitwa_dominia_we, [ Bitwa_Dominia.wrz_budowle, Bitwa_Dominia.wrz_mapa__jednostki ] );


          Self.Budowa__Tryb__Ustaw__Go( false );

          Self.Surowce__Zasoby__Informacja__Wyœwietl__Go();

          Self.Gra_Okno_Etap__Interfejs__Dostosuj__Go();

          Self.Tury_Wyœwietl__Go();


          Self.bitwa_dominia_we.Jednostki__Zakup__Wiele__Bd();


          Self.Kamera__Resetuj();


          Self.bitwa_dominia_we.Bitwa__Jednostki___Starcie__Zwolnij__Bd();
          Self.bitwa_dominia_we.Bitwa__Jednostki___Starcie__Przygotuj__Bd();

          Self.Jednostki__Wytrzyma³oœæ_Punkty__Wyœwietl__Go( true );

          Self.bitwa_dominia_we.Wizualizacja__Rysuj__Bd( Self.bitwa_dominia_we, [ Bitwa_Dominia.wrz_jednostki__jednostki, Bitwa_Dominia.wrz_jednostki__obszar ], 1, true );

          Self.Jednostki__Obszar__T³o__Ustaw__Go();


          if Zakup__Jednostki__Automatycznie__Zawsze_CheckBox.Checked then
            Zakup__Jednostki__Automatycznie_ButtonClick( Sender );

        end;
      //---//if Self.tury__przeliczenia_g <= Self.bitwa_dominia_we.Przeliczeñ_W_Turze__Odczytaj__Bd() then

    end;
  //---//if Self.bitwa_dominia_we.Bitwa__Dominia__Koniec__Warunek__SprawdŸ__Bd( bitwa_dominia_we ) then

end;//---//Tura_TimerTimer().

procedure TGra_Okno_Form.Zakup__Jednostki__Automatycznie_ButtonClick( Sender: TObject );
var
  ztb,
  czy_pauza_l
    : boolean;

  zt_modal_result : TModalResult;

  zt_task_dialog : TTaskDialog;
begin

  if Self.gra_okno_etap_g <> Gra_Okno.goe_bitwa__jednostki__zakup then
    Exit;


  if not Zakup__Jednostki__Automatycznie__Zawsze_CheckBox.Checked then
    begin

      //if Self.Komunikat_Wyœwietl( 'Zakupiæ i po³¹czyæ jednostki automatycznie?' + #13 + #13 + '<Einheiten automatisch kaufen und zusammenführen?>' + #13 + #13 + '<Buy and merge units automatically?>', 'Potwierdzenie', MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
      //  Exit;
      czy_pauza_l := Self.Czy_Pauza();

      if not czy_pauza_l then
        Self.Pauza();


      zt_task_dialog := TTaskDialog.Create( Application );
      zt_task_dialog.Title := 'Potwierdzenie';
      zt_task_dialog.Text := 'Zakupiæ i po³¹czyæ jednostki automatycznie?' + #13 + #13 + '<Einheiten automatisch kaufen und zusammenführen?>' + #13 + #13 + '<Buy and merge units automatically?>';
      zt_task_dialog.CommonButtons := [ Vcl.Dialogs.tcbYes, Vcl.Dialogs.tcbNo ];
      zt_task_dialog.DefaultButton := Vcl.Dialogs.tcbNo;
      zt_task_dialog.VerificationText := 'Zawsze. <Immer.> <Always.>';
      zt_task_dialog.Flags := zt_task_dialog.Flags
        + [ Vcl.Dialogs.tfUseHiconMain ];
      zt_task_dialog.CustomMainIcon.Handle := Winapi.Windows.LoadIcon( 0, Winapi.Windows.IDI_QUESTION );
      zt_task_dialog.Execute();
      ztb := Vcl.Dialogs.tfVerificationFlagChecked in zt_task_dialog.Flags;
      zt_modal_result := zt_task_dialog.ModalResult;
      FreeAndNil( zt_task_dialog );


      if not czy_pauza_l then
        Self.Pauza();


      if zt_modal_result <> ID_YES then
        Exit;


      Zakup__Jednostki__Automatycznie__Zawsze_CheckBox.Checked := ztb;

    end;
  //---//if not Zakup__Jednostki__Automatycznie__Zawsze_CheckBox.Checked then


  Self.bitwa_dominia_we.Jednostki__Zakup__Wiele__Bd( true );

  Self.Surowce__Zasoby__Informacja__Wyœwietl__Go();

  Self.bitwa_dominia_we.Bitwa__Jednostki___Starcie__Zwolnij__Bd();
  Self.bitwa_dominia_we.Bitwa__Jednostki___Starcie__Przygotuj__Bd();

  Self.Jednostki__Wytrzyma³oœæ_Punkty__Wyœwietl__Go( true );

  Self.Jednostki__Obszar__T³o__Ustaw__Go();

  Self.bitwa_dominia_we.Wizualizacja__Rysuj__Bd( Self.bitwa_dominia_we, [ Bitwa_Dominia.wrz_jednostki__jednostki, Bitwa_Dominia.wrz_jednostki__obszar ], 1, true );


  if Zakup__Jednostki__Automatycznie__Zawsze_CheckBox.Checked then
    Bitwa__Jednostki__Wynik__Ustal_ButtonClick( Sender );

end;//---//Zakup__Jednostki__Automatycznie_ButtonClick().


initialization
  Gra_Okno.TGra_Okno_Form.bitwa_jednostki_timer__interval__kopia_g := 0;
  Gra_Okno.TGra_Okno_Form.tura_timer__interval__kopia_g := 0;
  Gra_Okno.TGra_Okno_Form.zakup__jednostki__automatycznie__zawsze__kopia_g := false;

end.
