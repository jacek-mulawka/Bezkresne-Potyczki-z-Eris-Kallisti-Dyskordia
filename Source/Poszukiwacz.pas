unit Poszukiwacz;{21.Sie.2026 z 11.Mar.2011}

  //
  // MIT License
  //
  // Copyright (c) 2011 Jacek Mulawka
  //
  // j.mulawka@interia.pl
  //
  // https://github.com/jacek-mulawka
  //

interface

uses
  System.Classes,
  System.SysUtils;

type
  TPoszukiwacz_Wynik = ( pw_wszystko_w_porz¹dku, pw_mapa_jest_pusta, pw_z_pola_pocz¹tkowego_nie_mo¿na_siê_przemieœciæ, pw_punkt_docelowy_jest_nieosi¹galny, pw_brak_mo¿liwoœci_ruchu );

  TTablica2D_Integer = array of array of integer;

  TPoszukiwacz = class
  private
    { Private declarations }
    start__x,
    start__y,
    stop__x,
    stop__y,

    fdroga__d³ugoœæ
      : integer;

    kierunki_ruchu_t : array [ 1..8, 1..2 ] of integer;
    //
    //  X, Y - [ i, j ].
    //
    //  815
    //  402
    //  736
    //

    // Musz¹ mieæ tak¹ sam¹ d³ugoœæ.
    droga__punkty__x_l,
    droga__punkty__y_l,
    punkty__kolejka__x_l,
    punkty__kolejka__y_l
      : System.Classes.TStringList;

    function Punkt__Nale¿y_Do__Mapy__SprawdŸ( const mapa_t_f : Poszukiwacz.TTablica2D_Integer; const x_f, y_f : integer ) : boolean;

    procedure Droga__Punkty__Wpisz__Do__Tabeli();
  public
    { Public declarations }
    constructor Create();
    destructor Destroy(); override;

    function Droga__Szukaj( const mapa_t_f : Poszukiwacz.TTablica2D_Integer; const x_od_f, y_od_f, x_do_f, y_do_f : integer ) : Poszukiwacz.TPoszukiwacz_Wynik;
  public
    { Public declarations }
    droga__punkty : Poszukiwacz.TTablica2D_Integer;
  published
    property droga__d³ugoœæ : integer read fdroga__d³ugoœæ;
  end;//---//TPoszukiwacz = class

const
  pole__dostêpne_c : integer = 0;
  pole__niedostêpne_c: integer = -2;
  pole__wolne_c: integer = -1;
  przejscie_przez_skosy_c : boolean = true;

implementation

//Konstruktor klasy TPoszukiwacz.
constructor TPoszukiwacz.Create();
begin

  Self.fdroga__d³ugoœæ := 0;

  // Wype³niania danych tabeli mo¿liwych kierunków ruchu.
  //
  //  X, Y - [ i, j ].
  //
  //  815
  //  402
  //  736
  //

  Self.kierunki_ruchu_t[ 1, 1 ] := -1;
  Self.kierunki_ruchu_t[ 1, 2 ] := 0;

  Self.kierunki_ruchu_t[ 5, 1 ] := -1;
  Self.kierunki_ruchu_t[ 5, 2 ] := 1;

  Self.kierunki_ruchu_t[ 2, 1 ] := 0;
  Self.kierunki_ruchu_t[ 2, 2 ] := 1;

  Self.kierunki_ruchu_t[ 6, 1 ] := 1;
  Self.kierunki_ruchu_t[ 6, 2 ] := 1;

  Self.kierunki_ruchu_t[ 3, 1 ] := 1;
  Self.kierunki_ruchu_t[ 3, 2 ] := 0;

  Self.kierunki_ruchu_t[ 7, 1 ] := 1;
  Self.kierunki_ruchu_t[ 7, 2 ] := -1;

  Self.kierunki_ruchu_t[ 4, 1 ] := 0;
  Self.kierunki_ruchu_t[ 4, 2 ] := -1;

  Self.kierunki_ruchu_t[ 8, 1 ] := -1;
  Self.kierunki_ruchu_t[ 8, 2 ] := -1;
  //---// Wype³niania danych tabeli mo¿liwych kierunków ruchu.


  Self.droga__punkty__x_l := System.Classes.TStringList.Create();
  Self.droga__punkty__y_l := System.Classes.TStringList.Create();

  Self.punkty__kolejka__x_l := System.Classes.TStringList.Create();
  Self.punkty__kolejka__y_l := System.Classes.TStringList.Create();

end;//---//Konstruktor klasy TPoszukiwacz.

//Destruktor klasy TPoszukiwacz.
destructor TPoszukiwacz.Destroy();
begin

  Self.droga__punkty__x_l.Free();
  Self.droga__punkty__y_l.Free();

  Self.punkty__kolejka__x_l.Free();
  Self.punkty__kolejka__y_l.Free();

end;//---//Destruktor klasy TPoszukiwacz.

//Funkcja Droga__Punkty__Wpisz__Do__Tabeli().
procedure TPoszukiwacz.Droga__Punkty__Wpisz__Do__Tabeli();
var
  i : integer;
begin

  SetLength( droga__punkty, 0, 0 );
  SetLength( droga__punkty, 2, Self.droga__punkty__x_l.Count );

  for i := 0 to Self.droga__punkty__x_l.Count - 1 do
    begin

      droga__punkty[ 0, i ] := System.SysUtils.StrToInt( Self.droga__punkty__x_l[ Self.droga__punkty__x_l.Count - 1 - i ] ); // X.
      droga__punkty[ 1, i ] := System.SysUtils.StrToInt( Self.droga__punkty__y_l[ Self.droga__punkty__x_l.Count - 1  - i ] ); // Y.

    end;
  //---//for i := 0 to Self.droga__punkty__x_l.Count - 1 do

end;//---//Funkcja Droga__Punkty__Wpisz__Do__Tabeli().

//Funkcja Droga__Szukaj().
function TPoszukiwacz.Droga__Szukaj( const mapa_t_f : Poszukiwacz.TTablica2D_Integer; const x_od_f, y_od_f, x_do_f, y_do_f : integer ) : Poszukiwacz.TPoszukiwacz_Wynik;

  //Funkcja Dojœcia__Wylicz() w Droga__Szukaj().
  procedure Dojœcia__Wylicz( mapa__kopia_t_f : Poszukiwacz.TTablica2D_Integer );
  var
    koniec_przeszukiwania_mapy : boolean;

    i,
    x_l,
    y_l,
    krok__waga,
    punkt__poprzedni__x,
    punkt__poprzedni__y,
    punkt__wyliczany__x,
    punkt__wyliczany__y
      : integer;
  begin

    //
    // Funkcja przeszukuje mapê i wpisuje wagi dojœcia do punktu stop.
    // Zatrzymuje siê gdy natrafi na punkt stop lub skoñczy siê mapa.
    //

    koniec_przeszukiwania_mapy := false;

    // X, Y - [ x_l, y_l ].
    // Wpisuje wartoœci do tabeli szukania drogi (wszystkie niedostêpne pola maj¹ wartoœæ -2, wolne -1).
    for x_l := 0 to Length( mapa_t_f ) - 1 do
      for y_l := 0 to Length( mapa_t_f[ x_l ] ) - 1 do
        if mapa_t_f [ x_l, y_l ] >= pole__dostêpne_c then
          mapa__kopia_t_f[ x_l, y_l ] := pole__wolne_c
        else//if mapa_t_f [ x_l, y_l ] >= pole__dostêpne_c then
          mapa__kopia_t_f[ x_l, y_l ] := pole__niedostêpne_c;
    //---// Wpisuje wartoœci do tabeli szukania drogi.

    x_l := Self.start__x;
    y_l := Self.start__y;

    punkt__poprzedni__x := Self.start__x;
    punkt__poprzedni__y := Self.start__y;

    krok__waga := 0;
    mapa__kopia_t_f[ x_l, y_l ] := krok__waga;
    Self.punkty__kolejka__x_l.Add(  System.SysUtils.IntToStr( Self.start__x )  );
    Self.punkty__kolejka__y_l.Add(  System.SysUtils.IntToStr( Self.start__y )  );

    // Przeszukuje mapê.
    while ( not koniec_przeszukiwania_mapy )
      and ( Self.punkty__kolejka__x_l.Count > 0 ) do
      begin

        punkt__poprzedni__x := System.SysUtils.StrToInt( Self.punkty__kolejka__x_l[ 0 ] );
        punkt__poprzedni__y := System.SysUtils.StrToInt( Self.punkty__kolejka__y_l[ 0 ] );

        krok__waga := mapa__kopia_t_f[ punkt__poprzedni__x, punkt__poprzedni__y ];
        inc( krok__waga );

        Self.punkty__kolejka__x_l.Delete( 0 );
        Self.punkty__kolejka__y_l.Delete( 0 );


        for i := 1 to Length( Self.kierunki_ruchu_t ) do
          begin

            punkt__wyliczany__x := punkt__poprzedni__x + Self.kierunki_ruchu_t[ i, 1 ];
            punkt__wyliczany__y := punkt__poprzedni__y + Self.kierunki_ruchu_t[ i, 2 ];

            // Czy wyliczany punkt mieœci siê na obszarze mapy.
            if Punkt__Nale¿y_Do__Mapy__SprawdŸ( mapa_t_f, punkt__wyliczany__x, punkt__wyliczany__y ) then
              begin

                x_l := punkt__wyliczany__x;
                y_l := punkt__wyliczany__y;

                if przejscie_przez_skosy_c then
                  begin

                    //      ***      Wersja, w której mo¿na przechodziæ przez przek¹tne œciany.      ***      //

                    // Je¿eli sprawdzany punkt nie by³ jeszcze odwiedzony.
                    if mapa__kopia_t_f[ x_l, y_l ] = pole__wolne_c then
                      begin

                        mapa__kopia_t_f[ x_l, y_l ] := krok__waga;
                        Self.punkty__kolejka__x_l.Add(  System.SysUtils.IntToStr( x_l )  );
                        Self.punkty__kolejka__y_l.Add(  System.SysUtils.IntToStr( y_l )  );

                        // Je¿eli sprawdzany punkt jest punktem docelowym.
                        if    ( x_l = stop__x )
                          and ( y_l = stop__y ) then
                          begin

                            koniec_przeszukiwania_mapy := true;
                            Break;

                          end;
                        //---//if    ( x_l = stop__x ) (...)

                      end;
                    //---//if mapa__kopia_t_f[ x_l, y_l ] = pole__wolne_c then

                    //---//      ***      Wersja, w której mo¿na przechodziæ przez przek¹tne œciany.      ***      //---//

                  end
                else//if przejscie_przez_skosy_c then
                  begin

                    //      ***      Wersja, w której NIE mo¿na przechodziæ przez przek¹tne œciany.      ***      //

                    if    ( mapa__kopia_t_f[ x_l, y_l ] = pole__wolne_c )
                      and (
                               ( Self.kierunki_ruchu_t[ i, 1 ] = pole__dostêpne_c )
                            or ( Self.kierunki_ruchu_t[ i, 2 ] = pole__dostêpne_c )
                            or
                               (
                                     ( mapa_t_f[  punkt__poprzedni__x + Self.kierunki_ruchu_t[ i, 1 ], punkt__poprzedni__y  ] >= pole__dostêpne_c )
                                 and ( mapa_t_f[  punkt__poprzedni__x, punkt__poprzedni__y + Self.kierunki_ruchu_t[ i, 2 ]  ] >= pole__dostêpne_c )
                               )
                          ) then
                      begin

                        mapa__kopia_t_f[ x_l, y_l ] := krok__waga;
                        Self.punkty__kolejka__x_l.Add(  System.SysUtils.IntToStr( x_l )  );
                        Self.punkty__kolejka__y_l.Add(  System.SysUtils.IntToStr( y_l )  );

                        // Je¿eli sprawdzany punkt jest punktem docelowym.
                        if    ( x_l = stop__x )
                          and ( y_l = stop__y ) then
                          begin

                            koniec_przeszukiwania_mapy := true;
                            Break;

                          end;
                        //---//if    ( x_l = stop__x ) (...)n

                      end;
                    //---//if    ( mapa__kopia_t_f[ x_l, y_l ] = pole__wolne_c ) (...)

                    //---//      ***      Wersja, w której NIE mo¿na przechodziæ przez przek¹tne œciany.      ***      //---//

                   end;
                //---//if przejscie_przez_skosy_c then

              end;
            //---//if Punkt__Nale¿y_Do__Mapy__SprawdŸ( mapa_t_f, punkt__wyliczany__x, punkt__wyliczany__y ) then
            //---// Czy wyliczany punkt mieœci siê na obszarze mapy.

          end;
        //---//for i := 1 to Length( Self.kierunki_ruchu_t ) do

      end;
    //---//while ( not koniec_przeszukiwania_mapy ) (...)
    //---// Przeszukuje mapê.

  end;//---//Funkcja Dojœcia__Wylicz() w Droga__Szukaj().

  //Funkcja Droga__Punkty__Wpisz__Do__List() w Droga__Szukaj().
  procedure Droga__Punkty__Wpisz__Do__List( mapa__kopia_t_f : Poszukiwacz.TTablica2D_Integer );
  var
    i,
    x_l,
    y_l,
    krok__waga,
    punkt__poprzedni__x,
    punkt__poprzedni__y,
    punkt__wyliczany__x,
    punkt__wyliczany__y
      : integer;
  begin

    //
    // Funkcja wybiera punktu dojœcia od punktu stop do punktu start.
    //

    punkt__poprzedni__x := System.SysUtils.StrToInt( Self.punkty__kolejka__x_l[ Self.punkty__kolejka__x_l.Count - 1 ] );
    punkt__poprzedni__y := System.SysUtils.StrToInt( Self.punkty__kolejka__y_l[ Self.punkty__kolejka__y_l.Count - 1 ] );

    x_l := punkt__poprzedni__x;
    y_l := punkt__poprzedni__y;

    krok__waga := mapa__kopia_t_f[ x_l, y_l ];

    Self.fdroga__d³ugoœæ := 0;

    Self.droga__punkty__x_l.Clear();
    Self.droga__punkty__y_l.Clear();

    Self.droga__punkty__x_l.Add(  System.SysUtils.IntToStr( stop__x )  );
    Self.droga__punkty__y_l.Add(  System.SysUtils.IntToStr( stop__y )  );

    while krok__waga > 0 do
      begin

        for i := 1 to Length( Self.kierunki_ruchu_t ) do
          begin

            punkt__wyliczany__x := punkt__poprzedni__x + Self.kierunki_ruchu_t[ i, 1 ];
            punkt__wyliczany__y := punkt__poprzedni__y + Self.kierunki_ruchu_t[ i, 2 ];

            // Czy wyliczany punkt mieœci siê na obszarze mapy.
            if Punkt__Nale¿y_Do__Mapy__SprawdŸ( mapa_t_f, punkt__wyliczany__x, punkt__wyliczany__y ) then
              begin

                x_l := punkt__wyliczany__x;
                y_l := punkt__wyliczany__y;


                // Je¿eli punkt ma wagê o jeden mniejsz¹ od poprzedniej.
                if mapa__kopia_t_f[ x_l, y_l ] = krok__waga - 1 then
                  begin

                    punkt__poprzedni__x := punkt__wyliczany__x;
                    punkt__poprzedni__y := punkt__wyliczany__y;

                    dec( krok__waga );

                    Self.droga__punkty__x_l.Add(  System.SysUtils.IntToStr( punkt__wyliczany__x )  );
                    Self.droga__punkty__y_l.Add(  System.SysUtils.IntToStr( punkt__wyliczany__y )  );

                    inc( Self.fdroga__d³ugoœæ );

                    Break;

                  end;
                //---//if mapa__kopia_t_f[ x_l, y_l ] = krok__waga - 1 then

              end;
            //---//if Punkt__Nale¿y_Do__Mapy__SprawdŸ( mapa_t_f, punkt__wyliczany__x, punkt__wyliczany__y ) then
            //---//Czy wyliczany punkt mieœci siê na obszarze mapy.

          end;
        //---//for i := 1 to Length( Self.kierunki_ruchu_t ) do

      end;
    //---//while krok__waga > 0 do

  end;//---//Funkcja Droga__Punkty__Wpisz__Do__List() w Droga__Szukaj().

  //Funkcja Punkt__Najblizszy_Dostêpny__Istnieje__SprawdŸ() w Droga__Szukaj().
  function Punkt__Najblizszy_Dostêpny__Istnieje__SprawdŸ( mapa__kopia_t_f : Poszukiwacz.TTablica2D_Integer ) : boolean;
  var
    x_l,
    y_l,
    zti,
    odleg³oœæ,
    punkt__najbli¿szy__x,
    punkt__najbli¿szy__y
      : integer;
  begin

    //
    // Funkcja szuka najbli¿szy punktowi stop dostêpny punkt.
    // Je¿eli nie mo¿na okreœliæ najbli¿szego dostêpnego punktu zwraca fa³sz.
    //

    Result := false;

    // Wyszukuje najbli¿szy punktowi docelowemu dostêpny punkt.
    odleg³oœæ := -1;
    punkt__najbli¿szy__x := -1;
    punkt__najbli¿szy__y := -1;


    // X, Y - [ x_l, y_l ].
    for x_l := 0 to Length( mapa__kopia_t_f ) - 1 do
      for y_l := 0 to Length( mapa__kopia_t_f[ x_l ] ) - 1 do
        begin

          // Tutaj zti przechowuje wyliczon¹ odleg³oœci punktu docelowego do aktualnie badanego punktu.
          zti := System.Abs( stop__x - x_l ) + System.Abs( stop__y - y_l );

          // Wartoœæ 0 ma punkt startowy, -1 punkty nie odwiedzone, -2 przeszkody.
          if   ( mapa__kopia_t_f[ x_l, y_l ] > pole__dostêpne_c )
           and (
                    ( odleg³oœæ = -1 )
                 or ( zti < odleg³oœæ )
               ) then
            begin

              punkt__najbli¿szy__x := x_l;
              punkt__najbli¿szy__y := y_l;
              odleg³oœæ := zti;

            end;
          //---//if   ( mapa__kopia_t_f[ x_l, y_l ] > pole__dostêpne_c ) (...)

        end;
      //---//for y_l := 0 to Length( mapa__kopia_t_f[ x_l ] ) - 1 do

    if odleg³oœæ > 0 then
      begin

        stop__x := punkt__najbli¿szy__x;
        stop__y := punkt__najbli¿szy__y;

        x_l := punkt__najbli¿szy__x;
        y_l := punkt__najbli¿szy__y;

        Result := true;

      end;
    //---// if odleg³oœæ > 0 then
    //---//Wyszukuje najbli¿szy punktowi docelowemu dostêpny punkt.

  end;//---//Funkcja Punkt__Najblizszy_Dostêpny__Istnieje__SprawdŸ() w Droga__Szukaj().

var
  mapa__kopia_t_l : Poszukiwacz.TTablica2D_Integer;
begin//Funkcja Droga__Szukaj().

  Result := Poszukiwacz.pw_wszystko_w_porz¹dku;


  Self.fdroga__d³ugoœæ := 0;
  SetLength( droga__punkty, 0, 0 );


  if Length( mapa_t_f ) <= 0 then
    begin

      Result := Poszukiwacz.pw_mapa_jest_pusta;
      Exit;

    end;
  //---//if Length( mapa_t_f ) <= 0 then


  // Wspó³rzêdne punktu pocz¹tkowego i docelowego.
  Self.start__x := x_od_f;
  Self.start__y := y_od_f;
  stop__x := x_do_f;
  stop__y := y_do_f;

  if Self.start__x < 0 then
    Self.start__x := 0;

  if Self.start__y < 0 then
    Self.start__y := 0;

  if stop__x < 0 then
    stop__x := 0;

  if stop__y < 0 then
    stop__y := 0;


  if Self.start__x > Length( mapa_t_f ) - 1 then
    Self.start__x := Length( mapa_t_f ) - 1;

  if Self.start__y > Length( mapa_t_f[ 0 ] ) - 1 then
    Self.start__y := Length( mapa_t_f[ 0 ] ) - 1;

  if stop__x > Length( mapa_t_f ) - 1 then
    stop__x := Length( mapa_t_f ) - 1;

  if stop__y > Length( mapa_t_f[ 0 ] ) - 1 then
    stop__y := Length( mapa_t_f[ 0 ] ) - 1;
  //---// Wspó³rzêdne punktu pocz¹tkowego i docelowego.


  if mapa_t_f[ Self.start__x, Self.start__y ] < pole__dostêpne_c then
    begin

      Result := Poszukiwacz.pw_z_pola_pocz¹tkowego_nie_mo¿na_siê_przemieœciæ;
      Exit;

    end;
  //---//if mapa_t_f[ start_wiersz, start_kolumna ] < pole__dostêpne_c then


  SetLength(  mapa__kopia_t_l, Length( mapa_t_f ), Length( mapa_t_f[ 0 ] )  ); // X, Y - domyœlnie jest wype³niona zerami.

  Dojœcia__Wylicz( mapa__kopia_t_l );

  // Je¿eli d³ugoœæ (kolejka_punktow_wiersz_l.Count = 0) jest równa 0 oznacza to, ¿e drogi nie znaleziono.
  if Self.punkty__kolejka__x_l.Count <= 0 then
    Result := Poszukiwacz.pw_punkt_docelowy_jest_nieosi¹galny;

  // Je¿eli nie znalaz³ drogi do punktu.
  if    ( Self.punkty__kolejka__x_l.Count <= 0 )
    and (  Punkt__Najblizszy_Dostêpny__Istnieje__SprawdŸ( mapa__kopia_t_l )  ) then
    Dojœcia__Wylicz( mapa__kopia_t_l );

  // Je¿eli znalaz³ punkt docelowy buduje œcie¿kê do niego.
  if Self.punkty__kolejka__x_l.Count > 0 then
    Droga__Punkty__Wpisz__Do__List( mapa__kopia_t_l )
  else
    Result := Poszukiwacz.pw_brak_mo¿liwoœci_ruchu;

  SetLength( mapa__kopia_t_l, 0, 0 );

  Droga__Punkty__Wpisz__Do__Tabeli();

end;//---//Funkcja Droga__Szukaj().

//Funkcja Punkt__Nale¿y_Do__Mapy__SprawdŸ().
function TPoszukiwacz.Punkt__Nale¿y_Do__Mapy__SprawdŸ( const mapa_t_f : Poszukiwacz.TTablica2D_Integer; const x_f, y_f : integer ) : boolean;
begin

  if    ( x_f >= 0 )
    and ( y_f >= 0 )
    and (  Length( mapa_t_f ) > 0  )
    and (  Length( mapa_t_f[ 0 ] ) > 0  )
    and (  x_f <= Length( mapa_t_f ) - 1 )
    and (  y_f <= Length( mapa_t_f[ 0 ] ) - 1 ) then
    Result := true
  else//if    ( x_f >= 0 ) (...)
    Result := false;

end;//---//Funkcja Punkt__Nale¿y_Do__Mapy__SprawdŸ().

end.




