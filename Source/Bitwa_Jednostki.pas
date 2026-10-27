unit Bitwa_Jednostki;{13.Sie.2026}

interface

uses
  System.SysUtils,

  Definicje,
  Dominium,
  Jednostka,
  Wizualizacja;

type
  TBitwa_Jednostki = class
  private
    { Private declarations }
    class procedure Jednostka__Uszkodzenia_Punkty__Zwiêksz__Bj( jednostki_f : Jednostka.TJednostki_t; const indeks_f : integer; const wartoœæ_f : real );
    class function Jednostka__Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Bj( const jednostki_f : Jednostka.TJednostki_t; const indeks_f : integer ) : real;

    class procedure Jednostki__Atak__Przelicz__Bj( jednostki__1_f, jednostki__2_f : Jednostka.TJednostki_t; const jednostka__broñ_rodzaj_f : Definicje.TJednostka_Broñ_Rodzaj );
    class procedure Jednostki__Cel__Wybierz__Bj( jednostki__1_f, jednostki__2_f : Jednostka.TJednostki_t; const jednostka__broñ_rodzaj_f : Definicje.TJednostka_Broñ_Rodzaj );
    class procedure Jednostki__Cel__Zbli¿_Siê__Bj( jednostki_f : Jednostka.TJednostki_t );
    class procedure Jednostki__Uszkodzenia_Punkty__Przelicz__Bj( var jednostki__1_f : Jednostka.TJednostki_t; jednostki__2_f : Jednostka.TJednostki_t );
  public
    { Public declarations }
    class function Bitwa__Jednostki_Przelicz__Bj( dominium__1_f, dominium__2_f : Dominium.TDominium ) : Definicje.TBitwa_Jednostki_Wynik;
    class function Bitwa__Jednostki__Jednostki__Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Bj( const jednostki_f : Jednostka.TJednostki_t ) : real;
    class function Bitwa__Jednostki__Koniec__Warunek__SprawdŸ__Bj( const jednostki__1_f, jednostki__2_f : Jednostka.TJednostki_t ) : boolean;
    class procedure Bitwa__Jednostki__Starcie__Przelicz__Bj( var bitwa_starcie_etap_f : Definicje.TBitwa_Starcie_Etap; var jednostki__1_f, jednostki__2_f : Jednostka.TJednostki_t; const gra_gracz_f : boolean = false );
    class procedure Bitwa__Jednostki__Starcie__Przygotuj__Bj( var bitwa_starcie_etap_f : Definicje.TBitwa_Starcie_Etap; dominium__1_f, dominium__2_f : Dominium.TDominium; var dominium__1__jednostki_t_f, dominium__2__jednostki_t_f : Jednostka.TJednostki_t );
    class procedure Bitwa__Jednostki__Starcie__Zwolnij__Bj( var dominium__1__jednostki_t_f, dominium__2__jednostki_t_f : Jednostka.TJednostki_t );
    class function Bitwa__Jednostki__Wynik__Odczytaj__Bj( const jednostki__1_f, jednostki__2_f : Jednostka.TJednostki_t ) : Definicje.TBitwa_Jednostki_Wynik;
  end;//---//TBitwa_Jednostki = class

implementation

class function TBitwa_Jednostki.Bitwa__Jednostki_Przelicz__Bj( dominium__1_f, dominium__2_f : Dominium.TDominium ) : Definicje.TBitwa_Jednostki_Wynik;
var
  bitwa_starcie_etap_l : Definicje.TBitwa_Starcie_Etap;

  jednostki__1,
  jednostki__2
    : Jednostka.TJednostki_t;
begin

  if   ( dominium__1_f = nil )
    or ( dominium__2_f = nil ) then
    Exit;


  Self.Bitwa__Jednostki__Starcie__Przygotuj__Bj( bitwa_starcie_etap_l, dominium__1_f, dominium__2_f, jednostki__1, jednostki__2 );


  while not Self.Bitwa__Jednostki__Koniec__Warunek__SprawdŸ__Bj( jednostki__1, jednostki__2 ) do
    Self.Bitwa__Jednostki__Starcie__Przelicz__Bj( bitwa_starcie_etap_l, jednostki__1, jednostki__2 );


  Result := Self.Bitwa__Jednostki__Wynik__Odczytaj__Bj( jednostki__1, jednostki__2 );


  Self.Bitwa__Jednostki__Starcie__Zwolnij__Bj( jednostki__1, jednostki__2 );

end;//---//Funkcja Bitwa__Jednostki_Przelicz__Bj().

class function TBitwa_Jednostki.Bitwa__Jednostki__Jednostki__Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Bj( const jednostki_f : Jednostka.TJednostki_t ) : real;
var
  i : integer;
begin

  Result := 0;


  for i := 0 to Length( jednostki_f ) - 1 do
    begin

      Result := Result
        + jednostki_f[ i ].Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Je();

    end;
  //---//for i := 0 to Length( jednostki_f ) - 1 do

end;//---//Funkcja Bitwa__Jednostki__Jednostki__Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Bj().

class function TBitwa_Jednostki.Bitwa__Jednostki__Koniec__Warunek__SprawdŸ__Bj( const jednostki__1_f, jednostki__2_f : Jednostka.TJednostki_t ) : boolean;
begin

  Result :=
       (  Self.Bitwa__Jednostki__Jednostki__Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Bj( jednostki__1_f ) <= 0  )
    or (  Self.Bitwa__Jednostki__Jednostki__Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Bj( jednostki__2_f ) <= 0  );

end;//---//Funkcja Bitwa__Jednostki__Koniec__Warunek__SprawdŸ__Bj().

class procedure TBitwa_Jednostki.Jednostka__Uszkodzenia_Punkty__Zwiêksz__Bj( jednostki_f : Jednostka.TJednostki_t; const indeks_f : integer; const wartoœæ_f : real );
begin

  if    ( indeks_f >= 0 )
    and (  Length( jednostki_f ) > 0  )
    and (  indeks_f < Length( jednostki_f )  ) then
    jednostki_f[ indeks_f ].Uszkodzenia_Punkty__Zwiêksz__Je( wartoœæ_f );

end;//---//Funkcja Jednostka__Uszkodzenia_Punkty__Zwiêksz__Bj().

class function TBitwa_Jednostki.Jednostka__Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Bj( const jednostki_f : Jednostka.TJednostki_t; const indeks_f : integer ) : real;
begin

  if    ( indeks_f >= 0 )
    and (  Length( jednostki_f ) > 0  )
    and (  indeks_f < Length( jednostki_f )  ) then
    Result := jednostki_f[ indeks_f ].Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Je()
  else//if    ( indeks_f >= 0 ) (...)
    Result := 0;

end;//---//Funkcja Jednostka__Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Bj().

class procedure TBitwa_Jednostki.Jednostki__Atak__Przelicz__Bj( jednostki__1_f, jednostki__2_f : Jednostka.TJednostki_t; const jednostka__broñ_rodzaj_f : Definicje.TJednostka_Broñ_Rodzaj );
var
  i : integer;
begin

  if   (  Length( jednostki__1_f ) <= 0  )
    or (  Length( jednostki__2_f ) <= 0  ) then
    Exit;


  for i := 0 to Length( jednostki__1_f ) - 1 do
    if    ( jednostki__1_f[ i ].Broñ_Rodzaj__Odczytaj__Je() = jednostka__broñ_rodzaj_f )
      and ( jednostki__1_f[ i ].Atakowaæ_Mo¿e__SprawdŸ__Je() ) then
      begin

        Self.Jednostka__Uszkodzenia_Punkty__Zwiêksz__Bj( jednostki__2_f, jednostki__1_f[ i ].W_Zwarciu_Z_Indeks__Odczytaj__Je(),  jednostki__1_f[ i ].Atak_Si³a__Odczytaj__Je() );

      end;
    //---//if    ( Self.jednostki_t[ i ].Broñ_Rodzaj__Odczytaj__Je() = jednostka__broñ_rodzaj_f ) (...)

end;//---//Funkcja Jednostki__Atak__Przelicz__Bj().

class procedure TBitwa_Jednostki.Jednostki__Cel__Wybierz__Bj( jednostki__1_f, jednostki__2_f : Jednostka.TJednostki_t; const jednostka__broñ_rodzaj_f : Definicje.TJednostka_Broñ_Rodzaj );
var
  i,
  zti,
  wybór__indeks__do,
  wybór__indeks__od
    : integer;
begin

  if   (  Length( jednostki__1_f ) <= 0  )
    or (  Length( jednostki__2_f ) <= 0  ) then
    Exit;


  for i := 0 to Length( jednostki__1_f ) - 1 do
    if    ( jednostki__1_f[ i ].Broñ_Rodzaj__Odczytaj__Je() = jednostka__broñ_rodzaj_f )
      and (
               ( jednostki__1_f[ i ].W_Zwarciu_Z_Indeks__Odczytaj__Je() = Definicje.jednostka__w_zwarciu_z_indeks__pusty_c )
            or (  Self.Jednostka__Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Bj( jednostki__2_f, jednostki__1_f[ i ].W_Zwarciu_Z_Indeks__Odczytaj__Je() ) <= 0  )
          ) then
      begin

        wybór__indeks__do := i + 1;
        wybór__indeks__od := i - 1;

        if wybór__indeks__od < 0 then
          wybór__indeks__od := 0;

        if wybór__indeks__do > Length( jednostki__2_f ) - 1 then
          wybór__indeks__do := Length( jednostki__2_f ) - 1;


        if wybór__indeks__od > wybór__indeks__do then
          wybór__indeks__od := wybór__indeks__do;


        zti := wybór__indeks__do - wybór__indeks__od + 1;


        jednostki__1_f[ i ].W_Zwarciu_Z_Indeks__Zmieñ__Je(  Random( zti ) + wybór__indeks__od  );
        jednostki__1_f[ i ].Atakowaæ_Mo¿e_Zasiêg__Zmieñ__Je(  System.Abs( i - jednostki__1_f[ i ].W_Zwarciu_Z_Indeks__Odczytaj__Je() )  );

      end;
    //---//if    ( jednostki__1_f[ i ].Broñ_Rodzaj__Odczytaj__Je() = jednostka__broñ_rodzaj_f ) (...)

end;//---//Funkcja Jednostki__Cel__Wybierz__Bj().

class procedure TBitwa_Jednostki.Jednostki__Cel__Zbli¿_Siê__Bj( jednostki_f : Jednostka.TJednostki_t );
var
  i : integer;
begin

  for i := 0 to Length( jednostki_f ) - 1 do
    jednostki_f[ i ].Cel__Zbli¿_Siê__Je();

end;//---//Funkcja Jednostki__Cel__Zbli¿_Siê__Bj().

class procedure TBitwa_Jednostki.Bitwa__Jednostki__Starcie__Przelicz__Bj( var bitwa_starcie_etap_f : Definicje.TBitwa_Starcie_Etap; var jednostki__1_f, jednostki__2_f : Jednostka.TJednostki_t; const gra_gracz_f : boolean = false );
begin

  if bitwa_starcie_etap_f = Definicje.bse_atak__zwarcie then
    begin

      Self.Jednostki__Cel__Wybierz__Bj( jednostki__1_f, jednostki__2_f, Definicje.jbr_zwarcie );
      Self.Jednostki__Cel__Wybierz__Bj( jednostki__2_f, jednostki__1_f, Definicje.jbr_zwarcie );


      if gra_gracz_f then
        Wizualizacja.TWizualizacja.Jednostki__Rysuj__Wi( false, bitwa_starcie_etap_f, jednostki__1_f, jednostki__2_f );


      Self.Jednostki__Atak__Przelicz__Bj( jednostki__1_f, jednostki__2_f, Definicje.jbr_zwarcie );
      Self.Jednostki__Atak__Przelicz__Bj( jednostki__2_f, jednostki__1_f, Definicje.jbr_zwarcie );

      Self.Jednostki__Uszkodzenia_Punkty__Przelicz__Bj( jednostki__1_f, jednostki__2_f );
      Self.Jednostki__Uszkodzenia_Punkty__Przelicz__Bj( jednostki__2_f, jednostki__1_f );

    end
  else//if bitwa_starcie_etap_f = Definicje.bse_atak__zwarcie then
  if bitwa_starcie_etap_f = Definicje.bse_atak__dystans then
    begin

      Self.Jednostki__Cel__Wybierz__Bj( jednostki__1_f, jednostki__2_f, Definicje.jbr_dystans );
      Self.Jednostki__Cel__Wybierz__Bj( jednostki__2_f, jednostki__1_f, Definicje.jbr_dystans );


      if gra_gracz_f then
        Wizualizacja.TWizualizacja.Jednostki__Rysuj__Wi( false, bitwa_starcie_etap_f, jednostki__1_f, jednostki__2_f );


      Self.Jednostki__Atak__Przelicz__Bj( jednostki__1_f, jednostki__2_f, Definicje.jbr_dystans );
      Self.Jednostki__Atak__Przelicz__Bj( jednostki__2_f, jednostki__1_f, Definicje.jbr_dystans );

      Self.Jednostki__Uszkodzenia_Punkty__Przelicz__Bj( jednostki__1_f, jednostki__2_f );
      Self.Jednostki__Uszkodzenia_Punkty__Przelicz__Bj( jednostki__2_f, jednostki__1_f );

    end
  else//if bitwa_starcie_etap_f = Definicje.bse_atak__dystans then
  if bitwa_starcie_etap_f = Definicje.bse_d¹¿enie_do_zwarcia then
    begin

      Self.Jednostki__Cel__Wybierz__Bj( jednostki__1_f, jednostki__2_f, Definicje.jbr_dystans );
      Self.Jednostki__Cel__Wybierz__Bj( jednostki__2_f, jednostki__1_f, Definicje.jbr_dystans );

      Self.Jednostki__Cel__Wybierz__Bj( jednostki__1_f, jednostki__2_f, Definicje.jbr_zwarcie );
      Self.Jednostki__Cel__Wybierz__Bj( jednostki__2_f, jednostki__1_f, Definicje.jbr_zwarcie );


      if gra_gracz_f then
        Wizualizacja.TWizualizacja.Jednostki__Rysuj__Wi( false, bitwa_starcie_etap_f, jednostki__1_f, jednostki__2_f );


      Self.Jednostki__Cel__Zbli¿_Siê__Bj( jednostki__1_f );
      Self.Jednostki__Cel__Zbli¿_Siê__Bj( jednostki__2_f );

    end;
  //---//if bitwa_starcie_etap_f = Definicje.bse_d¹¿enie_do_zwarcia then


  if bitwa_starcie_etap_f < High( Definicje.TBitwa_Starcie_Etap ) then
    bitwa_starcie_etap_f := Definicje.TBitwa_Starcie_Etap(integer(bitwa_starcie_etap_f) + 1)
  else//if bitwa_starcie_etap_f < High( Definicje.TBitwa_Starcie_Etap ) then
    bitwa_starcie_etap_f := Low( Definicje.TBitwa_Starcie_Etap );

end;//---//Funkcja Bitwa__Jednostki__Starcie__Przelicz__Bj().

class procedure TBitwa_Jednostki.Bitwa__Jednostki__Starcie__Przygotuj__Bj( var bitwa_starcie_etap_f : Definicje.TBitwa_Starcie_Etap; dominium__1_f, dominium__2_f : Dominium.TDominium; var dominium__1__jednostki_t_f, dominium__2__jednostki_t_f : Jednostka.TJednostki_t );
begin

  bitwa_starcie_etap_f := Low( Definicje.TBitwa_Starcie_Etap );


  if   ( dominium__1_f = nil )
    or ( dominium__2_f = nil ) then
    Exit;


  dominium__1_f.Jednostki__Starcie__Przygotuj__Do( dominium__1__jednostki_t_f );
  dominium__2_f.Jednostki__Starcie__Przygotuj__Do( dominium__2__jednostki_t_f );

end;//---//Funkcja Bitwa__Jednostki__Starcie__Przygotuj__Bj().

class procedure TBitwa_Jednostki.Bitwa__Jednostki__Starcie__Zwolnij__Bj( var dominium__1__jednostki_t_f, dominium__2__jednostki_t_f : Jednostka.TJednostki_t );
var
  i : integer;
begin

  for i := Length( dominium__1__jednostki_t_f ) - 1 downto 0 do
    System.SysUtils.FreeAndNil( dominium__1__jednostki_t_f[ i ] );

  for i := Length( dominium__2__jednostki_t_f ) - 1 downto 0 do
    System.SysUtils.FreeAndNil( dominium__2__jednostki_t_f[ i ] );

  SetLength( dominium__1__jednostki_t_f, 0 );
  SetLength( dominium__2__jednostki_t_f, 0 );

end;//---//Funkcja Bitwa__Jednostki__Starcie__Zwolnij__Bj().

class function TBitwa_Jednostki.Bitwa__Jednostki__Wynik__Odczytaj__Bj( const jednostki__1_f, jednostki__2_f : Jednostka.TJednostki_t ) : Definicje.TBitwa_Jednostki_Wynik;
begin

  // Result = wynik__dominium__1.

  if    (  Self.Bitwa__Jednostki__Jednostki__Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Bj( jednostki__1_f ) <= 0  )
    and (  Self.Bitwa__Jednostki__Jednostki__Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Bj( jednostki__2_f ) <= 0  ) then
    Result := Definicje.bjw_remis
  else//if    (  Self.Bitwa__Jednostki__Jednostki__Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Bj( jednostki__1_f ) <= 0  ) (...)
  if Self.Bitwa__Jednostki__Jednostki__Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Bj( jednostki__2_f ) <= 0 then
    Result := Definicje.bjw_zwyciêstwo
  else//if Self.Bitwa__Jednostki__Jednostki__Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Bj( jednostki__2_f ) <= 0 then
  if Self.Bitwa__Jednostki__Jednostki__Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Bj( jednostki__1_f ) <= 0 then
    Result := Definicje.bjw_pora¿ka;

end;//---//Funkcja Bitwa__Jednostki__Wynik__Odczytaj__Bj().

class procedure TBitwa_Jednostki.Jednostki__Uszkodzenia_Punkty__Przelicz__Bj( var jednostki__1_f : Jednostka.TJednostki_t; jednostki__2_f : Jednostka.TJednostki_t );
var
  i,
  j
    : integer;
begin

  for i := Length( jednostki__1_f ) - 1 downto 0 do
    begin

      jednostki__1_f[ i ].Uszkodzenia_Punkty__Przelicz__Je();


      if jednostki__1_f[ i ].Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Je() <= 0 then
        begin

          for j := 0 to Length( jednostki__2_f ) - 1 do
            if jednostki__2_f[ j ].W_Zwarciu_Z_Indeks__Odczytaj__Je() = i then
              jednostki__2_f[ j ].W_Zwarciu_Z_Indeks__Zmieñ__Je( Definicje.jednostka__w_zwarciu_z_indeks__pusty_c );


          System.SysUtils.FreeAndNil( jednostki__1_f[ i ] );


          for j := i to Length( jednostki__1_f ) - 2 do
            begin

              jednostki__1_f[ j ] := jednostki__1_f[ j + 1 ];

            end;
          //---//for j := i + 1 to Length( jednostki__1_f ) - 1 do

          SetLength(  jednostki__1_f, Length( jednostki__1_f ) - 1  );

        end;
      //---//if jednostki__1_f[ i ].Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Je() <= 0 then

    end;
  //---//for i := Length( jednostki__1_f ) - 1 downto 0 do

end;//---//Funkcja Jednostki__Uszkodzenia_Punkty__Przelicz__Bj().

end.
