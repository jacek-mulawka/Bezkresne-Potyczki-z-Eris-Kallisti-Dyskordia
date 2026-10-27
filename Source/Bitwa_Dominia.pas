unit Bitwa_Dominia;{13.Sie.2026}

interface

{$DEFINE xtest__funkcjonalnosc_d}

uses
  System.Math,
  System.SysUtils,
  Winapi.Windows,

  {$IFDEF test__funkcjonalnosc_d}
  Test_Funkcjonalnosc,
  {$ENDIF}

  Bitwa_Jednostki,
  Definicje,
  Dominium,
  Gracz,
  Jednostka,
  Mapa,
  Wizualizacja;

type
  TBitwa_Dominia_Wynik = ( bdw_pora¿ka, bdw_remis, bdw_zwyciêstwo );

  TWizualizacja_Rysuj_Zakres = ( wrz_animacje__jednostki, wrz_animacje___mapa, wrz_budowle, wrz_jednostki__jednostki, wrz_jednostki__obszar, wrz_mapa, wrz_mapa__jednostki, wrz_surowce );

  TWizualizacja_Rysuj_Zakresy = set of Bitwa_Dominia.TWizualizacja_Rysuj_Zakres;

  TBitwa_Dominia = class
  private
    { Private declarations }
    dominium__1__gra_gracz__bd,
    dominium__2__gra_gracz__bd,
    gra_gracz__bd
      : boolean;

    przeliczeñ_w_turze__bd : integer;

    dominium__1__nazwa__bd,
    dominium__1__parametry__bd,
    dominium__2__nazwa__bd,
    dominium__2__parametry__bd
      : string;

    bitwa__jednostki__bitwa_starcie_etap__bd : Definicje.TBitwa_Starcie_Etap;

    dominium__1__bd,
    dominium__2__bd
      : Dominium.TDominium;

    dominium__1__jednostki__bd,
    dominium__2__jednostki__bd
      : Jednostka.TJednostki_t;

    mapa_bitwy : Mapa.TMapa;

    procedure Bitwa__Jednostki_Przelicz__Bd();
    procedure Bitwa__Jednostki__Wytrzyma³oœæ_Punkty__Wartoœæ__Zmniejsz__Bd( const bitwa_jednostki_wynik__dominium__1_f : Definicje.TBitwa_Jednostki_Wynik );
    class procedure Budowa_Decyduj__Bd( const tura_numer_f : integer; dominium_f : Dominium.TDominium; bitwa_dominia_f : Bitwa_Dominia.TBitwa_Dominia );
    class procedure Domek__Budowa_Decyduj__Bd( const tura_numer_f : integer; dominium_f : Dominium.TDominium; bitwa_dominia_f : Bitwa_Dominia.TBitwa_Dominia; const surowce__rodzaj_f : Definicje.TSurowce_Rodzaj = []; const próg__budowania__zmniejszony_f : boolean = false );
    class function Domek__Surowce__Inne__Mniej_Ni¿__Razy__Bd( const iloœæ_razy_f : integer; dominium_f : Dominium.TDominium; const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj; const surowce_rodzaj_f: Definicje.TSurowce_Rodzaj ) : boolean;
    procedure Dominium__Budowle__Zburzenia_Przelicz__Bd( const budowle__domki_zburzone_t_f : Definicje.TBudowle );
    class function Surowiec__W__Zasiêgu__Bd( dominium_f : Dominium.TDominium; bitwa_dominia_f : Bitwa_Dominia.TBitwa_Dominia; const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj; const surowce_rodzaj_f: Definicje.TSurowce_Rodzaj ) : boolean; overload;
    class function Surowiec__W__Zasiêgu__Bd( dominium_f : Dominium.TDominium; bitwa_dominia_f : Bitwa_Dominia.TBitwa_Dominia; const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj; const surowce_rodzaj_f: Definicje.TSurowce_Rodzaj; var surowiec_wspó³rzêdne_f : Winapi.Windows.TPoint ) : boolean; overload;
  public
    { Public declarations }
    constructor Create( gracz__1_f, gracz__2_f : Gracz.TGracz; const bitwa_dominia__przeliczeñ_w_turze_f, dominium__wytrzyma³oœæ_punkty_f, potyczki__iloœæ_f : integer );
    destructor Destroy(); override;

    class function Bitwa__Dominia_Przelicz__Bd( const bitwa_dominia__przeliczeñ_w_turze_f, dominium__wytrzyma³oœæ_punkty_f : integer; gracz__1_f, gracz__2_f : Gracz.TGracz; const potyczki__iloœæ_f : integer ) : Bitwa_Dominia.TBitwa_Dominia_Wynik;

    procedure Atak__Obra¿enia__W_Trakcie__Zeruj__Bd();
    procedure Bitwa__Dominia__Gracz__Poddaje_Siê__Bd();
    class function Bitwa__Dominia__Koniec__Warunek__SprawdŸ__Bd( bitwa_dominia_f : Bitwa_Dominia.TBitwa_Dominia ) : boolean;
    function Bitwa__Dominia__Wynik__Ustal__Bd() : Bitwa_Dominia.TBitwa_Dominia_Wynik;
    function Bitwa__Jednostki__Jednostki__Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Bd( const dominium__numer_f : smallint ) : real;
    function Bitwa__Jednostki___Koniec__Warunek__SprawdŸ__Bd() : boolean;
    procedure Bitwa__Jednostki___Starcie__Przelicz__Bd();
    procedure Bitwa__Jednostki___Starcie__Przygotuj__Bd();
    procedure Bitwa__Jednostki___Starcie__Zwolnij__Bd();
    function Bitwa__Jednostki___Wynik__Zastosuj__Bd() : Definicje.TBitwa_Jednostki_Wynik;
    function Budowla__Surowce__Zmniejsz__Zbuduj__Bd( const dominium__numer_f : smallint; const budowla_rodzaj_f : Definicje.TBudowla_Rodzaj; const tylko_test_f : boolean = false ) : boolean;
    function Budowla__Zbuduj__Bd( const dominium__numer_f : smallint; const budowla_rodzaj_f : Definicje.TBudowla_Rodzaj; const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj; const y_f, x_f : integer; const tylko_test_f : boolean = false ) : boolean;
    procedure Buduj__Bd( const tura_numer_f : integer; const gracz__nie_przeliczaj_f : boolean = false );
    function Dominia__Jednostki__Obszar__Wielkoœæ__Odczytaj__Bd() : integer;
    function Dominium__Domek__Iloœæ__Zwiêksz__Bd( const dominium__numer_f : smallint; const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj; const tylko_test_f : boolean = false ) : boolean;
    function Dominium__Gra_Gracz__1__Bd() : boolean;
    function Dominium__Gracz__Nazwa__Odczytaj__Bd( const dominium__numer_f : smallint ) : string;
    function Dominium__Gracz__Parametry__Odczytaj__Bd( const dominium__numer_f : smallint ) : string;
    function Dominium__Jednostki__Odczytaj__Bd( const dominium__numer_f : smallint ) : Jednostka.TJednostki_t;
    function Dominium__Surowce__Zasoby__Odczytaj__Bd( const dominium__numer_f : smallint ) : Definicje.TSurowce_Zasoby;
    function Dominium__Wytrzyma³oœæ_Punkty__Odczytaj__Bd( const dominium__numer_f : smallint ) : integer;
    function Jednostki__Obszar__Wolny__Dostêpnoœæ__SprawdŸ__Bd() : boolean;
    function Jednostki__Obszar__Wolny__Zakup__Bd( out surowiec__iloœæ__kryszta³_f, surowiec__iloœæ__magma_f : integer; const tylko_test_f : boolean = false ) : boolean;
    function Jednostki__Po³¹cz__Bd( const jednostka_typ_f : Definicje.TJednostka_Typ; out surowiec__iloœæ__¿ywio³_f : integer; const tylko_test_f : boolean = false ) : boolean;
    function Jednostki__Po³¹cz__Jednostki__Dostêpne__Bd( const jednostka_typ_f : Definicje.TJednostka_Typ ) : boolean;
    function Jednostki__Po³¹cz__Surowce__Wystarczy__Bd( const jednostka_typ_f : Definicje.TJednostka_Typ ) : boolean;
    function Jednostka__Zakup__Jedn¹__Mo¿na__SprawdŸ__Bd( const jednostka_typ_f : Definicje.TJednostka_Typ ) : boolean;
    function Jednostki__Zakup__Obs³uga__Bd( const jednostki_po³¹cz_f, teren_kup_f : boolean; const jednostka_typ_f : Definicje.TJednostka_Typ; const jednostka_typ__po³¹cz_f : Definicje.TJednostka_Typ = Definicje.jt_pusta ) : boolean;
    procedure Jednostki__Zakup__Wiele__Bd( const gracz__tylko_przeliczaj_f : boolean = false );
    procedure Mapa__Atak__Przelicz__Bd();
    function Przeliczeñ_W_Turze__Odczytaj__Bd() : integer;
    procedure Surowce__Produkcja_Przelicz__Bd();

    function Teren__Punkt__Budowaæ__Mo¿na__SprawdŸ__Bd( const dominium__numer_f : smallint; const y_f, x_f : integer; const budowla__rodzaj_f : Definicje.TBudowla_Rodzaj ) : boolean; overload;
    function Teren__Punkt__Budowaæ__Mo¿na__SprawdŸ__Bd( const dominium__numer_f : smallint; const y_f, x_f : integer; const budowla__rodzaj_f : Definicje.TBudowla_Rodzaj; out surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj ) : boolean; overload;
    function Teren__Wielkoœæ__X__Odczytaj__Bd() : integer;
    function Teren__Wielkoœæ__Y__Odczytaj__Bd() : integer;

    class procedure Wizualizacja__Rysuj__Bd( bitwa_dominia_f : Bitwa_Dominia.TBitwa_Dominia; const wizualizacja_rysuj_zakresy_f : Bitwa_Dominia.TWizualizacja_Rysuj_Zakresy; const gra_wspó³czynnik_prêdkoœci_f : single = 1; const przed_starciem_f : boolean = false );
  end;//---//TBitwa_Dominia = class

implementation

uses
  Gra_Okno;

constructor TBitwa_Dominia.Create( gracz__1_f, gracz__2_f : Gracz.TGracz; const bitwa_dominia__przeliczeñ_w_turze_f, dominium__wytrzyma³oœæ_punkty_f, potyczki__iloœæ_f : integer );
begin

  if   ( gracz__1_f = nil )
    or ( gracz__2_f = nil ) then
    Exit;


  Self.bitwa__jednostki__bitwa_starcie_etap__bd := Definicje.bse_d¹¿enie_do_zwarcia;

  Self.dominium__1__gra_gracz__bd := gracz__1_f.Gra_Gracz__Odczytaj__Gr();
  Self.dominium__2__gra_gracz__bd := gracz__2_f.Gra_Gracz__Odczytaj__Gr();

  Self.gra_gracz__bd :=
       Self.dominium__1__gra_gracz__bd
    or Self.dominium__2__gra_gracz__bd;

  Self.dominium__1__nazwa__bd := gracz__1_f.Nazwa__Odczytaj__Gr();
  Self.dominium__1__parametry__bd := gracz__1_f.Parametry_Wyœwietl__Gr( true );
  Self.dominium__2__nazwa__bd := gracz__2_f.Nazwa__Odczytaj__Gr();
  Self.dominium__2__parametry__bd := gracz__2_f.Parametry_Wyœwietl__Gr( true );

  Self.dominium__1__bd := Dominium.TDominium.Create( Definicje.dominium__numer__gracz__1_c, dominium__wytrzyma³oœæ_punkty_f, gracz__1_f );
  Self.dominium__2__bd := Dominium.TDominium.Create( Definicje.dominium__numer__gracz__2_c, dominium__wytrzyma³oœæ_punkty_f, gracz__2_f );
  Self.mapa_bitwy := Mapa.TMapa.Create
    (
      Definicje.dominium__numer__gracz__1_c,
      Definicje.dominium__numer__gracz__2_c,
      potyczki__iloœæ_f,
      gracz__1_f.Atak__Wspó³czynnik__Odczytaj__Gr(),
      gracz__2_f.Atak__Wspó³czynnik__Odczytaj__Gr(),
      gracz__1_f.Obrona__Wspó³czynnik__Odczytaj__Gr(),
      gracz__2_f.Obrona__Wspó³czynnik__Odczytaj__Gr()
    );
  Self.przeliczeñ_w_turze__bd := bitwa_dominia__przeliczeñ_w_turze_f;

end;//---//Konstruktor klasy TBitwa_Dominia.

destructor TBitwa_Dominia.Destroy();
begin

  Self.Bitwa__Jednostki___Starcie__Zwolnij__Bd();

  System.SysUtils.FreeAndNil( Self.dominium__1__bd );
  System.SysUtils.FreeAndNil( Self.dominium__2__bd );
  System.SysUtils.FreeAndNil( Self.mapa_bitwy );

end;//---//Destruktor klasy TBitwa_Dominia.

procedure TBitwa_Dominia.Atak__Obra¿enia__W_Trakcie__Zeruj__Bd();
begin

  Self.mapa_bitwy.Atak__Obra¿enia__W_Trakcie__Zeruj__Ma();

end;//---//Funkcja Atak__Obra¿enia__W_Trakcie__Zeruj__Bd()

class procedure TBitwa_Dominia.Budowa_Decyduj__Bd( const tura_numer_f : integer; dominium_f : Dominium.TDominium; bitwa_dominia_f : Bitwa_Dominia.TBitwa_Dominia );

  //Funkcja Surowiec_Zajmuj_L() w Budowa_Decyduj__Bd().
  function Surowiec_Zajmuj_L( const surowiec__rodzaj_f_f : Definicje.TSurowiec_Rodzaj; const tura_numer_f_f : integer; dominium_f_f : Dominium.TDominium; bitwa_dominia_f_f : Bitwa_Dominia.TBitwa_Dominia ) : boolean;
  var
    zt_point_l : Winapi.Windows.TPoint;

    zt_surowce_rodzaj_l : Definicje.TSurowce_Rodzaj;
  begin

    Result := true;


    zt_surowce_rodzaj_l := bitwa_dominia_f_f.mapa_bitwy.Surowce__Wolne__Rodzaje__Odczytaj__Ma( dominium_f_f.Dominium__Numer__Odczytaj__Do() );

    if surowiec__rodzaj_f_f in zt_surowce_rodzaj_l then
      begin

        if dominium_f_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_domek, true ) then
          Self.Domek__Budowa_Decyduj__Bd( tura_numer_f_f, dominium_f_f, bitwa_dominia_f_f, [ surowiec__rodzaj_f_f ] );

      end
    else//if surowiec__rodzaj_f_f in zt_surowce_rodzaj_l then
      begin

        zt_surowce_rodzaj_l := bitwa_dominia_f_f.mapa_bitwy.Surowce__Wolne__Rodzaje__Odczytaj__Ma( dominium_f_f.Dominium__Numer__Odczytaj__Do(), false );


        if surowiec__rodzaj_f_f in zt_surowce_rodzaj_l then
          begin

            if dominium_f_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_wie¿a__zwiadowcza, true ) then
              zt_point_l := bitwa_dominia_f_f.mapa_bitwy.Surowiec__Najbli¿szy__ZnajdŸ__Ma( dominium_f_f.Dominium__Numer__Odczytaj__Do(), [ surowiec__rodzaj_f_f ] )
            else//if dominium_f_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_wie¿a__zwiadowcza, true ) then
              zt_point_l.SetLocation( Definicje.identyfikator_pusty_c, Definicje.identyfikator_pusty_c );


            while (  dominium_f_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_wie¿a__zwiadowcza, true )  )
              and ( zt_surowce_rodzaj_l <> [] )
              and ( zt_point_l.X <> Definicje.identyfikator_pusty_c )
              and ( zt_point_l.Y <> Definicje.identyfikator_pusty_c )
              and (  bitwa_dominia_f_f.mapa_bitwy.Budowla__Zbuduj__Ma( dominium_f_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_wie¿a__zwiadowcza, zt_point_l.Y, zt_point_l.X, true )  ) do
              begin

                if dominium_f_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_wie¿a__zwiadowcza ) then
                  bitwa_dominia_f_f.mapa_bitwy.Budowla__Zbuduj__Ma( dominium_f_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_wie¿a__zwiadowcza, zt_point_l.Y, zt_point_l.X );


                zt_surowce_rodzaj_l := bitwa_dominia_f_f.mapa_bitwy.Surowce__Wolne__Rodzaje__Odczytaj__Ma( dominium_f_f.Dominium__Numer__Odczytaj__Do() );

                if surowiec__rodzaj_f_f in zt_surowce_rodzaj_l then
                  begin

                    zt_point_l.SetLocation( Definicje.identyfikator_pusty_c, Definicje.identyfikator_pusty_c );

                    if dominium_f_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_domek, true ) then
                      Self.Domek__Budowa_Decyduj__Bd( tura_numer_f_f, dominium_f_f, bitwa_dominia_f_f, [ surowiec__rodzaj_f_f ] );

                  end
                else//if surowiec__rodzaj_f_f in zt_surowce_rodzaj_l then
                  zt_point_l := bitwa_dominia_f_f.mapa_bitwy.Surowiec__Najbli¿szy__ZnajdŸ__Ma( dominium_f_f.Dominium__Numer__Odczytaj__Do(), [ surowiec__rodzaj_f_f ] );

              end;
            //---//while (  dominium_f_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_wie¿a__zwiadowcza, true )  ) (...)

          end
        else//if surowiec__rodzaj_f_f in zt_surowce_rodzaj_l then
          Result := false;

      end;
    //---//if surowiec__rodzaj_f_f in zt_surowce_rodzaj_l then

  end;//---//Funkcja Surowiec_Zajmuj_L() w Budowa_Decyduj__Bd().

var
  dominium__numer_l : smallint;

  zti,
  budowle__w_promieniu_l,
  droga__d³ugoœæ_l,
  mapa_jednostka__w_promieniu_l
    : integer;

  ztr : real;

  zt_point__1,
  zt_point__2
    : Winapi.Windows.TPoint;

  zt_surowce_rodzaj : Definicje.TSurowce_Rodzaj;
begin//Funkcja Budowa_Decyduj__Bd().

  if   ( bitwa_dominia_f = nil )
    or ( dominium_f = nil ) then
    Exit;


  if dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_wie¿a__obronna, true ) then
    begin

      zt_point__1 := bitwa_dominia_f.mapa_bitwy.Mapa_Jednostka__Wrogie_Na_Terenie__Budowa__Ma( dominium_f.Dominium__Numer__Odczytaj__Do() );

      if    ( zt_point__1.X <> Definicje.identyfikator_pusty_c )
        and ( zt_point__1.Y <> Definicje.identyfikator_pusty_c )
        and (  bitwa_dominia_f.mapa_bitwy.Budowla__Zbuduj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_wie¿a__obronna, zt_point__1.Y, zt_point__1.X, true )  ) then
        begin

          if dominium_f.Dominium__Numer__Odczytaj__Do() = Definicje.dominium__numer__gracz__1_c then
            dominium__numer_l := Definicje.dominium__numer__gracz__2_c
          else//if dominium_f.Dominium__Numer__Odczytaj__Do() = Definicje.dominium__numer__gracz__1_c then
            dominium__numer_l := Definicje.dominium__numer__gracz__1_c;

          budowle__w_promieniu_l := bitwa_dominia_f.mapa_bitwy.Budowle__W_Promieniu__Odczytaj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_wie¿a__obronna, zt_point__1.Y, zt_point__1.X );

          mapa_jednostka__w_promieniu_l := bitwa_dominia_f.mapa_bitwy.Mapa_Jednostka__W_Promieniu__Odczytaj__Ma( dominium__numer_l, zt_point__1.Y, zt_point__1.X );

          case dominium_f.Strategia_Typ__Odczytaj__Do() of
              Definicje.st_agresywna_bardzo : ztr := 2;
              Definicje.st_agresywna : ztr := 1.5;
              Definicje.st_wywa¿ona : ztr := 1;
              Definicje.st_zachowawcza : ztr := 0.5;
              Definicje.st_zachowawcza_bardzo : ztr := 0.25;
              else//case dominium_f.Strategia_Typ__Odczytaj__Do() of
                ztr := 1;
            end;
          //---//case dominium_f.Strategia_Typ__Odczytaj__Do() of

          if    ( Mapa.koszary__mapa_jednostki__pojemnoœæ_c <> 0 )
            and (  budowle__w_promieniu_l < mapa_jednostka__w_promieniu_l / ( Mapa.koszary__mapa_jednostki__pojemnoœæ_c * ztr )  ) then
            if dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_wie¿a__obronna ) then
              bitwa_dominia_f.mapa_bitwy.Budowla__Zbuduj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_wie¿a__obronna, zt_point__1.Y, zt_point__1.X );

        end;
      //---//if    ( zt_point__1.X <> Definicje.identyfikator_pusty_c ) (...)

    end;
  //---//if dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_wie¿a__obronna, true ) then



  case dominium_f.Strategia_Typ__Odczytaj__Do() of
      Definicje.st_agresywna_bardzo : zti := 1;
      Definicje.st_agresywna : zti := 1;
      else//case dominium_f.Strategia_Typ__Odczytaj__Do() of
        zti := 0;
    end;
  //---//case dominium_f.Strategia_Typ__Odczytaj__Do() of

  if   ( zti = 1 )
    or ( dominium_f.Jednostki__Nie_Kupuje__Odczytaj__Do() ) then
    begin

      if not Surowiec_Zajmuj_L( Definicje.sr_kryszta³, tura_numer_f, dominium_f, bitwa_dominia_f ) then
        if not Surowiec_Zajmuj_L( Definicje.sr_magma, tura_numer_f, dominium_f, bitwa_dominia_f ) then
          if not dominium_f.Jednostki__Nie_Kupuje__Odczytaj__Do() then
            zti := 0;

    end;
  //---//if   ( zti = 1 ) (...)



  if zti = 0 then
    begin

      zt_surowce_rodzaj := bitwa_dominia_f.mapa_bitwy.Surowce__Wolne__Rodzaje__Odczytaj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do() );


      if    ( not ( Definicje.sr_kryszta³ in zt_surowce_rodzaj )  )
        and (  dominium_f.Domek__Iloœæ__Odczytaj__Do( Definicje.sr_kryszta³ ) <= 0  )
        and (  dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_wie¿a__zwiadowcza, true )  ) then
        begin

          zt_point__1 := bitwa_dominia_f.mapa_bitwy.Surowiec__Najbli¿szy__ZnajdŸ__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), [ Definicje.sr_kryszta³ ], droga__d³ugoœæ_l );

          if    ( zt_point__1.X <> Definicje.identyfikator_pusty_c )
            and ( zt_point__1.Y <> Definicje.identyfikator_pusty_c )
            and ( droga__d³ugoœæ_l <= Definicje.obserwacja__zasiêg___zamek_c + Definicje.obserwacja__zasiêg___wie¿a__zwiadowcza_c * 3 ) then
            begin

              if bitwa_dominia_f.mapa_bitwy.Budowla__Zbuduj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_wie¿a__zwiadowcza, zt_point__1.Y, zt_point__1.X, true ) then
                if dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_wie¿a__zwiadowcza ) then
                  bitwa_dominia_f.mapa_bitwy.Budowla__Zbuduj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_wie¿a__zwiadowcza, zt_point__1.Y, zt_point__1.X );


              Exit;

            end;
          //---//if    ( zt_point__1.X <> Definicje.identyfikator_pusty_c ) (...)

        end;
      //---//if    ( not ( Definicje.sr_kryszta³ in zt_surowce_rodzaj )  ) (...)


      case dominium_f.Strategia_Typ__Odczytaj__Do() of
          Definicje.st_agresywna_bardzo : zti := 1;
          Definicje.st_agresywna : zti := 1;
          Definicje.st_wywa¿ona : zti := 1;
          Definicje.st_zachowawcza : zti := Random( 2 );
          Definicje.st_zachowawcza_bardzo : zti := 0;
          else//case dominium_f.Strategia_Typ__Odczytaj__Do() of
            zti := 0;
        end;
      //---//case dominium_f.Strategia_Typ__Odczytaj__Do() of

      if zti = 1 then
        begin

          if    ( Definicje.sr_kryszta³ in zt_surowce_rodzaj )
            and (  Self.Domek__Surowce__Inne__Mniej_Ni¿__Razy__Bd( 2, dominium_f, Definicje.sr_kryszta³, zt_surowce_rodzaj )  ) then
            begin

              Self.Domek__Budowa_Decyduj__Bd( tura_numer_f, dominium_f, bitwa_dominia_f, [ Definicje.sr_kryszta³ ] );

              zt_surowce_rodzaj := bitwa_dominia_f.mapa_bitwy.Surowce__Wolne__Rodzaje__Odczytaj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do() );

            end;
          //---//if    ( Definicje.sr_kryszta³ in zt_surowce_rodzaj ) (...)

          if    ( Definicje.sr_magma in zt_surowce_rodzaj )
            and (  not ( Definicje.sr_kryszta³ in zt_surowce_rodzaj )  )
            and (  Self.Domek__Surowce__Inne__Mniej_Ni¿__Razy__Bd( 2, dominium_f, Definicje.sr_magma, zt_surowce_rodzaj )  ) then
            begin

              Self.Domek__Budowa_Decyduj__Bd( tura_numer_f, dominium_f, bitwa_dominia_f, [ Definicje.sr_magma ] );

              zt_surowce_rodzaj := bitwa_dominia_f.mapa_bitwy.Surowce__Wolne__Rodzaje__Odczytaj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do() );

            end;
          //---//if    ( Definicje.sr_magma in zt_surowce_rodzaj ) (...)

          if zt_surowce_rodzaj <> [] then
            begin

              Self.Domek__Budowa_Decyduj__Bd( tura_numer_f, dominium_f, bitwa_dominia_f, [], true );

              zt_surowce_rodzaj := bitwa_dominia_f.mapa_bitwy.Surowce__Wolne__Rodzaje__Odczytaj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do() );

            end;
          //---//if zt_surowce_rodzaj <> [] then


          if    (  not ( Definicje.sr_kryszta³ in zt_surowce_rodzaj )  )
            and (  not ( Definicje.sr_magma in zt_surowce_rodzaj )  )
            and (  Self.Surowiec__W__Zasiêgu__Bd( dominium_f, bitwa_dominia_f, Definicje.sr_kryszta³, zt_surowce_rodzaj, zt_point__1 )  ) then
            zti := 1
          else//if    (  not ( Definicje.sr_kryszta³ in zt_surowce_rodzaj )  ) (...)
            if    (  not ( Definicje.sr_magma in zt_surowce_rodzaj )  )
              and (  not ( Definicje.sr_kryszta³ in zt_surowce_rodzaj )  )
              and (  Self.Surowiec__W__Zasiêgu__Bd( dominium_f, bitwa_dominia_f, Definicje.sr_magma, zt_surowce_rodzaj, zt_point__1 )  ) then
              zti := 1
            else//if    (  not ( Definicje.sr_magma in zt_surowce_rodzaj )  ) (...)
              zti := 0;

        end;
      //---//if zti = 1 then


      if    ( zti = 0 )
        and ( zt_surowce_rodzaj <> [] ) then
        Self.Domek__Budowa_Decyduj__Bd( tura_numer_f, dominium_f, bitwa_dominia_f, [], zti = 1 )
      else//if    ( zti = 0 ) (...)
        begin

          if tura_numer_f > bitwa_dominia_f.Przeliczeñ_W_Turze__Odczytaj__Bd() * dominium_f.Surowce__Oszczêdzanie_Przed_Bitw¹__Wspó³czynnik__Odczytaj__Do() then
            Exit;


          if    ( zti = 0 )
            and (  dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_wie¿a__zwiadowcza, true )  ) then
            zt_point__1 := bitwa_dominia_f.mapa_bitwy.Surowiec__Najbli¿szy__ZnajdŸ__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), [] )
          else//if    ( zti = 0 ) (...)
            if not dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_wie¿a__zwiadowcza, true ) then
              zt_point__1.SetLocation( Definicje.identyfikator_pusty_c, Definicje.identyfikator_pusty_c );


          while (  dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_wie¿a__zwiadowcza, true )  )
            and (
                     ( zt_surowce_rodzaj = [] )
                  or ( zti = 1 )
                )
            and ( zt_point__1.X <> Definicje.identyfikator_pusty_c )
            and ( zt_point__1.Y <> Definicje.identyfikator_pusty_c )
            and (  bitwa_dominia_f.mapa_bitwy.Budowla__Zbuduj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_wie¿a__zwiadowcza, zt_point__1.Y, zt_point__1.X, true )  ) do
            begin

              if dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_wie¿a__zwiadowcza ) then
                bitwa_dominia_f.mapa_bitwy.Budowla__Zbuduj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_wie¿a__zwiadowcza, zt_point__1.Y, zt_point__1.X );


              zt_surowce_rodzaj := bitwa_dominia_f.mapa_bitwy.Surowce__Wolne__Rodzaje__Odczytaj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do() );

              {$IFDEF test__funkcjonalnosc_d}
              Test_Funkcjonalnosc.ShowMessage();
              {$ENDIF}

              if zt_surowce_rodzaj <> [] then
                begin

                  zt_point__1.SetLocation( Definicje.identyfikator_pusty_c, Definicje.identyfikator_pusty_c );

                  if dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_domek, true ) then
                    Self.Domek__Budowa_Decyduj__Bd( tura_numer_f, dominium_f, bitwa_dominia_f );

                end
              else//if zt_surowce_rodzaj <> [] then
                zt_point__1 := bitwa_dominia_f.mapa_bitwy.Surowiec__Najbli¿szy__ZnajdŸ__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), [] );

            end;
          //---//while (  dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_wie¿a__zwiadowcza, true )  ) (...)

        end;
      //---//if    ( zti = 0 ) (...)

    end;
  //---//if zti = 0 then



  if dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_wie¿a__obronna, true ) then
    begin

      zt_point__1 := bitwa_dominia_f.mapa_bitwy.Budowla__Atakowana__Jest__Ma( dominium_f.Dominium__Numer__Odczytaj__Do() );

      if    ( zt_point__1.X <> Definicje.identyfikator_pusty_c )
        and ( zt_point__1.Y <> Definicje.identyfikator_pusty_c )
        and (  bitwa_dominia_f.mapa_bitwy.Budowla__Zbuduj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_wie¿a__obronna, zt_point__1.Y, zt_point__1.X, true )  ) then
        begin

          budowle__w_promieniu_l := bitwa_dominia_f.mapa_bitwy.Budowle__W_Promieniu__Odczytaj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_wie¿a__obronna, zt_point__1.Y, zt_point__1.X );

          case dominium_f.Strategia_Typ__Odczytaj__Do() of
              Definicje.st_agresywna_bardzo : zti := 1;
              Definicje.st_agresywna : zti := 1;
              Definicje.st_wywa¿ona : zti := 2;
              Definicje.st_zachowawcza : zti := 3;
              Definicje.st_zachowawcza_bardzo : zti := 4;
              else//case dominium_f.Strategia_Typ__Odczytaj__Do() of
                zti := 1;
            end;
          //---//case dominium_f.Strategia_Typ__Odczytaj__Do() of

          if budowle__w_promieniu_l < zti then
            if dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_wie¿a__obronna ) then
              bitwa_dominia_f.mapa_bitwy.Budowla__Zbuduj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_wie¿a__obronna, zt_point__1.Y, zt_point__1.X );

        end;
      //---//if    ( zt_point__1.X <> Definicje.identyfikator_pusty_c ) (...)

    end;
  //---//if dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_wie¿a__obronna, true ) then



  if dominium_f.Jednostki__Nie_Kupuje__Odczytaj__Do() then
    begin

      if dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_koszary, true ) then
        begin

          if dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_wie¿a__zwiadowcza, true ) then
            zt_point__1 := bitwa_dominia_f.mapa_bitwy.Surowiec__Najbli¿szy__ZnajdŸ__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), [], droga__d³ugoœæ_l, zt_point__2, true )
          else//if dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_wie¿a__zwiadowcza, true ) then
            zt_point__1.SetLocation( Definicje.identyfikator_pusty_c, Definicje.identyfikator_pusty_c );

          if    (  dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_wie¿a__zwiadowcza, true )  )
            and ( zt_point__1.X <> Definicje.identyfikator_pusty_c )
            and ( zt_point__1.Y <> Definicje.identyfikator_pusty_c )
            and (
                     ( zt_point__2.X = Definicje.identyfikator_pusty_c )
                  or ( zt_point__2.Y = Definicje.identyfikator_pusty_c )
                  or (
                           ( zt_point__2.X <> Definicje.identyfikator_pusty_c )
                       and ( zt_point__2.Y <> Definicje.identyfikator_pusty_c )
                       and (
                                (  System.Abs( zt_point__1.X - zt_point__2.X ) >= Definicje.obserwacja__zasiêg___wie¿a__zwiadowcza_c  )
                             or (  System.Abs( zt_point__1.Y - zt_point__2.Y ) >= Definicje.obserwacja__zasiêg___wie¿a__zwiadowcza_c  )
                           )
                     )
                )
            and (  bitwa_dominia_f.mapa_bitwy.Budowla__Zbuduj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_wie¿a__zwiadowcza, zt_point__1.Y, zt_point__1.X, true )  ) then
            zti := 2
          else//if    (  dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_wie¿a__zwiadowcza, true )  ) (...)
            zti := 1;

          if dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_koszary, zti ) then
            begin

              if    ( zti > 1 )
                and ( dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_wie¿a__zwiadowcza )  ) then
                bitwa_dominia_f.mapa_bitwy.Budowla__Zbuduj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_wie¿a__zwiadowcza, zt_point__1.Y, zt_point__1.X );


              zt_point__1 := bitwa_dominia_f.mapa_bitwy.Surowiec__Najbli¿szy__ZnajdŸ__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), [], true, 1 );

              if    ( zt_point__1.X <> Definicje.identyfikator_pusty_c )
                and ( zt_point__1.Y <> Definicje.identyfikator_pusty_c )
                and (  bitwa_dominia_f.mapa_bitwy.Budowla__Zbuduj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_koszary, zt_point__1.Y, zt_point__1.X, true )  ) then
                begin

                  if dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_koszary ) then
                    bitwa_dominia_f.mapa_bitwy.Budowla__Zbuduj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_koszary, zt_point__1.Y, zt_point__1.X );

                end
              else//if    ( zt_point__1.X <> Definicje.identyfikator_pusty_c ) (...)
                begin

                  zt_point__1 := bitwa_dominia_f.mapa_bitwy.Koszary__Budowa__Punkt__ZnajdŸ__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), 2 );

                  if    ( zt_point__1.X <> Definicje.identyfikator_pusty_c )
                    and ( zt_point__1.Y <> Definicje.identyfikator_pusty_c )
                    and (  bitwa_dominia_f.mapa_bitwy.Budowla__Zbuduj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_koszary, zt_point__1.Y, zt_point__1.X, true )  ) then
                    if dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_koszary ) then
                      bitwa_dominia_f.mapa_bitwy.Budowla__Zbuduj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_koszary, zt_point__1.Y, zt_point__1.X );

                end;
              //---//if    ( zt_point__1.X <> Definicje.identyfikator_pusty_c ) (...)

            end;
          //---//if dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_koszary, true ) then

        end;
      //---//if dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_koszary, true ) then

    end
  else//if dominium_f.Jednostki__Nie_Kupuje__Odczytaj__Do() then
    begin

      if tura_numer_f <= bitwa_dominia_f.Przeliczeñ_W_Turze__Odczytaj__Bd() * dominium_f.Surowce__Oszczêdzanie_Przed_Bitw¹__Wspó³czynnik__Odczytaj__Do() then
        begin

          case dominium_f.Strategia_Typ__Odczytaj__Do() of
              Definicje.st_agresywna_bardzo : zti := 1;
              Definicje.st_agresywna : zti := 1;
              Definicje.st_wywa¿ona : zti := 2;
              Definicje.st_zachowawcza : zti := 2;
              Definicje.st_zachowawcza_bardzo : zti := 2;
              else//case dominium_f.Strategia_Typ__Odczytaj__Do() of
                zti := 2;
            end;
          //---//case dominium_f.Strategia_Typ__Odczytaj__Do() of


          if    (  dominium_f.Domek__Iloœæ__Odczytaj__Do( Definicje.sr_kryszta³ ) >= zti  )
            and (  dominium_f.Domek__Iloœæ__Odczytaj__Do( Definicje.sr_magma ) >= zti  )
            and (  dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_wie¿a__obronna, zti )  )
            and (  dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_koszary, zti )  ) then
            begin

              zt_point__1 := bitwa_dominia_f.mapa_bitwy.Surowiec__Najbli¿szy__ZnajdŸ__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), [], true, 2 );

              if    ( zt_point__1.X <> Definicje.identyfikator_pusty_c )
                and ( zt_point__1.Y <> Definicje.identyfikator_pusty_c )
                and (  bitwa_dominia_f.mapa_bitwy.Budowla__Zbuduj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_koszary, zt_point__1.Y, zt_point__1.X, true )  ) then
                begin

                  if dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_koszary ) then
                    bitwa_dominia_f.mapa_bitwy.Budowla__Zbuduj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_koszary, zt_point__1.Y, zt_point__1.X );


                  zt_point__1 := bitwa_dominia_f.mapa_bitwy.Surowiec__Najbli¿szy__ZnajdŸ__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), [], true, 1 );

                  if    ( zt_point__1.X <> Definicje.identyfikator_pusty_c )
                    and ( zt_point__1.Y <> Definicje.identyfikator_pusty_c )
                    and (  bitwa_dominia_f.mapa_bitwy.Budowla__Zbuduj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_wie¿a__obronna, zt_point__1.Y, zt_point__1.X, true )  ) then
                    if dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_wie¿a__obronna ) then
                      bitwa_dominia_f.mapa_bitwy.Budowla__Zbuduj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_wie¿a__obronna, zt_point__1.Y, zt_point__1.X );

                end
              else//if    ( zt_point__1.X <> Definicje.identyfikator_pusty_c ) (...)
              if dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_koszary, zti ) then
                begin

                  case dominium_f.Strategia_Typ__Odczytaj__Do() of
                      Definicje.st_agresywna_bardzo : zti := 0;
                      Definicje.st_agresywna : zti := 1;
                      Definicje.st_wywa¿ona : zti := 2;
                      Definicje.st_zachowawcza : zti := Mapa.koszary__mapa_jednostki__pojemnoœæ_c;
                      Definicje.st_zachowawcza_bardzo : zti := Mapa.koszary__mapa_jednostki__pojemnoœæ_c;
                      else//case dominium_f.Strategia_Typ__Odczytaj__Do() of
                        zti := Mapa.koszary__mapa_jednostki__pojemnoœæ_c;
                    end;
                  //---//case dominium_f.Strategia_Typ__Odczytaj__Do() of


                  if    (  bitwa_dominia_f.mapa_bitwy.Budowle__W_Promieniu__Odczytaj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_wie¿a__obronna, Definicje.identyfikator_pusty_c, Definicje.identyfikator_pusty_c, -1 ) >= zti  )
                    and (  bitwa_dominia_f.mapa_bitwy.Budowle__W_Promieniu__Odczytaj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_koszary, Definicje.identyfikator_pusty_c, Definicje.identyfikator_pusty_c, -1 ) >= zti  ) then
                    begin

                      case dominium_f.Strategia_Typ__Odczytaj__Do() of
                          Definicje.st_agresywna_bardzo : zti := 2;
                          Definicje.st_agresywna : zti := 3;
                          Definicje.st_wywa¿ona : zti := 4;
                          Definicje.st_zachowawcza : zti := 5;
                          Definicje.st_zachowawcza_bardzo : zti := 6;
                          else//case dominium_f.Strategia_Typ__Odczytaj__Do() of
                            zti := 1;
                        end;
                      //---//case dominium_f.Strategia_Typ__Odczytaj__Do() of


                      zt_point__1 := bitwa_dominia_f.mapa_bitwy.Koszary__Budowa__Punkt__ZnajdŸ__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), zti );

                      if    ( zt_point__1.X <> Definicje.identyfikator_pusty_c )
                        and ( zt_point__1.Y <> Definicje.identyfikator_pusty_c )
                        and (  bitwa_dominia_f.mapa_bitwy.Budowla__Zbuduj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_koszary, zt_point__1.Y, zt_point__1.X, true )  ) then
                        if dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_koszary ) then
                          bitwa_dominia_f.mapa_bitwy.Budowla__Zbuduj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_koszary, zt_point__1.Y, zt_point__1.X );

                    end;
                  //---//if    (  bitwa_dominia_f.mapa_bitwy.Budowle__W_Promieniu__Odczytaj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), Definicje.br_wie¿a__obronna, Definicje.identyfikator_pusty_c, Definicje.identyfikator_pusty_c, -1 ) >= zti  ) (...)

                end;
              //---//if dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_koszary, zti ) then

            end;
          //---//if    (  dominium_f.Domek__Iloœæ__Odczytaj__Do( Definicje.sr_kryszta³ ) >= zti  ) (...)

        end;
      //---//if tura_numer_f <= bitwa_dominia_f.Przeliczeñ_W_Turze__Odczytaj__Bd() * dominium_f.Surowce__Oszczêdzanie_Przed_Bitw¹__Wspó³czynnik__Odczytaj__Do() then

    end;
  //---//if dominium_f.Jednostki__Nie_Kupuje__Odczytaj__Do() then

end;//---//Funkcja Budowa_Decyduj__Bd().

class function TBitwa_Dominia.Bitwa__Dominia_Przelicz__Bd( const bitwa_dominia__przeliczeñ_w_turze_f, dominium__wytrzyma³oœæ_punkty_f : integer; gracz__1_f, gracz__2_f : Gracz.TGracz; const potyczki__iloœæ_f : integer ) : Bitwa_Dominia.TBitwa_Dominia_Wynik;
var
  i : integer;
  bitwa_dominia_l : Bitwa_Dominia.TBitwa_Dominia;
  zt_gra_okno_form : Gra_Okno.TGra_Okno_Form;
begin

  if   ( gracz__1_f = nil )
    or ( gracz__2_f = nil ) then
    Exit;


  bitwa_dominia_l := Bitwa_Dominia.TBitwa_Dominia.Create( gracz__1_f, gracz__2_f, bitwa_dominia__przeliczeñ_w_turze_f, dominium__wytrzyma³oœæ_punkty_f, potyczki__iloœæ_f );


  if bitwa_dominia_l.gra_gracz__bd then
    begin

      zt_gra_okno_form := Gra_Okno.TGra_Okno_Form.Create( nil );
      zt_gra_okno_form.bitwa_dominia_we := bitwa_dominia_l;
      zt_gra_okno_form.ShowModal();
      System.SysUtils.FreeAndNil( zt_gra_okno_form );

    end
  else//if bitwa_dominia_l.gra_gracz__bd then
    while not bitwa_dominia_l.Bitwa__Dominia__Koniec__Warunek__SprawdŸ__Bd( bitwa_dominia_l ) do
      begin

        for i := 1 to bitwa_dominia_l.Przeliczeñ_W_Turze__Odczytaj__Bd() do
          begin

            bitwa_dominia_l.Surowce__Produkcja_Przelicz__Bd();

            bitwa_dominia_l.Buduj__Bd( i );

            bitwa_dominia_l.Mapa__Atak__Przelicz__Bd();

          end;
        //---//for i := 1 to bitwa_dominia_l.Przeliczeñ_W_Turze__Odczytaj__Bd() do


        bitwa_dominia_l.Jednostki__Zakup__Wiele__Bd();

        bitwa_dominia_l.Bitwa__Jednostki_Przelicz__Bd();

      end;
    //---//while not bitwa_dominia_l.Bitwa__Dominia__Koniec__Warunek__SprawdŸ__Bd( bitwa_dominia_l ) do


  Result := bitwa_dominia_l.Bitwa__Dominia__Wynik__Ustal__Bd();


  System.SysUtils.FreeAndNil( bitwa_dominia_l );

end;//---//Funkcja Bitwa__Dominia_Przelicz__Bd().

class function TBitwa_Dominia.Bitwa__Dominia__Koniec__Warunek__SprawdŸ__Bd( bitwa_dominia_f : Bitwa_Dominia.TBitwa_Dominia ) : boolean;
begin

  if bitwa_dominia_f = nil then
    begin

      Result := true;

      Exit;

    end;
  //---//if bitwa_dominia_f = nil then


  if    ( bitwa_dominia_f.dominium__1__bd.Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Do() > 0 )
    and ( not bitwa_dominia_f.dominium__1__bd.Zamek__Zburzony__Odczytaj__Do() )
    and ( bitwa_dominia_f.dominium__2__bd.Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Do() > 0 )
    and ( not bitwa_dominia_f.dominium__2__bd.Zamek__Zburzony__Odczytaj__Do() ) then
    Result := false
  else//if    ( bitwa_dominia_f.dominium__1__bd.Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Do() > 0 ) (...)
    Result := true;

end;//---//Funkcja Bitwa__Dominia__Koniec__Warunek__SprawdŸ__Bd().

procedure TBitwa_Dominia.Bitwa__Dominia__Gracz__Poddaje_Siê__Bd();
begin

  if Self.dominium__1__gra_gracz__bd then
    begin

      while Self.dominium__1__bd.Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Do() > 0 do
        Self.dominium__1__bd.Wytrzyma³oœæ_Punkty__Wartoœæ__Zmniejsz__Do();

    end
  else//if Self.dominium__1__gra_gracz__bd then
  if Self.dominium__2__gra_gracz__bd then
    begin

      while Self.dominium__2__bd.Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Do() > 0 do
        Self.dominium__2__bd.Wytrzyma³oœæ_Punkty__Wartoœæ__Zmniejsz__Do();

    end;
  //---//if Self.dominium__2__gra_gracz__bd then

end;//---//Funkcja Bitwa__Dominia__Gracz__Poddaje_Siê__Bd().

function TBitwa_Dominia.Bitwa__Dominia__Wynik__Ustal__Bd() : Bitwa_Dominia.TBitwa_Dominia_Wynik;
begin

  // Result = wynik__gracz__1.

  if    (
             ( Self.dominium__1__bd.Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Do() <= 0 )
          or ( Self.dominium__1__bd.Zamek__Zburzony__Odczytaj__Do() )
        )
    and (
             ( Self.dominium__2__bd.Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Do() <= 0 )
          or ( Self.dominium__2__bd.Zamek__Zburzony__Odczytaj__Do() )
        ) then
    Result := Bitwa_Dominia.bdw_remis
  else//if    ( (...)
  if   ( Self.dominium__2__bd.Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Do() <= 0 )
    or ( Self.dominium__2__bd.Zamek__Zburzony__Odczytaj__Do() ) then
    Result := Bitwa_Dominia.bdw_zwyciêstwo
  else//if   ( Self.dominium__2__bd.Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Do() <= 0 ) (...)
  if   ( Self.dominium__1__bd.Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Do() <= 0 )
    or ( Self.dominium__1__bd.Zamek__Zburzony__Odczytaj__Do() ) then
    Result := Bitwa_Dominia.bdw_pora¿ka;

end;//---//Funkcja Bitwa__Dominia__Wynik__Ustal__Bd().

procedure TBitwa_Dominia.Bitwa__Jednostki_Przelicz__Bd();
begin
                                                                      // Result = wynik__gracz__1.
  Self.Bitwa__Jednostki__Wytrzyma³oœæ_Punkty__Wartoœæ__Zmniejsz__Bd(  Bitwa_Jednostki.TBitwa_Jednostki.Bitwa__Jednostki_Przelicz__Bj( Self.dominium__1__bd, Self.dominium__2__bd )  );

end;//---//Funkcja Bitwa__Jednostki_Przelicz__Bd().

function TBitwa_Dominia.Bitwa__Jednostki__Jednostki__Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Bd( const dominium__numer_f : smallint ) : real;
begin

  if dominium__numer_f = Definicje.dominium__numer__gracz__2_c then
    Result := Bitwa_Jednostki.TBitwa_Jednostki.Bitwa__Jednostki__Jednostki__Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Bj( Self.dominium__2__jednostki__bd )
  else//if dominium__numer_f = Definicje.dominium__numer__gracz__2_c then
    Result := Bitwa_Jednostki.TBitwa_Jednostki.Bitwa__Jednostki__Jednostki__Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Bj( Self.dominium__1__jednostki__bd );

end;//---//Funkcja Bitwa__Jednostki__Jednostki__Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Bd().

function TBitwa_Dominia.Bitwa__Jednostki___Koniec__Warunek__SprawdŸ__Bd() : boolean;
begin

  Result := Bitwa_Jednostki.TBitwa_Jednostki.Bitwa__Jednostki__Koniec__Warunek__SprawdŸ__Bj( Self.dominium__1__jednostki__bd, Self.dominium__2__jednostki__bd );

end;//---//Funkcja Bitwa__Jednostki___Koniec__Warunek__SprawdŸ__Bd().

procedure TBitwa_Dominia.Bitwa__Jednostki___Starcie__Przelicz__Bd();
begin

  Bitwa_Jednostki.TBitwa_Jednostki.Bitwa__Jednostki__Starcie__Przelicz__Bj( Self.bitwa__jednostki__bitwa_starcie_etap__bd, Self.dominium__1__jednostki__bd, Self.dominium__2__jednostki__bd, true );

end;//---//Funkcja Bitwa__Jednostki___Starcie__Przelicz__Bd().

procedure TBitwa_Dominia.Bitwa__Jednostki___Starcie__Przygotuj__Bd();
begin

  Bitwa_Jednostki.TBitwa_Jednostki.Bitwa__Jednostki__Starcie__Przygotuj__Bj( Self.bitwa__jednostki__bitwa_starcie_etap__bd, Self.dominium__1__bd, Self.dominium__2__bd, Self.dominium__1__jednostki__bd, Self.dominium__2__jednostki__bd );

end;//---//Funkcja Bitwa__Jednostki___Starcie__Przygotuj__Bd().

procedure TBitwa_Dominia.Bitwa__Jednostki___Starcie__Zwolnij__Bd();
begin

  Bitwa_Jednostki.TBitwa_Jednostki.Bitwa__Jednostki__Starcie__Zwolnij__Bj( Self.dominium__1__jednostki__bd, Self.dominium__2__jednostki__bd );

end;//---//Funkcja Bitwa__Jednostki___Starcie__Zwolnij__Bd().

function TBitwa_Dominia.Bitwa__Jednostki___Wynik__Zastosuj__Bd() : Definicje.TBitwa_Jednostki_Wynik;
begin

  // Result = wynik__dominium__1.

  Result := Bitwa_Jednostki.TBitwa_Jednostki.Bitwa__Jednostki__Wynik__Odczytaj__Bj( Self.dominium__1__jednostki__bd, Self.dominium__2__jednostki__bd );

  Self.Bitwa__Jednostki__Wytrzyma³oœæ_Punkty__Wartoœæ__Zmniejsz__Bd( Result );

end;//---//Funkcja Bitwa__Jednostki___Wynik__Zastosuj__Bd().

procedure TBitwa_Dominia.Bitwa__Jednostki__Wytrzyma³oœæ_Punkty__Wartoœæ__Zmniejsz__Bd( const bitwa_jednostki_wynik__dominium__1_f : Definicje.TBitwa_Jednostki_Wynik );
begin

  if bitwa_jednostki_wynik__dominium__1_f = Definicje.bjw_remis then
    begin

      Self.dominium__1__bd.Wytrzyma³oœæ_Punkty__Wartoœæ__Zmniejsz__Do();
      Self.dominium__2__bd.Wytrzyma³oœæ_Punkty__Wartoœæ__Zmniejsz__Do();

    end
  else//if bitwa_jednostki_wynik__dominium__1_f = Definicje.bjw_remis then
  if bitwa_jednostki_wynik__dominium__1_f = Definicje.bjw_zwyciêstwo then
    Self.dominium__2__bd.Wytrzyma³oœæ_Punkty__Wartoœæ__Zmniejsz__Do()
  else//if bitwa_jednostki_wynik__dominium__1_f = Definicje.bjw_zwyciêstwo then
    Self.dominium__1__bd.Wytrzyma³oœæ_Punkty__Wartoœæ__Zmniejsz__Do();

end;//---//Funkcja Bitwa__Jednostki__Wytrzyma³oœæ_Punkty__Wartoœæ__Zmniejsz__Bd().

function TBitwa_Dominia.Budowla__Surowce__Zmniejsz__Zbuduj__Bd( const dominium__numer_f : smallint; const budowla_rodzaj_f : Definicje.TBudowla_Rodzaj; const tylko_test_f : boolean = false ) : boolean;
begin

  if dominium__numer_f = Definicje.dominium__numer__gracz__2_c then
    Result := Self.dominium__2__bd.Budowla__Surowce__Zmniejsz__Zbuduj__Do( budowla_rodzaj_f, tylko_test_f )
  else//if dominium__numer_f = Definicje.dominium__numer__gracz__2_c then
    Result := Self.dominium__1__bd.Budowla__Surowce__Zmniejsz__Zbuduj__Do( budowla_rodzaj_f, tylko_test_f );

end;//---//Funkcja Budowla__Surowce__Zmniejsz__Zbuduj__Bd().

function TBitwa_Dominia.Budowla__Zbuduj__Bd( const dominium__numer_f : smallint; const budowla_rodzaj_f : Definicje.TBudowla_Rodzaj; const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj; const y_f, x_f : integer; const tylko_test_f : boolean = false ) : boolean;
begin

  if Self.mapa_bitwy <> nil then
    begin

      if budowla_rodzaj_f = Definicje.br_domek then
        Result := Self.mapa_bitwy.Surowiec__Zajmij__Ma( dominium__numer_f, surowiec__rodzaj_f, y_f, x_f, tylko_test_f )
      else//if budowla_rodzaj_f = Definicje.br_domek then
        Result := Self.mapa_bitwy.Budowla__Zbuduj__Ma( dominium__numer_f, budowla_rodzaj_f, y_f, x_f, tylko_test_f );

    end
  else//if Self.mapa_bitwy <> nil then
    Result := false;

end;//---//Funkcja Budowla__Zbuduj__Bd().

procedure TBitwa_Dominia.Buduj__Bd( const tura_numer_f : integer; const gracz__nie_przeliczaj_f : boolean = false );
begin

  if gracz__nie_przeliczaj_f then
    begin

      if not Self.dominium__1__gra_gracz__bd then
        Self.Budowa_Decyduj__Bd( tura_numer_f, Self.dominium__1__bd, Self );

      if not Self.dominium__2__gra_gracz__bd then
        Self.Budowa_Decyduj__Bd( tura_numer_f, Self.dominium__2__bd, Self );

    end
  else//if gracz__nie_przeliczaj_f then
    begin

      if Random( 2 ) = 0 then
        begin

          Self.Budowa_Decyduj__Bd( tura_numer_f, Self.dominium__1__bd, Self );
          Self.Budowa_Decyduj__Bd( tura_numer_f, Self.dominium__2__bd, Self );

        end
      else//if Random( 2 ) = 0 then
        begin

          Self.Budowa_Decyduj__Bd( tura_numer_f, Self.dominium__2__bd, Self );
          Self.Budowa_Decyduj__Bd( tura_numer_f, Self.dominium__1__bd, Self );

        end;
      //---//if Random( 2 ) = 0 then

    end;
  //---//if gracz__nie_przeliczaj_f then

end;//---//Funkcja Buduj__Bd().

class procedure TBitwa_Dominia.Domek__Budowa_Decyduj__Bd( const tura_numer_f : integer; dominium_f : Dominium.TDominium; bitwa_dominia_f : Bitwa_Dominia.TBitwa_Dominia; const surowce__rodzaj_f : Definicje.TSurowce_Rodzaj = []; const próg__budowania__zmniejszony_f : boolean = false );

  //Funkcja Domek__Iloœæ__Zwiêksz_L() w Domek__Budowa_Decyduj__Bd().
  procedure Domek__Iloœæ__Zwiêksz_L( const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj );
  begin

    if    (  dominium_f.Domek__Iloœæ__Zwiêksz__Do( surowiec__rodzaj_f, true )  )
      and (  bitwa_dominia_f.mapa_bitwy.Surowiec__Zajmij__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), surowiec__rodzaj_f )  ) then
      begin

        dominium_f.Domek__Iloœæ__Zwiêksz__Do( surowiec__rodzaj_f );

        bitwa_dominia_f.Wizualizacja__Rysuj__Bd( bitwa_dominia_f, [ Bitwa_Dominia.wrz_budowle, Bitwa_Dominia.wrz_mapa, Bitwa_Dominia.wrz_surowce ] );

      end;
    //---//if    (  dominium_f.Domek__Iloœæ__Zwiêksz__Do( surowiec__rodzaj_f, true )  ) (...)

  end;//---//Funkcja Domek__Iloœæ__Zwiêksz_L() w Domek__Budowa_Decyduj__Bd().

var
  domki__iloœæ__próg__budowania_l : integer;

  zt_surowce_rodzaj : Definicje.TSurowce_Rodzaj;
begin//Funkcja Domek__Budowa_Decyduj__Bd().

  if   ( bitwa_dominia_f = nil )
    or ( dominium_f = nil ) then
    Exit;


  if    ( not dominium_f.Jednostki__Nie_Kupuje__Odczytaj__Do() )
    and ( tura_numer_f > bitwa_dominia_f.Przeliczeñ_W_Turze__Odczytaj__Bd() * dominium_f.Surowce__Oszczêdzanie_Przed_Bitw¹__Wspó³czynnik__Odczytaj__Do() ) then
    Exit;


  zt_surowce_rodzaj := bitwa_dominia_f.mapa_bitwy.Surowce__Wolne__Rodzaje__Odczytaj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do() );


  while ( zt_surowce_rodzaj <> [] )
    and (  dominium_f.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_domek, true )  ) do
    begin

      domki__iloœæ__próg__budowania_l := dominium_f.Domek__Iloœæ__Odczytaj__Do( Definicje.sr_kryszta³ );

      if domki__iloœæ__próg__budowania_l <= 0 then
        domki__iloœæ__próg__budowania_l := 2;

      if   ( próg__budowania__zmniejszony_f )
        or (  Self.Surowiec__W__Zasiêgu__Bd( dominium_f, bitwa_dominia_f, Definicje.sr_kryszta³, zt_surowce_rodzaj )  ) then
        begin

          domki__iloœæ__próg__budowania_l := System.Math.Floor( domki__iloœæ__próg__budowania_l * 0.5 );

          if domki__iloœæ__próg__budowania_l <= 0 then
            domki__iloœæ__próg__budowania_l := 1;

        end;
      //---//if   ( próg__budowania__zmniejszony_f ) (...)


      if   ( zt_surowce_rodzaj = [ Definicje.sr_kryszta³ ] )
        or (
                 ( Definicje.sr_kryszta³ in zt_surowce_rodzaj  )
             and (
                      ( Definicje.sr_kryszta³ in surowce__rodzaj_f )
                   or (
                            ( surowce__rodzaj_f = [] )
                        and (  dominium_f.Domek__Iloœæ__Odczytaj__Do( Definicje.sr_kryszta³ ) < 4  )
                      )
                 )
           ) then
        begin

          Domek__Iloœæ__Zwiêksz_L( Definicje.sr_kryszta³ );

        end
      else//if   ( zt_surowce_rodzaj = [ Definicje.sr_kryszta³ ] ) (...)
      if   ( zt_surowce_rodzaj = [ Definicje.sr_magma ] )
        or (
                 ( Definicje.sr_magma in zt_surowce_rodzaj  )
             and (
                      ( Definicje.sr_magma in surowce__rodzaj_f )
                   or (
                            ( surowce__rodzaj_f = [] )
                        and (  dominium_f.Domek__Iloœæ__Odczytaj__Do( Definicje.sr_magma ) < domki__iloœæ__próg__budowania_l  )
                      )
                 )
           ) then
        begin

          Domek__Iloœæ__Zwiêksz_L( Definicje.sr_magma );

        end
      else//if   ( zt_surowce_rodzaj = [ Definicje.sr_kryszta³ ] ) (...)
      if   ( zt_surowce_rodzaj = [ Definicje.sr_woda ] )
        or (
                 ( Definicje.sr_woda in zt_surowce_rodzaj  )
             and (
                      ( Definicje.sr_woda in surowce__rodzaj_f )
                   or (
                            ( surowce__rodzaj_f = [] )
                        and (  dominium_f.Domek__Iloœæ__Odczytaj__Do( Definicje.sr_woda ) < domki__iloœæ__próg__budowania_l  )
                      )
                 )
           ) then
        begin

          Domek__Iloœæ__Zwiêksz_L( Definicje.sr_woda );

        end
      else//if   ( zt_surowce_rodzaj = [ Definicje.sr_woda ] ) (...)
      if   ( zt_surowce_rodzaj = [ Definicje.sr_kwiatki ] )
        or (
                 ( Definicje.sr_kwiatki in zt_surowce_rodzaj  )
             and (
                      ( Definicje.sr_kwiatki in surowce__rodzaj_f )
                   or (
                            ( surowce__rodzaj_f = [] )
                        and (  dominium_f.Domek__Iloœæ__Odczytaj__Do( Definicje.sr_kwiatki ) < domki__iloœæ__próg__budowania_l  )
                      )
                 )
           ) then
        begin

          Domek__Iloœæ__Zwiêksz_L( Definicje.sr_kwiatki );

        end
      else//if    ( Definicje.sr_kwiatki in zt_surowce_rodzaj  ) (...)
      if   ( zt_surowce_rodzaj = [ Definicje.sr_¿ywio³ ] )
        or (
                 ( Definicje.sr_¿ywio³ in zt_surowce_rodzaj  )
             and (
                      ( Definicje.sr_¿ywio³ in surowce__rodzaj_f )
                   or (
                            ( surowce__rodzaj_f = [] )
                        and (  dominium_f.Domek__Iloœæ__Odczytaj__Do( Definicje.sr_¿ywio³ ) < domki__iloœæ__próg__budowania_l  )
                      )
                 )
           ) then
        begin

          Domek__Iloœæ__Zwiêksz_L( Definicje.sr_¿ywio³ );

        end
      else//if   ( zt_surowce_rodzaj = [ Definicje.sr_¿ywio³ ] ) (...)
        begin

          if   ( zt_surowce_rodzaj = [ Definicje.sr_kryszta³ ] )
            or (
                     ( Definicje.sr_kryszta³ in zt_surowce_rodzaj  )
                 and (
                          ( Definicje.sr_kryszta³ in surowce__rodzaj_f )
                       or (
                                ( surowce__rodzaj_f = [] )
                            and (  dominium_f.Domek__Iloœæ__Odczytaj__Do( Definicje.sr_kryszta³ ) <= dominium_f.Domek__Iloœæ__Odczytaj__Do( Definicje.sr_magma )  )
                          )
                     )
               ) then
            begin

              Domek__Iloœæ__Zwiêksz_L( Definicje.sr_kryszta³ );

            end
          else//if   ( zt_surowce_rodzaj = [ Definicje.sr_kryszta³ ] ) (...)
            Break;

        end;
      //---//if   ( zt_surowce_rodzaj = [ Definicje.sr_¿ywio³ ] ) (...)


      zt_surowce_rodzaj := bitwa_dominia_f.mapa_bitwy.Surowce__Wolne__Rodzaje__Odczytaj__Ma( dominium_f.Dominium__Numer__Odczytaj__Do() );

    end;
  //---//while ( zt_surowce_rodzaj <> [] ) (...)

end;//---//Funkcja Domek__Budowa_Decyduj__Bd().

class function TBitwa_Dominia.Domek__Surowce__Inne__Mniej_Ni¿__Razy__Bd( const iloœæ_razy_f : integer; dominium_f : Dominium.TDominium; const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj; const surowce_rodzaj_f: Definicje.TSurowce_Rodzaj ) : boolean;
var
  i : integer;
begin

  Result := false;


  if dominium_f = nil then
    Exit;


  Result := true;


  for i := Ord(  Low( Definicje.TSurowiec_Rodzaj )  ) to Ord(  High( Definicje.TSurowiec_Rodzaj )  ) do
    if    ( Definicje.TSurowiec_Rodzaj(i) <> surowiec__rodzaj_f )
      and ( Definicje.TSurowiec_Rodzaj(i) in surowce_rodzaj_f )
      and (  dominium_f.Domek__Iloœæ__Odczytaj__Do( surowiec__rodzaj_f ) > dominium_f.Domek__Iloœæ__Odczytaj__Do( Definicje.TSurowiec_Rodzaj(i) ) * iloœæ_razy_f  ) then
      begin

        Result := false;


        Exit;

      end;
    //---//if    ( Definicje.TSurowiec_Rodzaj(i) <> surowiec__rodzaj_f ) (...)

end;//---//Funkcja Domek__Surowce__Inne__Mniej_Ni¿__Razy__Bd().

procedure TBitwa_Dominia.Dominium__Budowle__Zburzenia_Przelicz__Bd( const budowle__domki_zburzone_t_f : Definicje.TBudowle );
var
  i : integer;
begin

  for i := 0 to Length( budowle__domki_zburzone_t_f ) - 1 do
    if budowle__domki_zburzone_t_f[ i ].dominium__numer__bu = Definicje.dominium__numer__gracz__1_c then
      begin

        if budowle__domki_zburzone_t_f[ i ].budowla_rodzaj__bu = Definicje.br_domek then
          Self.dominium__1__bd.Domek__Iloœæ__Zmniejsz__Do( budowle__domki_zburzone_t_f[ i ].surowiec__rodzaj__bu )
        else//if budowle__domki_zburzone_t_f[ i ].budowla_rodzaj__bu = Definicje.br_domek then
        if budowle__domki_zburzone_t_f[ i ].budowla_rodzaj__bu = Definicje.br_zamek then
          Self.dominium__1__bd.Zamek__Zburzony__Zburz__Do();

      end
    else//if budowle__domki_zburzone_t_f[ i ].dominium__numer__bu = Definicje.dominium__numer__gracz__1_c then
    if budowle__domki_zburzone_t_f[ i ].dominium__numer__bu = Definicje.dominium__numer__gracz__2_c then
      begin

        if budowle__domki_zburzone_t_f[ i ].budowla_rodzaj__bu = Definicje.br_domek then
          Self.dominium__2__bd.Domek__Iloœæ__Zmniejsz__Do( budowle__domki_zburzone_t_f[ i ].surowiec__rodzaj__bu )
        else//if budowle__domki_zburzone_t_f[ i ].budowla_rodzaj__bu = Definicje.br_domek then
        if budowle__domki_zburzone_t_f[ i ].budowla_rodzaj__bu = Definicje.br_zamek then
          Self.dominium__2__bd.Zamek__Zburzony__Zburz__Do();

      end;
    //---//if budowle__domki_zburzone_t_f[ i ].dominium__numer__bu = Definicje.dominium__numer__gracz__2_c then

end;//---//Funkcja Dominium__Budowle__Zburzenia_Przelicz__Bd().

function TBitwa_Dominia.Dominia__Jednostki__Obszar__Wielkoœæ__Odczytaj__Bd() : integer;
begin

  Result := System.Math.Max( Self.dominium__1__bd.Jednostki__Obszar__Wielkoœæ__Odczytaj__Do(), Self.dominium__2__bd.Jednostki__Obszar__Wielkoœæ__Odczytaj__Do() );

end;//---//Funkcja Dominia__Jednostki__Obszar__Wielkoœæ__Odczytaj__Bd().

function TBitwa_Dominia.Dominium__Domek__Iloœæ__Zwiêksz__Bd( const dominium__numer_f : smallint; const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj; const tylko_test_f : boolean = false ) : boolean;
begin

  if dominium__numer_f = Definicje.dominium__numer__gracz__2_c then
    Result := Self.dominium__2__bd.Domek__Iloœæ__Zwiêksz__Do( surowiec__rodzaj_f, tylko_test_f )
  else//if dominium__numer_f = Definicje.dominium__numer__gracz__2_c then
    Result := Self.dominium__1__bd.Domek__Iloœæ__Zwiêksz__Do( surowiec__rodzaj_f, tylko_test_f );

end;//---//Funkcja Dominium__Domek__Iloœæ__Zwiêksz__Bd().

function TBitwa_Dominia.Dominium__Gra_Gracz__1__Bd() : boolean;
begin

  Result := Self.dominium__1__gra_gracz__bd;

end;//---//Funkcja Dominium__Gra_Gracz__1__Bd().

function TBitwa_Dominia.Dominium__Gracz__Nazwa__Odczytaj__Bd( const dominium__numer_f : smallint ) : string;
begin

  if dominium__numer_f = Definicje.dominium__numer__gracz__2_c then
    Result := Self.dominium__2__nazwa__bd
  else//if dominium__numer_f = Definicje.dominium__numer__gracz__2_c then
    Result := Self.dominium__1__nazwa__bd;

end;//---//Funkcja Dominium__Gracz__Nazwa__Odczytaj__Bd().

function TBitwa_Dominia.Dominium__Gracz__Parametry__Odczytaj__Bd( const dominium__numer_f : smallint ) : string;
begin

  if dominium__numer_f = Definicje.dominium__numer__gracz__2_c then
    Result := Self.dominium__2__parametry__bd
  else//if dominium__numer_f = Definicje.dominium__numer__gracz__2_c then
    Result := Self.dominium__1__parametry__bd;

end;//---//Funkcja Dominium__Gracz__Parametry__Odczytaj__Bd().

function TBitwa_Dominia.Dominium__Jednostki__Odczytaj__Bd( const dominium__numer_f : smallint ) : Jednostka.TJednostki_t;
begin

  if dominium__numer_f = Definicje.dominium__numer__gracz__2_c then
    Result := Self.dominium__2__jednostki__bd
  else//if dominium__numer_f = Definicje.dominium__numer__gracz__2_c then
    Result := Self.dominium__1__jednostki__bd;

end;//---//Funkcja Dominium__Jednostki__Odczytaj__Bd().

function TBitwa_Dominia.Dominium__Surowce__Zasoby__Odczytaj__Bd( const dominium__numer_f : smallint ) : Definicje.TSurowce_Zasoby;
var
  i : integer;
begin

  SetLength(   Result, Ord(  High( Definicje.TSurowiec_Rodzaj )  ) + 1   );

  for i := Ord(  Low( Definicje.TSurowiec_Rodzaj )  ) to Ord(  High( Definicje.TSurowiec_Rodzaj )  ) do
    begin

      Result[ i ].domki__iloœæ__sz := 0;
      Result[ i ].surowiec__rodzaj__sz := Definicje.TSurowiec_Rodzaj(i);

      if dominium__numer_f = Definicje.dominium__numer__gracz__2_c then
        Result[ i ].surowiec__iloœæ__sz := Self.dominium__2__bd.Domek__Surowiec__Odczytaj__Do( Definicje.TSurowiec_Rodzaj(i) )
      else//if dominium__numer_f = Definicje.dominium__numer__gracz__2_c then
        Result[ i ].surowiec__iloœæ__sz := Self.dominium__1__bd.Domek__Surowiec__Odczytaj__Do( Definicje.TSurowiec_Rodzaj(i) );

    end;
  //---//for i := Ord(  Low( Definicje.TSurowiec_Rodzaj )  ) to Ord(  High( Definicje.TSurowiec_Rodzaj )  ) do

end;//---//Funkcja Dominium__Surowce__Zasoby__Odczytaj__Bd().

function TBitwa_Dominia.Dominium__Wytrzyma³oœæ_Punkty__Odczytaj__Bd( const dominium__numer_f : smallint ) : integer;
begin

  if dominium__numer_f = Definicje.dominium__numer__gracz__2_c then
    Result := Self.dominium__2__bd.Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Do()
  else//if dominium__numer_f = Definicje.dominium__numer__gracz__2_c then
    Result := Self.dominium__1__bd.Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Do();

end;//---//Funkcja Dominium__Wytrzyma³oœæ_Punkty__Odczytaj__Bd().

function TBitwa_Dominia.Jednostki__Obszar__Wolny__Dostêpnoœæ__SprawdŸ__Bd() : boolean;
begin

  if Self.dominium__1__gra_gracz__bd then
    Result := Self.dominium__1__bd.Jednostki__Obszar__Wolny__Dostêpnoœæ__SprawdŸ__Do()
  else
  if Self.dominium__2__gra_gracz__bd then
    Result := Self.dominium__2__bd.Jednostki__Obszar__Wolny__Dostêpnoœæ__SprawdŸ__Do()
  else
    Result := false;

end;//---//Funkcja Jednostki__Obszar__Wolny__Dostêpnoœæ__SprawdŸ__Bd().

function TBitwa_Dominia.Jednostki__Obszar__Wolny__Zakup__Bd( out surowiec__iloœæ__kryszta³_f, surowiec__iloœæ__magma_f : integer; const tylko_test_f : boolean = false ) : boolean;
begin

  if Self.dominium__1__gra_gracz__bd then
    Result := Self.dominium__1__bd.Jednostki__Obszar__Wolny__Zakup__Do( surowiec__iloœæ__kryszta³_f, surowiec__iloœæ__magma_f, tylko_test_f )
  else
  if Self.dominium__2__gra_gracz__bd then
    Result := Self.dominium__2__bd.Jednostki__Obszar__Wolny__Zakup__Do( surowiec__iloœæ__kryszta³_f, surowiec__iloœæ__magma_f, tylko_test_f )
  else
    Result := false;

end;//---//Funkcja Jednostki__Obszar__Wolny__Zakup__Bd().().

function TBitwa_Dominia.Jednostki__Po³¹cz__Bd( const jednostka_typ_f : Definicje.TJednostka_Typ; out surowiec__iloœæ__¿ywio³_f : integer; const tylko_test_f : boolean = false ) : boolean;
begin

  if Self.dominium__1__gra_gracz__bd then
    Result := Self.dominium__1__bd.Jednostki__Po³¹cz__Do( jednostka_typ_f, surowiec__iloœæ__¿ywio³_f, tylko_test_f )
  else
  if Self.dominium__2__gra_gracz__bd then
    Result := Self.dominium__2__bd.Jednostki__Po³¹cz__Do( jednostka_typ_f, surowiec__iloœæ__¿ywio³_f, tylko_test_f )
  else
    Result := false;

end;//---//Funkcja Jednostki__Po³¹cz__Bd().

function TBitwa_Dominia.Jednostki__Po³¹cz__Jednostki__Dostêpne__Bd( const jednostka_typ_f : Definicje.TJednostka_Typ ) : boolean;
begin

  if Self.dominium__1__gra_gracz__bd then
    Result := Self.dominium__1__bd.Jednostki__Po³¹cz__Jednostki__Dostêpne__Do( jednostka_typ_f )
  else
  if Self.dominium__2__gra_gracz__bd then
    Result := Self.dominium__2__bd.Jednostki__Po³¹cz__Jednostki__Dostêpne__Do( jednostka_typ_f )
  else
    Result := false;

end;//---//Funkcja Jednostki__Po³¹cz__Jednostki__Dostêpne__Bd().

function TBitwa_Dominia.Jednostki__Po³¹cz__Surowce__Wystarczy__Bd( const jednostka_typ_f : Definicje.TJednostka_Typ ) : boolean;
begin

  if Self.dominium__1__gra_gracz__bd then
    Result := Self.dominium__1__bd.Jednostki__Po³¹cz__Surowce__Wystarczy__Do( jednostka_typ_f )
  else
  if Self.dominium__2__gra_gracz__bd then
    Result := Self.dominium__2__bd.Jednostki__Po³¹cz__Surowce__Wystarczy__Do( jednostka_typ_f )
  else
    Result := false;

end;//---//Funkcja Jednostki__Po³¹cz__Surowce__Wystarczy__Bd().

function TBitwa_Dominia.Jednostka__Zakup__Jedn¹__Mo¿na__SprawdŸ__Bd( const jednostka_typ_f : Definicje.TJednostka_Typ ) : boolean;
begin

  if Self.dominium__1__gra_gracz__bd then
    Result := Self.dominium__1__bd.Jednostka__Zakup__Jedn¹__Do( jednostka_typ_f, true )
  else
  if Self.dominium__2__gra_gracz__bd then
    Result := Self.dominium__2__bd.Jednostka__Zakup__Jedn¹__Do( jednostka_typ_f, true )
  else
    Result := false;

end;//---//Funkcja Jednostka__Zakup__Jedn¹__Mo¿na__SprawdŸ__Bd().

function TBitwa_Dominia.Jednostki__Zakup__Obs³uga__Bd( const jednostki_po³¹cz_f, teren_kup_f : boolean; const jednostka_typ_f : Definicje.TJednostka_Typ; const jednostka_typ__po³¹cz_f : Definicje.TJednostka_Typ = Definicje.jt_pusta ) : boolean;
begin

  if jednostki_po³¹cz_f then
    begin

      if Self.dominium__1__gra_gracz__bd then
        Result := Self.dominium__1__bd.Jednostki__Po³¹cz__Do( jednostka_typ__po³¹cz_f )
      else
      if Self.dominium__2__gra_gracz__bd then
        Result := Self.dominium__2__bd.Jednostki__Po³¹cz__Do( jednostka_typ__po³¹cz_f )
      else
        Result := false;

    end
  else//if jednostki_po³¹cz_f then
  if teren_kup_f then
    begin

      if Self.dominium__1__gra_gracz__bd then
        Result := Self.dominium__1__bd.Jednostki__Obszar__Wolny__Zakup__Do()
      else
      if Self.dominium__2__gra_gracz__bd then
        Result := Self.dominium__2__bd.Jednostki__Obszar__Wolny__Zakup__Do()
      else
        Result := false;

    end
  else//if teren_kup_f then
    begin

      if Self.dominium__1__gra_gracz__bd then
        Result := Self.dominium__1__bd.Jednostka__Zakup__Jedn¹__Do( jednostka_typ_f )
      else
      if Self.dominium__2__gra_gracz__bd then
        Result := Self.dominium__2__bd.Jednostka__Zakup__Jedn¹__Do( jednostka_typ_f )
      else
        Result := false;

    end;
  //---//if teren_kup_f then

end;//---//Funkcja Jednostki__Zakup__Obs³uga__Bd().

procedure TBitwa_Dominia.Jednostki__Zakup__Wiele__Bd( const gracz__tylko_przeliczaj_f : boolean = false );
begin

  if   (
             ( not gracz__tylko_przeliczaj_f )
         and ( not Self.dominium__1__gra_gracz__bd )
       )
    or (
             ( gracz__tylko_przeliczaj_f )
         and ( Self.dominium__1__gra_gracz__bd )
       ) then
    Self.dominium__1__bd.Jednostki__Zakup__Wiele__Do();


  if   (
             ( not gracz__tylko_przeliczaj_f )
         and ( not Self.dominium__2__gra_gracz__bd )
       )
    or (
             ( gracz__tylko_przeliczaj_f )
         and ( Self.dominium__2__gra_gracz__bd )
       ) then
    Self.dominium__2__bd.Jednostki__Zakup__Wiele__Do();

end;//---//Funkcja Jednostki__Zakup__Wiele__Bd().

procedure TBitwa_Dominia.Mapa__Atak__Przelicz__Bd();
var
  budowle__domki_zburzone_t_l : Definicje.TBudowle;
begin

  Self.mapa_bitwy.Koszary__Mapa_Jednostki__Atak_Ruch__Przelicz__Ma( budowle__domki_zburzone_t_l );

  Self.Dominium__Budowle__Zburzenia_Przelicz__Bd( budowle__domki_zburzone_t_l );

  Self.mapa_bitwy.Koszary__Produkcja_Przelicz__Ma();


  Self.mapa_bitwy.Budowle__Atak_Przelicz__Ma( budowle__domki_zburzone_t_l );

  Self.Dominium__Budowle__Zburzenia_Przelicz__Bd( budowle__domki_zburzone_t_l );

end;//---//Funkcja Mapa__Atak__Przelicz__Bd().

function TBitwa_Dominia.Przeliczeñ_W_Turze__Odczytaj__Bd() : integer;
begin

  Result := Self.przeliczeñ_w_turze__bd;

end;//---//Funkcja Przeliczeñ_W_Turze__Odczytaj__Bd().

procedure TBitwa_Dominia.Surowce__Produkcja_Przelicz__Bd();
begin

  Self.dominium__1__bd.Surowce__Produkcja_Przelicz__Do();
  Self.dominium__2__bd.Surowce__Produkcja_Przelicz__Do();

end;//---//Funkcja Surowce__Produkcja_Przelicz__Bd().

class function TBitwa_Dominia.Surowiec__W__Zasiêgu__Bd( dominium_f : Dominium.TDominium; bitwa_dominia_f : Bitwa_Dominia.TBitwa_Dominia; const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj; const surowce_rodzaj_f: Definicje.TSurowce_Rodzaj ) : boolean;
var
  surowiec_wspó³rzêdne_l : Winapi.Windows.TPoint; // Tylko aby wywo³aæ funkcjê.
begin

  Result := Self.Surowiec__W__Zasiêgu__Bd( dominium_f, bitwa_dominia_f, surowiec__rodzaj_f, surowce_rodzaj_f, surowiec_wspó³rzêdne_l );

end;//---//Funkcja Surowiec__W__Zasiêgu__Bd().

class function TBitwa_Dominia.Surowiec__W__Zasiêgu__Bd( dominium_f : Dominium.TDominium; bitwa_dominia_f : Bitwa_Dominia.TBitwa_Dominia; const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj; const surowce_rodzaj_f: Definicje.TSurowce_Rodzaj; var surowiec_wspó³rzêdne_f : Winapi.Windows.TPoint ) : boolean;
var
  droga__d³ugoœæ_l : integer;
begin

  Result := false;


  if   ( bitwa_dominia_f = nil )
    or ( dominium_f = nil ) then
    Exit;


  if    (  Self.Domek__Surowce__Inne__Mniej_Ni¿__Razy__Bd( 2, dominium_f, surowiec__rodzaj_f, surowce_rodzaj_f )  )
    and (  dominium_f.Domek__Iloœæ__Odczytaj__Do( surowiec__rodzaj_f ) >= 2  ) then
    begin

      surowiec_wspó³rzêdne_f := bitwa_dominia_f.mapa_bitwy.Surowiec__Najbli¿szy__ZnajdŸ__Ma( dominium_f.Dominium__Numer__Odczytaj__Do(), [ surowiec__rodzaj_f ], droga__d³ugoœæ_l );

      if    ( surowiec_wspó³rzêdne_f.X <> Definicje.identyfikator_pusty_c )
        and ( surowiec_wspó³rzêdne_f.Y <> Definicje.identyfikator_pusty_c )
        and (  droga__d³ugoœæ_l <= Definicje.obserwacja__zasiêg___zamek_c + Definicje.obserwacja__zasiêg___wie¿a__zwiadowcza_c * 5 * dominium_f.Domek__Iloœæ__Odczytaj__Do( surowiec__rodzaj_f )  ) then
        Result := true;

    end;
  //---//if    (  Self.Domek__Surowce__Inne__Mniej_Ni¿__Bd( 2, dominium_f, surowiec__rodzaj_f, surowce_rodzaj_f )  ) (...)

end;//---//Funkcja Surowiec__W__Zasiêgu__Bd().

function TBitwa_Dominia.Teren__Punkt__Budowaæ__Mo¿na__SprawdŸ__Bd( const dominium__numer_f : smallint; const y_f, x_f : integer; const budowla__rodzaj_f : Definicje.TBudowla_Rodzaj ) : boolean;
var
  surowiec__rodzaj_l : Definicje.TSurowiec_Rodzaj; // Tylko aby wywo³aæ funkcjê.
begin

  Result := Self.Teren__Punkt__Budowaæ__Mo¿na__SprawdŸ__Bd( dominium__numer_f, y_f, x_f, budowla__rodzaj_f, surowiec__rodzaj_l );

end;//---//Funkcja Teren__Punkt__Budowaæ__Mo¿na__SprawdŸ__Bd().

function TBitwa_Dominia.Teren__Punkt__Budowaæ__Mo¿na__SprawdŸ__Bd( const dominium__numer_f : smallint; const y_f, x_f : integer; const budowla__rodzaj_f : Definicje.TBudowla_Rodzaj; out surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj ) : boolean;
begin

  if Self.mapa_bitwy <> nil then
    Result := Self.mapa_bitwy.Punkt__Budowaæ__Mo¿na__SprawdŸ__Ma( dominium__numer_f, y_f, x_f, surowiec__rodzaj_f, budowla__rodzaj_f = Definicje.br_domek )
  else//if Self.mapa_bitwy <> nil then
    Result := false;

end;//---//Funkcja Teren__Punkt__Budowaæ__Mo¿na__SprawdŸ__Bd().

function TBitwa_Dominia.Teren__Wielkoœæ__X__Odczytaj__Bd() : integer;
begin

  if Self.mapa_bitwy <> nil then
    Result := Self.mapa_bitwy.Teren__Wielkoœæ__X__Odczytaj__Ma()
  else//if Self.mapa_bitwy <> nil then
    Result := -1;

end;//---//Funkcja Teren__Wielkoœæ__X__Odczytaj__Bd().

function TBitwa_Dominia.Teren__Wielkoœæ__Y__Odczytaj__Bd() : integer;
begin

  if Self.mapa_bitwy <> nil then
    Result := Self.mapa_bitwy.Teren__Wielkoœæ__Y__Odczytaj__Ma()
  else//if Self.mapa_bitwy <> nil then
    Result := -1;

end;//---//Funkcja Teren__Wielkoœæ__Y__Odczytaj__Bd().

class procedure TBitwa_Dominia.Wizualizacja__Rysuj__Bd( bitwa_dominia_f : Bitwa_Dominia.TBitwa_Dominia; const wizualizacja_rysuj_zakresy_f : Bitwa_Dominia.TWizualizacja_Rysuj_Zakresy; const gra_wspó³czynnik_prêdkoœci_f : single = 1; const przed_starciem_f : boolean = false );
begin

  if   ( bitwa_dominia_f = nil )
    or ( not bitwa_dominia_f.gra_gracz__bd ) then
    Exit;


  if Bitwa_Dominia.wrz_mapa in wizualizacja_rysuj_zakresy_f then
    Wizualizacja.TWizualizacja.Mapa__Rysuj__Wi( bitwa_dominia_f.mapa_bitwy.Teren__Mapa__Odczytaj__Ma() );

  if Bitwa_Dominia.wrz_jednostki__jednostki in wizualizacja_rysuj_zakresy_f then
    Wizualizacja.TWizualizacja.Jednostki__Rysuj__Wi(  przed_starciem_f, bitwa_dominia_f.bitwa__jednostki__bitwa_starcie_etap__bd, bitwa_dominia_f.Dominium__Jednostki__Odczytaj__Bd( Definicje.dominium__numer__gracz__1_c ), bitwa_dominia_f.Dominium__Jednostki__Odczytaj__Bd( Definicje.dominium__numer__gracz__2_c )  );

  if Bitwa_Dominia.wrz_jednostki__obszar in wizualizacja_rysuj_zakresy_f then
    Wizualizacja.TWizualizacja.Jednostki__Obszar__Rysuj__Wi(  System.Math.Max( bitwa_dominia_f.dominium__1__bd.Jednostki__Obszar__Wielkoœæ__Odczytaj__Do(), bitwa_dominia_f.dominium__2__bd.Jednostki__Obszar__Wielkoœæ__Odczytaj__Do() )  );

  if Bitwa_Dominia.wrz_surowce in wizualizacja_rysuj_zakresy_f then
    Wizualizacja.TWizualizacja.Surowce__Rysuj__Wi( bitwa_dominia_f.mapa_bitwy.Teren__Surowce__Odczytaj__Ma() );

  if Bitwa_Dominia.wrz_budowle in wizualizacja_rysuj_zakresy_f then
    Wizualizacja.TWizualizacja.Budowle__Rysuj__Wi( bitwa_dominia_f.mapa_bitwy.Teren__Budowle__Odczytaj__Ma() );

  if Bitwa_Dominia.wrz_mapa__jednostki in wizualizacja_rysuj_zakresy_f then
    Wizualizacja.TWizualizacja.Mapa__Jednostki__Rysuj__Wi( bitwa_dominia_f.mapa_bitwy.Teren__Mapa__Jednostki__Odczytaj__Ma() );

  if Bitwa_Dominia.wrz_animacje___mapa in wizualizacja_rysuj_zakresy_f then
    Wizualizacja.TWizualizacja.Animacje___Mapa__Wi( gra_wspó³czynnik_prêdkoœci_f );

  if Bitwa_Dominia.wrz_animacje__jednostki in wizualizacja_rysuj_zakresy_f then
    Wizualizacja.TWizualizacja.Animacje__Jednostki__Wi( gra_wspó³czynnik_prêdkoœci_f );

end;//---//Funkcja Wizualizacja__Rysuj__Bd().

end.
