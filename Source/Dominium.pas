unit Dominium;{06.Sie.2026}

interface

uses
  System.Math,
  System.SysUtils,

  Definicje,
  Gracz,
  Jednostka;

type
  TDominium = class
  private
    { Private declarations }
    jednostki__nie_kupuje__do,
    zamek__zburzony__do
      : boolean;

    dominium__numer__do : smallint;

    surowce__oszczêdzanie_przed_bitw¹__wspó³czynnik__do,
    wytrzyma³oœæ_punkty__do,
    zamek__produkcja_wspó³czynnik__skumulowany__indeks
      : integer;

    atak__wspó³czynnik__do,
    obrona__wspó³czynnik__do,
    obserwacja__zasiêg_wspó³czynnik__do,
    surowiec__produkcja_wspó³czynnik__do,
    surowiec__produkcja_wspó³czynnik__skumulowany__do,
    zamek__produkcja_wspó³czynnik__do
      : real;

    zamek__produkcja_wspó³czynnik__skumulowany_t : array of real;

    jednostki_t : Jednostka.TJednostki_t;

    strategia_typ__do : Definicje.TStrategia_Typ;

    surowce_zasoby_t : Definicje.TSurowce_Zasoby;

    function Budowla__Surowce__Zmniejsz__Zbuduj__Do( const budowla_rodzaj_f : Definicje.TBudowla_Rodzaj; iloœæ_f : integer; const tylko_test_f : boolean = false ) : boolean; overload;
    procedure Domek__Surowiec__Zmniejsz__Do( const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj; const wartoœæ_f : integer );
    function Jednostki__Po³¹cz__Koszt__Do( const jednostka_typ_f : Definicje.TJednostka_Typ ) : integer;
  public
    { Public declarations }
    constructor Create( const dominium__numer_f : smallint; const dominium__wytrzyma³oœæ_punkty_f : integer; const gracz_f : Gracz.TGracz );
    destructor Destroy(); override;

    function Budowla__Surowce__Zmniejsz__Zbuduj__Do( const budowla_rodzaj_f : Definicje.TBudowla_Rodzaj; iloœæ_f : integer ) : boolean; overload;
    function Budowla__Surowce__Zmniejsz__Zbuduj__Do( const budowla_rodzaj_f : Definicje.TBudowla_Rodzaj; const tylko_test_f : boolean = false ) : boolean; overload;

    function Domek__Iloœæ__Odczytaj__Do( const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj ) : integer;
    procedure Domek__Iloœæ__Zmniejsz__Do( const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj );
    function Domek__Iloœæ__Zwiêksz__Do( const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj; const tylko_test_f : boolean = false ) : boolean;

    function Domek__Surowiec__Odczytaj__Do( const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj ) : integer;

    function Dominium__Numer__Odczytaj__Do() : integer;

    function Jednostka__Zakup__Jedn¹__Do( const jednostka_typ_f : Definicje.TJednostka_Typ; const tylko_test_f : boolean = false ) : boolean;
    function Jednostki__Nie_Kupuje__Odczytaj__Do() : boolean;
    function Jednostki__Obszar__Wielkoœæ__Odczytaj__Do() : integer;
    function Jednostki__Obszar__Wolny__Dostêpnoœæ__SprawdŸ__Do() : boolean;
    function Jednostki__Obszar__Wolny__Zakup__Do( const tylko_test_f : boolean = false ) : boolean; overload;
    function Jednostki__Obszar__Wolny__Zakup__Do( out surowiec__iloœæ__kryszta³_f, surowiec__iloœæ__magma_f : integer; const tylko_test_f : boolean = false ) : boolean; overload;
    function Jednostki__Po³¹cz__Do( const jednostka_typ_f : Definicje.TJednostka_Typ; const tylko_test_f : boolean = false ) : boolean; overload;
    function Jednostki__Po³¹cz__Do( const jednostka_typ_f : Definicje.TJednostka_Typ; out surowiec__iloœæ__¿ywio³_f : integer; const tylko_test_f : boolean = false ) : boolean; overload;
    function Jednostki__Po³¹cz__Jednostki__Dostêpne__Do( const jednostka_typ_f : Definicje.TJednostka_Typ ) : boolean;
    function Jednostki__Po³¹cz__Surowce__Wystarczy__Do( const jednostka_typ_f : Definicje.TJednostka_Typ ) : boolean;
    procedure Jednostki__Starcie__Przygotuj__Do( var jednostki_t_f : Jednostka.TJednostki_t );
    procedure Jednostki__Zakup__Wiele__Do();

    function Strategia_Typ__Odczytaj__Do() : Definicje.TStrategia_Typ;

    function Surowce__Oszczêdzanie_Przed_Bitw¹__Wspó³czynnik__Odczytaj__Do() : real;
    procedure Surowce__Produkcja_Przelicz__Do();

    function Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Do() : integer;
    procedure Wytrzyma³oœæ_Punkty__Wartoœæ__Zmniejsz__Do();

    function Zamek__Zburzony__Odczytaj__Do() : boolean;
    procedure Zamek__Zburzony__Zburz__Do();
  end;//---//TDominium = class

const
  surowiec__iloœæ__pocz¹tkowa_c : integer = 100;
  surowiec__produkcja_wspó³czynnik__podstawowy_wartoœæ_c : real = 0.7;

implementation

constructor TDominium.Create( const dominium__numer_f : smallint; const dominium__wytrzyma³oœæ_punkty_f : integer; const gracz_f : Gracz.TGracz );
var
  i,
  zti
    : integer;
begin

  Self.atak__wspó³czynnik__do := gracz_f.Atak__Wspó³czynnik__Odczytaj__Gr();
  Self.dominium__numer__do := dominium__numer_f;
  SetLength( Self.jednostki_t, 1 );
  Self.jednostki_t[ 0 ] := Jednostka.TJednostka.Create( 0 );
  Self.obrona__wspó³czynnik__do := gracz_f.Obrona__Wspó³czynnik__Odczytaj__Gr();
  Self.obserwacja__zasiêg_wspó³czynnik__do := gracz_f.Obserwacja__Zasiêg_Wspó³czynnik__Odczytaj__Gr();
  Self.strategia_typ__do := gracz_f.Strategia_Typ__Odczytaj__Gr();

  if not ( Self.Strategia_Typ__Odczytaj__Do() in [ Definicje.st_agresywna_bardzo, Definicje.st_agresywna ] ) then
    Self.jednostki__nie_kupuje__do := false
  else//if not ( Self.Strategia_Typ__Odczytaj__Do() in [ Definicje.st_agresywna_bardzo, Definicje.st_agresywna ] ) then
    begin

      if Self.Strategia_Typ__Odczytaj__Do() = Definicje.st_agresywna_bardzo then
        Self.jednostki__nie_kupuje__do := Random( 10 ) >= 2
      else//if Self.Strategia_Typ__Odczytaj__Do() = Definicje.st_agresywna_bardzo then
        Self.jednostki__nie_kupuje__do := Random( 10 ) < 2

    end;
  //---//if not ( Self.Strategia_Typ__Odczytaj__Do() in [ Definicje.st_agresywna_bardzo, Definicje.st_agresywna ] ) then

  Self.surowce__oszczêdzanie_przed_bitw¹__wspó³czynnik__do := 60 + Random( 41 );
  Self.surowiec__produkcja_wspó³czynnik__do := gracz_f.Surowiec__Produkcja__Wspó³czynnik__Odczytaj__Gr();
  Self.surowiec__produkcja_wspó³czynnik__skumulowany__do := 0;
  Self.wytrzyma³oœæ_punkty__do := dominium__wytrzyma³oœæ_punkty_f;
  Self.zamek__produkcja_wspó³czynnik__do := gracz_f.Zamek__Produkcja__Wspó³czynnik__Odczytaj__Gr();
  Self.zamek__produkcja_wspó³czynnik__skumulowany__indeks := Ord(  Low( Definicje.TSurowiec_Rodzaj )  );
  Self.zamek__zburzony__do := false;

  Self.jednostki_t[ 0 ].Wspó³czynniki__Zmieñ__Je( Self.atak__wspó³czynnik__do, Self.obrona__wspó³czynnik__do );

  SetLength(   Self.surowce_zasoby_t, Ord(  High( Definicje.TSurowiec_Rodzaj )  ) + 1   );
  SetLength(  Self.zamek__produkcja_wspó³czynnik__skumulowany_t, Length( Self.surowce_zasoby_t )  );

  zti := 0;

  for i := Ord(  Low( Definicje.TSurowiec_Rodzaj )  ) to Ord(  High( Definicje.TSurowiec_Rodzaj )  ) do
    begin

      Self.surowce_zasoby_t[ zti ].domki__iloœæ__sz := 0;
      Self.surowce_zasoby_t[ zti ].surowiec__produkcja_wspó³czynnik__skumulowany__sz := 0;
      Self.surowce_zasoby_t[ zti ].surowiec__rodzaj__sz := Definicje.TSurowiec_Rodzaj(i);

      //if Self.surowce_zasoby_t[ zti ].surowiec__rodzaj__sz in [ Definicje.sr_kryszta³ ] then
      //  Self.surowce_zasoby_t[ zti ].surowiec__iloœæ__sz := Dominium.surowiec__iloœæ__pocz¹tkowa_c
      //else
      //if Self.surowce_zasoby_t[ zti ].surowiec__rodzaj__sz in [ Definicje.sr_magma ] then
      //  Self.surowce_zasoby_t[ zti ].surowiec__iloœæ__sz := Round( Dominium.surowiec__iloœæ__pocz¹tkowa_c * 0.17 )
      //else
      //if Self.surowce_zasoby_t[ zti ].surowiec__rodzaj__sz in [ Definicje.sr_woda ] then
      //  Self.surowce_zasoby_t[ zti ].surowiec__iloœæ__sz := Round( Dominium.surowiec__iloœæ__pocz¹tkowa_c * 0.34 )
      //else
      //  Self.surowce_zasoby_t[ zti ].surowiec__iloœæ__sz := 0;
      if Self.surowce_zasoby_t[ zti ].surowiec__rodzaj__sz in [ Definicje.sr_kryszta³ ] then
        Self.surowce_zasoby_t[ zti ].surowiec__iloœæ__sz := Dominium.surowiec__iloœæ__pocz¹tkowa_c
      else
        Self.surowce_zasoby_t[ zti ].surowiec__iloœæ__sz := 0;

      Self.zamek__produkcja_wspó³czynnik__skumulowany_t[ zti ] := 0;


      inc( zti );

    end;
  //---//for i := Ord(  Low( Definicje.TSurowiec_Rodzaj )  ) to Ord(  High( Definicje.TSurowiec_Rodzaj )  ) do

end;//---//Konstruktor klasy TDominium.

destructor TDominium.Destroy();
var
  i : integer;
begin

  SetLength( Self.surowce_zasoby_t, 0 );
  SetLength( Self.zamek__produkcja_wspó³czynnik__skumulowany_t, 0 );

  for i := Length( Self.jednostki_t ) - 1 downto 0 do
    System.SysUtils.FreeAndNil( Self.jednostki_t[ i ] );

  SetLength( Self.jednostki_t, 0 );

end;//---//Destruktor klasy TDominium.

function TDominium.Budowla__Surowce__Zmniejsz__Zbuduj__Do( const budowla_rodzaj_f : Definicje.TBudowla_Rodzaj; iloœæ_f : integer ) : boolean;
begin

  if iloœæ_f <= 0 then
    iloœæ_f := 1;

  Result := Self.Budowla__Surowce__Zmniejsz__Zbuduj__Do( budowla_rodzaj_f, iloœæ_f, true );

end;//---//Funkcja Budowla__Surowce__Zmniejsz__Zbuduj__Do().

function TDominium.Budowla__Surowce__Zmniejsz__Zbuduj__Do( const budowla_rodzaj_f : Definicje.TBudowla_Rodzaj; const tylko_test_f : boolean = false ) : boolean;
begin

  Result := Self.Budowla__Surowce__Zmniejsz__Zbuduj__Do( budowla_rodzaj_f, 1, tylko_test_f );

end;//---//Funkcja Budowla__Surowce__Zmniejsz__Zbuduj__Do().

function TDominium.Budowla__Surowce__Zmniejsz__Zbuduj__Do( const budowla_rodzaj_f : Definicje.TBudowla_Rodzaj; iloœæ_f : integer; const tylko_test_f : boolean = false ) : boolean;
begin

  if iloœæ_f <= 0 then
    iloœæ_f := 1;


  if   (
             ( budowla_rodzaj_f = Definicje.br_domek )
         and (  Self.Domek__Surowiec__Odczytaj__Do( Definicje.sr_kryszta³ ) >= Definicje.budowa__koszt__domek_c * iloœæ_f  )
       )
    or (
             ( budowla_rodzaj_f = Definicje.br_koszary )
         and (  Self.Domek__Surowiec__Odczytaj__Do( Definicje.sr_kryszta³ ) >= Definicje.budowa__koszt__wie¿a__obronna_c * iloœæ_f  )
         and (  Self.Domek__Surowiec__Odczytaj__Do( Definicje.sr_magma ) >= Definicje.budowa__koszt__wie¿a__obronna_c * iloœæ_f  )
       )
    or (
             ( budowla_rodzaj_f = Definicje.br_wie¿a__obronna )
         and (  Self.Domek__Surowiec__Odczytaj__Do( Definicje.sr_magma ) >= Definicje.budowa__koszt__wie¿a__obronna_c * iloœæ_f  )
       )
    or (
             ( budowla_rodzaj_f = Definicje.br_wie¿a__zwiadowcza )
         and (  Self.Domek__Surowiec__Odczytaj__Do( Definicje.sr_kryszta³ ) >= Definicje.budowa__koszt__wie¿a__zwiadowcza_c * iloœæ_f  )
       ) then
    Result := true
  else//if   ( (...)
    Result := false;


  if    ( Result )
    and ( not tylko_test_f ) then
    begin

      if budowla_rodzaj_f = Definicje.br_domek then
        Self.Domek__Surowiec__Zmniejsz__Do( Definicje.sr_kryszta³, Definicje.budowa__koszt__domek_c )
      else
      if budowla_rodzaj_f = Definicje.br_koszary then
        begin

          Self.Domek__Surowiec__Zmniejsz__Do( Definicje.sr_kryszta³, Definicje.budowa__koszt__wie¿a__obronna_c );
          Self.Domek__Surowiec__Zmniejsz__Do( Definicje.sr_magma, Definicje.budowa__koszt__wie¿a__obronna_c );

        end
      else//if budowla_rodzaj_f = Definicje.br_koszary then
      if budowla_rodzaj_f = Definicje.br_wie¿a__obronna then
        Self.Domek__Surowiec__Zmniejsz__Do( Definicje.sr_magma, Definicje.budowa__koszt__wie¿a__obronna_c )
      else
      if budowla_rodzaj_f = Definicje.br_wie¿a__zwiadowcza then
        Self.Domek__Surowiec__Zmniejsz__Do( Definicje.sr_kryszta³, Definicje.budowa__koszt__wie¿a__zwiadowcza_c );

    end;
  //---//if    ( Result ) (...)

end;//---//Funkcja Budowla__Surowce__Zmniejsz__Zbuduj__Do().

function TDominium.Domek__Iloœæ__Odczytaj__Do( const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj ) : integer;
var
  i : integer;
begin

  Result := 0;


  for i := 0 to Length( Self.surowce_zasoby_t ) - 1 do
    if Self.surowce_zasoby_t[ i ].surowiec__rodzaj__sz = surowiec__rodzaj_f then
      begin

        Result := Self.surowce_zasoby_t[ i ].domki__iloœæ__sz;


        Break;

      end;
    //---//if Self.surowce_zasoby_t[ i ].surowiec__rodzaj__sz = surowiec__rodzaj_f then

end;//---//Funkcja Domek__Iloœæ__Odczytaj__Do().

procedure TDominium.Domek__Iloœæ__Zmniejsz__Do( const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj );
var
  i : integer;
begin

  for i := 0 to Length( Self.surowce_zasoby_t ) - 1 do
    if    ( Self.surowce_zasoby_t[ i ].surowiec__rodzaj__sz = surowiec__rodzaj_f )
      and ( Self.surowce_zasoby_t[ i ].domki__iloœæ__sz > 0 ) then
      begin

        dec( Self.surowce_zasoby_t[ i ].domki__iloœæ__sz );

        if Self.surowce_zasoby_t[ i ].domki__iloœæ__sz < 0 then
          Self.surowce_zasoby_t[ i ].domki__iloœæ__sz := 0;


        Break;

      end;
    //---//if Self.surowce_zasoby_t[ i ].surowiec__rodzaj__sz = surowiec__rodzaj_f then

end;//---//Funkcja Domek__Iloœæ__Zmniejsz__Do().

function TDominium.Domek__Iloœæ__Zwiêksz__Do( const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj; const tylko_test_f : boolean = false ) : boolean;
var
  i : integer;
begin

  Result := Self.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_domek, true );


  if    ( Result )
    and ( not tylko_test_f ) then
    begin

      Self.Budowla__Surowce__Zmniejsz__Zbuduj__Do( Definicje.br_domek );


      for i := 0 to Length( Self.surowce_zasoby_t ) - 1 do
        if Self.surowce_zasoby_t[ i ].surowiec__rodzaj__sz = surowiec__rodzaj_f then
          begin

            inc( Self.surowce_zasoby_t[ i ].domki__iloœæ__sz );


            Break;

          end;
        //---//if Self.surowce_zasoby_t[ i ].surowiec__rodzaj__sz = surowiec__rodzaj_f then

    end;
  //---//if    ( Result ) (...)

end;//---//Funkcja Domek__Iloœæ__Zwiêksz__Do().

function TDominium.Domek__Surowiec__Odczytaj__Do( const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj ) : integer;
var
  i : integer;
begin

  Result := 0;


  if Self.Zamek__Zburzony__Odczytaj__Do() then
    Exit;


  for i := 0 to Length( Self.surowce_zasoby_t ) - 1 do
    if Self.surowce_zasoby_t[ i ].surowiec__rodzaj__sz = surowiec__rodzaj_f then
      begin

        Result := Self.surowce_zasoby_t[ i ].surowiec__iloœæ__sz;


        Break;

      end;
    //---//if Self.surowce_zasoby_t[ i ].surowiec__rodzaj__sz = surowiec__rodzaj_f then

end;//---//Funkcja Domek__Surowiec__Odczytaj__Do().

procedure TDominium.Domek__Surowiec__Zmniejsz__Do( const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj; const wartoœæ_f : integer );
var
  i : integer;
begin

  for i := 0 to Length( Self.surowce_zasoby_t ) - 1 do
    if Self.surowce_zasoby_t[ i ].surowiec__rodzaj__sz = surowiec__rodzaj_f then
      begin

        Self.surowce_zasoby_t[ i ].surowiec__iloœæ__sz := Self.surowce_zasoby_t[ i ].surowiec__iloœæ__sz
          - System.Abs( wartoœæ_f );

        if Self.surowce_zasoby_t[ i ].surowiec__iloœæ__sz <= 0 then
          Self.surowce_zasoby_t[ i ].surowiec__iloœæ__sz := 0;


        Break;

      end;
    //---//if Self.surowce_zasoby_t[ i ].surowiec__rodzaj__sz = surowiec__rodzaj_f then

end;//---//Funkcja Domek__Surowiec__Zmniejsz__Do().

function TDominium.Dominium__Numer__Odczytaj__Do() : integer;
begin

  Result := Self.dominium__numer__do;

end;//---//Funkcja Dominium__Numer__Odczytaj__Do().

function TDominium.Jednostka__Zakup__Jedn¹__Do( const jednostka_typ_f : Definicje.TJednostka_Typ; const tylko_test_f : boolean = false ) : boolean;
var
  i,
  zti
    : integer;
begin

  Result := false;


  zti := Definicje.jednostka__koszt__zakup_c;

  if Self.Domek__Surowiec__Odczytaj__Do( Definicje.sr_woda ) < zti then
    Exit;


  if    ( jednostka_typ_f = Definicje.jt_jazda )
    and (  Self.Domek__Surowiec__Odczytaj__Do( Definicje.sr_kwiatki ) < zti * 2  ) then
    Exit;


  if tylko_test_f then
    begin

      Result := true;

      Exit;

    end;
  //---//if tylko_test_f then


  for i := 0 to Length( Self.jednostki_t ) - 1 do
    if    ( Self.jednostki_t[ i ].Poziom__Odczytaj__Je() = Jednostka.jednostka__poziom__pusta_c )
      and ( Self.jednostki_t[ i ].Typ__Odczytaj__Je() = Definicje.jt_pusta ) then
      begin

        Result := true;


        Self.Domek__Surowiec__Zmniejsz__Do( Definicje.sr_woda, zti );

        if jednostka_typ_f = Definicje.jt_jazda then
          Self.Domek__Surowiec__Zmniejsz__Do( Definicje.sr_kwiatki, zti * 2 );


        Self.jednostki_t[ i ].Zakup__Je( jednostka_typ_f );


        Break;

      end;
    //---//if    ( Self.jednostki_t[ i ].Poziom__Odczytaj__Je() = Jednostka.jednostka__poziom__pusta_c ) (...)

end;//---//Funkcja Jednostka__Zakup__Jedn¹__Do().

function TDominium.Jednostki__Obszar__Wolny__Dostêpnoœæ__SprawdŸ__Do() : boolean;
var
  i : integer;
begin

  Result := false;


  for i := Length( Self.jednostki_t ) - 1 downto 0 do
    if Self.jednostki_t[ i ].Obszar__Wolny__Dostêpnoœæ__SprawdŸ__Je() then
      begin

        Result := true;

        Break;

      end;
    //---//if Self.jednostki_t[ i ].Obszar__Wolny__Dostêpnoœæ__SprawdŸ__Je() then

end;//---//Funkcja Jednostki__Obszar__Wolny__Dostêpnoœæ__SprawdŸ__Do().

function TDominium.Jednostki__Nie_Kupuje__Odczytaj__Do() : boolean;
begin

  Result := Self.jednostki__nie_kupuje__do;

end;//---//Funkcja Jednostki__Nie_Kupuje__Odczytaj__Do().

function TDominium.Jednostki__Obszar__Wielkoœæ__Odczytaj__Do() : integer;
begin

  Result := Length( Self.jednostki_t );

end;//---//Funkcja Jednostki__Obszar__Wielkoœæ__Odczytaj__Do().

function TDominium.Jednostki__Obszar__Wolny__Zakup__Do( const tylko_test_f : boolean = false ) : boolean;
var
  surowiec__iloœæ__kryszta³_l, // Tylko aby wywo³aæ funkcjê.
  surowiec__iloœæ__magma_l // Tylko aby wywo³aæ funkcjê.
    : integer;
begin

  Result := Self.Jednostki__Obszar__Wolny__Zakup__Do( surowiec__iloœæ__kryszta³_l, surowiec__iloœæ__magma_l, tylko_test_f );

end;//---//Funkcja Jednostki__Obszar__Wolny__Zakup__Do().

function TDominium.Jednostki__Obszar__Wolny__Zakup__Do( out surowiec__iloœæ__kryszta³_f, surowiec__iloœæ__magma_f : integer; const tylko_test_f : boolean = false ) : boolean;
var
  i,
  zti
    : integer;
begin

  // 5k 5m -> 8 10 13 15 18 20

  Result := false;


  zti := Definicje.jednostka__koszt__obszar__zakup_c;

  for i := 2 to Length( Self.jednostki_t ) do
    begin

      zti := zti + 2;

      if ( i mod 2 ) = 0 then
        zti := zti + 1;

    end;
  //---//for i := 2 to Length( Self.jednostki_t ) do


  surowiec__iloœæ__kryszta³_f := zti;
  surowiec__iloœæ__magma_f := zti;


  if   (  Self.Domek__Surowiec__Odczytaj__Do( Definicje.sr_kryszta³ ) < zti  )
    or (  Self.Domek__Surowiec__Odczytaj__Do( Definicje.sr_magma ) < zti  ) then
    Exit;


  Result := true;


  if tylko_test_f then
    Exit;


  Self.Domek__Surowiec__Zmniejsz__Do( Definicje.sr_kryszta³, zti );
  Self.Domek__Surowiec__Zmniejsz__Do( Definicje.sr_magma, zti );


  zti := Length( Self.jednostki_t );
  SetLength( Self.jednostki_t, zti + 1 );

  Self.jednostki_t[ zti ] := Jednostka.TJednostka.Create( zti );
  Self.jednostki_t[ zti ].Wspó³czynniki__Zmieñ__Je( Self.atak__wspó³czynnik__do, Self.obrona__wspó³czynnik__do );

end;//---//Funkcja Jednostki__Obszar__Wolny__Zakup__Do().

function TDominium.Jednostki__Po³¹cz__Do( const jednostka_typ_f : Definicje.TJednostka_Typ; const tylko_test_f : boolean = false ) : boolean;
var
  surowiec__iloœæ__¿ywio³_l : integer; // Tylko aby wywo³aæ funkcjê.
begin

  Result := Self.Jednostki__Po³¹cz__Do( jednostka_typ_f, surowiec__iloœæ__¿ywio³_l, tylko_test_f );

end;//---//Funkcja Jednostki__Po³¹cz__Do().

function TDominium.Jednostki__Po³¹cz__Do( const jednostka_typ_f : Definicje.TJednostka_Typ; out surowiec__iloœæ__¿ywio³_f : integer; const tylko_test_f : boolean = false ) : boolean;
var
  i,
  j,
  zti
    : integer;

  jednostka_l : Jednostka.TJednostka;
begin

  Result := false;


  zti := Self.Jednostki__Po³¹cz__Koszt__Do( jednostka_typ_f );

  surowiec__iloœæ__¿ywio³_f := zti;


  if not Self.Jednostki__Po³¹cz__Surowce__Wystarczy__Do( jednostka_typ_f ) then
    Exit;


  for i := 0 to Length( Self.jednostki_t ) - 2 do
    begin

      for j := i + 1 to Length( Self.jednostki_t ) - 1 do
        if    ( Self.jednostki_t[ i ].Poziom__Odczytaj__Je() <> Jednostka.jednostka__poziom__pusta_c )
          and ( Self.jednostki_t[ i ].Typ__Odczytaj__Je() <> Definicje.jt_pusta )
          and ( Self.jednostki_t[ i ].Typ__Odczytaj__Je() = jednostka_typ_f  )
          and ( Self.jednostki_t[ i ].Poziom__Odczytaj__Je() = Self.jednostki_t[ j ].Poziom__Odczytaj__Je() )
          and ( Self.jednostki_t[ i ].Broñ_Rodzaj__Odczytaj__Je() = Self.jednostki_t[ j ].Broñ_Rodzaj__Odczytaj__Je() )
          and ( Self.jednostki_t[ i ].Typ__Odczytaj__Je() = Self.jednostki_t[ j ].Typ__Odczytaj__Je() ) then
          begin

            Result := true;


            if tylko_test_f then
              Exit;


            Self.Domek__Surowiec__Zmniejsz__Do( Definicje.sr_¿ywio³, zti );

            Self.jednostki_t[ i ].Poziom__Zwiêksz__Je();

            Self.jednostki_t[ j ].Obszar__Wolny__Ustaw__Je();

            Break;

          end;
        //---//if    ( Self.jednostki_t[ i ].Poziom__Odczytaj__Je() <> Jednostka.jednostka__poziom__pusta_c ) (...)


      if Result then
        Break;

    end;
  //---//for i := 0 to Length( Self.jednostki_t ) - 2 do



  zti := 1;

  while zti = 1 do
    begin

      zti := 0;

      for i := 0 to Length( Self.jednostki_t ) - 2 do
        begin

          if    ( Self.jednostki_t[ i ].Typ__Odczytaj__Je() = Definicje.jt_pusta )
            and ( Self.jednostki_t[ i + 1 ].Typ__Odczytaj__Je() <> Definicje.jt_pusta  ) then
            begin

              zti := 1;


              jednostka_l := Self.jednostki_t[ i ];
              Self.jednostki_t[ i ] := Self.jednostki_t[ i + 1 ];
              Self.jednostki_t[ i + 1 ] := jednostka_l;

              Break;

            end;
          //---//if    ( Self.jednostki_t[ i ].Typ__Odczytaj__Je() = Definicje.jt_pusta ) (...)

        end;
      //---//while zti = 1 do

    end;
  //---//for i := 0 to Length( Self.jednostki_t ) - 2 do

end;//---//Funkcja Jednostki__Po³¹cz__Do().

function TDominium.Jednostki__Po³¹cz__Jednostki__Dostêpne__Do( const jednostka_typ_f : Definicje.TJednostka_Typ ) : boolean;
var
  i,
  j
    : integer;
begin

  Result := false;


  for i := 0 to Length( Self.jednostki_t ) - 2 do
    for j := i + 1 to Length( Self.jednostki_t ) - 1 do
      if    ( Self.jednostki_t[ i ].Poziom__Odczytaj__Je() <> Jednostka.jednostka__poziom__pusta_c )
        and ( Self.jednostki_t[ i ].Typ__Odczytaj__Je() <> Definicje.jt_pusta )
        and (
                 ( jednostka_typ_f = Definicje.jt_pusta )
              or ( Self.jednostki_t[ i ].Typ__Odczytaj__Je() = jednostka_typ_f  )
            )
        and ( Self.jednostki_t[ i ].Poziom__Odczytaj__Je() = Self.jednostki_t[ j ].Poziom__Odczytaj__Je() )
        and ( Self.jednostki_t[ i ].Broñ_Rodzaj__Odczytaj__Je() = Self.jednostki_t[ j ].Broñ_Rodzaj__Odczytaj__Je() )
        and ( Self.jednostki_t[ i ].Typ__Odczytaj__Je() = Self.jednostki_t[ j ].Typ__Odczytaj__Je() ) then
        begin

          Result := true;

          Exit;

        end;
      //---//if    ( Self.jednostki_t[ i ].Poziom__Odczytaj__Je() <> Jednostka.jednostka__poziom__pusta_c ) (...)

end;//---//Funkcja Jednostki__Po³¹cz__Jednostki__Dostêpne__Do().

function TDominium.Jednostki__Po³¹cz__Koszt__Do( const jednostka_typ_f : Definicje.TJednostka_Typ ) : integer;
begin

  Result := Definicje.jednostka__koszt__po³¹czenie_c;

  if jednostka_typ_f = Definicje.jt_jazda then
    Result := Result
      * 2;

end;//---//Funkcja Jednostki__Po³¹cz__Koszt__Do().

function TDominium.Jednostki__Po³¹cz__Surowce__Wystarczy__Do( const jednostka_typ_f : Definicje.TJednostka_Typ ) : boolean;
begin

  Result := Self.Domek__Surowiec__Odczytaj__Do( Definicje.sr_¿ywio³ ) >= Self.Jednostki__Po³¹cz__Koszt__Do( jednostka_typ_f );

end;//---//Funkcja Jednostki__Po³¹cz__Surowce__Wystarczy__Do().

procedure TDominium.Jednostki__Starcie__Przygotuj__Do( var jednostki_t_f : Jednostka.TJednostki_t );
var
  i : integer;
begin

  SetLength(  jednostki_t_f, Length( Self.jednostki_t )  );

  for i := 0 to Length( Self.jednostki_t ) - 1 do
    begin

      jednostki_t_f[ i ] := Jednostka.TJednostka.Create( Definicje.identyfikator_pusty_c );
      jednostki_t_f[ i ].Kopiuj_Wartoœci_Z_Obiektu_Klasy( Self.jednostki_t[ i ] );
      jednostki_t_f[ i ].Starcie__Przygotuj__Je();

    end;
  //---//for i := 0 to Length( Self.jednostki_t ) - 1 do

end;//---//Funkcja Jednostki__Starcie__Przygotuj__Do().

procedure TDominium.Jednostki__Zakup__Wiele__Do();

  //Funkcja Zakup_Decyzja() w Jednostki__Zakup__Wiele__Do().
  function Zakup_Decyzja() : boolean;
  begin

    Result := false;


    if Self.Jednostki__Po³¹cz__Do( Definicje.jt_jazda ) then
      begin

        Result := true;

        Exit;

      end;
    //---//if Self.Jednostki__Po³¹cz__Do( Definicje.jt_jazda ) then

    if Self.Jednostki__Po³¹cz__Do( Definicje.jt_piechota ) then
      begin

        Result := true;

        Exit;

      end;
    //---//if Self.Jednostki__Po³¹cz__Do( Definicje.jt_piechota ) then


    if    (  Self.Jednostka__Zakup__Jedn¹__Do( Definicje.jt_pusta, true )  )
      and ( not Self.Jednostki__Obszar__Wolny__Dostêpnoœæ__SprawdŸ__Do() )
      and (  Self.Jednostki__Obszar__Wolny__Zakup__Do( true )  ) then
      begin

        Self.Jednostki__Obszar__Wolny__Zakup__Do();

        Result := true;

        Exit;

      end;
    //---//if    (  Self.Jednostka__Zakup__Jedn¹__Do( Definicje.jt_pusta, true )  ) (...)


    if    ( Self.Jednostki__Obszar__Wolny__Dostêpnoœæ__SprawdŸ__Do() )
      and (  Self.Jednostka__Zakup__Jedn¹__Do( Definicje.jt_jazda, true )  ) then
      begin

        Self.Jednostka__Zakup__Jedn¹__Do( Definicje.jt_jazda );

        Result := true;

        Exit;

      end;
    //---//if    ( Self.Jednostki__Obszar__Wolny__Dostêpnoœæ__SprawdŸ__Do() ) (...)

    if    ( Self.Jednostki__Obszar__Wolny__Dostêpnoœæ__SprawdŸ__Do() )
      and (  Self.Jednostka__Zakup__Jedn¹__Do( Definicje.jt_piechota, true )  ) then
      begin

        Self.Jednostka__Zakup__Jedn¹__Do( Definicje.jt_piechota );

        Result := true;

        Exit;

      end;
    //---//if    ( Self.Jednostki__Obszar__Wolny__Dostêpnoœæ__SprawdŸ__Do() ) (...)

  end;//---//Funkcja Zakup_Decyzja() w Jednostki__Zakup__Wiele__Do().

begin//Funkcja Jednostki__Zakup__Wiele__Do().

  while Zakup_Decyzja() do
    ;

end;//---//Funkcja Jednostki__Zakup__Wiele__Do().

function TDominium.Strategia_Typ__Odczytaj__Do() : Definicje.TStrategia_Typ;
begin

  Result := Self.strategia_typ__do;

end;//---//Funkcja Strategia_Typ__Odczytaj__Do().

function TDominium.Surowce__Oszczêdzanie_Przed_Bitw¹__Wspó³czynnik__Odczytaj__Do() : real;
begin

  Result := Self.surowce__oszczêdzanie_przed_bitw¹__wspó³czynnik__do * 0.01;

end;//---//Funkcja Surowce__Oszczêdzanie_Przed_Bitw¹__Wspó³czynnik__Odczytaj__Do().

procedure TDominium.Surowce__Produkcja_Przelicz__Do();

  //Funkcja Produkcja_Wspó³czynnik__Skumulowany__Wy³uskaj() w Surowce__Produkcja_Przelicz__Do().
  function Produkcja_Wspó³czynnik__Skumulowany__Wy³uskaj( var produkcja_wspó³czynnik__skumulowany_f : real ) : integer;
  begin

    Result := System.Math.Floor( produkcja_wspó³czynnik__skumulowany_f );


    if Result >= 1 then
      begin

        produkcja_wspó³czynnik__skumulowany_f := produkcja_wspó³czynnik__skumulowany_f
          - Result;

        if produkcja_wspó³czynnik__skumulowany_f < 0 then
          produkcja_wspó³czynnik__skumulowany_f := 0;

      end;
    //---//if Result >= 1 then

  end;//---//Funkcja Produkcja_Wspó³czynnik__Skumulowany__Wy³uskaj() w Surowce__Produkcja_Przelicz__Do().

var
  i : integer;
begin//Funkcja Surowce__Produkcja_Przelicz__Do().

  Self.zamek__produkcja_wspó³czynnik__skumulowany_t[ Self.zamek__produkcja_wspó³czynnik__skumulowany__indeks ] := Self.zamek__produkcja_wspó³czynnik__skumulowany_t[ Self.zamek__produkcja_wspó³czynnik__skumulowany__indeks ]
    + Dominium.surowiec__produkcja_wspó³czynnik__podstawowy_wartoœæ_c
    * 2
    * Self.zamek__produkcja_wspó³czynnik__do;

  inc( Self.zamek__produkcja_wspó³czynnik__skumulowany__indeks );

  if Self.zamek__produkcja_wspó³czynnik__skumulowany__indeks > Ord(  High( Definicje.TSurowiec_Rodzaj )  ) then
    Self.zamek__produkcja_wspó³czynnik__skumulowany__indeks := Ord(  Low( Definicje.TSurowiec_Rodzaj )  );


  for i := 0 to Length( Self.surowce_zasoby_t ) - 1 do
    begin

      Self.surowce_zasoby_t[ i ].surowiec__produkcja_wspó³czynnik__skumulowany__sz := Self.surowce_zasoby_t[ i ].surowiec__produkcja_wspó³czynnik__skumulowany__sz
        + Dominium.surowiec__produkcja_wspó³czynnik__podstawowy_wartoœæ_c
        * Self.surowiec__produkcja_wspó³czynnik__do
        * Self.surowce_zasoby_t[ i ].domki__iloœæ__sz;


      Self.surowce_zasoby_t[ i ].surowiec__iloœæ__sz := Self.surowce_zasoby_t[ i ].surowiec__iloœæ__sz
        + Produkcja_Wspó³czynnik__Skumulowany__Wy³uskaj( Self.surowce_zasoby_t[ i ].surowiec__produkcja_wspó³czynnik__skumulowany__sz )
        + Produkcja_Wspó³czynnik__Skumulowany__Wy³uskaj( Self.zamek__produkcja_wspó³czynnik__skumulowany_t[ i ] );

    end;
  //---//for i := 0 to Length( Self.surowce_zasoby_t ) - 1 do

end;//---//Funkcja Surowce__Produkcja_Przelicz__Do().

function TDominium.Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Do() : integer;
begin

  Result := Self.wytrzyma³oœæ_punkty__do;

end;//---//Funkcja Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Do().

procedure TDominium.Wytrzyma³oœæ_Punkty__Wartoœæ__Zmniejsz__Do();
begin

  Self.wytrzyma³oœæ_punkty__do := Self.wytrzyma³oœæ_punkty__do - 1;

  if Self.wytrzyma³oœæ_punkty__do < 0 then
    Self.wytrzyma³oœæ_punkty__do := 0;

end;//---//Funkcja Wytrzyma³oœæ_Punkty__Wartoœæ__Zmniejsz__Do().

function TDominium.Zamek__Zburzony__Odczytaj__Do() : boolean;
begin

  Result := Self.zamek__zburzony__do;

end;//---//Funkcja Zamek__Zburzony__Odczytaj__Do().

procedure TDominium.Zamek__Zburzony__Zburz__Do();
begin

  Self.zamek__zburzony__do := true;

end;//---//Funkcja Zamek__Zburzony__Zburz__Do().

end.
