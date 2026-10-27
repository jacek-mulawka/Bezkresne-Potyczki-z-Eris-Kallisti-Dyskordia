unit Mapa;{13.Sie.2026}

  // WspÛ≥rzÍdne mapy.
  //
  //   x ---
  // y
  // |
  // |
  // |
  //

interface

{$DEFINE xtest__funkcjonalnosc_d}

uses
  System.SysUtils,
  Vcl.Forms,
  Vcl.Graphics,
  Winapi.Windows,

  {$IFDEF test__funkcjonalnosc_d}
  Test_Funkcjonalnosc,
  {$ENDIF}

  Definicje,
  Poszukiwacz;

type
  TMapa = class
  private
    { Private declarations }
    budowle__id__ma,
    mapa_jednostki__id__ma,
    teren__wielkoúÊ__x__ma,
    teren__wielkoúÊ__y__ma
      : integer;

    dominium__1__atak__wspÛ≥czynnik__ma,
    dominium__2__atak__wspÛ≥czynnik__ma,
    dominium__1__obrona__wspÛ≥czynnik__ma,
    dominium__2__obrona__wspÛ≥czynnik__ma
      : real;

    budowle_t__ma : Definicje.TBudowle;
    mapa_jednostki_t__ma : Definicje.TMapa_Jednostki;
    surowce_ürÛd≥o_t__ma : Definicje.TSurowce_èrÛd≥o;
    teren_t__ma : Poszukiwacz.TTablica2D_Integer; // Self.teren_t__ma[ y, x ].

    function Odleg≥oúÊ__Wylicz__Ma( const y__1_f, x__1_f, y__2_f, x__2_f : integer ) : real;
    function Punkt__Naleøy_Do__Terenu__Sprawdü__Ma( const y_f, x_f : integer ) : boolean;
    function Punkt__W_Promieniu__Sprawdü__Ma( const y__1_f, y__2_f, x__1_f, x__2_f, promieÒ_f : integer ) : boolean;
    function Teren__Na_Oko≥o__Punktu__DostÍpny__Sprawdü__Ma( const dominium__numer_f : smallint; const y_f, x_f : integer; const promieÒ_f : integer = 1 ) : integer;
    procedure Teren__PrzynaleønoúÊ__Oznacz__Ma();
    function Teren__PrzynaleønoúÊ__Sprawdü__Ma( const przynaleønoúÊ__numer_f : smallint; const y_f, x_f : integer ) : boolean;
    procedure Wczytaj__Ma( const dominium__numer__1_f, dominium__numer__2_f : smallint; const potyczki__iloúÊ_f : integer );
    function WspÛ≥czynniki__Dolicz__Ma( const dominium__numer_f : smallint; const wartoúÊ_f : real; const czy_atak_f : boolean ) : real;
    function Zamek__WspÛ≥rzÍdne__Znajdü__Ma( const dominium__numer_f : smallint; var y_f, x_f : integer) : boolean;
  public
    { Public declarations }
    constructor Create( const dominium__numer__1_f, dominium__numer__2_f : smallint; const potyczki__iloúÊ_f : integer; const dominium__1__atak__wspÛ≥czynnik_f, dominium__2__atak__wspÛ≥czynnik_f, dominium__1__obrona__wspÛ≥czynnik_f, dominium__2__obrona__wspÛ≥czynnik_f : real );
    destructor Destroy(); override;

    procedure Atak__Obraøenia__W_Trakcie__Zeruj__Ma();
    function Budowla__Zbuduj__Ma( const dominium__numer_f : smallint; const budowla_rodzaj_f : Definicje.TBudowla_Rodzaj; const y_f, x_f : integer; const tylko_test_f : boolean = false ) : boolean;
    function Budowla__Atakowana__Jest__Ma( const dominium__numer_f : smallint ) : Winapi.Windows.TPoint;
    procedure Budowla__Zburz__Jednπ__Ma( const id_f : integer );
    procedure Budowle__Atak_Przelicz__Ma( var budowle__domki_zburzone_t_f : Definicje.TBudowle );
    procedure Budowle__Zburzenie__Przelicz__Ma( var budowle__domki_zburzone_t_f : Definicje.TBudowle );
    function Budowle__W_Promieniu__Odczytaj__Ma( const dominium__numer_f : smallint; const budowla_rodzaj_f : Definicje.TBudowla_Rodzaj; const y_f, x_f : integer; promieÒ_f : integer = 1 ) : integer;

    function Koszary__Budowa__Punkt__Znajdü__Ma( const dominium__numer_f : smallint; const koszar_w_rzÍdzie_f : integer = 0; const cofnij_wspÛ≥rzÍdnπ_y_razy_f : integer = 0 ) : Winapi.Windows.TPoint;
    procedure Koszary__Mapa_Jednostki__Atak_Ruch__Przelicz__Ma( var budowle__domki_zburzone_t_f : Definicje.TBudowle );
    procedure Koszary__Produkcja_Przelicz__Ma();

    function Mapa_Jednostka__W_Promieniu__Odczytaj__Ma( const dominium__numer_f : smallint; const y_f, x_f : integer; promieÒ_f : integer = 1 ) : integer;
    function Mapa_Jednostka__Wrogie_Na_Terenie__Budowa__Ma( const dominium__numer_f : smallint ) : Winapi.Windows.TPoint;

    procedure Mapa_Jednostka__Zburz__Wiele__Ma();

    function Punkt__BudowaÊ__Moøna__Sprawdü__Ma( const dominium__numer_f : smallint; const y_f, x_f : integer; const czy_domek_f : boolean = false ) : boolean; overload;
    function Punkt__BudowaÊ__Moøna__Sprawdü__Ma( const dominium__numer_f : smallint; const y_f, x_f : integer; out surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj; const czy_domek_f : boolean = false ) : boolean; overload;
    function Punkt__BudowaÊ__Moøna__Znajdü__W_Promieniu__Ma( const dominium__numer_f : smallint; const y_f, x_f : integer; promieÒ_f : integer = 1 ) : Winapi.Windows.TPoint;

    function Surowce__Wolne__Rodzaje__Odczytaj__Ma( const dominium__numer_f : smallint; const czy_w_zasiÍgu_terytorium_f : boolean = true ) : Definicje.TSurowce_Rodzaj;

    function Surowiec__Najbliøszy__Znajdü__Ma( const dominium__numer_f : smallint; const surowce_rodzaj_f : Definicje.TSurowce_Rodzaj; var droga__d≥ugoúÊ_f : integer; const czy_na_wrogim_terytorium_f : boolean = false; const granica_odstÍp_f : integer = 0 ) : Winapi.Windows.TPoint; overload;
    function Surowiec__Najbliøszy__Znajdü__Ma( const dominium__numer_f : smallint; const surowce_rodzaj_f : Definicje.TSurowce_Rodzaj; const czy_na_wrogim_terytorium_f : boolean = false; const granica_odstÍp_f : integer = 0 ) : Winapi.Windows.TPoint; overload;
    function Surowiec__Najbliøszy__Znajdü__Ma( const dominium__numer_f : smallint; const surowce_rodzaj_f : Definicje.TSurowce_Rodzaj; var droga__d≥ugoúÊ_f : integer; var punkt__na_wrogim_terytorium__pierwszy_f : Winapi.Windows.TPoint; const czy_na_wrogim_terytorium_f : boolean = false; const granica_odstÍp_f : integer = 0 ) : Winapi.Windows.TPoint; overload;
    function Surowiec__OpuúÊ__Ma( const dominium__numer_f : smallint; const id__surowiec_ürÛd≥o_f : integer; const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj ) : boolean;
    function Surowiec__Zajmij__Ma( const dominium__numer_f : smallint; const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj; const y_f : integer = -99; const x_f : integer = -99; const tylko_test_f : boolean = false ) : boolean;

    function Teren__Budowle__Odczytaj__Ma() : Definicje.TBudowle;
    function Teren__Mapa__Jednostki__Odczytaj__Ma() : Definicje.TMapa_Jednostki;
    function Teren__Mapa__Odczytaj__Ma() : Poszukiwacz.TTablica2D_Integer;
    function Teren__Surowce__Odczytaj__Ma() : Definicje.TSurowce_èrÛd≥o;
    function Teren__WielkoúÊ__X__Odczytaj__Ma() : integer;
    function Teren__WielkoúÊ__Y__Odczytaj__Ma() : integer;
  end;//---//TMapa = class

const
  atak__si≥a___mapa__jednostka_c : integer = 20;
  atak__si≥a___wieøa__obronna_c : integer = 50;
  atak__zasiÍg___wieøa__obronna_c : integer = 1;

  budowa__koszt__mapa__jednostka_c : integer = 1;

  koszary__mapa_jednostki__pojemnoúÊ_c : integer = 5;
  koszary__produkcja_wspÛ≥czynnik_c : real = 0.7;

  mapa__plik__nazwa__prefiks_c : string = 'mapa__';
  mapy__katalog__nazwa_c : string = 'Mapy';

  surowiec_ürÛd≥o__pojemnoúÊ__domki_c : integer = 2;

  wieøa__obronna__atakÛw_w__mapa_jednostki_c : integer = 1;

  wytrzyma≥oúÊ_punkty__domek_c : integer = 400;
  wytrzyma≥oúÊ_punkty__koszary_c : integer = 1200;
  wytrzyma≥oúÊ_punkty__mapa__jednostka_c : integer = 5;
  wytrzyma≥oúÊ_punkty__wieøa__obronna_c : integer = 1000;
  wytrzyma≥oúÊ_punkty__wieøa__zwiadowcza_c : integer = 200;
  wytrzyma≥oúÊ_punkty__zamek_c : integer = 6000;

implementation

constructor TMapa.Create( const dominium__numer__1_f, dominium__numer__2_f : smallint; const potyczki__iloúÊ_f : integer; const dominium__1__atak__wspÛ≥czynnik_f, dominium__2__atak__wspÛ≥czynnik_f, dominium__1__obrona__wspÛ≥czynnik_f, dominium__2__obrona__wspÛ≥czynnik_f : real );
begin

  Self.budowle__id__ma := -1;
  Self.dominium__1__atak__wspÛ≥czynnik__ma := dominium__1__atak__wspÛ≥czynnik_f;
  Self.dominium__2__atak__wspÛ≥czynnik__ma := dominium__2__atak__wspÛ≥czynnik_f;
  Self.dominium__1__obrona__wspÛ≥czynnik__ma := dominium__1__obrona__wspÛ≥czynnik_f;
  Self.dominium__2__obrona__wspÛ≥czynnik__ma := dominium__2__obrona__wspÛ≥czynnik_f;
  Self.mapa_jednostki__id__ma := -1;
  Self.teren__wielkoúÊ__x__ma := -1;
  Self.teren__wielkoúÊ__y__ma := -1;

  Self.Wczytaj__Ma( dominium__numer__1_f, dominium__numer__2_f, potyczki__iloúÊ_f );

end;//---//Konstruktor klasy TMapa.

destructor TMapa.Destroy();
begin

  SetLength( Self.budowle_t__ma, 0 );
  SetLength( Self.mapa_jednostki_t__ma, 0 );
  SetLength( Self.surowce_ürÛd≥o_t__ma, 0 );
  SetLength( Self.teren_t__ma, 0, 0 );

end;//---//Destruktor klasy TMapa.

procedure TMapa.Atak__Obraøenia__W_Trakcie__Zeruj__Ma();
var
  i : integer;
begin

  for i := 0 to Length( Self.budowle_t__ma ) - 1 do
    begin

      Self.budowle_t__ma[ i ].atak__w_trakcie__bu := false;
      Self.budowle_t__ma[ i ].obraøenia__w_trakcie__bu := false;

    end;
  //---//for i := 0 to Length( Self.budowle_t__ma ) - 1 do

  for i := 0 to Length( Self.mapa_jednostki_t__ma ) - 1 do
    begin

      Self.mapa_jednostki_t__ma[ i ].atak__w_trakcie__mj := false;
      Self.mapa_jednostki_t__ma[ i ].obraøenia__w_trakcie__mj := false;

    end;
  //---//for i := 0 to Length( Self.mapa_jednostki_t__ma ) - 1 do

end;//---//Funkcja Atak__Obraøenia__W_Trakcie__Zeruj__Ma().

function TMapa.Budowla__Zbuduj__Ma( const dominium__numer_f : smallint; const budowla_rodzaj_f : Definicje.TBudowla_Rodzaj; const y_f, x_f : integer; const tylko_test_f : boolean = false ) : boolean;
var
  i : integer;
begin

  Result := false;


  if   (  not ( budowla_rodzaj_f in [ Definicje.br_koszary, Definicje.br_wieøa__obronna, Definicje.br_wieøa__zwiadowcza ] )  )
    or (  not Self.Punkt__BudowaÊ__Moøna__Sprawdü__Ma( dominium__numer_f, y_f, x_f )  ) then
    Exit;


  if not tylko_test_f then
    begin

      inc( Self.budowle__id__ma );

      i := Length( Self.budowle_t__ma );
      SetLength( Self.budowle_t__ma, i + 1 );

      Self.budowle_t__ma[ i ].id__bu := Self.budowle__id__ma;
      Self.budowle_t__ma[ i ].id__surowiec_ürÛd≥o__bu := Definicje.identyfikator_pusty_c;
      Self.budowle_t__ma[ i ].atak__w_trakcie__bu := false;
      Self.budowle_t__ma[ i ].budowla_rodzaj__bu := budowla_rodzaj_f;
      Self.budowle_t__ma[ i ].dominium__numer__bu := dominium__numer_f;
      Self.budowle_t__ma[ i ].koszary__mapa_jednostki__iloúÊ__bu := 0;
      Self.budowle_t__ma[ i ].koszary__produkcja_wspÛ≥czynnik__skumulowany__bu := 0;
      Self.budowle_t__ma[ i ].obraøenia__w_trakcie__bu := false;
      Self.budowle_t__ma[ i ].ruch_grupπ__bu := false;
      Self.budowle_t__ma[ i ].surowiec__rodzaj__bu := Definicje.sr_kryszta≥;
      Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__x__bu := x_f;
      Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__y__bu := y_f;
      Self.budowle_t__ma[ i ].wytrzyma≥oúÊ_punkty__bu := 0;

      if budowla_rodzaj_f in [ Definicje.br_koszary ] then
        Self.budowle_t__ma[ i ].wytrzyma≥oúÊ_punkty__bu := Mapa.wytrzyma≥oúÊ_punkty__koszary_c
      else
      if budowla_rodzaj_f in [ Definicje.br_wieøa__obronna ] then
        Self.budowle_t__ma[ i ].wytrzyma≥oúÊ_punkty__bu := Mapa.wytrzyma≥oúÊ_punkty__wieøa__obronna_c
      else
      if budowla_rodzaj_f in [ Definicje.br_wieøa__zwiadowcza ] then
        Self.budowle_t__ma[ i ].wytrzyma≥oúÊ_punkty__bu := Mapa.wytrzyma≥oúÊ_punkty__wieøa__zwiadowcza_c;

      Self.budowle_t__ma[ i ].wytrzyma≥oúÊ_punkty__bu := Self.WspÛ≥czynniki__Dolicz__Ma( Self.budowle_t__ma[ i ].dominium__numer__bu, Self.budowle_t__ma[ i ].wytrzyma≥oúÊ_punkty__bu, false );


      Self.Teren__PrzynaleønoúÊ__Oznacz__Ma();

    end;
  //---//if not tylko_test_f then


  Result := true;

end;//---//Funkcja Budowla__Zbuduj__Ma().

function TMapa.Budowla__Atakowana__Jest__Ma( const dominium__numer_f : smallint ) : Winapi.Windows.TPoint;
var
  i,
  j
    : integer;
begin

  Result.SetLocation( Definicje.identyfikator_pusty_c, Definicje.identyfikator_pusty_c );


  for i := 0 to Length( Self.budowle_t__ma ) - 1 do
    if    ( Self.budowle_t__ma[ i ].dominium__numer__bu = dominium__numer_f )
      and ( Self.budowle_t__ma[ i ].obraøenia__w_trakcie__bu ) then
      for j := 1 to 5 do
        begin

          Result := Self.Punkt__BudowaÊ__Moøna__Znajdü__W_Promieniu__Ma( dominium__numer_f, Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__y__bu, Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__x__bu, j );

          if    ( Result.X <> Definicje.identyfikator_pusty_c )
            and ( Result.Y <> Definicje.identyfikator_pusty_c ) then
            Exit;

        end;
      //---//for j := 1 to 5 do

end;//---//Funkcja Budowla__Atakowana__Jest__Ma().

procedure TMapa.Budowla__Zburz__Jednπ__Ma( const id_f : integer );
var
  i,
  j
    : integer;
begin

  for i := Length( Self.budowle_t__ma ) - 1 downto 0 do
    if Self.budowle_t__ma[ i ].id__bu = id_f then
      begin

        if Self.budowle_t__ma[ i ].budowla_rodzaj__bu = Definicje.br_koszary then
          for j := 0 to Length( Self.mapa_jednostki_t__ma ) - 1 do
            if    ( Self.mapa_jednostki_t__ma[ j ].id__budowla__mj = Self.budowle_t__ma[ i ].id__bu )
              and ( Self.mapa_jednostki_t__ma[ j ].dominium__numer__mj = Self.budowle_t__ma[ i ].dominium__numer__bu ) then
              begin

                Self.mapa_jednostki_t__ma[ j ].id__budowla__mj := Definicje.identyfikator_pusty_c;

                if not Self.mapa_jednostki_t__ma[ j ].poza_koszarami__mj then
                  Self.mapa_jednostki_t__ma[ j ].poza_koszarami__mj := true;

                if not Self.mapa_jednostki_t__ma[ j ].ruch__mj then
                  Self.mapa_jednostki_t__ma[ j ].ruch__mj := true;

              end;
            //---//if    ( Self.mapa_jednostki_t__ma[ j ].id__budowla__mj = Self.budowle_t__ma[ i ].id__bu ) (...)


        for j := i to Length( Self.budowle_t__ma ) - 2 do
          Self.budowle_t__ma[ j ] := Self.budowle_t__ma[ j + 1 ];


        SetLength(  Self.budowle_t__ma, Length( Self.budowle_t__ma ) - 1  );


        Break;

      end;
    //---//if Self.budowle_t__ma[ i ].id__bu = id_f then

end;//---//Funkcja Budowla__Zburz__Jednπ__Ma().

procedure TMapa.Budowle__Atak_Przelicz__Ma( var budowle__domki_zburzone_t_f : Definicje.TBudowle );
var
  ztb : boolean;

  i,
  j,
  zti
    : integer;

  budowle__cele__id_t_l : array of integer;
begin

  for i := 0 to Length( Self.budowle_t__ma ) - 1 do
    if Self.budowle_t__ma[ i ].budowla_rodzaj__bu = Definicje.br_wieøa__obronna then
      begin

        ztb := false;
        zti := 0;

        for j := 0 to Length( Self.mapa_jednostki_t__ma ) - 1 do
          if    ( i <> j )
            and ( Self.budowle_t__ma[ i ].dominium__numer__bu <> Self.mapa_jednostki_t__ma[ j ].dominium__numer__mj )
            and ( Self.mapa_jednostki_t__ma[ j ].poza_koszarami__mj )
            and ( Self.mapa_jednostki_t__ma[ j ].wytrzyma≥oúÊ_punkty__mj > 0 )
            and (  Self.Punkt__W_Promieniu__Sprawdü__Ma( Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__y__bu, Self.mapa_jednostki_t__ma[ j ].wspÛ≥rzÍdna__y__mj, Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__x__bu, Self.mapa_jednostki_t__ma[ j ].wspÛ≥rzÍdna__x__mj, Mapa.atak__zasiÍg___wieøa__obronna_c )  ) then
            begin

              if not ztb then
                ztb := true;


              inc( zti );


              if not Self.budowle_t__ma[ i ].atak__w_trakcie__bu then
                begin

                  Self.budowle_t__ma[ i ].atak__w_trakcie__bu := true;
                  Self.budowle_t__ma[ i ].atak__cel__wspÛ≥rzÍdna__x__bu := Self.mapa_jednostki_t__ma[ j ].wspÛ≥rzÍdna__x__mj;
                  Self.budowle_t__ma[ i ].atak__cel__wspÛ≥rzÍdna__y__bu := Self.mapa_jednostki_t__ma[ j ].wspÛ≥rzÍdna__y__mj;

                end;
              //---//if not Self.budowle_t__ma[ i ].atak__w_trakcie__bu then


              if not Self.mapa_jednostki_t__ma[ j ].obraøenia__w_trakcie__mj then
                Self.mapa_jednostki_t__ma[ j ].obraøenia__w_trakcie__mj := true;


              Self.mapa_jednostki_t__ma[ j ].wytrzyma≥oúÊ_punkty__mj := Self.mapa_jednostki_t__ma[ j ].wytrzyma≥oúÊ_punkty__mj
                - Self.WspÛ≥czynniki__Dolicz__Ma( Self.budowle_t__ma[ i ].dominium__numer__bu, Mapa.atak__si≥a___wieøa__obronna_c, true );


              if zti >= Mapa.wieøa__obronna__atakÛw_w__mapa_jednostki_c then
                Break;

            end;
          //---//if    ( i <> j ) (...)


        if not ztb then
          begin

            SetLength( budowle__cele__id_t_l, 0 );


            for j := 0 to Length( Self.budowle_t__ma ) - 1 do
              if    ( i <> j )
                and ( Self.budowle_t__ma[ i ].id__bu <> Self.budowle_t__ma[ j ].id__bu )
                and ( Self.budowle_t__ma[ i ].dominium__numer__bu <> Self.budowle_t__ma[ j ].dominium__numer__bu )
                and ( Self.budowle_t__ma[ j ].wytrzyma≥oúÊ_punkty__bu > 0 )
                and (  Self.Punkt__W_Promieniu__Sprawdü__Ma( Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__y__bu, Self.budowle_t__ma[ j ].wspÛ≥rzÍdna__y__bu, Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__x__bu, Self.budowle_t__ma[ j ].wspÛ≥rzÍdna__x__bu, Mapa.atak__zasiÍg___wieøa__obronna_c )  ) then
                begin

                  if not Self.budowle_t__ma[ i ].atak__w_trakcie__bu then
                    begin

                      Self.budowle_t__ma[ i ].atak__w_trakcie__bu := true;
                      Self.budowle_t__ma[ i ].atak__cel__wspÛ≥rzÍdna__x__bu := Self.budowle_t__ma[ j ].wspÛ≥rzÍdna__x__bu;
                      Self.budowle_t__ma[ i ].atak__cel__wspÛ≥rzÍdna__y__bu := Self.budowle_t__ma[ j ].wspÛ≥rzÍdna__y__bu;

                    end;
                  //---//if not Self.budowle_t__ma[ i ].atak__w_trakcie__bu then

                  SetLength(  budowle__cele__id_t_l, Length( budowle__cele__id_t_l ) + 1  );
                  budowle__cele__id_t_l[ Length( budowle__cele__id_t_l ) - 1 ] := Self.budowle_t__ma[ j ].id__bu;

                end;
              //---//if    ( i <> j ) (...)


            if Length( budowle__cele__id_t_l ) > 0 then
              begin

                zti := budowle__cele__id_t_l[ Random(  Length( budowle__cele__id_t_l )  ) ];

                for j := 0 to Length( Self.budowle_t__ma ) - 1 do
                  if Self.budowle_t__ma[ j ].id__bu = zti then
                    begin

                      if not Self.budowle_t__ma[ j ].obraøenia__w_trakcie__bu then
                        Self.budowle_t__ma[ j ].obraøenia__w_trakcie__bu := true;

                      Self.budowle_t__ma[ j ].wytrzyma≥oúÊ_punkty__bu := Self.budowle_t__ma[ j ].wytrzyma≥oúÊ_punkty__bu
                        - Self.WspÛ≥czynniki__Dolicz__Ma( Self.budowle_t__ma[ i ].dominium__numer__bu, Mapa.atak__si≥a___wieøa__obronna_c, true );

                      Break;

                    end;
                  //---//if Self.budowle_t__ma[ j ].id__bu = zti then

              end;
            //---//if Length( budowle__cele__id_t_l ) > 0 then

          end;
        //---//if Self.budowle_t__ma[ i ].budowla_rodzaj__bu = Definicje.br_wieøa__obronna then

      end;
    //---//if Self.budowle_t__ma[ i ].budowla_rodzaj__bu = Definicje.br_wieøa__obronna then


  Self.Budowle__Zburzenie__Przelicz__Ma( budowle__domki_zburzone_t_f );


  Self.Mapa_Jednostka__Zburz__Wiele__Ma();

end;//---//Funkcja Budowle__Atak_Przelicz__Ma().

procedure TMapa.Budowle__Zburzenie__Przelicz__Ma( var budowle__domki_zburzone_t_f : Definicje.TBudowle );
var
  ztb : boolean;

  i,
  zti
    : integer;
begin

  SetLength( budowle__domki_zburzone_t_f, 0 );


  ztb := false;


  for i := Length( Self.budowle_t__ma ) - 1 downto 0 do
    if Self.budowle_t__ma[ i ].wytrzyma≥oúÊ_punkty__bu <= 0 then
      begin

        if not ztb then
          ztb := true;


        if Self.budowle_t__ma[ i ].budowla_rodzaj__bu in [ Definicje.br_domek, Definicje.br_zamek ] then
          begin

            zti := Length( budowle__domki_zburzone_t_f );
            SetLength( budowle__domki_zburzone_t_f, zti + 1 );

            budowle__domki_zburzone_t_f[ zti ].budowla_rodzaj__bu := Self.budowle_t__ma[ i ].budowla_rodzaj__bu;
            budowle__domki_zburzone_t_f[ zti ].dominium__numer__bu := Self.budowle_t__ma[ i ].dominium__numer__bu;
            budowle__domki_zburzone_t_f[ zti ].surowiec__rodzaj__bu := Self.budowle_t__ma[ i ].surowiec__rodzaj__bu;

          end;
        //---//if Self.budowle_t__ma[ i ].budowla_rodzaj__bu in [ Definicje.br_domek, Definicje.br_zamek ] then


        Self.Surowiec__OpuúÊ__Ma( Self.budowle_t__ma[ i ].dominium__numer__bu, Self.budowle_t__ma[ i ].id__surowiec_ürÛd≥o__bu, Self.budowle_t__ma[ i ].surowiec__rodzaj__bu );

        Self.Budowla__Zburz__Jednπ__Ma( Self.budowle_t__ma[ i ].id__bu );

      end;
    //---//if Self.budowle_t__ma[ i ].wytrzyma≥oúÊ_punkty__bu <= 0 then


  if ztb then
    Self.Teren__PrzynaleønoúÊ__Oznacz__Ma();

end;//---//Funkcja Budowle__Zburzenie__Przelicz__Ma().

function TMapa.Budowle__W_Promieniu__Odczytaj__Ma( const dominium__numer_f : smallint; const budowla_rodzaj_f : Definicje.TBudowla_Rodzaj; const y_f, x_f : integer; promieÒ_f : integer = 1 ) : integer;
var
  i : integer;
begin

  Result := 0;

  for i := 0 to Length( Self.budowle_t__ma ) - 1 do
    if    ( Self.budowle_t__ma[ i ].dominium__numer__bu = dominium__numer_f )
      and ( Self.budowle_t__ma[ i ].budowla_rodzaj__bu = budowla_rodzaj_f )
      and (
               ( promieÒ_f < 0 )
            or (  Self.Punkt__W_Promieniu__Sprawdü__Ma( y_f, Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__y__bu, x_f, Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__x__bu, promieÒ_f )  )
          ) then
      inc( Result );

end;//---//Funkcja Budowle__W_Promieniu__Odczytaj__Ma().

function TMapa.Koszary__Budowa__Punkt__Znajdü__Ma( const dominium__numer_f : smallint; const koszar_w_rzÍdzie_f : integer = 0; const cofnij_wspÛ≥rzÍdnπ_y_razy_f : integer = 0 ) : Winapi.Windows.TPoint;
var
  x_l,
  y_l,
  zti,
  zamek__wrogi__wspÛ≥rzÍdna__x,
  zamek__wrogi__wspÛ≥rzÍdna__y,
  zamek__wspÛ≥rzÍdna__x,
  zamek__wspÛ≥rzÍdna__y
    : integer;

  x_t_l : array of integer;
begin

  Result.SetLocation( Definicje.identyfikator_pusty_c, Definicje.identyfikator_pusty_c );


  if dominium__numer_f = Definicje.dominium__numer__gracz__1_c then
    zti := Definicje.dominium__numer__gracz__2_c
  else//if dominium__numer_f = Definicje.dominium__numer__gracz__1_c then
    zti := Definicje.dominium__numer__gracz__1_c;


  if   (  not Self.Zamek__WspÛ≥rzÍdne__Znajdü__Ma( dominium__numer_f, zamek__wspÛ≥rzÍdna__y, zamek__wspÛ≥rzÍdna__x )  )
    or (  not Self.Zamek__WspÛ≥rzÍdne__Znajdü__Ma( zti, zamek__wrogi__wspÛ≥rzÍdna__y, zamek__wrogi__wspÛ≥rzÍdna__x )  ) then
    Exit;


  y_l := zamek__wspÛ≥rzÍdna__y;


  if cofnij_wspÛ≥rzÍdnπ_y_razy_f > 0 then
    if zamek__wspÛ≥rzÍdna__y < zamek__wrogi__wspÛ≥rzÍdna__y then
      begin

        for zti := 1 to cofnij_wspÛ≥rzÍdnπ_y_razy_f do
          dec( y_l );

        if y_l < 0 then
          Exit;

      end
    else//if zamek__wspÛ≥rzÍdna__y < zamek__wrogi__wspÛ≥rzÍdna__y then
    if zamek__wspÛ≥rzÍdna__y > zamek__wrogi__wspÛ≥rzÍdna__y then
      begin

        for zti := 1 to cofnij_wspÛ≥rzÍdnπ_y_razy_f do
          inc( y_l );

        if y_l > Length( Self.teren_t__ma ) - 1 then
          Exit;

      end;
    //---//if zamek__wspÛ≥rzÍdna__y > zamek__wrogi__wspÛ≥rzÍdna__y then



  while true do
    begin

      zti := 0;
      SetLength( x_t_l, 0 );


      for x_l := 0 to Length( Self.teren_t__ma[ y_l ] ) - 1 do
        begin

          zti := Self.Budowle__W_Promieniu__Odczytaj__Ma( dominium__numer_f, Definicje.br_koszary, y_l, x_l, 0 );

          if Self.Punkt__BudowaÊ__Moøna__Sprawdü__Ma( dominium__numer_f, y_l, x_l ) then
            begin

              SetLength(  x_t_l, Length( x_t_l ) + 1  );
              x_t_l[ Length( x_t_l ) - 1 ] := x_l;

            end;
          //---//if Self.Punkt__BudowaÊ__Moøna__Sprawdü__Ma( dominium__numer_f, y_l, x_l ) then

        end;
      //---//for x_l := 0 to Length( Self.teren_t__ma[ y_l ] ) - 1 do


      if    (
                 ( koszar_w_rzÍdzie_f <= 0 )
              or ( zti <= koszar_w_rzÍdzie_f )
              or (  koszar_w_rzÍdzie_f > Length( x_t_l )  )
            )
        and (  Length( x_t_l ) > 0  ) then
        begin

          Result.SetLocation(   x_t_l[ Random(  Length( x_t_l )  ) ], y_l   );

          Break;

        end;
      //---//if Length( indeksy_t_l ) > 0 then



      if zamek__wspÛ≥rzÍdna__y < zamek__wrogi__wspÛ≥rzÍdna__y then
        begin

          inc( y_l );

          if y_l >= Length( Self.teren_t__ma ) - 1 then
            Break;

        end
      else//if zamek__wspÛ≥rzÍdna__y < zamek__wrogi__wspÛ≥rzÍdna__y then
      if zamek__wspÛ≥rzÍdna__y > zamek__wrogi__wspÛ≥rzÍdna__y then
        begin

          dec( y_l );

          if y_l <= 0 then
            Break;

        end
      else//if zamek__wspÛ≥rzÍdna__y > zamek__wrogi__wspÛ≥rzÍdna__y then
        Break;

    end;
  //---//while true do


  if   ( Result.X = Definicje.identyfikator_pusty_c )
    or ( Result.Y = Definicje.identyfikator_pusty_c ) then
    Result := Self.Koszary__Budowa__Punkt__Znajdü__Ma( dominium__numer_f, koszar_w_rzÍdzie_f, cofnij_wspÛ≥rzÍdnπ_y_razy_f + 1 );

end;//---//Funkcja Koszary__Budowa__Punkt__Znajdü__Ma().

procedure TMapa.Koszary__Mapa_Jednostki__Atak_Ruch__Przelicz__Ma( var budowle__domki_zburzone_t_f : Definicje.TBudowle );
const
  mapa_jednostki__ruch_szybkoúÊ_c_l : integer = 1;

var
  czy_atak_l : boolean;

  i,
  j,
  wspÛ≥rzÍdna__x_l,
  wspÛ≥rzÍdna__y_l
    : integer;

  ztr_1,
  ztr_2
    : real;
begin

  for i := 0 to Length( Self.mapa_jednostki_t__ma ) - 1 do
    begin

      czy_atak_l := false;
      ztr_1 := -1;


      for j := 0 to Length( Self.mapa_jednostki_t__ma ) - 1 do
        if    ( i <> j )
          and ( Self.mapa_jednostki_t__ma[ i ].id__mj <> Self.mapa_jednostki_t__ma[ j ].id__mj )
          and ( Self.mapa_jednostki_t__ma[ i ].dominium__numer__mj <> Self.mapa_jednostki_t__ma[ j ].dominium__numer__mj )
          and ( Self.mapa_jednostki_t__ma[ j ].poza_koszarami__mj )
          and ( Self.mapa_jednostki_t__ma[ j ].wytrzyma≥oúÊ_punkty__mj > 0 ) then
          begin

            if    ( Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__x__mj = Self.mapa_jednostki_t__ma[ j ].wspÛ≥rzÍdna__x__mj )
              and ( Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__y__mj = Self.mapa_jednostki_t__ma[ j ].wspÛ≥rzÍdna__y__mj ) then
              begin

                czy_atak_l := true;


                if not Self.mapa_jednostki_t__ma[ i ].atak__w_trakcie__mj then
                  Self.mapa_jednostki_t__ma[ i ].atak__w_trakcie__mj := true;

                if not Self.mapa_jednostki_t__ma[ j ].obraøenia__w_trakcie__mj then
                  Self.mapa_jednostki_t__ma[ j ].obraøenia__w_trakcie__mj := true;


                Self.mapa_jednostki_t__ma[ j ].wytrzyma≥oúÊ_punkty__mj := Self.mapa_jednostki_t__ma[ j ].wytrzyma≥oúÊ_punkty__mj
                  - Self.WspÛ≥czynniki__Dolicz__Ma( Self.mapa_jednostki_t__ma[ i ].dominium__numer__mj, Mapa.atak__si≥a___mapa__jednostka_c, true );


                Break;

              end
            else//if    ( Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__x__mj = Self.mapa_jednostki_t__ma[ j ].wspÛ≥rzÍdna__x__mj ) (...)
              if Self.mapa_jednostki_t__ma[ i ].ruch__mj then
                begin

                  ztr_2 := Self.Odleg≥oúÊ__Wylicz__Ma( Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__y__mj, Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__x__mj, Self.mapa_jednostki_t__ma[ j ].wspÛ≥rzÍdna__y__mj, Self.mapa_jednostki_t__ma[ j ].wspÛ≥rzÍdna__x__mj );

                  if   ( ztr_1 < 0 )
                    or ( ztr_1 > ztr_2 ) then
                    begin

                      ztr_1 := ztr_2;

                      wspÛ≥rzÍdna__x_l := Self.mapa_jednostki_t__ma[ j ].wspÛ≥rzÍdna__x__mj;
                      wspÛ≥rzÍdna__y_l := Self.mapa_jednostki_t__ma[ j ].wspÛ≥rzÍdna__y__mj;

                    end;
                  //---//if   ( ztr_1 < 0 ) (...)

                end;
              //---//if Self.mapa_jednostki_t__ma[ i ].ruch__mj then (...)

          end;
        //---//for i := 0 to Length( Self.mapa_jednostki_t__ma ) - 1 do


      if not czy_atak_l then
        for j := 0 to Length( Self.budowle_t__ma ) - 1 do
          if    ( Self.mapa_jednostki_t__ma[ i ].dominium__numer__mj <> Self.budowle_t__ma[ j ].dominium__numer__bu )
            and ( Self.budowle_t__ma[ j ].wytrzyma≥oúÊ_punkty__bu > 0 ) then
            begin

              if    ( Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__x__mj = Self.budowle_t__ma[ j ].wspÛ≥rzÍdna__x__bu )
                and ( Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__y__mj = Self.budowle_t__ma[ j ].wspÛ≥rzÍdna__y__bu ) then
                begin

                  czy_atak_l := true;


                  if not Self.mapa_jednostki_t__ma[ i ].atak__w_trakcie__mj then
                    Self.mapa_jednostki_t__ma[ i ].atak__w_trakcie__mj := true;

                  if not Self.budowle_t__ma[ j ].obraøenia__w_trakcie__bu then
                    Self.budowle_t__ma[ j ].obraøenia__w_trakcie__bu := true;


                  Self.budowle_t__ma[ j ].wytrzyma≥oúÊ_punkty__bu := Self.budowle_t__ma[ j ].wytrzyma≥oúÊ_punkty__bu
                    - Self.WspÛ≥czynniki__Dolicz__Ma( Self.mapa_jednostki_t__ma[ i ].dominium__numer__mj, Mapa.atak__si≥a___mapa__jednostka_c, true );


                  Break;

                end
              else//if    ( Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__x__mj = Self.budowle_t__ma[ j ].wspÛ≥rzÍdna__x__bu ) (...)
                if Self.mapa_jednostki_t__ma[ i ].ruch__mj then
                  begin

                    ztr_2 := Self.Odleg≥oúÊ__Wylicz__Ma( Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__y__mj, Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__x__mj, Self.budowle_t__ma[ j ].wspÛ≥rzÍdna__y__bu, Self.budowle_t__ma[ j ].wspÛ≥rzÍdna__x__bu );

                    if   ( ztr_1 < 0 )
                      or ( ztr_1 > ztr_2 ) then
                      begin

                        ztr_1 := ztr_2;

                        wspÛ≥rzÍdna__x_l := Self.budowle_t__ma[ j ].wspÛ≥rzÍdna__x__bu;
                        wspÛ≥rzÍdna__y_l := Self.budowle_t__ma[ j ].wspÛ≥rzÍdna__y__bu;

                      end;
                    //---//if   ( ztr_1 < 0 ) (...)

                  end;
                //---//if Self.mapa_jednostki_t__ma[ i ].ruch__mj then (...)

            end;
          //---//if    ( Self.mapa_jednostki_t__ma[ i ].dominium__numer__mj <> Self.budowle_t__ma[ j ].dominium__numer__bu ) (...)


      if    ( not czy_atak_l )
        and ( ztr_1 >= 0 )
        and ( Self.mapa_jednostki_t__ma[ i ].ruch__mj ) then
        begin

          if not Self.mapa_jednostki_t__ma[ i ].poza_koszarami__mj then
            Self.mapa_jednostki_t__ma[ i ].poza_koszarami__mj := true;


          if wspÛ≥rzÍdna__x_l > Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__x__mj then
            Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__x__mj := Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__x__mj + mapa_jednostki__ruch_szybkoúÊ_c_l
          else
          if wspÛ≥rzÍdna__x_l < Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__x__mj then
            Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__x__mj := Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__x__mj - mapa_jednostki__ruch_szybkoúÊ_c_l;


          if wspÛ≥rzÍdna__y_l > Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__y__mj then
            Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__y__mj := Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__y__mj + mapa_jednostki__ruch_szybkoúÊ_c_l
          else
          if wspÛ≥rzÍdna__y_l < Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__y__mj then
            Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__y__mj := Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__y__mj - mapa_jednostki__ruch_szybkoúÊ_c_l;

        end;
      //---//if if    ( not czy_atak_l ) (...)

    end;
  //---//for i := 0 to Length( Self.mapa_jednostki_t__ma ) - 1 do


  Self.Budowle__Zburzenie__Przelicz__Ma( budowle__domki_zburzone_t_f );


  Self.Mapa_Jednostka__Zburz__Wiele__Ma();

end;//---//Funkcja Koszary__Mapa_Jednostki__Atak_Ruch__Przelicz__Ma().

procedure TMapa.Koszary__Produkcja_Przelicz__Ma();
var
  i,
  j,
  zti
    : integer;
begin

  for i := 0 to Length( Self.budowle_t__ma ) - 1 do
    if Self.budowle_t__ma[ i ].budowla_rodzaj__bu = Definicje.br_koszary then
      begin

        if Self.budowle_t__ma[ i ].koszary__mapa_jednostki__iloúÊ__bu < Mapa.koszary__mapa_jednostki__pojemnoúÊ_c then
          begin

            Self.budowle_t__ma[ i ].koszary__produkcja_wspÛ≥czynnik__skumulowany__bu := Self.budowle_t__ma[ i ].koszary__produkcja_wspÛ≥czynnik__skumulowany__bu
              + Mapa.koszary__produkcja_wspÛ≥czynnik_c;

            if Self.budowle_t__ma[ i ].koszary__produkcja_wspÛ≥czynnik__skumulowany__bu >= Mapa.budowa__koszt__mapa__jednostka_c then
              begin

                if Self.budowle_t__ma[ i ].koszary__mapa_jednostki__iloúÊ__bu <= 0 then
                  Self.budowle_t__ma[ i ].ruch_grupπ__bu := Random( 2 ) = 1;

                Self.budowle_t__ma[ i ].koszary__mapa_jednostki__iloúÊ__bu := Self.budowle_t__ma[ i ].koszary__mapa_jednostki__iloúÊ__bu
                  + 1;

                Self.budowle_t__ma[ i ].koszary__produkcja_wspÛ≥czynnik__skumulowany__bu := Self.budowle_t__ma[ i ].koszary__produkcja_wspÛ≥czynnik__skumulowany__bu
                  - Mapa.budowa__koszt__mapa__jednostka_c;


                inc( Self.mapa_jednostki__id__ma );

                zti := Length( Self.mapa_jednostki_t__ma );
                SetLength( Self.mapa_jednostki_t__ma, zti + 1 );

                Self.mapa_jednostki_t__ma[ zti ].id__mj := Self.mapa_jednostki__id__ma;
                Self.mapa_jednostki_t__ma[ zti ].id__budowla__mj := Self.budowle_t__ma[ i ].id__bu;
                Self.mapa_jednostki_t__ma[ zti ].atak__w_trakcie__mj := false;
                Self.mapa_jednostki_t__ma[ zti ].dominium__numer__mj := Self.budowle_t__ma[ i ].dominium__numer__bu;
                Self.mapa_jednostki_t__ma[ zti ].ruch__mj := not Self.budowle_t__ma[ i ].ruch_grupπ__bu;
                Self.mapa_jednostki_t__ma[ zti ].obraøenia__w_trakcie__mj := false;
                Self.mapa_jednostki_t__ma[ zti ].poza_koszarami__mj := false;
                Self.mapa_jednostki_t__ma[ zti ].wspÛ≥rzÍdna__x__mj := Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__x__bu;
                Self.mapa_jednostki_t__ma[ zti ].wspÛ≥rzÍdna__y__mj := Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__y__bu;
                Self.mapa_jednostki_t__ma[ zti ].wytrzyma≥oúÊ_punkty__mj := Self.WspÛ≥czynniki__Dolicz__Ma( Self.mapa_jednostki_t__ma[ zti ].dominium__numer__mj, Mapa.wytrzyma≥oúÊ_punkty__mapa__jednostka_c, false );

              end;
            //---//if Self.budowle_t__ma[ i ].koszary__produkcja_wspÛ≥czynnik__skumulowany__bu >= Mapa.budowa__koszt__mapa__jednostka_c then

          end
        else//if Self.budowle_t__ma[ i ].koszary__mapa_jednostki__iloúÊ__bu < Mapa.koszary__mapa_jednostki__pojemnoúÊ_c then
          if Self.budowle_t__ma[ i ].ruch_grupπ__bu then
            begin

              for j := 0 to Length( Self.mapa_jednostki_t__ma ) - 1 do
                if    ( Self.mapa_jednostki_t__ma[ j ].id__budowla__mj = Self.budowle_t__ma[ i ].id__bu )
                  and ( Self.mapa_jednostki_t__ma[ j ].dominium__numer__mj = Self.budowle_t__ma[ i ].dominium__numer__bu )
                  and ( not Self.mapa_jednostki_t__ma[ j ].ruch__mj ) then
                  Self.mapa_jednostki_t__ma[ j ].ruch__mj := true;

            end;
          //---//if Self.budowle_t__ma[ i ].ruch_grupπ__bu then

      end;
    //---//if Self.budowle_t__ma[ i ].budowla_rodzaj__bu = Definicje.br_koszary then

end;//---//Funkcja Koszary__Produkcja_Przelicz__Ma().

function TMapa.Mapa_Jednostka__W_Promieniu__Odczytaj__Ma( const dominium__numer_f : smallint; const y_f, x_f : integer; promieÒ_f : integer = 1 ) : integer;
var
  i : integer;
begin

  Result := 0;

  for i := 0 to Length( Self.mapa_jednostki_t__ma ) - 1 do
    if    ( Self.mapa_jednostki_t__ma[ i ].dominium__numer__mj = dominium__numer_f )
      and (  Self.Punkt__W_Promieniu__Sprawdü__Ma( y_f, Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__y__mj, x_f, Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__x__mj, promieÒ_f )  ) then
      inc( Result );

end;//---//Funkcja Mapa_Jednostka__W_Promieniu__Odczytaj__Ma().

function TMapa.Mapa_Jednostka__Wrogie_Na_Terenie__Budowa__Ma( const dominium__numer_f : smallint ) : Winapi.Windows.TPoint;
var
  i,
  j
    : integer;
begin

  Result.SetLocation( Definicje.identyfikator_pusty_c, Definicje.identyfikator_pusty_c );


  for i := 0 to Length( Self.mapa_jednostki_t__ma ) - 1 do
    if    ( Self.mapa_jednostki_t__ma[ i ].dominium__numer__mj <> dominium__numer_f )
      and (  Self.Teren__PrzynaleønoúÊ__Sprawdü__Ma( dominium__numer_f, Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__y__mj, Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__x__mj )  ) then
      for j := 1 to 5 do
        begin

          Result := Self.Punkt__BudowaÊ__Moøna__Znajdü__W_Promieniu__Ma( dominium__numer_f, Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__y__mj, Self.mapa_jednostki_t__ma[ i ].wspÛ≥rzÍdna__x__mj, j );

          if    ( Result.X <> Definicje.identyfikator_pusty_c )
            and ( Result.Y <> Definicje.identyfikator_pusty_c ) then
            Exit;

        end;
      //---//for j := 1 to 5 do

end;//---//Funkcja Mapa_Jednostka__Wrogie_Na_Terenie__Budowa__Ma().

procedure TMapa.Mapa_Jednostka__Zburz__Wiele__Ma();
var
  i,
  j
    : integer;
begin

  for i := Length( Self.mapa_jednostki_t__ma ) - 1 downto 0 do
    if Self.mapa_jednostki_t__ma[ i ].wytrzyma≥oúÊ_punkty__mj <= 0 then
      begin

        for j := 0 to Length( Self.budowle_t__ma ) - 1 do
          if    ( Self.budowle_t__ma[ j ].id__bu = Self.mapa_jednostki_t__ma[ i ].id__budowla__mj )
            and ( Self.budowle_t__ma[ j ].budowla_rodzaj__bu = Definicje.br_koszary )
            and ( Self.budowle_t__ma[ j ].koszary__mapa_jednostki__iloúÊ__bu > 0 ) then
            begin

              Self.budowle_t__ma[ j ].koszary__mapa_jednostki__iloúÊ__bu := Self.budowle_t__ma[ j ].koszary__mapa_jednostki__iloúÊ__bu - 1;

              Break;

            end;
          //---//if    ( Self.budowle_t__ma[ j ].id__bu = Self.mapa_jednostki_t__ma[ i ].id__budowla__mj ) (...)


        for j := i to Length( Self.mapa_jednostki_t__ma ) - 2 do
          Self.mapa_jednostki_t__ma[ j ] := Self.mapa_jednostki_t__ma[ j + 1 ];


        SetLength(  Self.mapa_jednostki_t__ma, Length( Self.mapa_jednostki_t__ma ) - 1  );

      end;
    //---//if Self.mapa_jednostki_t__ma[ i ].id__mj = id_f then

end;//---//Funkcja Mapa_Jednostka__Zburz__Wiele__Ma().

function TMapa.Odleg≥oúÊ__Wylicz__Ma( const y__1_f, x__1_f, y__2_f, x__2_f : integer ) : real;
begin

  Result :=
    Sqrt
      (
          Sqr( y__1_f - y__2_f )
        + Sqr( x__1_f - x__2_f )
      );

end;//---//Funkcja Odleg≥oúÊ__Wylicz__Ma().

function TMapa.Punkt__BudowaÊ__Moøna__Sprawdü__Ma( const dominium__numer_f : smallint; const y_f, x_f : integer; const czy_domek_f : boolean = false ) : boolean;
var
  surowiec__rodzaj_l : Definicje.TSurowiec_Rodzaj; // Tylko aby wywo≥aÊ funkcjÍ.
begin

  Result := Self.Punkt__BudowaÊ__Moøna__Sprawdü__Ma( dominium__numer_f, y_f, x_f, surowiec__rodzaj_l, czy_domek_f );

end;//---//Funkcja Punkt__BudowaÊ__Moøna__Sprawdü__Ma().

function TMapa.Punkt__BudowaÊ__Moøna__Sprawdü__Ma( const dominium__numer_f : smallint; const y_f, x_f : integer; out surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj; const czy_domek_f : boolean = false ) : boolean;
var
  ztb : boolean;

  i
    : integer;
begin

  Result := false;


  if   (  not Self.Punkt__Naleøy_Do__Terenu__Sprawdü__Ma( y_f, x_f )  )
    or (
             (  Self.Punkt__Naleøy_Do__Terenu__Sprawdü__Ma( y_f, x_f )  )
         and (
                  ( Self.teren_t__ma[ y_f, x_f ] = Definicje.mapa__teren__niedostÍpny_c )
               or ( Self.teren_t__ma[ y_f, x_f ] <> dominium__numer_f )
             )
       ) then
    Exit;


  for i := 0 to Length( Self.budowle_t__ma ) - 1 do
    if    ( Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__x__bu = x_f )
      and ( Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__y__bu = y_f ) then
      Exit;


  for i := 0 to Length( Self.surowce_ürÛd≥o_t__ma ) - 1 do
    if    ( Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__x__sü = x_f )
      and ( Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__y__sü = y_f ) then
      Exit;



  if czy_domek_f then
    begin

      ztb := false;

      for i := 0 to Length( Self.surowce_ürÛd≥o_t__ma ) - 1 do
        if    (
                   ( Self.surowce_ürÛd≥o_t__ma[ i ].dominium__numer__sü = Definicje.dominium__numer__puste_c )
                or ( Self.surowce_ürÛd≥o_t__ma[ i ].dominium__numer__sü = dominium__numer_f )
              )
          and ( Self.surowce_ürÛd≥o_t__ma[ i ].domki__iloúÊ__sü < Mapa.surowiec_ürÛd≥o__pojemnoúÊ__domki_c )
          and (
                   ( Self.teren_t__ma[ Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__y__sü, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__x__sü ] = dominium__numer_f )
                or ( Self.teren_t__ma[ Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__y__sü, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__x__sü ] = Definicje.dominium__numer__puste_c )
              )
          and (  Self.Punkt__W_Promieniu__Sprawdü__Ma( y_f, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__y__sü, x_f, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__x__sü, Definicje.wydobycie__zasiÍg__domek_c )  ) then
          begin

            ztb := true;

            surowiec__rodzaj_f := Self.surowce_ürÛd≥o_t__ma[ i ].surowiec__rodzaj__sü;

            Break;

          end;
        //---//if    ( Self.surowce_ürÛd≥o_t__ma[ i ].dominium__numer__sü = dominium__numer_f ) (...)

    end
  else//if czy_domek_f then
    ztb := true;


  Result := ztb;

end;//---//Funkcja Punkt__BudowaÊ__Moøna__Sprawdü__Ma().

function TMapa.Punkt__BudowaÊ__Moøna__Znajdü__W_Promieniu__Ma( const dominium__numer_f : smallint; const y_f, x_f : integer; promieÒ_f : integer = 1 ) : Winapi.Windows.TPoint;

  //Funkcja PrzesuniÍcie_Losuj() w Punkt__BudowaÊ__Moøna__Znajdü__W_Promieniu__Ma().
  function PrzesuniÍcie_Losuj() : integer;
  begin

    Result := Random( 1 + promieÒ_f * 2 ) - promieÒ_f;

  end;//---//Funkcja PrzesuniÍcie_Losuj() w Punkt__BudowaÊ__Moøna__Znajdü__W_Promieniu__Ma().

var
  ztb : boolean;

  zti,
  wspÛ≥rzÍdna__x,
  wspÛ≥rzÍdna__y
    : integer;
begin//Funkcja Punkt__BudowaÊ__Moøna__Znajdü__W_Promieniu__Ma().

  Result.SetLocation( Definicje.identyfikator_pusty_c, Definicje.identyfikator_pusty_c );


  if promieÒ_f < 1 then
    promieÒ_f := 1;


  if Self.Punkt__BudowaÊ__Moøna__Sprawdü__Ma( dominium__numer_f, y_f, x_f ) then
    begin

      Result.SetLocation( x_f, y_f );

      Exit;

    end;
  //---//if Self.Punkt__BudowaÊ__Moøna__Sprawdü__Ma( dominium__numer_f, y_f, x_f ) then


  zti := 1;
  ztb := false;

  while ( zti <= 1000 )
    and ( not ztb ) do
    begin

      inc( zti );

      wspÛ≥rzÍdna__x := x_f + PrzesuniÍcie_Losuj();
      wspÛ≥rzÍdna__y := y_f + PrzesuniÍcie_Losuj();

      ztb := Self.Punkt__BudowaÊ__Moøna__Sprawdü__Ma( dominium__numer_f, wspÛ≥rzÍdna__y, wspÛ≥rzÍdna__x );

    end;
  //---//while ( zti <= 1000 ) (...)


  if ztb then
    Result.SetLocation( wspÛ≥rzÍdna__x, wspÛ≥rzÍdna__y );

end;//---//Funkcja Punkt__BudowaÊ__Moøna__Znajdü__W_Promieniu__Ma().

function TMapa.Punkt__Naleøy_Do__Terenu__Sprawdü__Ma( const y_f, x_f : integer ) : boolean;
begin

  if    ( x_f >= 0 )
    and ( y_f >= 0 )
    and (  Length( Self.teren_t__ma ) > 0  )
    and (  Length( Self.teren_t__ma[ 0 ] ) > 0  )
    and (  y_f <= Length( Self.teren_t__ma ) - 1 )
    and (  x_f <= Length( Self.teren_t__ma[ 0 ] ) - 1 ) then
    Result := true
  else//if    ( x_f >= 0 ) (...)
    Result := false;

end;//---//Funkcja Punkt__Naleøy_Do__Terenu__Sprawdü__Ma().

function TMapa.Punkt__W_Promieniu__Sprawdü__Ma( const y__1_f, y__2_f, x__1_f, x__2_f, promieÒ_f : integer ) : boolean;
begin

  if    (  System.Abs( x__1_f - x__2_f ) <= promieÒ_f  )
    and (  System.Abs( y__1_f - y__2_f ) <= promieÒ_f  ) then
    Result := true
  else//if    (  System.Abs( x__1_f - x__2_f ) <= promieÒ_f  ) (...)
    Result := false;

end;//---//Funkcja Punkt__W_Promieniu__Sprawdü__Ma().

function TMapa.Surowce__Wolne__Rodzaje__Odczytaj__Ma( const dominium__numer_f : smallint; const czy_w_zasiÍgu_terytorium_f : boolean = true ) : Definicje.TSurowce_Rodzaj;
var
  i : integer;
begin

  Result := [];


  for i := 0 to Length( Self.surowce_ürÛd≥o_t__ma ) - 1 do
    if    (
               ( Self.surowce_ürÛd≥o_t__ma[ i ].dominium__numer__sü = Definicje.dominium__numer__puste_c )
            or ( Self.surowce_ürÛd≥o_t__ma[ i ].dominium__numer__sü = dominium__numer_f )
          )
      and ( Self.surowce_ürÛd≥o_t__ma[ i ].domki__iloúÊ__sü < Mapa.surowiec_ürÛd≥o__pojemnoúÊ__domki_c )
      and (
               (
                     ( czy_w_zasiÍgu_terytorium_f )
                 and (  Self.Teren__PrzynaleønoúÊ__Sprawdü__Ma( dominium__numer_f, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__y__sü, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__x__sü )  )
                 and (  Self.Teren__Na_Oko≥o__Punktu__DostÍpny__Sprawdü__Ma( dominium__numer_f, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__y__sü, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__x__sü, Definicje.wydobycie__zasiÍg__domek_c ) > 0  )
               )
            or (
                     ( not czy_w_zasiÍgu_terytorium_f )
                 and (  Self.Teren__PrzynaleønoúÊ__Sprawdü__Ma( Definicje.dominium__numer__puste_c, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__y__sü, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__x__sü )  )
                 and (  Self.Teren__Na_Oko≥o__Punktu__DostÍpny__Sprawdü__Ma( Definicje.dominium__numer__puste_c, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__y__sü, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__x__sü, Definicje.wydobycie__zasiÍg__domek_c ) > 0  )
               )
          ) then
      begin

        if not ( Self.surowce_ürÛd≥o_t__ma[ i ].surowiec__rodzaj__sü in Result ) then
          Result := Result + [  Self.surowce_ürÛd≥o_t__ma[ i ].surowiec__rodzaj__sü  ];

      end;
    //---//if Self.surowce_ürÛd≥o_t__ma[ i ].dominium__numer__sü = Definicje.dominium__numer__puste_c then

end;//---//Funkcja Surowce__Wolne__Rodzaje__Odczytaj__Ma().

function TMapa.Surowiec__Najbliøszy__Znajdü__Ma( const dominium__numer_f : smallint; const surowce_rodzaj_f : Definicje.TSurowce_Rodzaj; var droga__d≥ugoúÊ_f : integer; const czy_na_wrogim_terytorium_f : boolean = false; const granica_odstÍp_f : integer = 0 ) : Winapi.Windows.TPoint;
var
  punkt__na_wrogim_terytorium__pierwszy_l : Winapi.Windows.TPoint; // Tylko aby wywo≥aÊ funkcjÍ.
begin

  Result := Self.Surowiec__Najbliøszy__Znajdü__Ma( dominium__numer_f, surowce_rodzaj_f, droga__d≥ugoúÊ_f, punkt__na_wrogim_terytorium__pierwszy_l, czy_na_wrogim_terytorium_f, granica_odstÍp_f );

end;//---//Funkcja Surowiec__Najbliøszy__Znajdü__Ma().

function TMapa.Surowiec__Najbliøszy__Znajdü__Ma( const dominium__numer_f : smallint; const surowce_rodzaj_f : Definicje.TSurowce_Rodzaj; const czy_na_wrogim_terytorium_f : boolean = false; const granica_odstÍp_f : integer = 0 ) : Winapi.Windows.TPoint;
var
  droga__d≥ugoúÊ_l : integer; // Tylko aby wywo≥aÊ funkcjÍ.
  punkt__na_wrogim_terytorium__pierwszy_l : Winapi.Windows.TPoint; // Tylko aby wywo≥aÊ funkcjÍ.
begin

  Result := Self.Surowiec__Najbliøszy__Znajdü__Ma( dominium__numer_f, surowce_rodzaj_f, droga__d≥ugoúÊ_l, punkt__na_wrogim_terytorium__pierwszy_l, czy_na_wrogim_terytorium_f, granica_odstÍp_f );

end;//---//Funkcja Surowiec__Najbliøszy__Znajdü__Ma().

function TMapa.Surowiec__Najbliøszy__Znajdü__Ma( const dominium__numer_f : smallint; const surowce_rodzaj_f : Definicje.TSurowce_Rodzaj; var droga__d≥ugoúÊ_f : integer; var punkt__na_wrogim_terytorium__pierwszy_f : Winapi.Windows.TPoint; const czy_na_wrogim_terytorium_f : boolean = false; const granica_odstÍp_f : integer = 0 ) : Winapi.Windows.TPoint;
var
  ztb,
  punkt__na_terytorium__ostatni__znaleziony,
  punkt__po_ostatnim__na_wrogim_terytorium__znaleziony
    : boolean;

  i,
  j,
  zti,
  granica_odstÍp_l,
  odleg≥oúÊ_l,
  zamek_wspÛ≥rzÍdna__x,
  zamek_wspÛ≥rzÍdna__y
    : integer;

  zt_point : Winapi.Windows.TPoint;

  zt_poszukiwacz_wynik : Poszukiwacz.TPoszukiwacz_Wynik;

  tablica_drogi_t_l,
  teren__kopia_t_l
    : Poszukiwacz.TTablica2D_Integer;

  zt_poszukiwacz : Poszukiwacz.TPoszukiwacz;
begin

  Result.SetLocation( Definicje.identyfikator_pusty_c, Definicje.identyfikator_pusty_c );

  droga__d≥ugoúÊ_f := -1;


  if not Self.Zamek__WspÛ≥rzÍdne__Znajdü__Ma( dominium__numer_f, zamek_wspÛ≥rzÍdna__y, zamek_wspÛ≥rzÍdna__x ) then
    Exit;


  ztb := false;
  zt_point.SetLocation( Definicje.identyfikator_pusty_c, Definicje.identyfikator_pusty_c );
  punkt__na_wrogim_terytorium__pierwszy_f.SetLocation( Definicje.identyfikator_pusty_c, Definicje.identyfikator_pusty_c );


  SetLength(  teren__kopia_t_l, Length( Self.teren_t__ma ), Length( Self.teren_t__ma[ 0 ] )  );

  for i := 0 to Length( Self.teren_t__ma ) - 1 do
    for j := 0 to Length( Self.teren_t__ma[ i ] ) - 1 do
      begin

        if not czy_na_wrogim_terytorium_f then
          begin

            if    ( teren_t__ma[ i, j ] <> Definicje.mapa__teren__dostÍpny_c )
              and ( teren_t__ma[ i, j ] <> dominium__numer_f ) then
              teren__kopia_t_l[ i, j ] := Definicje.mapa__teren__niedostÍpny_c
            else//if    ( teren_t__ma[ i, j ] <> Definicje.mapa__teren__dostÍpny_c ) (...)
              teren__kopia_t_l[ i, j ] := Self.teren_t__ma[ i, j ];

          end
        else//if not czy_na_wrogim_terytorium_f then
          begin

            if teren_t__ma[ i, j ] = Definicje.mapa__teren__niedostÍpny_c then
              teren__kopia_t_l[ i, j ] := Definicje.mapa__teren__niedostÍpny_c
            else//if teren_t__ma[ i, j ] = Definicje.mapa__teren__niedostÍpny_c then
              teren__kopia_t_l[ i, j ] := Definicje.mapa__teren__dostÍpny_c;

          end;
        //---//if not czy_na_wrogim_terytorium_f then

      end;
    //---//for j := 0 to Length( Self.teren_t__ma[ i ] ) - 1 do


  if not czy_na_wrogim_terytorium_f then
    begin

      for i := 0 to Length( Self.budowle_t__ma ) - 1 do
        if not ( Self.budowle_t__ma[ i ].budowla_rodzaj__bu in [ Definicje.br_wieøa__zwiadowcza, Definicje.br_zamek ] ) then
          teren__kopia_t_l[ Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__y__bu, Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__x__bu ] := Definicje.mapa__teren__niedostÍpny_c;


    end
  else//if not czy_na_wrogim_terytorium_f then
    begin

      for i := 0 to Length( Self.budowle_t__ma ) - 1 do
        if    ( Self.budowle_t__ma[ i ].dominium__numer__bu = dominium__numer_f )
          and (  not ( Self.budowle_t__ma[ i ].budowla_rodzaj__bu in [ Definicje.br_zamek ] )  ) then
          teren__kopia_t_l[ Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__y__bu, Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__x__bu ] := Definicje.mapa__teren__niedostÍpny_c;

    end;
  //---//if not czy_na_wrogim_terytorium_f then


  for i := 0 to Length( Self.surowce_ürÛd≥o_t__ma ) - 1 do
    if    (
               (
                     ( not czy_na_wrogim_terytorium_f )
                 and ( Self.surowce_ürÛd≥o_t__ma[ i ].dominium__numer__sü = Definicje.dominium__numer__puste_c )
                 and (  Self.Teren__PrzynaleønoúÊ__Sprawdü__Ma( Definicje.dominium__numer__puste_c, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__y__sü, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__x__sü )  )
               )
            or (
                     ( czy_na_wrogim_terytorium_f )
                 and ( Self.surowce_ürÛd≥o_t__ma[ i ].dominium__numer__sü <> dominium__numer_f )
                 and (  not Self.Teren__PrzynaleønoúÊ__Sprawdü__Ma( Definicje.dominium__numer__puste_c, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__y__sü, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__x__sü )  )
                 and (  not Self.Teren__PrzynaleønoúÊ__Sprawdü__Ma( dominium__numer_f, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__y__sü, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__x__sü )  )
               )
          )
      and (
               ( surowce_rodzaj_f = [] )
            or ( Self.surowce_ürÛd≥o_t__ma[ i ].surowiec__rodzaj__sü in surowce_rodzaj_f )
          ) then
      begin

        zt_poszukiwacz := TPoszukiwacz.Create();

        zt_poszukiwacz_wynik := zt_poszukiwacz.Droga__Szukaj( teren__kopia_t_l, zamek_wspÛ≥rzÍdna__y, zamek_wspÛ≥rzÍdna__x, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__y__sü, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__x__sü ); // WspÛ≥rzÍdne x i y sπ pozamieniane w Poszukiwacz.

        if    ( zt_poszukiwacz_wynik = Poszukiwacz.pw_wszystko_w_porzπdku )
          and (
                   ( not ztb )
                or ( odleg≥oúÊ_l > zt_poszukiwacz.droga__d≥ugoúÊ )
              ) then
          begin

            ztb := true;

            granica_odstÍp_l := granica_odstÍp_f;

            odleg≥oúÊ_l := zt_poszukiwacz.droga__d≥ugoúÊ;
            droga__d≥ugoúÊ_f := zt_poszukiwacz.droga__d≥ugoúÊ;

            SetLength( tablica_drogi_t_l, 0, 0 );

            if    (  Length( zt_poszukiwacz.droga__punkty ) > 0  )
              and (  Length( zt_poszukiwacz.droga__punkty[ 0 ] ) > 0  ) then
              begin

                SetLength(  tablica_drogi_t_l, 2, Length( zt_poszukiwacz.droga__punkty[ 0 ] )  );

                for j := 0 to Length( zt_poszukiwacz.droga__punkty[ 0 ] ) - 1 do
                  begin

                    tablica_drogi_t_l[ 0, j ] := zt_poszukiwacz.droga__punkty[ 0, j ]; // y.
                    tablica_drogi_t_l[ 1, j ] := zt_poszukiwacz.droga__punkty[ 1, j ]; // x.

                  end;
                //---//for j := 0 to Length( zt_poszukiwacz.droga__punkty[ 0 ] ) - 1 do


                punkt__na_terytorium__ostatni__znaleziony := false;
                punkt__po_ostatnim__na_wrogim_terytorium__znaleziony := false;

                if    (  Length( tablica_drogi_t_l ) > 0  )
                  and (  Length( tablica_drogi_t_l[ 0 ] ) > 0  ) then
                  begin

                    for j := 1 to Length( tablica_drogi_t_l[ 0 ] ) - 1 do
                      if Self.Punkt__Naleøy_Do__Terenu__Sprawdü__Ma( tablica_drogi_t_l[ 0, j ], tablica_drogi_t_l[ 1, j ] ) then
                        begin

                          if    ( not czy_na_wrogim_terytorium_f )
                            and ( punkt__na_terytorium__ostatni__znaleziony )
                            and ( Self.teren_t__ma[  tablica_drogi_t_l[ 0, j ], tablica_drogi_t_l[ 1, j ]  ] <> Definicje.dominium__numer__puste_c )
                            and ( Self.teren_t__ma[  tablica_drogi_t_l[ 0, j ], tablica_drogi_t_l[ 1, j ]  ] <> dominium__numer_f ) then
                            begin

                              punkt__po_ostatnim__na_wrogim_terytorium__znaleziony := true;

                              zt_point.SetLocation( Definicje.identyfikator_pusty_c, Definicje.identyfikator_pusty_c );

                              Break;

                            end
                          else//if    ( not czy_na_wrogim_terytorium_f ) (...)
                          if    ( not punkt__na_terytorium__ostatni__znaleziony )
                            and ( Self.teren_t__ma[  tablica_drogi_t_l[ 0, j ], tablica_drogi_t_l[ 1, j ]  ] <> dominium__numer_f ) then
                            begin

                              punkt__na_terytorium__ostatni__znaleziony := true;

                              zti := j - 1;

                              // WspÛ≥rzÍdne x i y sπ pozamieniane w Poszukiwacz.
                              zt_point.SetLocation( tablica_drogi_t_l[ 1, zti ], tablica_drogi_t_l[ 0, zti ] ); // Ostatni najbliøszy punkt na terytorium.

                              {$IFDEF test__funkcjonalnosc_d}
                              if czy_na_wrogim_terytorium_f then
                                Test_Funkcjonalnosc.Wizualizacja__Droga__Rysuj__Wi( zt_poszukiwacz.droga__punkty, tablica_drogi_t_l[ 0, j - 1 ], tablica_drogi_t_l[ 1, j - 1 ] );
                              {$ENDIF}

                              if czy_na_wrogim_terytorium_f then
                                Break;

                            end;
                          //---//if    ( not punkt__na_terytorium__ostatni__znaleziony ) (...)

                        end;
                      //---//if Self.Punkt__Naleøy_Do__Terenu__Sprawdü__Ma( tablica_drogi_t_l[ 0, j ], tablica_drogi_t_l[ 1, j ] ) then


                    for j := 1 to Length( tablica_drogi_t_l[ 0 ] ) - 1 do
                      if    (  Self.Punkt__Naleøy_Do__Terenu__Sprawdü__Ma( tablica_drogi_t_l[ 0, j ], tablica_drogi_t_l[ 1, j ] )  )
                        and ( Self.teren_t__ma[  tablica_drogi_t_l[ 0, j ], tablica_drogi_t_l[ 1, j ]  ] <> Definicje.dominium__numer__puste_c )
                        and ( Self.teren_t__ma[  tablica_drogi_t_l[ 0, j ], tablica_drogi_t_l[ 1, j ]  ] <> dominium__numer_f ) then
                        begin

                          punkt__na_wrogim_terytorium__pierwszy_f.SetLocation( tablica_drogi_t_l[ 1, j ], tablica_drogi_t_l[ 0, j ] );

                          {$IFDEF test__funkcjonalnosc_d}
                          if czy_na_wrogim_terytorium_f then
                            Test_Funkcjonalnosc.Wizualizacja__Droga__Rysuj__Wi( zt_poszukiwacz.droga__punkty, tablica_drogi_t_l[ 0, j ], tablica_drogi_t_l[ 1, j ] );
                          {$ENDIF}

                          Break;

                        end;
                      //---//if    (  Self.Punkt__Naleøy_Do__Terenu__Sprawdü__Ma( tablica_drogi_t_l[ 0, j ], tablica_drogi_t_l[ 1, j ] )  ) (...)


                    if    ( punkt__na_terytorium__ostatni__znaleziony )
                      and ( not punkt__po_ostatnim__na_wrogim_terytorium__znaleziony )
                      and ( zt_point.X <> Definicje.identyfikator_pusty_c )
                      and ( zt_point.Y <> Definicje.identyfikator_pusty_c ) then
                      begin

                        if    ( granica_odstÍp_l <= 0 )
                          and (  Self.Punkt__BudowaÊ__Moøna__Sprawdü__Ma( dominium__numer_f, zt_point.Y, zt_point.X )  ) then
                          Result := zt_point
                        else//if    ( granica_odstÍp_l <= 0 ) (...)
                          begin

                            dec( zti );
                            dec( granica_odstÍp_l);

                            while zti >= 0 do
                              begin

                                if    ( granica_odstÍp_l <= 0 )
                                  and (  Self.Punkt__BudowaÊ__Moøna__Sprawdü__Ma( dominium__numer_f, tablica_drogi_t_l[ 0, zti ], tablica_drogi_t_l[ 1, zti ] )  ) then
                                  begin

                                    Result.SetLocation( tablica_drogi_t_l[ 1, zti ], tablica_drogi_t_l[ 0, zti ] ); // Jeøeli na wskazanym punkcie nie da siÍ budowaÊ wybiera punkt poprzedni.

                                    Break;

                                  end;
                                //---//if    ( granica_odstÍp_l <= 0 ) (...)

                                dec( zti );
                                dec( granica_odstÍp_l);

                              end;
                            //---//while zti >= 0 do

                          end;
                        //---//if    ( granica_odstÍp_l <= 0 ) (...)

                      end;
                    //---//if    ( punkt__na_terytorium__ostatni__znaleziony ) (...)

                  end;
                //---//if    (  Length( tablica_drogi_t_l ) > 0  ) (...)

              end;
            //---//if   (  Length( zt_poszukiwacz.droga__punkty ) > 0  ) (...)

          end;
        //---//if    ( zt_poszukiwacz_wynik = Poszukiwacz.pw_wszystko_w_porzπdku ) (...)

        System.SysUtils.FreeAndNil( zt_poszukiwacz );

      end;
    //---//if    ( (...)


  SetLength( teren__kopia_t_l, 0, 0 );

end;//---//Funkcja Surowiec__Najbliøszy__Znajdü__Ma().

function TMapa.Surowiec__OpuúÊ__Ma( const dominium__numer_f : smallint; const id__surowiec_ürÛd≥o_f : integer; const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj ) : boolean;
var
  i : integer;
begin

  Result := false;


  for i := 0 to Length( Self.surowce_ürÛd≥o_t__ma ) - 1 do
    if    ( Self.surowce_ürÛd≥o_t__ma[ i ].id__sü = id__surowiec_ürÛd≥o_f )
      and ( Self.surowce_ürÛd≥o_t__ma[ i ].dominium__numer__sü = dominium__numer_f )
      and ( Self.surowce_ürÛd≥o_t__ma[ i ].surowiec__rodzaj__sü = surowiec__rodzaj_f )
      and ( Self.surowce_ürÛd≥o_t__ma[ i ].domki__iloúÊ__sü > 0 ) then
      begin

        Self.surowce_ürÛd≥o_t__ma[ i ].domki__iloúÊ__sü := Self.surowce_ürÛd≥o_t__ma[ i ].domki__iloúÊ__sü
          - 1;

        if Self.surowce_ürÛd≥o_t__ma[ i ].domki__iloúÊ__sü < 0 then
          Self.surowce_ürÛd≥o_t__ma[ i ].domki__iloúÊ__sü := 0;

        if Self.surowce_ürÛd≥o_t__ma[ i ].domki__iloúÊ__sü <= 0 then
          Self.surowce_ürÛd≥o_t__ma[ i ].dominium__numer__sü := Definicje.dominium__numer__puste_c;


        Result := true;


        Break;

      end;
    //---//if    ( Self.surowce_ürÛd≥o_t__ma[ i ].id__sü = id__surowiec_ürÛd≥o_f ) (...)

end;//---//Funkcja Surowiec__OpuúÊ__Ma().

function TMapa.Surowiec__Zajmij__Ma( const dominium__numer_f : smallint; const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj; const y_f : integer = -99; const x_f : integer = -99; const tylko_test_f : boolean = false ) : boolean;
var
  ztb : boolean;

  i,
  indeks_l,
  wspÛ≥rzÍdna__x,
  wspÛ≥rzÍdna__y,
  zamek_wspÛ≥rzÍdna__x,
  zamek_wspÛ≥rzÍdna__y
    : integer;

  ztr,
  odleg≥oúÊ_najmniejsza_l
    : real;

  zt_point : Winapi.Windows.TPoint;
begin

  Result := false;


  if not Self.Zamek__WspÛ≥rzÍdne__Znajdü__Ma( dominium__numer_f, zamek_wspÛ≥rzÍdna__y, zamek_wspÛ≥rzÍdna__x ) then
    Exit;


  if    ( x_f <> Definicje.identyfikator_pusty_c )
    and ( y_f <> Definicje.identyfikator_pusty_c ) then
    begin

      zamek_wspÛ≥rzÍdna__x := x_f;
      zamek_wspÛ≥rzÍdna__y := y_f;

    end;
  //---//if    ( x_f <> Definicje.identyfikator_pusty_c ) (...)


  ztb := false;
  indeks_l := Definicje.identyfikator_pusty_c;

  for i := 0 to Length( Self.surowce_ürÛd≥o_t__ma ) - 1 do
    if    (
               ( Self.surowce_ürÛd≥o_t__ma[ i ].dominium__numer__sü = Definicje.dominium__numer__puste_c )
            or ( Self.surowce_ürÛd≥o_t__ma[ i ].dominium__numer__sü = dominium__numer_f )
          )
      and ( Self.surowce_ürÛd≥o_t__ma[ i ].surowiec__rodzaj__sü = surowiec__rodzaj_f )
      and ( Self.surowce_ürÛd≥o_t__ma[ i ].domki__iloúÊ__sü < Mapa.surowiec_ürÛd≥o__pojemnoúÊ__domki_c )
      and (
               (  Self.Teren__PrzynaleønoúÊ__Sprawdü__Ma( dominium__numer_f, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__y__sü, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__x__sü )  )
            or (  Self.Teren__PrzynaleønoúÊ__Sprawdü__Ma( Definicje.dominium__numer__puste_c, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__y__sü, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__x__sü )  )
          )
      and (  Self.Teren__Na_Oko≥o__Punktu__DostÍpny__Sprawdü__Ma( dominium__numer_f, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__y__sü, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__x__sü, Definicje.wydobycie__zasiÍg__domek_c ) > 0  ) then
      begin

        ztr := Odleg≥oúÊ__Wylicz__Ma( zamek_wspÛ≥rzÍdna__y, zamek_wspÛ≥rzÍdna__x, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__y__sü, Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__x__sü );

        if   ( not ztb )
          or ( odleg≥oúÊ_najmniejsza_l > ztr ) then
          begin

            ztb := true;
            indeks_l := i;
            odleg≥oúÊ_najmniejsza_l := ztr;

          end;
        //---//if not ztb then

      end;
    //---//if    ( (...)


  if indeks_l <> Definicje.identyfikator_pusty_c then
    begin

      if    ( x_f <> Definicje.identyfikator_pusty_c )
        and ( y_f <> Definicje.identyfikator_pusty_c ) then
        begin

          wspÛ≥rzÍdna__x := x_f;
          wspÛ≥rzÍdna__y := y_f;

          ztb := Self.Punkt__BudowaÊ__Moøna__Sprawdü__Ma( dominium__numer_f, wspÛ≥rzÍdna__y, wspÛ≥rzÍdna__x );

        end
      else//if    ( x_f <> Definicje.identyfikator_pusty_c ) (...)
        begin

          zt_point := Self.Punkt__BudowaÊ__Moøna__Znajdü__W_Promieniu__Ma( dominium__numer_f, Self.surowce_ürÛd≥o_t__ma[ indeks_l ].wspÛ≥rzÍdna__y__sü, Self.surowce_ürÛd≥o_t__ma[ indeks_l ].wspÛ≥rzÍdna__x__sü );

          if    ( zt_point.X <> Definicje.identyfikator_pusty_c )
            and ( zt_point.Y <> Definicje.identyfikator_pusty_c ) then
            begin

              ztb := true;

              wspÛ≥rzÍdna__x := zt_point.X;
              wspÛ≥rzÍdna__y := zt_point.Y;

            end
          else//if    ( zt_point.X <> Definicje.identyfikator_pusty_c ) (...)
            ztb := false;

        end;
      //---//if    ( x_f <> Definicje.identyfikator_pusty_c ) (...)


      if ztb then
        begin

          if not tylko_test_f then
            begin

              if Self.surowce_ürÛd≥o_t__ma[ indeks_l ].dominium__numer__sü = Definicje.dominium__numer__puste_c then
                Self.surowce_ürÛd≥o_t__ma[ indeks_l ].dominium__numer__sü := dominium__numer_f;

              Self.surowce_ürÛd≥o_t__ma[ indeks_l ].domki__iloúÊ__sü := Self.surowce_ürÛd≥o_t__ma[ indeks_l ].domki__iloúÊ__sü
                + 1;


              inc( Self.budowle__id__ma );

              i := Length( Self.budowle_t__ma );
              SetLength( Self.budowle_t__ma, i + 1 );

              Self.budowle_t__ma[ i ].id__bu := Self.budowle__id__ma;
              Self.budowle_t__ma[ i ].id__surowiec_ürÛd≥o__bu := Self.surowce_ürÛd≥o_t__ma[ indeks_l ].id__sü;
              Self.budowle_t__ma[ i ].atak__w_trakcie__bu := false;
              Self.budowle_t__ma[ i ].budowla_rodzaj__bu := Definicje.br_domek;
              Self.budowle_t__ma[ i ].dominium__numer__bu := dominium__numer_f;
              Self.budowle_t__ma[ i ].koszary__mapa_jednostki__iloúÊ__bu := 0;
              Self.budowle_t__ma[ i ].koszary__produkcja_wspÛ≥czynnik__skumulowany__bu := 0;
              Self.budowle_t__ma[ i ].obraøenia__w_trakcie__bu := false;
              Self.budowle_t__ma[ i ].ruch_grupπ__bu := false;
              Self.budowle_t__ma[ i ].surowiec__rodzaj__bu := surowiec__rodzaj_f;
              Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__x__bu := wspÛ≥rzÍdna__x;
              Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__y__bu := wspÛ≥rzÍdna__y;
              Self.budowle_t__ma[ i ].wytrzyma≥oúÊ_punkty__bu := Self.WspÛ≥czynniki__Dolicz__Ma( Self.budowle_t__ma[ i ].dominium__numer__bu, Mapa.wytrzyma≥oúÊ_punkty__domek_c, false );

            end;
          //---//if not tylko_test_f then


          Result := true;

        end;
      //---//if ztb then

    end;
  //---//if indeks_l <> Definicje.identyfikator_pusty_c then

end;//---//Funkcja Surowiec__Zajmij__Ma().

function TMapa.Teren__Budowle__Odczytaj__Ma() : Definicje.TBudowle;
var
  i : integer;
begin

  SetLength(  Result, Length( Self.budowle_t__ma )  );

  for i := 0 to Length( Self.budowle_t__ma ) - 1 do
    Result[ i ] := Self.budowle_t__ma[ i ];

end;//---//Funkcja Teren__Budowle__Odczytaj__Ma().

function TMapa.Teren__Mapa__Jednostki__Odczytaj__Ma() : Definicje.TMapa_Jednostki;
var
  i : integer;
begin

  SetLength(  Result, Length( Self.mapa_jednostki_t__ma )  );

  for i := 0 to Length( Self.mapa_jednostki_t__ma ) - 1 do
    Result[ i ] := Self.mapa_jednostki_t__ma[ i ];

end;//---//Funkcja Teren__Mapa__Jednostki__Odczytaj__Ma().

function TMapa.Teren__Mapa__Odczytaj__Ma() : Poszukiwacz.TTablica2D_Integer;
var
  i,
  j
    : integer;
begin

  SetLength(  Result, Length( Self.teren_t__ma ), Length( Self.teren_t__ma[ 0 ] )  );

  for i := 0 to Length( Self.teren_t__ma ) - 1 do
    for j := 0 to Length( Self.teren_t__ma[ i ] ) - 1 do
      Result[ i, j ] := Self.teren_t__ma[ i, j ];

end;//---//Funkcja Teren__Mapa__Odczytaj__Ma().

function TMapa.Teren__Na_Oko≥o__Punktu__DostÍpny__Sprawdü__Ma( const dominium__numer_f : smallint; const y_f, x_f : integer; const promieÒ_f : integer = 1 ) : integer;
var
  ztb : boolean;

  i,
  x,
  x__do,
  x__od,
  y,
  y__do,
  y__od
    : integer;
begin

  Result := 0;


  if not Self.Punkt__Naleøy_Do__Terenu__Sprawdü__Ma( y_f, x_f ) then
    Exit;


  x__od := x_f - promieÒ_f;

  if x__od < 0 then
    x__od := 0;


  x__do := x_f + promieÒ_f;

  if x__do > Length( Self.teren_t__ma[ 0 ] ) - 1 then
    x__do := Length( Self.teren_t__ma[ 0 ] ) - 1;



  y__od := y_f - promieÒ_f;

  if y__od < 0 then
    y__od := 0;


  y__do := y_f + promieÒ_f;

  if y__do > Length( Self.teren_t__ma ) - 1 then
    y__do := Length( Self.teren_t__ma ) - 1;


  for y := y__od to y__do do
    for x := x__od to x__do do
      if Self.teren_t__ma[ y, x ] = dominium__numer_f then
        begin

          ztb := true;


          for i := 0 to Length( Self.budowle_t__ma ) - 1 do
            if    ( Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__x__bu = x )
              and ( Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__y__bu = y ) then
              begin

                ztb := false;

                Break;

              end;
            //---//if    ( Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__x__bu = x ) (...)

          if ztb then
            for i := 0 to Length( Self.surowce_ürÛd≥o_t__ma ) - 1 do
              if    ( Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__x__sü = x )
                and ( Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__y__sü = y ) then
                begin

                  ztb := false;

                  Break;

                end;
              //---//if    ( Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__x__sü = x ) (...)


          if ztb then
            inc( Result );

        end;
      //---//if Self.teren_t__ma[ y, x ] = dominium__numer_f then

end;//---//Funkcja Teren__Na_Oko≥o__Punktu__DostÍpny__Sprawdü__Ma().

procedure TMapa.Teren__PrzynaleønoúÊ__Oznacz__Ma();
var
  i,
  obserwacja__zasiÍg_l,
  x,
  x__do,
  x__od,
  y,
  y__do,
  y__od
    : integer;
begin

  if   (  Length( Self.teren_t__ma ) <= 0  )
    or (  Length( Self.teren_t__ma[ 0 ] ) <= 0  ) then
    Exit;


  for y := 0 to Length( Self.teren_t__ma ) - 1 do
    for x := 0 to Length( Self.teren_t__ma[ y ] ) - 1 do
      if Self.teren_t__ma[ y, x ] > Definicje.mapa__teren__dostÍpny_c then
        Self.teren_t__ma[ y, x ] := Definicje.mapa__teren__dostÍpny_c;


  for i := 0 to Length( Self.budowle_t__ma ) - 1 do
    if Self.budowle_t__ma[ i ].budowla_rodzaj__bu in [ Definicje.br_wieøa__obronna, Definicje.br_wieøa__zwiadowcza, Definicje.br_zamek ] then
      begin

        if Self.budowle_t__ma[ i ].budowla_rodzaj__bu in [ Definicje.br_wieøa__zwiadowcza ] then
          obserwacja__zasiÍg_l := Definicje.obserwacja__zasiÍg___wieøa__zwiadowcza_c
        else
        if Self.budowle_t__ma[ i ].budowla_rodzaj__bu in [ Definicje.br_zamek ] then
          obserwacja__zasiÍg_l := Definicje.obserwacja__zasiÍg___zamek_c
        else
          obserwacja__zasiÍg_l := Definicje.obserwacja__zasiÍg___wieøa__obronna_c;


        x__od := Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__x__bu - obserwacja__zasiÍg_l;

        if x__od < 0 then
          x__od := 0;


        x__do := Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__x__bu + obserwacja__zasiÍg_l;

        if x__do > Length( Self.teren_t__ma[ 0 ] ) - 1 then
          x__do := Length( Self.teren_t__ma[ 0 ] ) - 1;



        y__od := Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__y__bu - obserwacja__zasiÍg_l;

        if y__od < 0 then
          y__od := 0;


        y__do := Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__y__bu + obserwacja__zasiÍg_l;

        if y__do > Length( Self.teren_t__ma ) - 1 then
          y__do := Length( Self.teren_t__ma ) - 1;


        for y := y__od to y__do do
          for x := x__od to x__do do
            if Self.teren_t__ma[ y, x ] = Definicje.mapa__teren__dostÍpny_c then
              Self.teren_t__ma[ y, x ] := Self.budowle_t__ma[ i ].dominium__numer__bu;

      end;
    //---//if Self.budowle_t__ma[ i ].budowla_rodzaj__bu in [ Definicje.br_wieøa__obronna, Definicje.br_wieøa__zwiadowcza, Definicje.br_zamek ] then

end;//---//Funkcja Teren__PrzynaleønoúÊ__Oznacz__Ma().

function TMapa.Teren__PrzynaleønoúÊ__Sprawdü__Ma( const przynaleønoúÊ__numer_f : smallint; const y_f, x_f : integer ) : boolean;
begin

  if    (  Self.Punkt__Naleøy_Do__Terenu__Sprawdü__Ma( y_f, x_f )  )
    and ( Self.teren_t__ma[ y_f, x_f ] = przynaleønoúÊ__numer_f ) then
    Result := true
  else//if    (  Self.Punkt__Naleøy_Do__Terenu__Sprawdü__Ma( y_f, x_f )  ) (...)
    Result := false;

end;//---//Funkcja Teren__PrzynaleønoúÊ__Sprawdü__Ma().

function TMapa.Teren__Surowce__Odczytaj__Ma() : Definicje.TSurowce_èrÛd≥o;
var
  i : integer;
begin

  SetLength(  Result, Length( Self.surowce_ürÛd≥o_t__ma )  );

  for i := 0 to Length( Self.surowce_ürÛd≥o_t__ma ) - 1 do
    begin

      Result[ i ].id__sü := Self.surowce_ürÛd≥o_t__ma[ i ].id__sü;
      Result[ i ].dominium__numer__sü := Self.surowce_ürÛd≥o_t__ma[ i ].dominium__numer__sü;
      Result[ i ].domki__iloúÊ__sü := Self.surowce_ürÛd≥o_t__ma[ i ].domki__iloúÊ__sü;
      Result[ i ].surowiec__rodzaj__sü := Self.surowce_ürÛd≥o_t__ma[ i ].surowiec__rodzaj__sü;
      Result[ i ].wspÛ≥rzÍdna__x__sü := Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__x__sü;
      Result[ i ].wspÛ≥rzÍdna__y__sü := Self.surowce_ürÛd≥o_t__ma[ i ].wspÛ≥rzÍdna__y__sü;

    end;
  //---//for i := 0 to Length( Self.surowce_ürÛd≥o_t__ma ) - 1 do

end;//---//Funkcja Teren__Surowce__Odczytaj__Ma().

function TMapa.Teren__WielkoúÊ__X__Odczytaj__Ma() : integer;
begin

  Result := Self.teren__wielkoúÊ__x__ma;

end;//---//Funkcja Teren__WielkoúÊ__X__Odczytaj__Ma().

function TMapa.Teren__WielkoúÊ__Y__Odczytaj__Ma() : integer;
begin

  Result := Self.teren__wielkoúÊ__y__ma;

end;//---//Funkcja Teren__WielkoúÊ__Y__Odczytaj__Ma().

procedure TMapa.Wczytaj__Ma( const dominium__numer__1_f, dominium__numer__2_f : smallint; const potyczki__iloúÊ_f : integer );

  //Funkcja Kolory_PorÛwnaj() w Wczytaj__Ma().
  function Kolory_PorÛwnaj( const kolor__1_f, kolor__2_f : Winapi.Windows.TRGBTriple ) : boolean;
  begin

    if    ( kolor__1_f.rgbtBlue = kolor__2_f.rgbtBlue )
      and ( kolor__1_f.rgbtGreen = kolor__2_f.rgbtGreen )
      and ( kolor__1_f.rgbtRed = kolor__2_f.rgbtRed ) then
      Result := true
    else//if    ( kolor__1_f.rgbtBlue = kolor__2_f.rgbtBlue ) (...)
      Result := false;

  end;//---//Funkcja Kolory_PorÛwnaj() w Wczytaj__Ma().

type
  TRGBTripleArray = array[ 0..32767 ] of Winapi.Windows.TRGBTriple;
  PRGBTripleArray = ^TRGBTripleArray;

var
  x,
  y,
  zti,
  mapa__wspÛ≥rzÍdna__y__korekta_l,
  mapa__wspÛ≥rzÍdna__y__korekta__odbicie_lustrzane_l,
  mapa__wspÛ≥rzÍdna__y__kolor__mapa__nie_kopiuj_l
    :  integer;

  search_rec : System.SysUtils.TSearchRec;

  zts : string;

  surowiec__rodzaj_l : Definicje.TSurowiec_Rodzaj;

  zt_p_rgb_triple_array :  PRGBTripleArray;
  zt_bitmap : Vcl.Graphics.TBitmap;
begin//Funkcja Wczytaj__Ma().

  {$region 'Okreúla plik mapy.'}
  zti := 0;

  if FindFirst(  System.SysUtils.ExtractFilePath( Vcl.Forms.Application.ExeName ) + Mapa.mapy__katalog__nazwa_c + System.SysUtils.PathDelim + Mapa.mapa__plik__nazwa__prefiks_c + '*.bmp', faAnyFile, search_rec  ) = 0 then
    begin

      repeat //FindNext( search_rec ) <> 0;

        inc( zti );

      until FindNext( search_rec ) <> 0; // Zwraca dane kolejnego pliku zgodnego z parametrami wczeúniej wywo≥anej funkcji FindFirst. Jeøeli moøna przejúÊ do nastÍpnego znalezionego pliku zwraca 0.

    end;
  //---//if FindFirst(  System.SysUtils.ExtractFilePath( Vcl.Forms.Application.ExeName ) + Mapa.mapy__katalog__nazwa_c + System.SysUtils.PathDelim + Mapa.mapa__plik__nazwa__prefiks_c + '*.bmp', faAnyFile, search_rec  ) = 0 then

  System.SysUtils.FindClose( search_rec );


  x := ( potyczki__iloúÊ_f - 1 ) mod zti; // potyczki__iloúÊ_f od 1
  zti := -1;


  if FindFirst(  System.SysUtils.ExtractFilePath( Vcl.Forms.Application.ExeName ) + Mapa.mapy__katalog__nazwa_c + System.SysUtils.PathDelim + Mapa.mapa__plik__nazwa__prefiks_c + '*.bmp', faAnyFile, search_rec  ) = 0 then
    begin

      repeat //FindNext( search_rec ) <> 0;

        inc( zti );

        if zti >= x then
          begin

            zts := search_rec.Name;

            Break;

          end;
        //---//if zti >= x then

      until FindNext( search_rec ) <> 0; // Zwraca dane kolejnego pliku zgodnego z parametrami wczeúniej wywo≥anej funkcji FindFirst. Jeøeli moøna przejúÊ do nastÍpnego znalezionego pliku zwraca 0.

    end;
  //---//if FindFirst(  System.SysUtils.ExtractFilePath( Vcl.Forms.Application.ExeName ) + Mapa.mapy__katalog__nazwa_c + System.SysUtils.PathDelim + Mapa.mapa__plik__nazwa__prefiks_c + '*.bmp', faAnyFile, search_rec  ) = 0 then

  System.SysUtils.FindClose( search_rec );
  {$endregion 'Okreúla plik mapy.'}


  SetLength( Self.budowle_t__ma, 0 );
  SetLength( Self.mapa_jednostki_t__ma, 0 );
  SetLength( Self.teren_t__ma, 0, 0 );
  SetLength( Self.surowce_ürÛd≥o_t__ma, 0 );


  zt_bitmap := Vcl.Graphics.TBitmap.Create();

  try
    zt_bitmap.PixelFormat := pf24bit;
    zt_bitmap.LoadFromFile(  System.SysUtils.ExtractFilePath( Vcl.Forms.Application.ExeName ) + Mapa.mapy__katalog__nazwa_c + System.SysUtils.PathDelim + zts  );


    mapa__wspÛ≥rzÍdna__y__kolor__mapa__nie_kopiuj_l := -1;

    if zt_bitmap.Width > 0 then
      for y := 0 to zt_bitmap.Height - 1 do
        begin

          zt_p_rgb_triple_array := zt_bitmap.Scanline[ y ];


          if Kolory_PorÛwnaj( zt_p_rgb_triple_array[ 0 ], Definicje.kolor__mapa__nie_kopiuj_c ) then
            begin

              mapa__wspÛ≥rzÍdna__y__kolor__mapa__nie_kopiuj_l := y;


              Break;

            end;
          //---//if Kolory_PorÛwnaj( zt_p_rgb_triple_array[ 0 ], Definicje.kolor__mapa__nie_kopiuj_c ) then

        end;
      //---//zt_p_rgb_triple_array := zt_bitmap.Scanline[ y ];



    mapa__wspÛ≥rzÍdna__y__korekta_l:= zt_bitmap.Height; // DÛ≥ mapy.
    mapa__wspÛ≥rzÍdna__y__korekta__odbicie_lustrzane_l := mapa__wspÛ≥rzÍdna__y__korekta_l - 1; // GÛra mapy.


    Self.teren__wielkoúÊ__x__ma := zt_bitmap.Width;
    Self.teren__wielkoúÊ__y__ma := zt_bitmap.Height * 2;


    if mapa__wspÛ≥rzÍdna__y__kolor__mapa__nie_kopiuj_l >= 0 then
      begin

        Self.teren__wielkoúÊ__y__ma := Self.teren__wielkoúÊ__y__ma
          - mapa__wspÛ≥rzÍdna__y__kolor__mapa__nie_kopiuj_l;

        mapa__wspÛ≥rzÍdna__y__korekta_l := mapa__wspÛ≥rzÍdna__y__korekta_l
          - mapa__wspÛ≥rzÍdna__y__kolor__mapa__nie_kopiuj_l;

      end;
    //---//if mapa__wspÛ≥rzÍdna__y__kolor__mapa__nie_kopiuj_l >= 0 then


    SetLength( Self.teren_t__ma, Self.teren__wielkoúÊ__y__ma, Self.teren__wielkoúÊ__x__ma );


    for y := 0 to zt_bitmap.Height - 1 do
      begin

        zt_p_rgb_triple_array := zt_bitmap.Scanline[ y ];

        for x := 0 to zt_bitmap.Width - 1 do
          begin

            zti := 1;

            if Kolory_PorÛwnaj( zt_p_rgb_triple_array[ x ], Definicje.kolor__surowiec__kryszta≥_c ) then
              surowiec__rodzaj_l := Definicje.sr_kryszta≥
            else
            if Kolory_PorÛwnaj( zt_p_rgb_triple_array[ x ], Definicje.kolor__surowiec__kwiatki_c ) then
              surowiec__rodzaj_l := Definicje.sr_kwiatki
            else
            if Kolory_PorÛwnaj( zt_p_rgb_triple_array[ x ], Definicje.kolor__surowiec__magma_c ) then
              surowiec__rodzaj_l := Definicje.sr_magma
            else
            if Kolory_PorÛwnaj( zt_p_rgb_triple_array[ x ], Definicje.kolor__surowiec__woda_c ) then
              surowiec__rodzaj_l := Definicje.sr_woda
            else
            if Kolory_PorÛwnaj( zt_p_rgb_triple_array[ x ], Definicje.kolor__surowiec__øywio≥_c ) then
              surowiec__rodzaj_l := Definicje.sr_øywio≥
            else
            if  (  Kolory_PorÛwnaj( zt_p_rgb_triple_array[ x ], Definicje.kolor__mapa__nie_kopiuj_c )  )
             or (  Kolory_PorÛwnaj( zt_p_rgb_triple_array[ x ], Definicje.kolor__teren__dostÍpny_c )  ) then
              zti := 2
            else
            if Kolory_PorÛwnaj( zt_p_rgb_triple_array[ x ], Definicje.kolor__zamek_c ) then
              zti := 3
            else
              zti := 0;


            if zti = 0 then
              begin

                // Teren niedostÍpny.

                if   ( mapa__wspÛ≥rzÍdna__y__kolor__mapa__nie_kopiuj_l < 0 )
                  or (
                           ( mapa__wspÛ≥rzÍdna__y__kolor__mapa__nie_kopiuj_l >= 0 )
                       and ( y >= mapa__wspÛ≥rzÍdna__y__kolor__mapa__nie_kopiuj_l )
                     ) then
                  Self.teren_t__ma[ mapa__wspÛ≥rzÍdna__y__korekta_l + y, x ] := Definicje.mapa__teren__niedostÍpny_c; // DÛ≥ mapy.

                Self.teren_t__ma[ mapa__wspÛ≥rzÍdna__y__korekta__odbicie_lustrzane_l - y, x ] := Definicje.mapa__teren__niedostÍpny_c; // GÛra mapy.

              end
            else//if zti = 0 then
              begin

                if   ( mapa__wspÛ≥rzÍdna__y__kolor__mapa__nie_kopiuj_l < 0 )
                  or (
                           ( mapa__wspÛ≥rzÍdna__y__kolor__mapa__nie_kopiuj_l >= 0 )
                       and ( y >= mapa__wspÛ≥rzÍdna__y__kolor__mapa__nie_kopiuj_l )
                     ) then
                  Self.teren_t__ma[ mapa__wspÛ≥rzÍdna__y__korekta_l + y, x ] := Definicje.mapa__teren__dostÍpny_c; // DÛ≥ mapy.

                Self.teren_t__ma[ mapa__wspÛ≥rzÍdna__y__korekta__odbicie_lustrzane_l - y, x ] := Definicje.mapa__teren__dostÍpny_c; // GÛra mapy.


                if zti = 1 then
                  begin

                    // kolor__surowiec.

                    if   ( mapa__wspÛ≥rzÍdna__y__kolor__mapa__nie_kopiuj_l < 0 )
                      or (
                               ( mapa__wspÛ≥rzÍdna__y__kolor__mapa__nie_kopiuj_l >= 0 )
                           and ( y >= mapa__wspÛ≥rzÍdna__y__kolor__mapa__nie_kopiuj_l )
                         ) then
                      begin

                        zti := Length( Self.surowce_ürÛd≥o_t__ma );
                        SetLength( Self.surowce_ürÛd≥o_t__ma, zti + 1 );

                        Self.surowce_ürÛd≥o_t__ma[ zti ].id__sü := zti;
                        Self.surowce_ürÛd≥o_t__ma[ zti ].dominium__numer__sü := Definicje.dominium__numer__puste_c;
                        Self.surowce_ürÛd≥o_t__ma[ zti ].domki__iloúÊ__sü := 0;
                        Self.surowce_ürÛd≥o_t__ma[ zti ].surowiec__rodzaj__sü := surowiec__rodzaj_l;
                        Self.surowce_ürÛd≥o_t__ma[ zti ].wspÛ≥rzÍdna__x__sü := x;
                        Self.surowce_ürÛd≥o_t__ma[ zti ].wspÛ≥rzÍdna__y__sü := mapa__wspÛ≥rzÍdna__y__korekta_l + y;

                      end;
                    //---//if   ( mapa__wspÛ≥rzÍdna__y__kolor__mapa__nie_kopiuj_l < 0 ) (...)


                    zti := Length( Self.surowce_ürÛd≥o_t__ma );
                    SetLength( Self.surowce_ürÛd≥o_t__ma, zti + 1 );

                    Self.surowce_ürÛd≥o_t__ma[ zti ].id__sü := zti;
                    Self.surowce_ürÛd≥o_t__ma[ zti ].dominium__numer__sü := Definicje.dominium__numer__puste_c;
                    Self.surowce_ürÛd≥o_t__ma[ zti ].domki__iloúÊ__sü := 0;
                    Self.surowce_ürÛd≥o_t__ma[ zti ].surowiec__rodzaj__sü := surowiec__rodzaj_l;
                    Self.surowce_ürÛd≥o_t__ma[ zti ].wspÛ≥rzÍdna__x__sü := x;
                    Self.surowce_ürÛd≥o_t__ma[ zti ].wspÛ≥rzÍdna__y__sü := mapa__wspÛ≥rzÍdna__y__korekta__odbicie_lustrzane_l - y;

                  end
                else//if zti = 1 then
                if zti = 2 then
                  begin

                    // kolor__teren__dostÍpny.

                  end
                else//if zti = 2 then
                if zti = 3 then
                  begin

                    // kolor__zamek.

                    inc( Self.budowle__id__ma );

                    zti := Length( Self.budowle_t__ma );
                    SetLength( Self.budowle_t__ma, zti + 2 );

                    Self.budowle_t__ma[ zti ].id__bu := Self.budowle__id__ma;
                    Self.budowle_t__ma[ zti ].id__surowiec_ürÛd≥o__bu := Definicje.identyfikator_pusty_c;
                    Self.budowle_t__ma[ zti ].atak__w_trakcie__bu := false;
                    Self.budowle_t__ma[ zti ].budowla_rodzaj__bu := Definicje.br_zamek;
                    Self.budowle_t__ma[ zti ].dominium__numer__bu := dominium__numer__1_f;
                    Self.budowle_t__ma[ zti ].koszary__mapa_jednostki__iloúÊ__bu := 0;
                    Self.budowle_t__ma[ zti ].koszary__produkcja_wspÛ≥czynnik__skumulowany__bu := 0;
                    Self.budowle_t__ma[ zti ].obraøenia__w_trakcie__bu := false;
                    Self.budowle_t__ma[ zti ].ruch_grupπ__bu := false;
                    Self.budowle_t__ma[ zti ].surowiec__rodzaj__bu := Definicje.sr_kryszta≥;
                    Self.budowle_t__ma[ zti ].wspÛ≥rzÍdna__x__bu := x;
                    Self.budowle_t__ma[ zti ].wspÛ≥rzÍdna__y__bu := mapa__wspÛ≥rzÍdna__y__korekta_l + y;
                    Self.budowle_t__ma[ zti ].wytrzyma≥oúÊ_punkty__bu := Self.WspÛ≥czynniki__Dolicz__Ma( Self.budowle_t__ma[ zti ].dominium__numer__bu, Mapa.wytrzyma≥oúÊ_punkty__zamek_c, false );


                    inc( Self.budowle__id__ma );

                    Self.budowle_t__ma[ zti + 1 ].id__bu := Self.budowle__id__ma;
                    Self.budowle_t__ma[ zti + 1 ].id__surowiec_ürÛd≥o__bu := Definicje.identyfikator_pusty_c;
                    Self.budowle_t__ma[ zti + 1 ].atak__w_trakcie__bu := false;
                    Self.budowle_t__ma[ zti + 1 ].budowla_rodzaj__bu := Definicje.br_zamek;
                    Self.budowle_t__ma[ zti + 1 ].dominium__numer__bu := dominium__numer__2_f;
                    Self.budowle_t__ma[ zti + 1 ].koszary__mapa_jednostki__iloúÊ__bu := 0;
                    Self.budowle_t__ma[ zti + 1 ].koszary__produkcja_wspÛ≥czynnik__skumulowany__bu := 0;
                    Self.budowle_t__ma[ zti + 1 ].obraøenia__w_trakcie__bu := false;
                    Self.budowle_t__ma[ zti + 1 ].ruch_grupπ__bu := false;
                    Self.budowle_t__ma[ zti + 1 ].surowiec__rodzaj__bu := Definicje.sr_kryszta≥;
                    Self.budowle_t__ma[ zti + 1 ].wspÛ≥rzÍdna__x__bu := x;
                    Self.budowle_t__ma[ zti + 1 ].wspÛ≥rzÍdna__y__bu := mapa__wspÛ≥rzÍdna__y__korekta__odbicie_lustrzane_l - y;
                    Self.budowle_t__ma[ zti + 1 ].wytrzyma≥oúÊ_punkty__bu := Self.WspÛ≥czynniki__Dolicz__Ma( Self.budowle_t__ma[ zti + 1 ].dominium__numer__bu, Mapa.wytrzyma≥oúÊ_punkty__zamek_c, false );

                  end;
                //---//if zti = 3 then

              end;
            //---//if zti = 0 then

          end;
        //---//for x := 0 to zt_bitmap.Width - 1 do

      end;
    //---//for y := 0 to zt_bitmap.Height - 1 do

  finally
    zt_bitmap.Free();
  end;
  //---//try

  Self.Teren__PrzynaleønoúÊ__Oznacz__Ma();

end;//---//Funkcja Wczytaj__Ma().

function TMapa.WspÛ≥czynniki__Dolicz__Ma( const dominium__numer_f : smallint; const wartoúÊ_f : real; const czy_atak_f : boolean ) : real;
var
  ztr : real;
begin

  if dominium__numer_f = Definicje.dominium__numer__gracz__1_c then
    begin

      if czy_atak_f then
        ztr := Self.dominium__1__atak__wspÛ≥czynnik__ma
      else//czy_atak_f
        ztr := Self.dominium__1__obrona__wspÛ≥czynnik__ma;

    end
  else//if dominium__numer_f = Definicje.dominium__numer__gracz__1_c then
  if dominium__numer_f = Definicje.dominium__numer__gracz__2_c then
    begin

      if czy_atak_f then
        ztr := Self.dominium__2__atak__wspÛ≥czynnik__ma
      else//czy_atak_f
        ztr := Self.dominium__2__obrona__wspÛ≥czynnik__ma;

    end
  else//if dominium__numer_f = Definicje.dominium__numer__gracz__2_c then
    ztr := 1;


  Result :=
      wartoúÊ_f
    * ztr;

end;//---//Funkcja WspÛ≥czynniki__Dolicz__Ma().

function TMapa.Zamek__WspÛ≥rzÍdne__Znajdü__Ma( const dominium__numer_f : smallint; var y_f, x_f : integer) : boolean;
var
  i : integer;
begin

  Result := false;


  for i := 0 to Length( Self.budowle_t__ma ) - 1 do
    if    ( Self.budowle_t__ma[ i ].budowla_rodzaj__bu = Definicje.br_zamek )
      and ( Self.budowle_t__ma[ i ].dominium__numer__bu = dominium__numer_f ) then
        begin

          x_f := Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__x__bu;
          y_f := Self.budowle_t__ma[ i ].wspÛ≥rzÍdna__y__bu;

          Result := true;

          Break;

        end;
      //---//if    ( Self.budowle_t__ma[ i ].budowla_rodzaj__bu = Definicje.br_zamek ) (...)

end;//---//Funkcja Zamek__WspÛ≥rzÍdne__Znajdü__Ma().

end.
