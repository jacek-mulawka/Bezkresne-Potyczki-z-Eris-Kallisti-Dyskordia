unit Ranking;{10.Sie.2026}

interface

uses
  System.Classes,
  System.Math,
  System.SysUtils,
  System.Threading,
  Vcl.Forms,

  Definicje,
  Bitwa_Dominia,
  Gracz;

type
  TRanking = class
  private
    { Private declarations }
    w¹tki__wszystkie_gotowe__ra : boolean;

    potyczki__iloœæ__ra,
    w¹tki__iloœæ__ra
      : integer;

    gracz_t : array of Gracz.TGracz;

    procedure Gracze__Sortuj();

    procedure Gracze__Zwolnij();

    procedure Potyczka__Odbyta__Zeruj_Wszystkich_Graczy__Ra();
    function Potyczka__Przeciwnik_Wylosuj__Ra( const gracz_f : Gracz.TGracz ) : Gracz.TGracz;
    procedure Potyczka__Przelicz__Ra( const bitwa_dominia__przeliczeñ_w_turze_f, dominium__wytrzyma³oœæ_punkty_f : integer; gracz__1_f, gracz__2_f : Gracz.TGracz );
    procedure Przeliczanie_W_Tle__Zakoñcz__Ra();
  public
    { Public declarations }
    Postêp__Odœwie¿__Ra,
    Przeliczanie_W_Tle__Zakoñczone__Ra
      : procedure() of object;

    constructor Create();
    destructor Destroy(); override;

    function Gracz__Id__Odczytaj__Ra( const tabela_indeks_f : integer ) : integer;
    function Gracz__Gra_Gracz__Ra( const tabela_indeks_f : integer ) : boolean;
    function Gracz__Gra_Gracz__Id_ZnajdŸ__Ra() : integer;
    function Gracz__Nazwa__Odczytaj__Ra( const tabela_indeks_f : integer ) : string;
    function Gracz__Parametry_Wyœwietl__Ra( const gracz_id_f : integer ) : string;
    function Gracz__Ranking__Wartoœæ__Odczytaj__Ra( const tabela_indeks_f : integer ) : integer;
    function Gracz__Rozbudowa__Dane__Odczytaj__Ra( const gracz_id_f : integer; out atak__koszt_f, obrona__koszt_f, obserwacja__koszt_f, rozbudowa__punkty_f, surowiec__produkcja__koszt_f, zamek__produkcja__koszt_f : integer; out atak__wspó³czynnik_f, obrona__wspó³czynnik_f, obserwacja__wspó³czynnik_f, surowiec__produkcja__wspó³czynnik_f, zamek__produkcja__wspó³czynnik_f : real ) : boolean;
    procedure Gracz__Rozbuduj__Ra( const gracz_id_f : integer; const wspó³czynnik_rodzaj__grp : Definicje.TGracz_Wspó³czynnik_Rodzaj );
    function Gracz__Strategia_Typ__Odczytaj__Ra( const tabela_indeks_f : integer ) : Definicje.TStrategia_Typ;
    function Gracz__Strategia_Typ__Napis__Odczytaj__Ra( const tabela_indeks_f : integer ) : string;
    function Gracze__Iloœæ__Odczytaj__Ra() : integer;
    procedure Gracze__Wylosuj( const gracze__iloœæ_f : integer;  const gracz__nazwa_f : string = '' );

    function Potyczki__Iloœæ__Odczytaj__Ra() : integer;
    procedure Potyczki__Runda__Przelicz__Ra( const bitwa_dominia__przeliczeñ_w_turze_f, dominium__wytrzyma³oœæ_punkty_f : integer; w¹tki__iloœæ_f : integer; const przeliczaj_w_tle_f : boolean; const tylko_gracz_f : boolean = false );

    procedure Ranking__Wczytaj();
    procedure Ranking__Zapisz();
  end;//---//TRanking = class

const
  gracze_nazwy__plik_nazwa_c : string = 'gracze_nazwy.txt';
  ranking__plik__nazwa_c : string = 'ranking.txt';
  ranking__plik__nowy_gracz_symbol_c : string = '!';

implementation

constructor TRanking.Create();
begin

  Randomize();

  Self.Postêp__Odœwie¿__Ra := nil;
  Self.Przeliczanie_W_Tle__Zakoñczone__Ra := nil;
  SetLength( Self.gracz_t, 0 );

end;//---//Konstruktor klasy TRanking.

destructor TRanking.Destroy();
begin

  Self.Gracze__Zwolnij();

end;//---//Destruktor klasy TRanking.

function TRanking.Gracz__Id__Odczytaj__Ra( const tabela_indeks_f : integer ) : integer;
begin

  if    ( tabela_indeks_f >= 0 )
    and (  tabela_indeks_f < Length( Self.gracz_t )  ) then
    Result := Self.gracz_t[ tabela_indeks_f ].Gracz__Id__Odczytaj__Gr()
  else//if    ( tabela_indeks_f >= 0 ) (...)
    Result := Definicje.identyfikator_pusty_c;

end;//---//Funkcja Gracz__Id__Odczytaj__Ra().

function TRanking.Gracz__Gra_Gracz__Ra( const tabela_indeks_f : integer ) : boolean;
begin

  if    ( tabela_indeks_f >= 0 )
    and (  tabela_indeks_f < Length( Self.gracz_t )  ) then
    Result := Self.gracz_t[ tabela_indeks_f ].Gra_Gracz__Odczytaj__Gr()
  else//if    ( tabela_indeks_f >= 0 ) (...)
    Result := false

end;//---//Funkcja Gracz__Gra_Gracz__Ra().

function TRanking.Gracz__Gra_Gracz__Id_ZnajdŸ__Ra() : integer;
var
  i : integer;
begin

  Result := Definicje.identyfikator_pusty_c;

  for i := 0 to Length( Self.gracz_t ) - 1 do
    if Self.Gracz__Gra_Gracz__Ra( i ) then
      begin

        Result := Self.gracz_t[ i ].Gracz__Id__Odczytaj__Gr();


        Break;

      end;
    //---//if Self.Gracz__Gra_Gracz__Ra( i ) then

end;//---//Funkcja Gracz__Gra_Gracz__Id_ZnajdŸ__Ra().

function TRanking.Gracz__Nazwa__Odczytaj__Ra( const tabela_indeks_f : integer ) : string;
begin

  if    ( tabela_indeks_f >= 0 )
    and (  tabela_indeks_f < Length( Self.gracz_t )  ) then
    Result := Self.gracz_t[ tabela_indeks_f ].Nazwa__Odczytaj__Gr()
  else//if    ( tabela_indeks_f >= 0 ) (...)
    Result := '<?>';

end;//---//Funkcja Gracz__Nazwa__Odczytaj__Ra().

function TRanking.Gracz__Parametry_Wyœwietl__Ra( const gracz_id_f : integer ) : string;
var
  i : integer;
begin

  Result := '<?>';

  for i := 0 to Length( Self.gracz_t ) - 1 do
    if Self.gracz_t[ i ].Gracz__Id__Odczytaj__Gr() = gracz_id_f then
      begin

        Result := Self.gracz_t[ i ].Parametry_Wyœwietl__Gr();


        Break;

      end;
    //---//if Self.gracz_t[ i ].Gracz__Id__Odczytaj__Gr() = gracz_id_f then

end;//---//Funkcja Gracz__Parametry_Wyœwietl__Ra().

function TRanking.Gracz__Ranking__Wartoœæ__Odczytaj__Ra( const tabela_indeks_f : integer ) : integer;
begin

  if    ( tabela_indeks_f >= 0 )
    and (  tabela_indeks_f < Length( Self.gracz_t )  ) then
    Result := Self.gracz_t[ tabela_indeks_f ].Ranking__Wartoœæ__Odczytaj__Gr()
  else//if    ( tabela_indeks_f >= 0 ) (...)
    Result := 0;

end;//---//Funkcja Gracz__Ranking__Wartoœæ__Odczytaj__Ra().

function TRanking.Gracz__Rozbudowa__Dane__Odczytaj__Ra( const gracz_id_f : integer; out atak__koszt_f, obrona__koszt_f, obserwacja__koszt_f, rozbudowa__punkty_f, surowiec__produkcja__koszt_f, zamek__produkcja__koszt_f : integer; out atak__wspó³czynnik_f, obrona__wspó³czynnik_f, obserwacja__wspó³czynnik_f, surowiec__produkcja__wspó³czynnik_f, zamek__produkcja__wspó³czynnik_f : real ) : boolean;
var
  i : integer;
begin

  Result := false;

  for i := 0 to Length( Self.gracz_t ) - 1 do
    if Self.gracz_t[ i ].Gracz__Id__Odczytaj__Gr() = gracz_id_f then
      begin

        Result := true;


        rozbudowa__punkty_f := Self.gracz_t[ i ].Rozbudowa__Punkty__Odczytaj__Gr();


        atak__wspó³czynnik_f := Self.gracz_t[ i ].Atak__Wspó³czynnik__Odczytaj__Gr();
        obrona__wspó³czynnik_f := Self.gracz_t[ i ].Obrona__Wspó³czynnik__Odczytaj__Gr();
        obserwacja__wspó³czynnik_f := Self.gracz_t[ i ].Obserwacja__Zasiêg_Wspó³czynnik__Odczytaj__Gr();
        surowiec__produkcja__wspó³czynnik_f := Self.gracz_t[ i ].Surowiec__Produkcja__Wspó³czynnik__Odczytaj__Gr();
        zamek__produkcja__wspó³czynnik_f := Self.gracz_t[ i ].Zamek__Produkcja__Wspó³czynnik__Odczytaj__Gr();


        Self.gracz_t[ i ].Wspó³czynnik__Rozbuduj__Gr( Definicje.gwr_atak, atak__koszt_f, true );
        Self.gracz_t[ i ].Wspó³czynnik__Rozbuduj__Gr( Definicje.gwr_obrona, obrona__koszt_f, true );
        Self.gracz_t[ i ].Wspó³czynnik__Rozbuduj__Gr( Definicje.gwr_obserwacja, obserwacja__koszt_f, true );
        Self.gracz_t[ i ].Wspó³czynnik__Rozbuduj__Gr( Definicje.gwr_surowiec__produkcja, surowiec__produkcja__koszt_f, true );
        Self.gracz_t[ i ].Wspó³czynnik__Rozbuduj__Gr( Definicje.gwr_zamek__produkcja, zamek__produkcja__koszt_f, true );


        Break;

      end;
    //---//if Self.gracz_t[ i ].Gracz__Id__Odczytaj__Gr() = gracz_id_f then

end;//---//Funkcja Gracz__Rozbudowa__Dane__Odczytaj__Ra().

procedure TRanking.Gracz__Rozbuduj__Ra( const gracz_id_f : integer; const wspó³czynnik_rodzaj__grp : Definicje.TGracz_Wspó³czynnik_Rodzaj );
var
  i : integer;
begin

  for i := 0 to Length( Self.gracz_t ) - 1 do
    if Self.gracz_t[ i ].Gracz__Id__Odczytaj__Gr() = gracz_id_f then
      begin

        Self.gracz_t[ i ].Wspó³czynnik__Rozbuduj__Gr( wspó³czynnik_rodzaj__grp );


        Break;

      end;
    //---//if Self.gracz_t[ i ].Gracz__Id__Odczytaj__Gr() = gracz_id_f then

end;//---//Funkcja Gracz__Rozbuduj__Ra().

function TRanking.Gracz__Strategia_Typ__Odczytaj__Ra( const tabela_indeks_f : integer ) : Definicje.TStrategia_Typ;
begin

  if    ( tabela_indeks_f >= 0 )
    and (  tabela_indeks_f < Length( Self.gracz_t )  ) then
    Result := Self.gracz_t[ tabela_indeks_f ].Strategia_Typ__Odczytaj__Gr()
  else//if    ( tabela_indeks_f >= 0 ) (...)
    Result := Definicje.st_wywa¿ona;

end;//---//Funkcja Gracz__Strategia_Typ__Odczytaj__Ra().

function TRanking.Gracz__Strategia_Typ__Napis__Odczytaj__Ra( const tabela_indeks_f : integer ) : string;
begin

  if    ( tabela_indeks_f >= 0 )
    and (  tabela_indeks_f < Length( Self.gracz_t )  ) then
    Result := Self.gracz_t[ tabela_indeks_f ].Strategia_Typ__Napis__Odczytaj__Gr()
  else//if    ( tabela_indeks_f >= 0 ) (...)
    Result := '<?>';

end;//---//Funkcja Gracz__Strategia_Typ__Napis__Odczytaj__Ra().

function TRanking.Gracze__Iloœæ__Odczytaj__Ra() : integer;
begin

  Result := Length( Self.gracz_t );

end;//---//Funkcja Gracze__Iloœæ__Odczytaj__Ra().

procedure TRanking.Gracze__Sortuj();
var
  ztb : boolean;
  i : integer;
  zt_gracz : Gracz.TGracz;
begin

  ztb := true;

  while ztb do
    begin

      ztb := false;

      for i := 0 to Length( Self.gracz_t ) - 2 do
        if Self.gracz_t[ i ].Ranking__Wartoœæ__Odczytaj__Gr() < Self.gracz_t[ i + 1 ].Ranking__Wartoœæ__Odczytaj__Gr() then
          begin

            zt_gracz := Self.gracz_t[ i ];
            Self.gracz_t[ i ] := Self.gracz_t[ i + 1 ];
            Self.gracz_t[ i + 1 ] := zt_gracz;

            if not ztb then
              ztb := true;

          end;
        //---//if Self.gracz_t[ i ].Ranking__Wartoœæ__Odczytaj__Gr() < Self.gracz_t[ i + 1 ].Ranking__Wartoœæ__Odczytaj__Gr() then

    end;
  //---//while ztb do

end;//---//Funkcja Gracze__Sortuj().

procedure TRanking.Gracze__Wylosuj( const gracze__iloœæ_f : integer;  const gracz__nazwa_f : string = '' );

  //Funkcja Gracz__Nazwa_Wyznacz() w Gracze__Wylosuj().
  function Gracz__Nazwa_Wyznacz( const numeruj_wszystkie_nazwy_f : boolean; const gracze_nazwy__kopia_numer_f : integer; gracze_nazwy_f : System.Classes.TStringList ) : string;

    //Funkcja Liczba_Arabska_W_Rzymska() w Gracz__Nazwa_Wyznacz() w Gracze__Wylosuj().
    function Liczba_Arabska_W_Rzymska( liczba_f : integer ) : string;
    const
     odejmowanie_liczba__1_c_l : integer = 9;
     odejmowanie_liczba__2_c_l : integer = 4;

    var
      i,
      tysi¹ce_iloœæ,
      piêæsetki_iloœæ,
      setki_iloœæ,
      piêædziesi¹tki_iloœæ,
      dziesi¹tki_iloœæ,
      pi¹tki_iloœæ,
      jednoœci_iloœæ
        : integer;
    begin

      //
      // https://www.matemaks.pl/cyfry-rzymskie
      // https://matmanaluzie.pl/liczby-rzymskie-jak-je-odczytywac-i-zapisywac-zamiana-liczb-rzymskich-na-arabskie/
      //
      // W systemie rzymskim mo¿na zapisaæ najwy¿ej trzy jednakowe cyfry obok siebie.
      //
      // I = 1
      // V = 5
      // X = 10
      // L = 50
      // C = 100
      // D = 500
      // M = 1000
      //
      // 40 = XL
      // 99 = XCIX
      // 134 = CXXXIV
      // 888 = DCCCLXXXVIII
      // 940 = CMXL
      // 1935 = MCMXXXV
      // 2023 = MMXXIII
      //


      Result := '';


      tysi¹ce_iloœæ := liczba_f div 1000;
      liczba_f := liczba_f - tysi¹ce_iloœæ * 1000;

      for i := 1 to tysi¹ce_iloœæ do
        Result := Result + 'M';


      setki_iloœæ := liczba_f div 100;

      if setki_iloœæ = odejmowanie_liczba__1_c_l then
        begin

          Result := Result + 'CM';
          liczba_f := liczba_f - setki_iloœæ * 100;

        end
      else//if setki_iloœæ = odejmowanie_liczba__1_c_l then
        begin

          piêæsetki_iloœæ := liczba_f div 500;
          liczba_f := liczba_f - piêæsetki_iloœæ * 500;

          for i := 1 to piêæsetki_iloœæ do
            Result := Result + 'D';


          setki_iloœæ := liczba_f div 100;
          liczba_f := liczba_f - setki_iloœæ * 100;

          for i := 1 to setki_iloœæ do
            Result := Result + 'C';

        end;
      //---//if setki_iloœæ = odejmowanie_liczba__1_c_l then


      dziesi¹tki_iloœæ := liczba_f div 10;

      if dziesi¹tki_iloœæ = odejmowanie_liczba__1_c_l then
        begin

          Result := Result + 'XC';
          liczba_f := liczba_f - dziesi¹tki_iloœæ * 10;

        end
      else//if dziesi¹tki_iloœæ = odejmowanie_liczba__1_c_l then
        begin

          piêædziesi¹tki_iloœæ := liczba_f div 50;
          liczba_f := liczba_f - piêædziesi¹tki_iloœæ * 50;

          for i := 1 to piêædziesi¹tki_iloœæ do
            Result := Result + 'L';


          dziesi¹tki_iloœæ := liczba_f div 10;

          if dziesi¹tki_iloœæ = odejmowanie_liczba__2_c_l then
            begin

              Result := Result + 'XL';
              liczba_f := liczba_f - dziesi¹tki_iloœæ * 10;

            end
          else//if dziesi¹tki_iloœæ = odejmowanie_liczba__2_c_l then
            begin

              liczba_f := liczba_f - dziesi¹tki_iloœæ * 10;

              for i := 1 to dziesi¹tki_iloœæ do
                Result := Result + 'X';

            end;
          //---//if dziesi¹tki_iloœæ = odejmowanie_liczba__2_c_l then

        end;
      //---//if dziesi¹tki_iloœæ = odejmowanie_liczba__1_c_l then


      jednoœci_iloœæ := liczba_f;

      if jednoœci_iloœæ = odejmowanie_liczba__1_c_l then
        begin

          Result := Result + 'IX';
          liczba_f := liczba_f - setki_iloœæ * 100;

        end
      else//if jednoœci_iloœæ = odejmowanie_liczba__1_c_l then
        begin

          pi¹tki_iloœæ := liczba_f div 5;
          liczba_f := liczba_f - pi¹tki_iloœæ * 5;

          for i := 1 to pi¹tki_iloœæ do
            Result := Result + 'V';


          jednoœci_iloœæ := liczba_f;

          if jednoœci_iloœæ = odejmowanie_liczba__2_c_l then
            begin

              Result := Result + 'IV';
              liczba_f := liczba_f - jednoœci_iloœæ;

            end
          else//if jednoœci_iloœæ = odejmowanie_liczba__2_c_l then
            begin

              liczba_f := liczba_f - jednoœci_iloœæ;

              for i := 1 to jednoœci_iloœæ do
                Result := Result + 'I';

            end;
          //---//if jednoœci_iloœæ = odejmowanie_liczba__2_c_l then

        end;
      //---//if jednoœci_iloœæ = odejmowanie_liczba__1_c_l then

    end;//---//Funkcja Liczba_Arabska_W_Rzymska() Gracz__Nazwa_Wyznacz() w Gracze__Wylosuj().

  var
    zti : integer;
  begin//Funkcja Gracz__Nazwa_Wyznacz() w Gracze__Wylosuj().

    zti := gracze_nazwy_f.Count;

    if zti > 0 then
      begin

        zti := Random( zti );

        Result := gracze_nazwy_f[ zti ];

        gracze_nazwy_f.Delete( zti );


        if   ( numeruj_wszystkie_nazwy_f )
          or ( gracze_nazwy__kopia_numer_f > 1 ) then
          begin

            Result := Result + ' ' + Liczba_Arabska_W_Rzymska( gracze_nazwy__kopia_numer_f );

          end;
        //---//if   ( numeruj_wszystkie_nazwy_f ) (...)

      end
    else//if zti > 0 then
      begin

        Result := Trim(  FormatFloat( '00000', Random( 10000 ) )  );

      end;
    //---//if zti > 0 then

  end;//---//Funkcja Gracz__Nazwa_Wyznacz() w Gracze__Wylosuj().

var
  numeruj_wszystkie_nazwy : boolean;

  i,
  gracze_nazwy__kopia_numer
    : integer;

  zts : string;

  gracze_nazwy_l,
  gracze_nazwy__kopia_l
    : System.Classes.TStringList;
begin//Funkcja Gracze__Wylosuj().

  Self.Gracze__Zwolnij();


  Self.potyczki__iloœæ__ra := 0;
  Self.w¹tki__iloœæ__ra := 0;
  Self.w¹tki__wszystkie_gotowe__ra := false;


  gracze_nazwy_l := System.Classes.TStringList.Create();
  gracze_nazwy__kopia_l := System.Classes.TStringList.Create();

  if System.SysUtils.FileExists( System.SysUtils.ExtractFilePath( Vcl.Forms.Application.ExeName ) + Ranking.gracze_nazwy__plik_nazwa_c ) then
    gracze_nazwy_l.LoadFromFile(  System.SysUtils.ExtractFilePath( Vcl.Forms.Application.ExeName ) + Ranking.gracze_nazwy__plik_nazwa_c, System.SysUtils.TEncoding.UTF8  );

  gracze_nazwy__kopia_l.Text := gracze_nazwy_l.Text;
  gracze_nazwy__kopia_numer := 1;

  numeruj_wszystkie_nazwy := gracze__iloœæ_f > gracze_nazwy_l.Count;


  SetLength( Self.gracz_t, gracze__iloœæ_f );


  for i := 0 to gracze__iloœæ_f - 1 do
    begin

      if    ( i = 0 )
        and (  Trim( gracz__nazwa_f ) <> ''  ) then
        zts := gracz__nazwa_f
      else//if    ( i = 0 ) (...)
        zts := Gracz__Nazwa_Wyznacz( numeruj_wszystkie_nazwy, gracze_nazwy__kopia_numer, gracze_nazwy_l );


      Self.gracz_t[ i ] := Gracz.TGracz.Create( zts );
      Self.gracz_t[ i ].Gracz__Id__Zmieñ__Gr( i + 1 );

      if i = 0 then
        Self.gracz_t[ i ].Gra_Gracz__Zmieñ__Gr( true );


      if gracze_nazwy_l.Count <= 0 then
        begin

          gracze_nazwy_l.Text := gracze_nazwy__kopia_l.Text;
          inc( gracze_nazwy__kopia_numer );

        end;
      //---//if gracze_nazwy_l.Count <= 0 then

    end;
  //---//for i := 0 to gracze__iloœæ_f - 1 do


  System.SysUtils.FreeAndNil( gracze_nazwy_l );
  System.SysUtils.FreeAndNil( gracze_nazwy__kopia_l );

end;//---//Funkcja Gracze__Wylosuj().

procedure TRanking.Gracze__Zwolnij();
var
  i : integer;
begin

  for i := Length( Self.gracz_t ) - 1 downto 0 do
    System.SysUtils.FreeAndNil( Self.gracz_t[ i ] );

  SetLength( Self.gracz_t, 0 );

end;//---//Funkcja Gracze__Zwolnij().

procedure TRanking.Potyczka__Odbyta__Zeruj_Wszystkich_Graczy__Ra();
var
  i : integer;
begin

  for i := 0 to Length( Self.gracz_t ) - 1 do
    Self.gracz_t[ i ].Potyczka_Odbyta__Zmieñ__Gr( false );

end;//---//Funkcja Potyczka__Odbyta__Zeruj_Wszystkich_Graczy__Ra().

function TRanking.Potyczka__Przeciwnik_Wylosuj__Ra( const gracz_f : Gracz.TGracz ) : Gracz.TGracz;
var
  i,
  zti_1,
  zti_2
    : integer;

  gracz_t_l : array of Gracz.TGracz;
begin

  Result := nil;

  if gracz_f = nil then
    Exit;


  zti_1 :=
      gracz_f.Ranking__Wartoœæ__Odczytaj__Gr()
    + gracz_f.Zwyciêstwa__Iloœæ__Pod_Rz¹d__Odczytaj__Gr()
    * Gracz.ranking__wartoœæ__zwyciêstwo_zmiana_c;


  for i := 0 to Length( Self.gracz_t ) - 1 do
    if    ( Self.gracz_t[ i ].Gracz__Id__Odczytaj__Gr() <> gracz_f.Gracz__Id__Odczytaj__Gr() )
      and ( not Self.gracz_t[ i ].Potyczka_Odbyta__Odczytaj__Gr() )
      and (
                Self.gracz_t[ i ].Ranking__Wartoœæ__Odczytaj__Gr()
              + Self.gracz_t[ i ].Zwyciêstwa__Iloœæ__Pod_Rz¹d__Odczytaj__Gr()
              * Gracz.ranking__wartoœæ__zwyciêstwo_zmiana_c
            >= zti_1
          ) then
      begin

         zti_2 := Length( gracz_t_l );
         SetLength( gracz_t_l, zti_2 + 1 );
         gracz_t_l[ zti_2 ] := Self.gracz_t[ i ];

      end;
    //---//if    ( Self.gracz_t[ i ].Gracz__Id__Odczytaj__Gr() <> gracz_f.Gracz__Id__Odczytaj__Gr() ) (...)


  zti_2 := Length( gracz_t_l );


  if zti_2 <= 0 then
    for i := 0 to Length( Self.gracz_t ) - 1 do
      if    ( Self.gracz_t[ i ].Gracz__Id__Odczytaj__Gr() <> gracz_f.Gracz__Id__Odczytaj__Gr() )
        and ( not Self.gracz_t[ i ].Potyczka_Odbyta__Odczytaj__Gr() ) then
        begin

           zti_2 := Length( gracz_t_l );
           SetLength( gracz_t_l, zti_2 + 1 );
           gracz_t_l[ zti_2 ] := Self.gracz_t[ i ];

        end;
      //---//if    ( Self.gracz_t[ i ].Gracz__Id__Odczytaj__Gr() <> gracz_f.Gracz__Id__Odczytaj__Gr() ) (...)


  zti_1 := Random( zti_2 );

  Result := gracz_t_l[ zti_1 ];

  SetLength( gracz_t_l, 0 );

end;//---//Funkcja Potyczka__Przeciwnik_Wylosuj__Ra().

procedure TRanking.Potyczka__Przelicz__Ra( const bitwa_dominia__przeliczeñ_w_turze_f, dominium__wytrzyma³oœæ_punkty_f : integer; gracz__1_f, gracz__2_f : Gracz.TGracz );
var
  zt_bitwa_dominia_wynik__gracz__1 : Bitwa_Dominia.TBitwa_Dominia_Wynik;
begin

  if   ( gracz__1_f = nil )
    or ( gracz__2_f = nil ) then
    Exit;


  gracz__1_f.Potyczka_Odbyta__Zmieñ__Gr( true );
  gracz__2_f.Potyczka_Odbyta__Zmieñ__Gr( true );

  zt_bitwa_dominia_wynik__gracz__1 := Bitwa_Dominia.TBitwa_Dominia.Bitwa__Dominia_Przelicz__Bd( bitwa_dominia__przeliczeñ_w_turze_f, dominium__wytrzyma³oœæ_punkty_f, gracz__1_f, gracz__2_f, Self.Potyczki__Iloœæ__Odczytaj__Ra() );

  if zt_bitwa_dominia_wynik__gracz__1 = Bitwa_Dominia.bdw_pora¿ka then
    begin

      gracz__1_f.Pora¿ki__Iloœæ__Zwiêksz__Gr();
      gracz__1_f.Ranking__Wartoœæ__Zmniejsz__Gr();
      gracz__1_f.Zwyciêstwa__Iloœæ__Pod_Rz¹d__Zmniejsz__Gr();

      gracz__2_f.Zwyciêstwa__Iloœæ__Zwiêksz__Gr();
      gracz__2_f.Zwyciêstwa__Iloœæ__Pod_Rz¹d__Zwiêksz__Gr();
      gracz__2_f.Ranking__Wartoœæ__Zwiêksz__Gr( gracz__1_f.Ranking__Wartoœæ__Odczytaj__Gr() );

    end
  else//if zt_bitwa_dominia_wynik__gracz__1 = Bitwa_Dominia.bdw_pora¿ka then
  if zt_bitwa_dominia_wynik__gracz__1 = Bitwa_Dominia.bdw_remis then
    begin

      gracz__1_f.Remisy__Iloœæ__Zwiêksz__Gr();
      gracz__1_f.Ranking__Wartoœæ__Zwiêksz__Gr();
      gracz__1_f.Ranking__Wartoœæ__Zmniejsz__Gr();

      gracz__2_f.Remisy__Iloœæ__Zwiêksz__Gr();
      gracz__2_f.Ranking__Wartoœæ__Zwiêksz__Gr();
      gracz__2_f.Ranking__Wartoœæ__Zmniejsz__Gr();

    end
  else//if zt_bitwa_dominia_wynik__gracz__1 = Bitwa_Dominia.bdw_remis then
  if zt_bitwa_dominia_wynik__gracz__1 = Bitwa_Dominia.bdw_zwyciêstwo then
    begin

      gracz__1_f.Zwyciêstwa__Iloœæ__Zwiêksz__Gr();
      gracz__1_f.Zwyciêstwa__Iloœæ__Pod_Rz¹d__Zwiêksz__Gr();
      gracz__1_f.Ranking__Wartoœæ__Zwiêksz__Gr( gracz__2_f.Ranking__Wartoœæ__Odczytaj__Gr() );

      gracz__2_f.Pora¿ki__Iloœæ__Zwiêksz__Gr();
      gracz__2_f.Ranking__Wartoœæ__Zmniejsz__Gr();
      gracz__2_f.Zwyciêstwa__Iloœæ__Pod_Rz¹d__Zmniejsz__Gr();

    end;
  //---//if zt_bitwa_dominia_wynik__gracz__1 = Bitwa_Dominia.bdw_zwyciêstwo then


  if not gracz__1_f.Gra_Gracz__Odczytaj__Gr() then
    gracz__1_f.Rozbuduj();

  if not gracz__2_f.Gra_Gracz__Odczytaj__Gr() then
    gracz__2_f.Rozbuduj();

end;//---//Funkcja Potyczka__Przelicz__Ra().

function TRanking.Potyczki__Iloœæ__Odczytaj__Ra() : integer;
begin

  Result := Self.potyczki__iloœæ__ra;

end;//---//Funkcja Potyczki__Iloœæ__Odczytaj__Ra().

procedure TRanking.Potyczki__Runda__Przelicz__Ra( const bitwa_dominia__przeliczeñ_w_turze_f, dominium__wytrzyma³oœæ_punkty_f : integer; w¹tki__iloœæ_f : integer; const przeliczaj_w_tle_f : boolean; const tylko_gracz_f : boolean = false );
type
  TPotyczka_Gracze_Para = record
    gracz__1__pgp,
    gracz__2__pgp
     : Gracz.TGracz;
  end;//---//TPotyczka_Gracze_Para = record

  TPotyczka_Gracze_Pary = array of TPotyczka_Gracze_Para;

  //Funkcja Potyczka_Przelicz_Gracz_L() w Potyczki__Runda__Przelicz__Ra().
  procedure Potyczka_Przelicz_Gracz_L( const bitwa_dominia__przeliczeñ_w_turze_f_f, dominium__wytrzyma³oœæ_punkty_f_f : integer; gracz__1_f, gracz__2_f : Gracz.TGracz );
  begin

    if gracz__2_f.Gra_Gracz__Odczytaj__Gr() then
      Self.Potyczka__Przelicz__Ra( bitwa_dominia__przeliczeñ_w_turze_f_f, dominium__wytrzyma³oœæ_punkty_f_f, gracz__2_f, gracz__1_f )
    else//if gracz__2_f.Gra_Gracz__Odczytaj__Gr() then
      Self.Potyczka__Przelicz__Ra( bitwa_dominia__przeliczeñ_w_turze_f_f, dominium__wytrzyma³oœæ_punkty_f_f, gracz__1_f, gracz__2_f );

  end;//---//Funkcja Potyczka_Przelicz_Gracz_L() w Potyczki__Runda__Przelicz__Ra().

  //Funkcja W¹tek_Utwórz_L() w Potyczki__Runda__Przelicz__Ra().
  procedure W¹tek_Utwórz_L( const bitwa_dominia__przeliczeñ_w_turze_f_f, dominium__wytrzyma³oœæ_punkty_f_f : integer; potyczka_gracze_pary_t_f : TPotyczka_Gracze_Pary );
  begin

    inc( Self.w¹tki__iloœæ__ra );


    System.Threading.TTask.Run
      (
        procedure
          var
            i_l : integer;
          begin

            for i_l := 0 to Length( potyczka_gracze_pary_t_f ) - 1 do
              Self.Potyczka__Przelicz__Ra( bitwa_dominia__przeliczeñ_w_turze_f_f, dominium__wytrzyma³oœæ_punkty_f_f, potyczka_gracze_pary_t_f[ i_l ].gracz__1__pgp, potyczka_gracze_pary_t_f[ i_l ].gracz__2__pgp );


            TThread.Synchronize
              (
                TThread.Current,
                procedure
                  begin

                    dec( Self.w¹tki__iloœæ__ra );


                    if @Self.Postêp__Odœwie¿__Ra <> nil then
                      Self.Postêp__Odœwie¿__Ra();


                    Self.Przeliczanie_W_Tle__Zakoñcz__Ra();

                  end
                //---//TThread.Current
              );
            //---//TThread.Synchronize

          end
      );
    //---//System.Threading.TTask.Run

  end;//---//Funkcja W¹tek_Utwórz_L() w Potyczki__Runda__Przelicz__Ra().

var
  i,
  zti,
  potyczek__na_w¹tek_l,
  potyczek__w_w¹tku_l
    : integer;

  zt_potyczka_gracze_pary__0_t_l,
  zt_potyczka_gracze_pary__1_t_l
    : TPotyczka_Gracze_Pary;
begin//Funkcja Potyczki__Runda__Przelicz__Ra().

  inc( Self.potyczki__iloœæ__ra );


  Self.Potyczka__Odbyta__Zeruj_Wszystkich_Graczy__Ra();


  if    ( przeliczaj_w_tle_f )
    and ( not tylko_gracz_f ) then
    begin

      Self.w¹tki__iloœæ__ra := 0;
      Self.w¹tki__wszystkie_gotowe__ra := false;


      for i := Length( Self.gracz_t ) - 1 downto 1 do
        begin

          if not Self.gracz_t[ i ].Potyczka_Odbyta__Odczytaj__Gr() then
            begin

              zti := Length( zt_potyczka_gracze_pary__0_t_l );
              SetLength( zt_potyczka_gracze_pary__0_t_l, zti + 1 );

              zt_potyczka_gracze_pary__0_t_l[ zti ].gracz__1__pgp := Self.gracz_t[ i ];
              zt_potyczka_gracze_pary__0_t_l[ zti ].gracz__2__pgp := Self.Potyczka__Przeciwnik_Wylosuj__Ra( zt_potyczka_gracze_pary__0_t_l[ zti ].gracz__1__pgp );


              zt_potyczka_gracze_pary__0_t_l[ zti ].gracz__1__pgp.Potyczka_Odbyta__Zmieñ__Gr( true );
              zt_potyczka_gracze_pary__0_t_l[ zti ].gracz__2__pgp.Potyczka_Odbyta__Zmieñ__Gr( true );

            end;
          //---//if not Self.gracz_t[ i ].Potyczka_Odbyta__Odczytaj__Gr() then

        end;
      //---//for i := Length( Self.gracz_t ) - 1 downto 1 do


      if w¹tki__iloœæ_f <= 0 then
        w¹tki__iloœæ_f := 1;

      potyczek__na_w¹tek_l := System.Math.Ceil(  Length( zt_potyczka_gracze_pary__0_t_l ) / w¹tki__iloœæ_f  );
      potyczek__w_w¹tku_l := 0;


      for i := 0 to Length( zt_potyczka_gracze_pary__0_t_l ) - 1 do
        if    ( not zt_potyczka_gracze_pary__0_t_l[ i ].gracz__1__pgp.Gra_Gracz__Odczytaj__Gr() )
          and ( not zt_potyczka_gracze_pary__0_t_l[ i ].gracz__2__pgp.Gra_Gracz__Odczytaj__Gr() ) then
          begin

            inc( potyczek__w_w¹tku_l );

            zti := Length( zt_potyczka_gracze_pary__1_t_l );
            SetLength( zt_potyczka_gracze_pary__1_t_l, zti + 1 );

            zt_potyczka_gracze_pary__1_t_l[ zti ].gracz__1__pgp := zt_potyczka_gracze_pary__0_t_l[ i ].gracz__1__pgp;
            zt_potyczka_gracze_pary__1_t_l[ zti ].gracz__2__pgp := zt_potyczka_gracze_pary__0_t_l[ i ].gracz__2__pgp;


            if   ( potyczek__w_w¹tku_l >= potyczek__na_w¹tek_l )
              or (  i >= Length( zt_potyczka_gracze_pary__0_t_l ) - 1  ) then
              begin

                W¹tek_Utwórz_L( bitwa_dominia__przeliczeñ_w_turze_f, dominium__wytrzyma³oœæ_punkty_f, zt_potyczka_gracze_pary__1_t_l );

                potyczek__w_w¹tku_l := 0;
                SetLength( zt_potyczka_gracze_pary__1_t_l, 0 );

              end;
            //---//if   ( potyczek__w_w¹tku_l >= potyczek__na_w¹tek_l ) (...)

          end;
        //---//if    ( not zt_potyczka_gracze_pary__0_t_l[ i ].gracz__1__pgp.Gra_Gracz__Odczytaj__Gr() ) (...)


      for i := 0 to Length( zt_potyczka_gracze_pary__0_t_l ) - 1 do
        if   ( zt_potyczka_gracze_pary__0_t_l[ i ].gracz__1__pgp.Gra_Gracz__Odczytaj__Gr() )
          or ( zt_potyczka_gracze_pary__0_t_l[ i ].gracz__2__pgp.Gra_Gracz__Odczytaj__Gr() ) then
          begin

            inc( Self.w¹tki__iloœæ__ra );

            Potyczka_Przelicz_Gracz_L( bitwa_dominia__przeliczeñ_w_turze_f, dominium__wytrzyma³oœæ_punkty_f, zt_potyczka_gracze_pary__0_t_l[ i ].gracz__1__pgp, zt_potyczka_gracze_pary__0_t_l[ i ].gracz__2__pgp );

            dec( Self.w¹tki__iloœæ__ra );
            Self.w¹tki__wszystkie_gotowe__ra := true;


            Self.Przeliczanie_W_Tle__Zakoñcz__Ra();

          end;
        //---//if   ( not zt_potyczka_gracze_pary__0_t_l[ i ].gracz__1__pgp.Gra_Gracz__Odczytaj__Gr() ) (...)

    end
  else//if    ( przeliczaj_w_tle_f ) (...)
    begin

      SetLength( zt_potyczka_gracze_pary__0_t_l, 1 );


      for i := Length( Self.gracz_t ) - 1 downto 1 do
        begin

          if   (
                     ( tylko_gracz_f )
                 and ( Self.gracz_t[ i ].Gra_Gracz__Odczytaj__Gr() )
               )
            or (
                     ( not tylko_gracz_f )
                 and ( not Self.gracz_t[ i ].Potyczka_Odbyta__Odczytaj__Gr() )
               ) then
            begin

              zt_potyczka_gracze_pary__0_t_l[ 0 ].gracz__1__pgp := Self.gracz_t[ i ];
              zt_potyczka_gracze_pary__0_t_l[ 0 ].gracz__2__pgp := Self.Potyczka__Przeciwnik_Wylosuj__Ra( zt_potyczka_gracze_pary__0_t_l[ 0 ].gracz__1__pgp );

              Potyczka_Przelicz_Gracz_L( bitwa_dominia__przeliczeñ_w_turze_f, dominium__wytrzyma³oœæ_punkty_f, zt_potyczka_gracze_pary__0_t_l[ 0 ].gracz__1__pgp, zt_potyczka_gracze_pary__0_t_l[ 0 ].gracz__2__pgp );


              if tylko_gracz_f then
                Break;

            end;
          //---//if   ( (...)


          if @Self.Postêp__Odœwie¿__Ra <> nil then
            Self.Postêp__Odœwie¿__Ra();

        end;
      //---//for i := Length( Self.gracz_t ) - 1 downto 1 do


      SetLength( zt_potyczka_gracze_pary__0_t_l, 0 );


      Self.Gracze__Sortuj();

    end;
  //---//if    ( przeliczaj_w_tle_f ) (...)

end;//---//Funkcja Potyczki__Runda__Przelicz__Ra().

procedure TRanking.Przeliczanie_W_Tle__Zakoñcz__Ra();
begin

  if    ( Self.w¹tki__iloœæ__ra <= 0 )
    and ( Self.w¹tki__wszystkie_gotowe__ra ) then
    begin

      Self.Gracze__Sortuj();


      if @Self.Przeliczanie_W_Tle__Zakoñczone__Ra <> nil then
        Self.Przeliczanie_W_Tle__Zakoñczone__Ra();

    end;
  //---//if    ( Self.w¹tki__iloœæ__ra <= 0 ) (...)

end;//---//Funkcja Przeliczanie_W_Tle__Zakoñcz__Ra().

procedure TRanking.Ranking__Wczytaj();
var
  i,
  zti,
  gracz_id__l
    : integer;
  ranking_l : System.Classes.TStringList;
  zt_gracz : Gracz.TGracz;
begin

  if not System.SysUtils.FileExists( System.SysUtils.ExtractFilePath( Vcl.Forms.Application.ExeName ) + Ranking.ranking__plik__nazwa_c ) then
    Exit;


  Self.Gracze__Zwolnij();

  ranking_l := System.Classes.TStringList.Create();
  ranking_l.LoadFromFile(  System.SysUtils.ExtractFilePath( Vcl.Forms.Application.ExeName ) + Ranking.ranking__plik__nazwa_c, System.SysUtils.TEncoding.UTF8  );

  i := 0;
  gracz_id__l := Definicje.identyfikator_pusty_c;


  if ranking_l.Count > 0 then
    begin

      Self.potyczki__iloœæ__ra := StrToIntDef( ranking_l[ i ], 0 );
      inc( i );

    end;
  //---//if ranking_l.Count > 0 then


  while i < ranking_l.Count - 1 do
    begin

      if ranking_l[ i ] = Ranking.ranking__plik__nowy_gracz_symbol_c then
        begin

          inc( i );

          try
            gracz_id__l := StrToInt( ranking_l[ i ] );
          except
            gracz_id__l := Definicje.identyfikator_pusty_c;
          end;
          //---//try


          if gracz_id__l <> Definicje.identyfikator_pusty_c then
            begin

              inc( i );
              zt_gracz := Gracz.TGracz.Create( ranking_l[ i ] );
              zt_gracz.Gracz__Id__Zmieñ__Gr( gracz_id__l );

              inc( i );
              zt_gracz.Gra_Gracz__Zmieñ__Gr(  StrToBoolDef( ranking_l[ i ], false )  );

              inc( i );
              zt_gracz.Atak__Wspó³czynnik__Zmieñ__Gr(  StrToFloatDef( ranking_l[ i ], 1 )  );

              inc( i );
              zt_gracz.Obrona__Wspó³czynnik__Zmieñ__Gr(  StrToFloatDef( ranking_l[ i ], 1 )  );

              inc( i );
              zt_gracz.Obserwacja__Zasiêg_Wspó³czynnik__Zmieñ__Gr(  StrToFloatDef( ranking_l[ i ], 1 )  );

              inc( i );
              zt_gracz.Pora¿ki__Iloœæ__Zmieñ__Gr(  StrToIntDef( ranking_l[ i ], 0 )  );

              inc( i );
              zt_gracz.Ranking__Wartoœæ__Zmieñ__Gr(  StrToIntDef( ranking_l[ i ], 0 )  );

              inc( i );
              zt_gracz.Remisy__Iloœæ__Zmieñ__Gr(  StrToIntDef( ranking_l[ i ], 0 )  );

              inc( i );
              zt_gracz.Rozbudowa__Punkty__Zmieñ__Gr(  StrToIntDef( ranking_l[ i ], 0 )  );

              inc( i );
              zt_gracz.Strategia_Typ__Zmieñ__Gr(  StrToIntDef( ranking_l[ i ], 0 )  );

              inc( i );
              zt_gracz.Surowiec__Produkcja__Wspó³czynnik__Zmieñ__Gr(  StrToFloatDef( ranking_l[ i ], 1 )  );

              inc( i );
              zt_gracz.Zamek__Produkcja__Wspó³czynnik__Zmieñ__Gr(  StrToFloatDef( ranking_l[ i ], 1 )  );

              inc( i );
              zt_gracz.Zwyciêstwa__Iloœæ__Zmieñ__Gr(  StrToIntDef( ranking_l[ i ], 0 )  );

              inc( i );
              zt_gracz.Zwyciêstwa__Iloœæ__Pod_Rz¹d__Zmieñ__Gr(  StrToIntDef( ranking_l[ i ], 0 )  );


              zti := Length( Self.gracz_t );
              SetLength( Self.gracz_t, zti + 1 );
              Self.gracz_t[ zti ] := zt_gracz;

            end;
          //---//if gracz_id__l <> Definicje.identyfikator_pusty_c then

        end;
      //---//if ranking_l[ i ] = Ranking.ranking__plik__nowy_gracz_symbol_c then


      inc( i );

    end;
  //---//while i < ranking_l.Count - 1 do


  System.SysUtils.FreeAndNil( ranking_l );

end;//---//Funkcja Ranking__Wczytaj().

procedure TRanking.Ranking__Zapisz();
var
  i : integer;
  zts : string;
  ranking_l : System.Classes.TStringList;
begin

  ranking_l := System.Classes.TStringList.Create();


  ranking_l.Add(  IntToStr( Self.potyczki__iloœæ__ra )  );


  for i := 0 to Length( Self.gracz_t ) - 1 do
    begin

      ranking_l.Add( Ranking.ranking__plik__nowy_gracz_symbol_c );
      ranking_l.Add(  IntToStr( Self.gracz_t[ i ].Gracz__Id__Odczytaj__Gr() )  );

      zts := Self.gracz_t[ i ].Nazwa__Odczytaj__Gr();
      zts := StringReplace( zts, #10, '', [ rfReplaceAll ] );
      zts := StringReplace( zts, #13, '', [ rfReplaceAll ] );

      if    (  Length( zts ) > 0  )
        and ( zts[ 1 ] = Ranking.ranking__plik__nowy_gracz_symbol_c ) then
        zts[ 1 ] := ' ';

      ranking_l.Add( zts );
      ranking_l.Add(  BoolToStr( Self.gracz_t[ i ].Gra_Gracz__Odczytaj__Gr() )  );
      ranking_l.Add(  FloatToStr( Self.gracz_t[ i ].Atak__Wspó³czynnik__Odczytaj__Gr() )  );
      ranking_l.Add(  FloatToStr( Self.gracz_t[ i ].Obrona__Wspó³czynnik__Odczytaj__Gr() )  );
      ranking_l.Add(  FloatToStr( Self.gracz_t[ i ].Obserwacja__Zasiêg_Wspó³czynnik__Odczytaj__Gr() )  );
      ranking_l.Add(  IntToStr( Self.gracz_t[ i ].Pora¿ki__Iloœæ__Odczytaj__Gr() )  );
      ranking_l.Add(  IntToStr( Self.gracz_t[ i ].Ranking__Wartoœæ__Odczytaj__Gr() )  );
      ranking_l.Add(  IntToStr( Self.gracz_t[ i ].Remisy__Iloœæ__Odczytaj__Gr() )  );
      ranking_l.Add(  IntToStr( Self.gracz_t[ i ].Rozbudowa__Punkty__Odczytaj__Gr() )  );
      ranking_l.Add(  IntToStr( integer(Self.gracz_t[ i ].Strategia_Typ__Odczytaj__Gr()) )  );
      ranking_l.Add(  FloatToStr( Self.gracz_t[ i ].Surowiec__Produkcja__Wspó³czynnik__Odczytaj__Gr() )  );
      ranking_l.Add(  FloatToStr( Self.gracz_t[ i ].Zamek__Produkcja__Wspó³czynnik__Odczytaj__Gr() )  );
      ranking_l.Add(  IntToStr( Self.gracz_t[ i ].Zwyciêstwa__Iloœæ__Odczytaj__Gr() )  );
      ranking_l.Add(  IntToStr( Self.gracz_t[ i ].Zwyciêstwa__Iloœæ__Pod_Rz¹d__Odczytaj__Gr() )  );

    end;
  //---//for i := 0 to Length( Self.gracz_t ) - 1 do


  ranking_l.SaveToFile(  System.SysUtils.ExtractFilePath( Vcl.Forms.Application.ExeName ) + Ranking.ranking__plik__nazwa_c, System.SysUtils.TEncoding.UTF8  );
  System.SysUtils.FreeAndNil( ranking_l );

end;//---//Funkcja Ranking__Zapisz().

end.
