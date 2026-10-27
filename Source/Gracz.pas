unit Gracz;{06.Sie.2026}

interface

uses
  System.Math,
  System.SysUtils,

  Definicje;

type
  TGracz = class
  private
    { Private declarations }
    gra_gracz__gr,
    potyczka_odbyta__gr
      : boolean;

    gracz_id__gr,
    pora¿ki__iloœæ__gr,
    ranking__wartoœæ__gr,
    remisy__iloœæ__gr,
    rozbudowa__punkty__gr,
    zwyciêstwa__iloœæ__gr,
    zwyciêstwa__iloœæ__pod_rz¹d__gr
      : integer;

    strategia_typ__gr : Definicje.TStrategia_Typ;

    atak__wspó³czynnik__gr,
    obrona__wspó³czynnik__gr,
    obserwacja__zasiêg_wspó³czynnik__gr,
    surowiec__produkcja_wspó³czynnik__gr,
    zamek__produkcja_wspó³czynnik__gr
      : real;

    nazwa__gr : string;

    function Strategia_Typ__W__Napis__Gr( const strategia_typ_f : Definicje.TStrategia_Typ ) : string;

    function Wspó³czynnik__Wartoœæ_SprawdŸ__Gr( const wartoœæ_f : real ) : real; overload;
    function Wspó³czynnik__Wartoœæ_SprawdŸ__Gr( const wartoœæ_f : integer ) : integer; overload;
  public
    { Public declarations }
    constructor Create( const nazwa_f : string );

    function Gracz__Id__Odczytaj__Gr() : integer;
    procedure Gracz__Id__Zmieñ__Gr( const wartoœæ_f : integer );

    function Atak__Wspó³czynnik__Odczytaj__Gr() : real;
    procedure Atak__Wspó³czynnik__Zmieñ__Gr( const wartoœæ_f : real );
    procedure Atak__Wspó³czynnik__Zwiêksz__Gr( const wartoœæ_f : real );

    function Gra_Gracz__Odczytaj__Gr() : boolean;
    procedure Gra_Gracz__Zmieñ__Gr( const gra_gracz_f : boolean );

    function Nazwa__Odczytaj__Gr() : string;

    function Obrona__Wspó³czynnik__Odczytaj__Gr() : real;
    procedure Obrona__Wspó³czynnik__Zmieñ__Gr( const wartoœæ_f : real );
    procedure Obrona__Wspó³czynnik__Zwiêksz__Gr( const wartoœæ_f : real );

    function Obserwacja__Zasiêg_Wspó³czynnik__Odczytaj__Gr() : real;
    procedure Obserwacja__Zasiêg_Wspó³czynnik__Zmieñ__Gr( const wartoœæ_f : real );
    procedure Obserwacja__Zasiêg_Wspó³czynnik__Zwiêksz__Gr( const wartoœæ_f : real );

    function Parametry_Wyœwietl__Gr( const gra_okno_f : boolean = false ) : string;

    function Pora¿ki__Iloœæ__Odczytaj__Gr() : integer;
    procedure Pora¿ki__Iloœæ__Zmieñ__Gr( const wartoœæ_f : integer );
    procedure Pora¿ki__Iloœæ__Zwiêksz__Gr();

    function Potyczka_Odbyta__Odczytaj__Gr() : boolean;
    procedure Potyczka_Odbyta__Zmieñ__Gr( const potyczka_odbyta_f : boolean );

    function Ranking__Wartoœæ__Odczytaj__Gr() : integer;
    procedure Ranking__Wartoœæ__Zmniejsz__Gr();
    procedure Ranking__Wartoœæ__Zmieñ__Gr( const wartoœæ_f : integer );
    procedure Ranking__Wartoœæ__Zwiêksz__Gr( const ranking__wartoœæ__przeciwnik_f : integer = 0 );

    function Remisy__Iloœæ__Odczytaj__Gr() : integer;
    procedure Remisy__Iloœæ__Zmieñ__Gr( const wartoœæ_f : integer );
    procedure Remisy__Iloœæ__Zwiêksz__Gr();

    function Rozbudowa__Punkty__Odczytaj__Gr() : integer;
    procedure Rozbudowa__Punkty__Zmieñ__Gr( const wartoœæ_f : integer );
    procedure Rozbudowa__Punkty__Zmniejsz__Gr( const wartoœæ_f : integer );
    procedure Rozbudowa__Punkty__Zwiêksz__Gr();

    procedure Rozbuduj();

    function Strategia_Typ__Odczytaj__Gr() : Definicje.TStrategia_Typ;
    procedure Strategia_Typ__Zmieñ__Gr( const strategia_typ_f : integer );
    function Strategia_Typ__Napis__Odczytaj__Gr() : string;

    function Surowiec__Produkcja__Wspó³czynnik__Odczytaj__Gr() : real;
    procedure Surowiec__Produkcja__Wspó³czynnik__Zmieñ__Gr( const wartoœæ_f : real );
    procedure Surowiec__Produkcja__Wspó³czynnik__Zwiêksz__Gr( const wartoœæ_f : real );

    function Wspó³czynnik__Rozbuduj__Gr( const wspó³czynnik__rodzaj_f : Definicje.TGracz_Wspó³czynnik_Rodzaj; const tylko_test_f : boolean = false ) : boolean; overload;
    function Wspó³czynnik__Rozbuduj__Gr( const wspó³czynnik__rodzaj_f : Definicje.TGracz_Wspó³czynnik_Rodzaj; out wspó³czynnik__koszt_f : integer; const tylko_test_f : boolean = false ) : boolean; overload;

    function Zamek__Produkcja__Wspó³czynnik__Odczytaj__Gr() : real;
    procedure Zamek__Produkcja__Wspó³czynnik__Zmieñ__Gr( const wartoœæ_f : real );
    procedure Zamek__Produkcja__Wspó³czynnik__Zwiêksz__Gr( const wartoœæ_f : real );

    function Zwyciêstwa__Iloœæ__Odczytaj__Gr() : integer;
    procedure Zwyciêstwa__Iloœæ__Zmieñ__Gr( const wartoœæ_f : integer );
    procedure Zwyciêstwa__Iloœæ__Zwiêksz__Gr();

    function Zwyciêstwa__Iloœæ__Pod_Rz¹d__Odczytaj__Gr() : integer;
    procedure Zwyciêstwa__Iloœæ__Pod_Rz¹d__Zmieñ__Gr( const wartoœæ_f : integer );
    procedure Zwyciêstwa__Iloœæ__Pod_Rz¹d__Zmniejsz__Gr();
    procedure Zwyciêstwa__Iloœæ__Pod_Rz¹d__Zwiêksz__Gr();
  end;//---//TGracz = class

const
  ranking__wartoœæ__pora¿ka_zmiana_c : integer = -2;
  ranking__wartoœæ__zwyciêstwo__ró¿nica_poziomów_dodatek_wspó³czynnik_c : integer = 10;
  ranking__wartoœæ__zwyciêstwo_zmiana_c : integer = 3;
  rozbudowa__punkty__przyrost_c : integer = 1;
  rozbudowa__wspó³czynnik__koszt_c : integer = 10;
  rozbudowa__wspó³czynnik__przyrost_c : real = 0.1;

implementation

constructor TGracz.Create( const nazwa_f : string );
begin

  Self.atak__wspó³czynnik__gr := 1;
  Self.gra_gracz__gr := false;
  Self.gracz_id__gr := -1;
  Self.nazwa__gr := nazwa_f;
  Self.obrona__wspó³czynnik__gr := 1;
  Self.obserwacja__zasiêg_wspó³czynnik__gr := 1;
  Self.pora¿ki__iloœæ__gr := 0;
  Self.potyczka_odbyta__gr := false;
  Self.ranking__wartoœæ__gr := 0;
  Self.remisy__iloœæ__gr := 0;
  Self.rozbudowa__punkty__gr := 0;
  Self.strategia_typ__gr := Definicje.TStrategia_Typ(Random(   Ord(  High( Definicje.TStrategia_Typ )  ) + 1   ));
  Self.surowiec__produkcja_wspó³czynnik__gr := 1;
  Self.zamek__produkcja_wspó³czynnik__gr := 1;
  Self.zwyciêstwa__iloœæ__gr := 0;

end;//---//Konstruktor klasy TGracz.

function TGracz.Atak__Wspó³czynnik__Odczytaj__Gr() : real;
begin

  Result := Self.atak__wspó³czynnik__gr;

end;//---//Funkcja Atak__Wspó³czynnik__Odczytaj__Gr().

function TGracz.Gracz__Id__Odczytaj__Gr() : integer;
begin

  Result := Self.gracz_id__gr;

end;//---//Funkcja Gracz__Id__Odczytaj__Gr().

procedure TGracz.Gracz__Id__Zmieñ__Gr( const wartoœæ_f : integer );
begin

  Self.gracz_id__gr := wartoœæ_f;

end;//---//Funkcja Gracz__Id__Zmieñ__Gr().

procedure TGracz.Atak__Wspó³czynnik__Zmieñ__Gr( const wartoœæ_f : real );
begin

  Self.atak__wspó³czynnik__gr := Self.Wspó³czynnik__Wartoœæ_SprawdŸ__Gr( wartoœæ_f );

end;//---//Funkcja Atak__Wspó³czynnik__Zmieñ__Gr().

procedure TGracz.Atak__Wspó³czynnik__Zwiêksz__Gr( const wartoœæ_f : real );
begin

  Self.atak__wspó³czynnik__gr := Self.Wspó³czynnik__Wartoœæ_SprawdŸ__Gr( Self.atak__wspó³czynnik__gr + wartoœæ_f );

end;//---//Funkcja Atak__Wspó³czynnik__Zwiêksz__Gr().

function TGracz.Gra_Gracz__Odczytaj__Gr() : boolean;
begin

  Result := Self.gra_gracz__gr;

end;//---//Funkcja Gra_Gracz__Odczytaj__Gr().

procedure TGracz.Gra_Gracz__Zmieñ__Gr( const gra_gracz_f : boolean );
begin

  Self.gra_gracz__gr := gra_gracz_f

end;//---//Funkcja Gra_Gracz__Zmieñ__Gr().

function TGracz.Nazwa__Odczytaj__Gr() : string;
begin

  Result := Self.nazwa__gr;

end;//---//Funkcja Nazwa__Odczytaj__Gr().

function TGracz.Obrona__Wspó³czynnik__Odczytaj__Gr() : real;
begin

  Result := Self.obrona__wspó³czynnik__gr;

end;//---//Funkcja Obrona__Wspó³czynnik__Odczytaj__Gr().

procedure TGracz.Obrona__Wspó³czynnik__Zmieñ__Gr( const wartoœæ_f : real );
begin

  Self.obrona__wspó³czynnik__gr := Self.Wspó³czynnik__Wartoœæ_SprawdŸ__Gr( wartoœæ_f );

end;//---//Funkcja Obrona__Wspó³czynnik__Zmieñ__Gr().

procedure TGracz.Obrona__Wspó³czynnik__Zwiêksz__Gr( const wartoœæ_f : real );
begin

  Self.obrona__wspó³czynnik__gr := Self.Wspó³czynnik__Wartoœæ_SprawdŸ__Gr( Self.obrona__wspó³czynnik__gr + wartoœæ_f );

end;//---//Funkcja Obrona__Wspó³czynnik__Zwiêksz__Gr().

function TGracz.Obserwacja__Zasiêg_Wspó³czynnik__Odczytaj__Gr() : real;
begin

  Result := Self.obserwacja__zasiêg_wspó³czynnik__gr;

end;//---//Funkcja Obserwacja__Zasiêg_Wspó³czynnik__Odczytaj__Gr().

procedure TGracz.Obserwacja__Zasiêg_Wspó³czynnik__Zmieñ__Gr( const wartoœæ_f : real );
begin

  Self.obserwacja__zasiêg_wspó³czynnik__gr := Self.Wspó³czynnik__Wartoœæ_SprawdŸ__Gr( wartoœæ_f );

end;//---//Funkcja Obserwacja__Zasiêg_Wspó³czynnik__Zmieñ__Gr().

procedure TGracz.Obserwacja__Zasiêg_Wspó³czynnik__Zwiêksz__Gr( const wartoœæ_f : real );
begin

  Self.obserwacja__zasiêg_wspó³czynnik__gr := Self.Wspó³czynnik__Wartoœæ_SprawdŸ__Gr( Self.obserwacja__zasiêg_wspó³czynnik__gr + wartoœæ_f );

end;//---//Funkcja Obserwacja__Zasiêg_Wspó³czynnik__Zwiêksz__Gr().

function TGracz.Parametry_Wyœwietl__Gr( const gra_okno_f : boolean = false ) : string;

  //Funkcja Boolean__W__Tak_Nie() w Parametry_Wyœwietl__Gr().
  function Boolean__W__Tak_Nie( const wartoœæ_f : boolean ) : string;
  begin

    if wartoœæ_f then
      Result := 'tak'
    else//if wartoœæ_f then
      Result := 'nie';

  end;//---//Funkcja Boolean__W__Tak_Nie() w Parametry_Wyœwietl__Gr().

const
  nowa_linia_znak_c_l : string = #13#10;
begin//Funkcja Parametry_Wyœwietl__Gr().

  Result :=
    'gracz_id: ' + IntToStr( Self.Gracz__Id__Odczytaj__Gr() ) + nowa_linia_znak_c_l +
    'nazwa: ' + Self.nazwa__gr + nowa_linia_znak_c_l +
    'gra_gracz: ' + Boolean__W__Tak_Nie( Self.Gra_Gracz__Odczytaj__Gr() ) + nowa_linia_znak_c_l +
    'atak__wspó³czynnik: ' + Trim(  FormatFloat( '### ### ##0.0000', Self.Atak__Wspó³czynnik__Odczytaj__Gr() )  ) + nowa_linia_znak_c_l +
    'obrona__wspó³czynnik: ' + Trim(  FormatFloat( '### ### ##0.0000', Self.Obrona__Wspó³czynnik__Odczytaj__Gr() )  ) + nowa_linia_znak_c_l +
    'obserwacja__zasiêg_wspó³czynnik: ' + Trim(  FormatFloat( '### ### ##0.0000', Self.Obserwacja__Zasiêg_Wspó³czynnik__Odczytaj__Gr() )  ) + nowa_linia_znak_c_l +
    'pora¿ki__iloœæ: ' + Trim(  FormatFloat( '### ### ##0', Self.Pora¿ki__Iloœæ__Odczytaj__Gr() )  ) + nowa_linia_znak_c_l +
    'potyczka_odbyta: ' + Boolean__W__Tak_Nie( Self.Potyczka_Odbyta__Odczytaj__Gr() ) + nowa_linia_znak_c_l +
    'ranking__wartoœæ: ' + Trim(  FormatFloat( '### ### ##0', Self.Ranking__Wartoœæ__Odczytaj__Gr() )  ) + nowa_linia_znak_c_l +
    'remisy__iloœæ: ' + Trim(  FormatFloat( '### ### ##0', Self.Remisy__Iloœæ__Odczytaj__Gr() )  ) + nowa_linia_znak_c_l +
    'rozbudowa__punkty: ' + Trim(  FormatFloat( '### ### ##0', Self.Rozbudowa__Punkty__Odczytaj__Gr() )  ) + nowa_linia_znak_c_l +
    'strategia_typ: ' + Trim(  FormatFloat( '### ### ##0', integer(Self.Strategia_Typ__Odczytaj__Gr()) )  ) + ' (' + Self.Strategia_Typ__W__Napis__Gr( Self.Strategia_Typ__Odczytaj__Gr() ) + ')' + nowa_linia_znak_c_l +
    'surowiec__produkcja_wspó³czynnik: ' + Trim(  FormatFloat( '### ### ##0.0000', Self.Surowiec__Produkcja__Wspó³czynnik__Odczytaj__Gr() )  ) + nowa_linia_znak_c_l +
    'zamek__produkcja_wspó³czynnik: ' + Trim(  FormatFloat( '### ### ##0.0000', Self.Zamek__Produkcja__Wspó³czynnik__Odczytaj__Gr() )  ) + nowa_linia_znak_c_l +
    'zwyciêstwa__iloœæ: ' + Trim(  FormatFloat( '### ### ##0', Self.Zwyciêstwa__Iloœæ__Odczytaj__Gr() )  ) + nowa_linia_znak_c_l +
    'zwyciêstwa__iloœæ__pod_rz¹d: ' + Trim(  FormatFloat( '### ### ##0', Self.Zwyciêstwa__Iloœæ__Pod_Rz¹d__Odczytaj__Gr() )  ) + nowa_linia_znak_c_l +
    'potyczki iloœæ: ' + Trim(  FormatFloat( '### ### ##0', Self.Pora¿ki__Iloœæ__Odczytaj__Gr() + Self.Remisy__Iloœæ__Odczytaj__Gr() + Self.Zwyciêstwa__Iloœæ__Odczytaj__Gr() )  );


  if gra_okno_f then
    Result :=
      'Atak: ' + Trim(  FormatFloat( '### ### ##0.0000', Self.Atak__Wspó³czynnik__Odczytaj__Gr() )  ) + nowa_linia_znak_c_l +
      'Obrona: ' + Trim(  FormatFloat( '### ### ##0.0000', Self.Obrona__Wspó³czynnik__Odczytaj__Gr() )  ) + nowa_linia_znak_c_l +
      'Surowiec produkcja: ' + Trim(  FormatFloat( '### ### ##0.0000', Self.Surowiec__Produkcja__Wspó³czynnik__Odczytaj__Gr() )  ) + nowa_linia_znak_c_l +
      'Zamek produkcja: ' + Trim(  FormatFloat( '### ### ##0.0000', Self.Zamek__Produkcja__Wspó³czynnik__Odczytaj__Gr() )  ) + nowa_linia_znak_c_l +
      nowa_linia_znak_c_l +
      'Obserwacja: ' + Trim(  FormatFloat( '### ### ##0.0000', Self.Obserwacja__Zasiêg_Wspó³czynnik__Odczytaj__Gr() )  ) + nowa_linia_znak_c_l +
      'Strategia: ' + Trim(  FormatFloat( '### ### ##0', integer(Self.Strategia_Typ__Odczytaj__Gr()) )  ) + ' (' + Self.Strategia_Typ__W__Napis__Gr( Self.Strategia_Typ__Odczytaj__Gr() ) + ')' + nowa_linia_znak_c_l +
      nowa_linia_znak_c_l +
      nowa_linia_znak_c_l +
      Result;

end;//---//Funkcja Parametry_Wyœwietl__Gr().

function TGracz.Pora¿ki__Iloœæ__Odczytaj__Gr() : integer;
begin

  Result := Self.pora¿ki__iloœæ__gr;

end;//---//Funkcja Pora¿ki__Iloœæ__Odczytaj__Gr().

procedure TGracz.Pora¿ki__Iloœæ__Zmieñ__Gr( const wartoœæ_f : integer );
begin

  Self.pora¿ki__iloœæ__gr := Self.Wspó³czynnik__Wartoœæ_SprawdŸ__Gr( wartoœæ_f );

end;//---//Funkcja Pora¿ki__Iloœæ__Zmieñ__Gr().

procedure TGracz.Pora¿ki__Iloœæ__Zwiêksz__Gr();
begin

  inc( Self.pora¿ki__iloœæ__gr );

end;//---//Funkcja Pora¿ki__Iloœæ__Zwiêksz__Gr().

function TGracz.Potyczka_Odbyta__Odczytaj__Gr() : boolean;
begin

  Result := Self.potyczka_odbyta__gr;

end;//---//Funkcja Potyczka_Odbyta__Odczytaj__Gr().

procedure TGracz.Potyczka_Odbyta__Zmieñ__Gr( const potyczka_odbyta_f : boolean );
begin

  Self.potyczka_odbyta__gr := potyczka_odbyta_f

end;//---//Funkcja Potyczka_Odbyta__Zmieñ__Gr().

function TGracz.Ranking__Wartoœæ__Odczytaj__Gr() : integer;
begin

  Result := Self.ranking__wartoœæ__gr;

end;//---//Funkcja Ranking__Wartoœæ__Odczytaj__Gr().

procedure TGracz.Ranking__Wartoœæ__Zmniejsz__Gr();
begin

  Self.ranking__wartoœæ__gr := Self.Wspó³czynnik__Wartoœæ_SprawdŸ__Gr( Self.ranking__wartoœæ__gr + Gracz.ranking__wartoœæ__pora¿ka_zmiana_c );

end;//---//Funkcja Ranking__Wartoœæ__Zmniejsz__Gr().

procedure TGracz.Ranking__Wartoœæ__Zmieñ__Gr( const wartoœæ_f : integer );
begin

  Self.ranking__wartoœæ__gr := Self.Wspó³czynnik__Wartoœæ_SprawdŸ__Gr( wartoœæ_f );

end;//---//Funkcja Ranking__Wartoœæ__Zmieñ__Gr().

procedure TGracz.Ranking__Wartoœæ__Zwiêksz__Gr( const ranking__wartoœæ__przeciwnik_f : integer = 0 );
var
  zti : integer;
begin

  if ranking__wartoœæ__przeciwnik_f > 0 then
    begin

      zti := ranking__wartoœæ__przeciwnik_f - Self.ranking__wartoœæ__gr;

      if zti > 0 then
        zti := Self.Wspó³czynnik__Wartoœæ_SprawdŸ__Gr( zti div Gracz.ranking__wartoœæ__zwyciêstwo__ró¿nica_poziomów_dodatek_wspó³czynnik_c )
      else//if zti > 0 then
        zti := 0;

    end
  else//if ranking__wartoœæ__przeciwnik_f > 0 then
    zti := 0;


  Self.ranking__wartoœæ__gr := Self.ranking__wartoœæ__gr
    + Gracz.ranking__wartoœæ__zwyciêstwo_zmiana_c
    + zti;

end;//---//Funkcja Ranking__Wartoœæ__Zwiêksz__Gr().

function TGracz.Remisy__Iloœæ__Odczytaj__Gr() : integer;
begin

  Result := Self.remisy__iloœæ__gr;

end;//---//Funkcja Remisy__Iloœæ__Odczytaj__Gr().

procedure TGracz.Remisy__Iloœæ__Zmieñ__Gr( const wartoœæ_f : integer );
begin

  Self.remisy__iloœæ__gr := Self.Wspó³czynnik__Wartoœæ_SprawdŸ__Gr( wartoœæ_f );

end;//---//Funkcja Remisy__Iloœæ__Zmieñ__Gr().

procedure TGracz.Remisy__Iloœæ__Zwiêksz__Gr();
begin

  inc( Self.remisy__iloœæ__gr );

end;//---//Funkcja Remisy__Iloœæ__Zwiêksz__Gr().

function TGracz.Rozbudowa__Punkty__Odczytaj__Gr() : integer;
begin

  Result := Self.rozbudowa__punkty__gr;

end;//---//Funkcja Rozbudowa__Punkty__Odczytaj__Gr().

procedure TGracz.Rozbudowa__Punkty__Zmieñ__Gr( const wartoœæ_f : integer );
begin

  Self.rozbudowa__punkty__gr := Self.Wspó³czynnik__Wartoœæ_SprawdŸ__Gr( wartoœæ_f );

end;//---//Funkcja Rozbudowa__Punkty__Zmieñ__Gr().

procedure TGracz.Rozbudowa__Punkty__Zmniejsz__Gr( const wartoœæ_f : integer );
begin

  Self.rozbudowa__punkty__gr := Self.Wspó³czynnik__Wartoœæ_SprawdŸ__Gr( Self.rozbudowa__punkty__gr + wartoœæ_f );

end;//---//Funkcja Rozbudowa__Punkty__Zmniejsz__Gr().

procedure TGracz.Rozbudowa__Punkty__Zwiêksz__Gr();
begin

  Self.rozbudowa__punkty__gr := Self.rozbudowa__punkty__gr
    + Gracz.rozbudowa__punkty__przyrost_c;

end;//---//Funkcja Rozbudowa__Punkty__Zwiêksz__Gr().

procedure TGracz.Rozbuduj();
var
  ztb : boolean;
  ztr : real;
  wspó³czynnik_rodzaj_l : Definicje.TGracz_Wspó³czynnik_Rodzaj;
begin

  ztb := true;

  while ztb do
    begin

      if Self.Strategia_Typ__Odczytaj__Gr() = Definicje.st_agresywna_bardzo then
        begin

          if Self.Atak__Wspó³czynnik__Odczytaj__Gr() >= Self.Surowiec__Produkcja__Wspó³czynnik__Odczytaj__Gr() * 3 then
            wspó³czynnik_rodzaj_l := Definicje.gwr_surowiec__produkcja
          else
            wspó³czynnik_rodzaj_l := Definicje.gwr_atak;

        end
      else//if Self.Strategia_Typ__Odczytaj__Gr() = Definicje.st_agresywna_bardzo then
      if Self.Strategia_Typ__Odczytaj__Gr() = Definicje.st_agresywna then
        begin

          if Self.Atak__Wspó³czynnik__Odczytaj__Gr() >= Self.Surowiec__Produkcja__Wspó³czynnik__Odczytaj__Gr() * 2 then
            wspó³czynnik_rodzaj_l := Definicje.gwr_surowiec__produkcja
          else
          if Self.Surowiec__Produkcja__Wspó³czynnik__Odczytaj__Gr() >= Self.Obrona__Wspó³czynnik__Odczytaj__Gr() * 2 then
            wspó³czynnik_rodzaj_l := Definicje.gwr_obrona
          else
            wspó³czynnik_rodzaj_l := Definicje.gwr_atak;

        end
      else//if Self.Strategia_Typ__Odczytaj__Gr() = Definicje.st_agresywna then
      if Self.Strategia_Typ__Odczytaj__Gr() = Definicje.st_wywa¿ona then
        begin

          ztr := -1;

          if   ( ztr = -1 )
            or ( ztr > Self.Surowiec__Produkcja__Wspó³czynnik__Odczytaj__Gr() ) then
            begin

              ztr := Self.Surowiec__Produkcja__Wspó³czynnik__Odczytaj__Gr();
              wspó³czynnik_rodzaj_l := Definicje.gwr_surowiec__produkcja;

            end;
          //---//if   ( ztr = -1 ) (...)

          if   ( ztr = -1 )
            or ( ztr > Self.Obrona__Wspó³czynnik__Odczytaj__Gr() ) then
            begin

              ztr := Self.Obrona__Wspó³czynnik__Odczytaj__Gr();
              wspó³czynnik_rodzaj_l := Definicje.gwr_obrona;

            end;
          //---//if   ( ztr = -1 ) (...)

          if   ( ztr = -1 )
            or ( ztr > Self.Zamek__Produkcja__Wspó³czynnik__Odczytaj__Gr() ) then
            begin

              ztr := Self.Surowiec__Produkcja__Wspó³czynnik__Odczytaj__Gr();
              wspó³czynnik_rodzaj_l := Definicje.gwr_zamek__produkcja;

            end;
          //---//if   ( ztr = -1 ) (...)

          if   ( ztr = -1 )
            or ( ztr > Self.Atak__Wspó³czynnik__Odczytaj__Gr() ) then
            begin

              ztr := Self.Atak__Wspó³czynnik__Odczytaj__Gr();
              wspó³czynnik_rodzaj_l := Definicje.gwr_atak;

            end;
          //---//if   ( ztr = -1 ) (...)

          if   ( ztr = -1 )
            or ( ztr > Self.Obserwacja__Zasiêg_Wspó³czynnik__Odczytaj__Gr() ) then
            begin

              ztr := Self.Obserwacja__Zasiêg_Wspó³czynnik__Odczytaj__Gr();
              wspó³czynnik_rodzaj_l := Definicje.gwr_obserwacja;

            end;
          //---//if   ( ztr = -1 ) (...)

        end
      else//if Self.Strategia_Typ__Odczytaj__Gr() = Definicje.st_wywa¿ona then
      if Self.Strategia_Typ__Odczytaj__Gr() = Definicje.st_zachowawcza then
        begin

          if Self.Surowiec__Produkcja__Wspó³czynnik__Odczytaj__Gr() >= Self.Obrona__Wspó³czynnik__Odczytaj__Gr() * 2 then
            wspó³czynnik_rodzaj_l := Definicje.gwr_obrona
          else
          if Self.Obrona__Wspó³czynnik__Odczytaj__Gr() >= Self.Atak__Wspó³czynnik__Odczytaj__Gr() * 2 then
            wspó³czynnik_rodzaj_l := Definicje.gwr_atak
          else
          if Self.Obserwacja__Zasiêg_Wspó³czynnik__Odczytaj__Gr() >= Self.Zamek__Produkcja__Wspó³czynnik__Odczytaj__Gr() * 2 then
            wspó³czynnik_rodzaj_l := Definicje.gwr_zamek__produkcja
          else
          if Self.Zamek__Produkcja__Wspó³czynnik__Odczytaj__Gr() >= Self.Obserwacja__Zasiêg_Wspó³czynnik__Odczytaj__Gr() * 2 then
            wspó³czynnik_rodzaj_l := Definicje.gwr_obserwacja
          else
            wspó³czynnik_rodzaj_l := Definicje.gwr_surowiec__produkcja;

        end
      else//if Self.Strategia_Typ__Odczytaj__Gr() = Definicje.st_zachowawcza then
      if Self.Strategia_Typ__Odczytaj__Gr() = Definicje.st_zachowawcza_bardzo then
        begin

          if Self.Surowiec__Produkcja__Wspó³czynnik__Odczytaj__Gr() >= Self.Obrona__Wspó³czynnik__Odczytaj__Gr() * 3 then
            wspó³czynnik_rodzaj_l := Definicje.gwr_obrona
          else
          if Self.Obrona__Wspó³czynnik__Odczytaj__Gr() >= Self.Zamek__Produkcja__Wspó³czynnik__Odczytaj__Gr() * 3 then
            wspó³czynnik_rodzaj_l := Definicje.gwr_zamek__produkcja
          else
            wspó³czynnik_rodzaj_l := Definicje.gwr_surowiec__produkcja;

        end;
      //---//if Self.Strategia_Typ__Odczytaj__Gr() = Definicje.st_zachowawcza_bardzo then


      ztb := Self.Wspó³czynnik__Rozbuduj__Gr( wspó³czynnik_rodzaj_l );

    end;
  //---//while ztb do

end;//---//Funkcja Rozbuduj().

function TGracz.Strategia_Typ__Odczytaj__Gr() : Definicje.TStrategia_Typ;
begin

  Result := Self.strategia_typ__gr;

end;//---//Funkcja Strategia_Typ__Odczytaj__Gr().

procedure TGracz.Strategia_Typ__Zmieñ__Gr( const strategia_typ_f : integer );
begin

  if    (   strategia_typ_f >= Ord(  Low( Definicje.TStrategia_Typ )  )   )
    and (   strategia_typ_f <= Ord(  High( Definicje.TStrategia_Typ )  )   ) then
    Self.strategia_typ__gr := Definicje.TStrategia_Typ(strategia_typ_f);

end;//---//Funkcja Strategia_Typ__Zmieñ__Gr().

function TGracz.Strategia_Typ__Napis__Odczytaj__Gr() : string;
begin

  Result := Self.Strategia_Typ__W__Napis__Gr( Self.Strategia_Typ__Odczytaj__Gr() );

end;//---//Funkcja Strategia_Typ__Napis__Odczytaj__Gr().

function TGracz.Strategia_Typ__W__Napis__Gr( const strategia_typ_f : Definicje.TStrategia_Typ ) : string;
begin

  case strategia_typ_f of
      Definicje.st_agresywna_bardzo : Result := 'agresywna bardzo';
      Definicje.st_agresywna : Result := 'agresywna';
      Definicje.st_wywa¿ona : Result := 'wywa¿ona';
      Definicje.st_zachowawcza : Result := 'zachowawcza';
      Definicje.st_zachowawcza_bardzo : Result := 'zachowawcza bardzo';
      else//case strategia_typ_f of
        Result := '<?>';
    end;
  //---//case strategia_typ_f of

end;//---//Funkcja Strategia_Typ__W__Napis__Gr().

function TGracz.Surowiec__Produkcja__Wspó³czynnik__Odczytaj__Gr() : real;
begin

  Result := Self.surowiec__produkcja_wspó³czynnik__gr;

end;//---//Funkcja Surowiec__Produkcja__Wspó³czynnik__Odczytaj__Gr().

procedure TGracz.Surowiec__Produkcja__Wspó³czynnik__Zmieñ__Gr( const wartoœæ_f : real );
begin

  Self.surowiec__produkcja_wspó³czynnik__gr := Self.Wspó³czynnik__Wartoœæ_SprawdŸ__Gr( wartoœæ_f );

end;//---//Funkcja Surowiec__Produkcja__Wspó³czynnik__Zmieñ__Gr().

procedure TGracz.Surowiec__Produkcja__Wspó³czynnik__Zwiêksz__Gr( const wartoœæ_f : real );
begin

  Self.surowiec__produkcja_wspó³czynnik__gr := Self.Wspó³czynnik__Wartoœæ_SprawdŸ__Gr( Self.surowiec__produkcja_wspó³czynnik__gr + wartoœæ_f );

end;//---//Funkcja Surowiec__Produkcja__Wspó³czynnik__Zwiêksz__Gr().

function TGracz.Wspó³czynnik__Rozbuduj__Gr( const wspó³czynnik__rodzaj_f : Definicje.TGracz_Wspó³czynnik_Rodzaj; const tylko_test_f : boolean = false ) : boolean;
var
  wspó³czynnik__koszt_l : integer; // Tylko aby wywo³aæ funkcjê.
begin

  Result := Self.Wspó³czynnik__Rozbuduj__Gr( wspó³czynnik__rodzaj_f, wspó³czynnik__koszt_l, tylko_test_f );

end;//---//Funkcja Wspó³czynnik__Rozbuduj__Gr().

function TGracz.Wspó³czynnik__Rozbuduj__Gr( const wspó³czynnik__rodzaj_f : Definicje.TGracz_Wspó³czynnik_Rodzaj; out wspó³czynnik__koszt_f : integer; const tylko_test_f : boolean = false ) : boolean;
var
  zti : integer;
  ztr : real;
begin

  Result := false;


  if wspó³czynnik__rodzaj_f = Definicje.gwr_atak then
    ztr := Self.atak__wspó³czynnik__gr
  else
  if wspó³czynnik__rodzaj_f = Definicje.gwr_obrona then
    ztr := Self.obrona__wspó³czynnik__gr
  else
  if wspó³czynnik__rodzaj_f = Definicje.gwr_obserwacja then
    ztr := Self.obserwacja__zasiêg_wspó³czynnik__gr
  else
  if wspó³czynnik__rodzaj_f = Definicje.gwr_surowiec__produkcja then
    ztr := Self.surowiec__produkcja_wspó³czynnik__gr
  else
  if wspó³czynnik__rodzaj_f = Definicje.gwr_zamek__produkcja then
    ztr := Self.zamek__produkcja_wspó³czynnik__gr
  else
    ztr := -1;


  if ztr < 0 then
    begin

      wspó³czynnik__koszt_f := -1;

      Exit;

    end;
  //---//if ztr < 0 then


  zti := System.Math.Floor( ztr ) - 1;

  if zti < 0 then
    zti := 0;

  zti :=
      Gracz.rozbudowa__wspó³czynnik__koszt_c
    + zti
    * Gracz.rozbudowa__wspó³czynnik__koszt_c;


  wspó³czynnik__koszt_f := zti;


  if Self.Rozbudowa__Punkty__Odczytaj__Gr() < zti then
    Exit;


  Result := true;


  if tylko_test_f then
    Exit;


  if wspó³czynnik__rodzaj_f = Definicje.gwr_atak then
    Self.Atak__Wspó³czynnik__Zwiêksz__Gr( Gracz.rozbudowa__wspó³czynnik__przyrost_c )
  else
  if wspó³czynnik__rodzaj_f = Definicje.gwr_obrona then
    Self.Obrona__Wspó³czynnik__Zwiêksz__Gr( Gracz.rozbudowa__wspó³czynnik__przyrost_c )
  else
  if wspó³czynnik__rodzaj_f = Definicje.gwr_obserwacja then
    Self.Obserwacja__Zasiêg_Wspó³czynnik__Zwiêksz__Gr( Gracz.rozbudowa__wspó³czynnik__przyrost_c )
  else
  if wspó³czynnik__rodzaj_f = Definicje.gwr_surowiec__produkcja then
    Self.Surowiec__Produkcja__Wspó³czynnik__Zwiêksz__Gr( Gracz.rozbudowa__wspó³czynnik__przyrost_c )
  else
  if wspó³czynnik__rodzaj_f = Definicje.gwr_zamek__produkcja then
    Self.Zamek__Produkcja__Wspó³czynnik__Zwiêksz__Gr( Gracz.rozbudowa__wspó³czynnik__przyrost_c );


  Self.Rozbudowa__Punkty__Zmniejsz__Gr( -zti );

end;//---//Funkcja Wspó³czynnik__Rozbuduj__Gr().

function TGracz.Zamek__Produkcja__Wspó³czynnik__Odczytaj__Gr() : real;
begin

  Result := Self.zamek__produkcja_wspó³czynnik__gr;

end;//---//Funkcja Zamek__Produkcja__Wspó³czynnik__Odczytaj__Gr().

procedure TGracz.Zamek__Produkcja__Wspó³czynnik__Zmieñ__Gr( const wartoœæ_f : real );
begin

  Self.zamek__produkcja_wspó³czynnik__gr := Self.Wspó³czynnik__Wartoœæ_SprawdŸ__Gr( wartoœæ_f );

end;//---//Funkcja Zamek__Produkcja__Wspó³czynnik__Zmieñ__Gr().

procedure TGracz.Zamek__Produkcja__Wspó³czynnik__Zwiêksz__Gr( const wartoœæ_f : real );
begin

  Self.zamek__produkcja_wspó³czynnik__gr := Self.Wspó³czynnik__Wartoœæ_SprawdŸ__Gr( Self.zamek__produkcja_wspó³czynnik__gr + wartoœæ_f );

end;//---//Funkcja Zamek__Produkcja__Wspó³czynnik__Zwiêksz__Gr().

function TGracz.Wspó³czynnik__Wartoœæ_SprawdŸ__Gr( const wartoœæ_f : real ) : real;
begin

  if wartoœæ_f < 1 then
    Result := 1
  else//if wartoœæ_f < 1 then
    Result := wartoœæ_f;

end;//---//Funkcja Wspó³czynnik__Wartoœæ_SprawdŸ__Gr().

function TGracz.Wspó³czynnik__Wartoœæ_SprawdŸ__Gr( const wartoœæ_f : integer ) : integer;
begin

  if wartoœæ_f < 0 then
    Result := 0
  else//if wartoœæ_f < 1 then
    Result := wartoœæ_f;

end;//---//Funkcja Wspó³czynnik__Wartoœæ_SprawdŸ__Gr().

function TGracz.Zwyciêstwa__Iloœæ__Odczytaj__Gr() : integer;
begin

  Result := Self.zwyciêstwa__iloœæ__gr;

end;//---//Funkcja Zwyciêstwa__Iloœæ__Odczytaj__Gr().

procedure TGracz.Zwyciêstwa__Iloœæ__Zmieñ__Gr( const wartoœæ_f : integer );
begin

  Self.zwyciêstwa__iloœæ__gr := Self.Wspó³czynnik__Wartoœæ_SprawdŸ__Gr( wartoœæ_f );

end;//---//Funkcja Zwyciêstwa__Iloœæ__Zmieñ__Gr().

procedure TGracz.Zwyciêstwa__Iloœæ__Zwiêksz__Gr();
begin

  inc( Self.zwyciêstwa__iloœæ__gr );

  Self.Rozbudowa__Punkty__Zwiêksz__Gr();

end;//---//Funkcja Zwyciêstwa__Iloœæ__Zwiêksz__Gr().

function TGracz.Zwyciêstwa__Iloœæ__Pod_Rz¹d__Odczytaj__Gr() : integer;
begin

  Result := Self.zwyciêstwa__iloœæ__pod_rz¹d__gr;

end;//---//Funkcja Zwyciêstwa__Iloœæ__Pod_Rz¹d__Odczytaj__Gr().

procedure TGracz.Zwyciêstwa__Iloœæ__Pod_Rz¹d__Zmieñ__Gr( const wartoœæ_f : integer );
begin

  Self.zwyciêstwa__iloœæ__pod_rz¹d__gr := Self.Wspó³czynnik__Wartoœæ_SprawdŸ__Gr( wartoœæ_f );

end;//---//Funkcja Zwyciêstwa__Iloœæ__Pod_Rz¹d__Zmieñ__Gr().

procedure TGracz.Zwyciêstwa__Iloœæ__Pod_Rz¹d__Zmniejsz__Gr();
begin

  Self.zwyciêstwa__iloœæ__pod_rz¹d__gr := Self.Wspó³czynnik__Wartoœæ_SprawdŸ__Gr( 0 );

end;//---//Funkcja Zwyciêstwa__Iloœæ__Pod_Rz¹d__Zmniejsz__Gr().

procedure TGracz.Zwyciêstwa__Iloœæ__Pod_Rz¹d__Zwiêksz__Gr();
begin

  inc( Self.zwyciêstwa__iloœæ__pod_rz¹d__gr );

end;//---//Funkcja Zwyciêstwa__Iloœæ__Pod_Rz¹d__Zwiêksz__Gr().

end.
