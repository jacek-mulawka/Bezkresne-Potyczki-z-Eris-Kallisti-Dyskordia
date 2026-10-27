unit Jednostka;{17.Sie.2026}

interface

uses
  System.Math,

  Definicje;

type
  TJednostka = class;

  TJednostki_t = array of Jednostka.TJednostka;

  TJednostka = class
  private
    { Private declarations }
    id__je,
    atakowaæ_mo¿e__dystans__je,
    poziom__je,
    w_zwarciu_z_indeks__je
      : integer;

    atak_si³a__je,
    atak__wspó³czynnik__je,
    obrona__wspó³czynnik__je,
    uszkodzenia_punkty__je,
    wytrzyma³oœæ_punkty__je
      : real;

    broñ_rodzaj__je : Definicje.TJednostka_Broñ_Rodzaj;

    typ__je : Definicje.TJednostka_Typ;

    function Atakowaæ_Mo¿e__Zasiêg__SprawdŸ__Je() : boolean;
  public
    { Public declarations }
    constructor Create( const id_f : integer );

    function Id__Odczytaj__Je() : integer;
    function Atak_Si³a__Odczytaj__Je() : real;
    function Atakowaæ_Mo¿e__SprawdŸ__Je() : boolean;
    procedure Atakowaæ_Mo¿e_Zasiêg__Zmieñ__Je( const wartoœæ_f : integer );
    function Cel__Zbli¿_Siê__Je( const tylko_test_f : boolean = false ) : boolean;
    function Broñ_Rodzaj__Odczytaj__Je() : Definicje.TJednostka_Broñ_Rodzaj;
    procedure Kopiuj_Wartoœci_Z_Obiektu_Klasy( const jednostka_f : Jednostka.TJednostka );
    function Obszar__Wolny__Dostêpnoœæ__SprawdŸ__Je() : boolean;
    procedure Obszar__Wolny__Ustaw__Je();
    function Poziom__Odczytaj__Je() : integer;
    procedure Poziom__Zwiêksz__Je();
    procedure Starcie__Przygotuj__Je();
    function Typ__Odczytaj__Je() : Definicje.TJednostka_Typ;
    procedure Uszkodzenia_Punkty__Przelicz__Je();
    procedure Uszkodzenia_Punkty__Zwiêksz__Je( const wartoœæ_f : real );
    procedure Wspó³czynniki__Zmieñ__Je( const atak__wspó³czynnik_f, obrona__wspó³czynnik_f : real );
    function Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Je() : real;
    function W_Zwarciu_Z_Indeks__Odczytaj__Je() : integer;
    procedure W_Zwarciu_Z_Indeks__Zmieñ__Je( const wartoœæ_f : integer );
    procedure Zakup__Je( const jednostka_typ_f : Definicje.TJednostka_Typ );
  end;//---//TJednostka = class

const
  atakowaæ_mo¿e__dystans__poza_zasiêgiem_c : integer = 2;
  jazda_mno¿nik_c : real = 2.5;
  jednostka__poziom_mno¿nik_c : real = 2.3; // = 1.15 * 2
  jednostka__poziom__pusta_c : integer = 0;

implementation

constructor TJednostka.Create( const id_f : integer );
begin

  Self.id__je := id_f;

  Self.Obszar__Wolny__Ustaw__Je();

end;//---//Konstruktor klasy TJednostka.

function TJednostka.Id__Odczytaj__Je() : integer;
begin

  Result := Self.id__je;

end;//---//Funkcja Id__Odczytaj__Je().

function TJednostka.Atak_Si³a__Odczytaj__Je() : real;
begin

  Result := Self.atak_si³a__je;

end;//---//Funkcja Atak_Si³a__Odczytaj__Je().

function TJednostka.Atakowaæ_Mo¿e__SprawdŸ__Je() : boolean;
begin

  Result :=
        ( Self.Atakowaæ_Mo¿e__Zasiêg__SprawdŸ__Je() )
    and ( Self.W_Zwarciu_Z_Indeks__Odczytaj__Je() <> Definicje.jednostka__w_zwarciu_z_indeks__pusty_c );

end;//---//Funkcja Atakowaæ_Mo¿e__SprawdŸ__Je().

function TJednostka.Atakowaæ_Mo¿e__Zasiêg__SprawdŸ__Je() : boolean;
begin

  if Self.broñ_rodzaj__je = Definicje.jbr_dystans then
    Result := Self.atakowaæ_mo¿e__dystans__je <= 1
  else//if Self.broñ_rodzaj__je = Definicje.jbr_dystans then
  if Self.broñ_rodzaj__je = Definicje.jbr_zwarcie then
    Result := Self.atakowaæ_mo¿e__dystans__je <= 0
  else//if Self.broñ_rodzaj__je = Definicje.jbr_zwarcie then
    Result := false;

end;//---//Funkcja Atakowaæ_Mo¿e__Zasiêg__SprawdŸ__Je().

procedure TJednostka.Atakowaæ_Mo¿e_Zasiêg__Zmieñ__Je( const wartoœæ_f : integer );
begin

  Self.atakowaæ_mo¿e__dystans__je := wartoœæ_f;


  if Self.atakowaæ_mo¿e__dystans__je < 0 then
    Self.atakowaæ_mo¿e__dystans__je := 0;

end;//---//Funkcja Atakowaæ_Mo¿e_Zasiêg__Zmieñ__Je().

function TJednostka.Cel__Zbli¿_Siê__Je( const tylko_test_f : boolean = false ) : boolean;
begin

  if    ( Self.W_Zwarciu_Z_Indeks__Odczytaj__Je <> Definicje.jednostka__w_zwarciu_z_indeks__pusty_c )
    and ( not Self.Atakowaæ_Mo¿e__Zasiêg__SprawdŸ__Je() )
    and ( Self.atakowaæ_mo¿e__dystans__je > 0 ) then
    begin

      Result := true;


      if not tylko_test_f then
        Self.Atakowaæ_Mo¿e_Zasiêg__Zmieñ__Je( Self.atakowaæ_mo¿e__dystans__je - 1 );

    end
  else//if    ( Self.W_Zwarciu_Z_Indeks__Odczytaj__Je <> Definicje.jednostka__w_zwarciu_z_indeks__pusty_c ) (...)
    Result := false;

end;//---//Funkcja Cel__Zbli¿_Siê__Je().

function TJednostka.Broñ_Rodzaj__Odczytaj__Je() : Definicje.TJednostka_Broñ_Rodzaj;
begin

  Result := Self.broñ_rodzaj__je;

end;//---//Funkcja Broñ_Rodzaj__Odczytaj__Je().

procedure TJednostka.Kopiuj_Wartoœci_Z_Obiektu_Klasy( const jednostka_f : Jednostka.TJednostka );
begin

  Self.id__je := jednostka_f.id__je;
  Self.atak_si³a__je := jednostka_f.atak_si³a__je;
  Self.atak__wspó³czynnik__je := jednostka_f.atak__wspó³czynnik__je;
  Self.atakowaæ_mo¿e__dystans__je := jednostka_f.atakowaæ_mo¿e__dystans__je;
  Self.broñ_rodzaj__je := jednostka_f.broñ_rodzaj__je;
  Self.obrona__wspó³czynnik__je := jednostka_f.obrona__wspó³czynnik__je;
  Self.poziom__je := jednostka_f.poziom__je;
  Self.uszkodzenia_punkty__je := jednostka_f.uszkodzenia_punkty__je;
  Self.typ__je := jednostka_f.typ__je;
  Self.w_zwarciu_z_indeks__je := jednostka_f.w_zwarciu_z_indeks__je;
  Self.wytrzyma³oœæ_punkty__je := jednostka_f.wytrzyma³oœæ_punkty__je;

end;//---//Funkcja Kopiuj_Wartoœci_Z_Obiektu_Klasy().

function TJednostka.Obszar__Wolny__Dostêpnoœæ__SprawdŸ__Je() : boolean;
begin

  Result := Self.typ__je = Definicje.jt_pusta;

end;//---//Funkcja Obszar__Wolny__Dostêpnoœæ__SprawdŸ__Je().

procedure TJednostka.Obszar__Wolny__Ustaw__Je();
begin

  Self.atak_si³a__je := 0;
  Self.Atakowaæ_Mo¿e_Zasiêg__Zmieñ__Je( Jednostka.atakowaæ_mo¿e__dystans__poza_zasiêgiem_c );
  Self.atak__wspó³czynnik__je := 1;
  Self.obrona__wspó³czynnik__je := 1;
  Self.poziom__je := Jednostka.jednostka__poziom__pusta_c;
  Self.typ__je := Definicje.jt_pusta;
  Self.uszkodzenia_punkty__je := 0;
  Self.w_zwarciu_z_indeks__je := Definicje.jednostka__w_zwarciu_z_indeks__pusty_c;
  Self.wytrzyma³oœæ_punkty__je := 0;

end;//---//Funkcja Obszar__Wolny__Ustaw__Je().

function TJednostka.Poziom__Odczytaj__Je() : integer;
begin

  Result := Self.poziom__je;

end;//---//Funkcja Poziom__Odczytaj__Je().

procedure TJednostka.Poziom__Zwiêksz__Je();
begin

  Self.poziom__je := Self.poziom__je
    * 2;

end;//---//Funkcja Poziom__Zwiêksz__Je().

procedure TJednostka.Starcie__Przygotuj__Je();
var
  ztr : real;
begin

  ztr := Self.poziom__je - 1;

  if ztr < 0 then
    ztr := 0;

  ztr := System.Math.Power( Jednostka.jednostka__poziom_mno¿nik_c, ztr );


  if Self.Typ__Odczytaj__Je() = Definicje.jt_pusta then
    ztr := 0
  else
  if Self.Typ__Odczytaj__Je() = Definicje.jt_jazda then
    ztr := ztr
      * Jednostka.jazda_mno¿nik_c;


  Self.Atakowaæ_Mo¿e_Zasiêg__Zmieñ__Je( Jednostka.atakowaæ_mo¿e__dystans__poza_zasiêgiem_c );
  Self.uszkodzenia_punkty__je := 0;
  Self.w_zwarciu_z_indeks__je := Definicje.jednostka__w_zwarciu_z_indeks__pusty_c;
  Self.wytrzyma³oœæ_punkty__je :=
      ztr
    * Self.obrona__wspó³czynnik__je;

  Self.atak_si³a__je :=
      ztr
    * Self.atak__wspó³czynnik__je;

end;//---//Funkcja Starcie__Przygotuj__Je().

function TJednostka.Typ__Odczytaj__Je() : Definicje.TJednostka_Typ;
begin

  Result := Self.typ__je;

end;//---//Funkcja Typ__Odczytaj__Je().

procedure TJednostka.Uszkodzenia_Punkty__Przelicz__Je();
begin

  Self.wytrzyma³oœæ_punkty__je := Self.wytrzyma³oœæ_punkty__je
    - Self.uszkodzenia_punkty__je;

  Self.uszkodzenia_punkty__je := 0;


  if Self.wytrzyma³oœæ_punkty__je < 0 then
    Self.wytrzyma³oœæ_punkty__je := 0;

end;//---//Funkcja Uszkodzenia_Punkty__Przelicz__Je().

procedure TJednostka.Uszkodzenia_Punkty__Zwiêksz__Je( const wartoœæ_f : real );
begin

  Self.uszkodzenia_punkty__je := Self.uszkodzenia_punkty__je
    + wartoœæ_f;

end;//---//Funkcja Uszkodzenia_Punkty__Zwiêksz__Je().

procedure TJednostka.Wspó³czynniki__Zmieñ__Je( const atak__wspó³czynnik_f, obrona__wspó³czynnik_f : real );
begin

  Self.atak__wspó³czynnik__je := atak__wspó³czynnik_f;
  Self.obrona__wspó³czynnik__je := obrona__wspó³czynnik_f;

end;//---//Funkcja Wspó³czynniki__Zmieñ__Je().

function TJednostka.Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Je() : real;
begin

  Result := Self.wytrzyma³oœæ_punkty__je;

end;//---//Funkcja Wytrzyma³oœæ_Punkty__Wartoœæ__Odczytaj__Je().

function TJednostka.W_Zwarciu_Z_Indeks__Odczytaj__Je() : integer;
begin

  Result := Self.w_zwarciu_z_indeks__je;

end;//---//Funkcja W_Zwarciu_Z_Indeks__Odczytaj__Je().

procedure TJednostka.W_Zwarciu_Z_Indeks__Zmieñ__Je( const wartoœæ_f : integer );
begin

  Self.w_zwarciu_z_indeks__je := wartoœæ_f;

end;//---//Funkcja W_Zwarciu_Z_Indeks__Zmieñ__Je().

procedure TJednostka.Zakup__Je( const jednostka_typ_f : Definicje.TJednostka_Typ );
begin

  Self.broñ_rodzaj__je := Definicje.TJednostka_Broñ_Rodzaj(Random(   Ord(  High( Definicje.TJednostka_Broñ_Rodzaj )  ) + 1   ));
  Self.poziom__je := 1;
  Self.typ__je := jednostka_typ_f;

end;//---//Funkcja Zakup__Je().

end.
