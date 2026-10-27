unit Wizualizacja;{24.Sie.2026}

interface

uses
  GLS.GeomObjects,
  GLS.Objects,
  Stage.Color,

  System.SysUtils,

  Definicje,
  Jednostka,
  Poszukiwacz,
  Wizualizacja__Obiekty__Budowle,
  Wizualizacja__Obiekty__Jednostki,
  Wizualizacja__Obiekty__Mapa,
  Wizualizacja__Obiekty__Mapa_Jednostki;

type
  TWizualizacja = class
  private
    { Private declarations }
    class var budowle__obiekty__gl_dummy_cube__wi,
              droga__obiekty__gl_dummy_cube__wi,
              jednostki__jednostki__gl_dummy_cube__wi,
              jednostki__obszar__gl_dummy_cube__wi,
              gra__obiekty__gl_dummy_cube__wi,
              mapa__jednostki__gl_dummy_cube__wi,
              mapa__obiekty__gl_dummy_cube__wi,
              surowce__obiekty__gl_dummy_cube__wi
      : GLS.Objects.TGLDummyCube;

    class procedure Budowla__Zwolnij__Jednπ__Wi( const id_f : integer );
    class procedure Mapa__Jednostka__Zwolnij__Jednπ__Wi( const id_f : integer );
  public
    { Public declarations }
    class var mapa__úrodek__x__wi,
              mapa__úrodek__y__wi
      : single;

    class var Kamera__Resetuj__Wi : procedure( const czy_kamera_pozycja_kopia_f : boolean = false ) of object;

    class procedure Animacje__Jednostki__Wi( const gra_wspÛ≥czynnik_prÍdkoúci_f : single );
    class procedure Animacje___Mapa__Wi( const gra_wspÛ≥czynnik_prÍdkoúci_f : single );
    class procedure Budowle__Rysuj__Wi( const budowle_t_f : Definicje.TBudowle );
    class procedure Droga__Rysuj__Wi( const droga__punkty_f : Poszukiwacz.TTablica2D_Integer; const y_f, x_f : integer; const droga_zablokowana_f : boolean = false );
    class procedure Inicjuj__Wi( gra_obiekty_gl_dummy_cube__wi_f : GLS.Objects.TGLDummyCube );
    class function Jednostka__W__Jednostka__Wyglπd_Aktualizuj( const jednostka_f : Jednostka.TJednostka ) : TJednostka__Wyglπd_Aktualizuj;
    class procedure Jednostki__Rysuj__Wi( const przed_starciem_f : boolean; const bitwa_starcie_etap_f : Definicje.TBitwa_Starcie_Etap; dominium__1__jednostki_t_f, dominium__2__jednostki_t_f : Jednostka.TJednostki_t );
    class procedure Jednostki__Obszar__Rysuj__Wi( obszar_wielkoúÊ_f : integer );
    class procedure Mapa__Jednostki__Rysuj__Wi( const mapa_jednostki_f : Definicje.TMapa_Jednostki );
    class procedure Mapa__Rysuj__Wi( const teren_t_f : Poszukiwacz.TTablica2D_Integer );
    class procedure Surowce__Rysuj__Wi( const surowce_ürÛd≥o_t_f : Definicje.TSurowce_èrÛd≥o );

    class procedure Wizualizacja__Zwolnij__Wi();
    class procedure Zwolnij__Wszystko__Wi();
  end;//---//TWizualizacja = class

const
  jednostki__obszar__dominium__1__poczπtkowe__y_c : integer = 4;
  jednostki__obszar__dominium__2__poczπtkowe__y_c : integer = 2;
  jednostki__obszar__przesuniÍcie__x_c : single = 3;
  jednostki__obszar__wysokoúÊ__y_c : integer = 5;
  kratka__wielkoúÊ_c : single = 1;

implementation


class procedure TWizualizacja.Animacje__Jednostki__Wi( const gra_wspÛ≥czynnik_prÍdkoúci_f : single );
var
  i : integer;
begin

  if Self.jednostki__jednostki__gl_dummy_cube__wi <> nil then
    for i := 0 to Self.jednostki__jednostki__gl_dummy_cube__wi.Count - 1 do
      if Self.jednostki__jednostki__gl_dummy_cube__wi.Children[ i ] is Wizualizacja__Obiekty__Jednostki.TWizualizacja__Jednostka then
        Wizualizacja__Obiekty__Jednostki.TWizualizacja__Jednostka(Self.jednostki__jednostki__gl_dummy_cube__wi.Children[ i ]).Animacja__Wj( gra_wspÛ≥czynnik_prÍdkoúci_f );

end;//---//Funkcja Animacje__Jednostki__Wi().

class procedure TWizualizacja.Animacje___Mapa__Wi( const gra_wspÛ≥czynnik_prÍdkoúci_f : single );
var
  i : integer;
begin

  if Self.mapa__jednostki__gl_dummy_cube__wi <> nil then
    for i := 0 to Self.mapa__jednostki__gl_dummy_cube__wi.Count - 1 do
      if Self.mapa__jednostki__gl_dummy_cube__wi.Children[ i ] is Wizualizacja__Obiekty__Mapa_Jednostki.TWizualizacja__Mapa_Jednostka then
        Wizualizacja__Obiekty__Mapa_Jednostki.TWizualizacja__Mapa_Jednostka(Self.mapa__jednostki__gl_dummy_cube__wi.Children[ i ]).Ruch__Wmj( gra_wspÛ≥czynnik_prÍdkoúci_f );


  if Self.budowle__obiekty__gl_dummy_cube__wi <> nil then
    for i := 0 to Self.budowle__obiekty__gl_dummy_cube__wi.Count - 1 do
      if Self.budowle__obiekty__gl_dummy_cube__wi.Children[ i ] is Wizualizacja__Obiekty__Budowle.TWizualizacja__Budowla then
        Wizualizacja__Obiekty__Budowle.TWizualizacja__Budowla(Self.budowle__obiekty__gl_dummy_cube__wi.Children[ i ]).Animacja__Wbu( gra_wspÛ≥czynnik_prÍdkoúci_f );

end;//---//Funkcja Animacje___Mapa__Wi().

class procedure TWizualizacja.Budowla__Zwolnij__Jednπ__Wi( const id_f : integer );
var
  i : integer;
begin

  if Self.budowle__obiekty__gl_dummy_cube__wi <> nil then
    for i := Self.budowle__obiekty__gl_dummy_cube__wi.Count - 1 downto 0 do
      if Wizualizacja__Obiekty__Budowle.TWizualizacja__Budowla(Self.budowle__obiekty__gl_dummy_cube__wi.Children[ i ]).Id__PorÛwnaj__Wo( id_f ) then
        begin

          System.SysUtils.FreeAndNil( Self.budowle__obiekty__gl_dummy_cube__wi.Children[ i ] );

          Break;

        end;
      //---//if Wizualizacja__Obiekty__Budowle.TWizualizacja__Budowla(Self.budowle__obiekty__gl_dummy_cube__wi.Children[ i ]).Id__PorÛwnaj__Wo( id_f ) then

end;//---//Funkcja Budowla__Zwolnij__Jednπ__Wi().

class procedure TWizualizacja.Mapa__Jednostka__Zwolnij__Jednπ__Wi( const id_f : integer );
var
  i : integer;
begin

  if Self.mapa__jednostki__gl_dummy_cube__wi <> nil then
    for i := Self.mapa__jednostki__gl_dummy_cube__wi.Count - 1 downto 0 do
      if Wizualizacja__Obiekty__Mapa_Jednostki.TWizualizacja__Mapa_Jednostka(Self.mapa__jednostki__gl_dummy_cube__wi.Children[ i ]).Id__PorÛwnaj__Wmj( id_f ) then
        begin

          System.SysUtils.FreeAndNil( Self.mapa__jednostki__gl_dummy_cube__wi.Children[ i ] );

          Break;

        end;
      //---//if Wizualizacja__Obiekty__Mapa_Jednostki.TWizualizacja__Mapa_Jednostka(Self.mapa__jednostki__gl_dummy_cube__wi.Children[ i ]).Id__PorÛwnaj__Wmj( id_f ) then

end;//---//Funkcja Mapa__Jednostka__Zwolnij__Jednπ__Wi().

class procedure TWizualizacja.Budowle__Rysuj__Wi( const budowle_t_f : Definicje.TBudowle );
var
  ztb : boolean;

  i,
  j
    : integer;

  zt_wizualizacja__budowla : Wizualizacja__Obiekty__Budowle.TWizualizacja__Budowla;
begin

  if Self.budowle__obiekty__gl_dummy_cube__wi = nil then
    Exit;


  for i := 0 to Length( budowle_t_f ) - 1 do
    if budowle_t_f[ i ].budowla_rodzaj__bu in [ Definicje.br_domek, Definicje.br_koszary, Definicje.br_wieøa__obronna, Definicje.br_wieøa__zwiadowcza, Definicje.br_zamek ] then
      begin

        ztb := false;

        for j := 0 to Self.budowle__obiekty__gl_dummy_cube__wi.Count - 1 do
          if    ( Self.budowle__obiekty__gl_dummy_cube__wi.Children[ j ] is Wizualizacja__Obiekty__Budowle.TWizualizacja__Budowla )
            and (  Wizualizacja__Obiekty__Budowle.TWizualizacja__Budowla(Self.budowle__obiekty__gl_dummy_cube__wi.Children[ j ]).Id__PorÛwnaj__Wo( budowle_t_f[ i ].id__bu )  ) then
            begin

              ztb := true;

              Wizualizacja__Obiekty__Budowle.TWizualizacja__Budowla(Self.budowle__obiekty__gl_dummy_cube__wi.Children[ j ]).PrzynaleønoúÊ__ZmieÒ__Wo( budowle_t_f[ i ].dominium__numer__bu );
              Wizualizacja__Obiekty__Budowle.TWizualizacja__Budowla(Self.budowle__obiekty__gl_dummy_cube__wi.Children[ j ]).Wytrzyma≥oúÊ_Punkty__WartoúÊ__ZmieÒ__Wo( budowle_t_f[ i ].wytrzyma≥oúÊ_punkty__bu );

              Wizualizacja__Obiekty__Budowle.TWizualizacja__Budowla(Self.budowle__obiekty__gl_dummy_cube__wi.Children[ j ]).Efekt__Atak__ZmieÒ__Wbu( budowle_t_f[ i ].atak__w_trakcie__bu, budowle_t_f[ i ].atak__cel__wspÛ≥rzÍdna__y__bu, budowle_t_f[ i ].atak__cel__wspÛ≥rzÍdna__x__bu );
              Wizualizacja__Obiekty__Budowle.TWizualizacja__Budowla(Self.budowle__obiekty__gl_dummy_cube__wi.Children[ j ]).Efekt__Obraøenia__ZmieÒ__Wbu( budowle_t_f[ i ].obraøenia__w_trakcie__bu );


              Break;

            end;
          //---//if    ( Self.budowle__obiekty__gl_dummy_cube__wi.Children[ j ] is Wizualizacja__Obiekty__Budowle.TWizualizacja__Budowla ) (...)


        if not ztb then
          begin

            zt_wizualizacja__budowla := Wizualizacja__Obiekty__Budowle.TWizualizacja__Budowla.Create
              (
                Self.budowle__obiekty__gl_dummy_cube__wi,
                budowle_t_f[ i ].dominium__numer__bu,
                budowle_t_f[ i ].id__bu,
                budowle_t_f[ i ].budowla_rodzaj__bu,
                budowle_t_f[ i ].wytrzyma≥oúÊ_punkty__bu
              );
            zt_wizualizacja__budowla.Parent := Self.budowle__obiekty__gl_dummy_cube__wi;
            zt_wizualizacja__budowla.CubeSize := Wizualizacja.kratka__wielkoúÊ_c;
            zt_wizualizacja__budowla.Position.X := budowle_t_f[ i ].wspÛ≥rzÍdna__x__bu;
            zt_wizualizacja__budowla.Position.Y := budowle_t_f[ i ].wspÛ≥rzÍdna__y__bu;
            zt_wizualizacja__budowla.Position.Z := -zt_wizualizacja__budowla.CubeSize * 0.5;
            zt_wizualizacja__budowla.PrzynaleønoúÊ__ZmieÒ__Wo( budowle_t_f[ i ].dominium__numer__bu );

          end;
        //---//if not ztb then

      end;
    //---//if budowle_t_f[ i ].budowla_rodzaj__bu in [ Definicje.br_domek, Definicje.br_koszary, Definicje.br_wieøa__obronna, Definicje.br_wieøa__zwiadowcza, Definicje.br_zamek ] then


  for j := 0 to Self.budowle__obiekty__gl_dummy_cube__wi.Count - 1 do
    if Self.budowle__obiekty__gl_dummy_cube__wi.Children[ j ] is Wizualizacja__Obiekty__Budowle.TWizualizacja__Budowla then
      begin

        ztb := false;

        for i := 0 to Length( budowle_t_f ) - 1 do
          if Wizualizacja__Obiekty__Budowle.TWizualizacja__Budowla(Self.budowle__obiekty__gl_dummy_cube__wi.Children[ j ]).Id__PorÛwnaj__Wo( budowle_t_f[ i ].id__bu ) then
            begin

              ztb := true;

              Break;

            end;
          //---//if Wizualizacja__Obiekty__Budowle.TWizualizacja__Budowla(Self.budowle__obiekty__gl_dummy_cube__wi.Children[ j ]).Id__PorÛwnaj__Wo( budowle_t_f[ i ].id__bu ) then


        if not ztb then
          Wizualizacja.TWizualizacja.Budowla__Zwolnij__Jednπ__Wi( Wizualizacja__Obiekty__Budowle.TWizualizacja__Budowla(Self.budowle__obiekty__gl_dummy_cube__wi.Children[ j ]).Id__Odczytaj__Wo() );

      end;
    //---//if Self.budowle__obiekty__gl_dummy_cube__wi.Children[ j ] is Wizualizacja__Obiekty__Budowle.TWizualizacja__Budowla then

end;//---//Funkcja Budowle__Rysuj__Wi().

class procedure TWizualizacja.Droga__Rysuj__Wi( const droga__punkty_f : Poszukiwacz.TTablica2D_Integer; const y_f, x_f : integer; const droga_zablokowana_f : boolean = false );
var
  i : integer;

  zt_gl_sphere : GLS.Objects.TGLSphere;
begin

  if Self.gra__obiekty__gl_dummy_cube__wi = nil then
    Exit;


  if Self.droga__obiekty__gl_dummy_cube__wi = nil then
    begin

      Self.droga__obiekty__gl_dummy_cube__wi := GLS.Objects.TGLDummyCube.Create( Self.gra__obiekty__gl_dummy_cube__wi );
      Self.droga__obiekty__gl_dummy_cube__wi.Parent := Self.gra__obiekty__gl_dummy_cube__wi;

    end;
  //---//if Self.droga__obiekty__gl_dummy_cube__wi = nil then


  for i := Self.droga__obiekty__gl_dummy_cube__wi.Count - 1 downto 0 do
    System.SysUtils.FreeAndNil( Self.droga__obiekty__gl_dummy_cube__wi.Children[ i ] );


  for i := 0 to Length( droga__punkty_f[ 0 ] ) - 1 do
    begin

      zt_gl_sphere := GLS.Objects.TGLSphere.Create( Self.droga__obiekty__gl_dummy_cube__wi );
      zt_gl_sphere.Parent := Self.droga__obiekty__gl_dummy_cube__wi;
      zt_gl_sphere.Radius := 0.1;

      if    ( droga__punkty_f[ 1, i ] = x_f )
        and ( droga__punkty_f[ 0, i ] = y_f ) then
        zt_gl_sphere.Material.FrontProperties.Diffuse.Color := Stage.Color.clrBlack
      else
      if i = 0 then
        zt_gl_sphere.Material.FrontProperties.Diffuse.Color := Stage.Color.clrYellow
      else
      if i = Length( droga__punkty_f[ 0 ] ) - 1 then
        begin

          if droga_zablokowana_f then
            zt_gl_sphere.Material.FrontProperties.Diffuse.Color := Stage.Color.clrBrown
          else
            zt_gl_sphere.Material.FrontProperties.Diffuse.Color := Stage.Color.clrLime;

        end
      else
        zt_gl_sphere.Material.FrontProperties.Diffuse.Color := Stage.Color.clrAqua;

      zt_gl_sphere.Position.X := droga__punkty_f[ 1, i ]; // x.
      zt_gl_sphere.Position.Y := droga__punkty_f[ 0, i ]; // y.
      zt_gl_sphere.Position.Z := 0;
      zt_gl_sphere.Scale.X := 7;

    end;
  //---//for i := 0 to Length( droga__punkty_f ) - 1 do

end;//---//Funkcja Droga__Rysuj__Wi().

class procedure TWizualizacja.Inicjuj__Wi( gra_obiekty_gl_dummy_cube__wi_f : GLS.Objects.TGLDummyCube );
begin

  Self.gra__obiekty__gl_dummy_cube__wi := gra_obiekty_gl_dummy_cube__wi_f;


  Self.budowle__obiekty__gl_dummy_cube__wi := GLS.Objects.TGLDummyCube.Create( Self.gra__obiekty__gl_dummy_cube__wi );
  Self.budowle__obiekty__gl_dummy_cube__wi.Parent := Self.gra__obiekty__gl_dummy_cube__wi;

  Self.droga__obiekty__gl_dummy_cube__wi := nil;

  Self.jednostki__jednostki__gl_dummy_cube__wi := GLS.Objects.TGLDummyCube.Create( Self.gra__obiekty__gl_dummy_cube__wi );
  Self.jednostki__jednostki__gl_dummy_cube__wi.Parent := Self.gra__obiekty__gl_dummy_cube__wi;

  Self.jednostki__obszar__gl_dummy_cube__wi := GLS.Objects.TGLDummyCube.Create( Self.gra__obiekty__gl_dummy_cube__wi );
  Self.jednostki__obszar__gl_dummy_cube__wi.Parent := Self.gra__obiekty__gl_dummy_cube__wi;

  Self.mapa__jednostki__gl_dummy_cube__wi := GLS.Objects.TGLDummyCube.Create( Self.gra__obiekty__gl_dummy_cube__wi );
  Self.mapa__jednostki__gl_dummy_cube__wi.Parent := Self.gra__obiekty__gl_dummy_cube__wi;

  Self.mapa__obiekty__gl_dummy_cube__wi := GLS.Objects.TGLDummyCube.Create( Self.gra__obiekty__gl_dummy_cube__wi );
  Self.mapa__obiekty__gl_dummy_cube__wi.Parent := Self.gra__obiekty__gl_dummy_cube__wi;

  Self.surowce__obiekty__gl_dummy_cube__wi := GLS.Objects.TGLDummyCube.Create( Self.gra__obiekty__gl_dummy_cube__wi );
  Self.surowce__obiekty__gl_dummy_cube__wi.Parent := Self.gra__obiekty__gl_dummy_cube__wi;

end;//---//Funkcja Inicjuj__Wi().

class function TWizualizacja.Jednostka__W__Jednostka__Wyglπd_Aktualizuj( const jednostka_f : Jednostka.TJednostka ) : TJednostka__Wyglπd_Aktualizuj;
begin

  Result.broÒ_rodzaj__jwa := jednostka_f.BroÒ_Rodzaj__Odczytaj__Je();
  Result.atakowaÊ_moøe__jwa := jednostka_f.AtakowaÊ_Moøe__Sprawdü__Je();
  Result.cel__zbliø_siÍ__jwa := jednostka_f.Cel__Zbliø_SiÍ__Je( true );
  Result.poziom__jwa := jednostka_f.Poziom__Odczytaj__Je();
  Result.typ__jwa := jednostka_f.Typ__Odczytaj__Je();
  Result.w_zwarciu_z_indeks__jwa := jednostka_f.W_Zwarciu_Z_Indeks__Odczytaj__Je();

end;//---//Funkcja Jednostka__W__Jednostka__Wyglπd_Aktualizuj().

class procedure TWizualizacja.Jednostki__Rysuj__Wi( const przed_starciem_f : boolean; const bitwa_starcie_etap_f : Definicje.TBitwa_Starcie_Etap; dominium__1__jednostki_t_f, dominium__2__jednostki_t_f : Jednostka.TJednostki_t );

  //Funkcja Jednostka__Rysuj__L() w Jednostki__Rysuj__Wi().
  procedure Jednostka__Rysuj__L( const przed_starciem_f_f : boolean; const dominium__numer_f_f : smallint; const bitwa_starcie_etap_f_f : Definicje.TBitwa_Starcie_Etap; jednostki_t_f_f : Jednostka.TJednostki_t );

    //Funkcja Dominium__Numer__Y__Ustal_L() w Jednostka__Rysuj__L() w Jednostki__Rysuj__Wi().
    function Dominium__Numer__Y__Ustal_L( const dominium__numer_f_f_f : smallint ) : integer;
    begin

      if dominium__numer_f_f_f = Definicje.dominium__numer__gracz__1_c then
        Result := Wizualizacja.jednostki__obszar__dominium__1__poczπtkowe__y_c
      else
      if dominium__numer_f_f_f = Definicje.dominium__numer__gracz__2_c then
        Result := Wizualizacja.jednostki__obszar__dominium__2__poczπtkowe__y_c
      else
        Result := 0;

    end;//---//Funkcja Dominium__Numer__Y__Ustal_L() w Jednostka__Rysuj__L() w Jednostki__Rysuj__Wi().

  var
    ztb : boolean;

    i,
    j
      : integer;

    zt_mapa_kratka : Wizualizacja__Obiekty__Mapa.TMapa_Kratka;
    zt_wizualizacja__jednostka : Wizualizacja__Obiekty__Jednostki.TWizualizacja__Jednostka;
  begin//Funkcja Jednostka__Rysuj__L() w Jednostki__Rysuj__Wi().

    for i := 0 to Length( jednostki_t_f_f ) - 1 do
      begin

        ztb := false;

        for j := 0 to Self.jednostki__jednostki__gl_dummy_cube__wi.Count - 1 do
          if    ( Self.jednostki__jednostki__gl_dummy_cube__wi.Children[ j ] is Wizualizacja__Obiekty__Mapa.TMapa_Kratka )
            and (   Wizualizacja__Obiekty__Mapa.TMapa_Kratka(Self.jednostki__jednostki__gl_dummy_cube__wi.Children[ j ]).Id__PorÛwnaj__Mk(  i, Dominium__Numer__Y__Ustal_L( dominium__numer_f_f )  )   ) then
            begin

              ztb := true;

              Break;

            end;
          //---//if    ( Self.jednostki__jednostki__gl_dummy_cube__wi.Children[ j ] is Wizualizacja__Obiekty__Mapa.TMapa_Kratka ) (...)

        if not ztb then
          begin

            zt_mapa_kratka := Wizualizacja__Obiekty__Mapa.TMapa_Kratka.Create( Self.jednostki__jednostki__gl_dummy_cube__wi );
            zt_mapa_kratka.Parent := Self.jednostki__jednostki__gl_dummy_cube__wi;
            zt_mapa_kratka.Id__ZmieÒ__Mk(  i, Dominium__Numer__Y__Ustal_L( dominium__numer_f_f )  );
            zt_mapa_kratka.CubeSize := Wizualizacja.kratka__wielkoúÊ_c;
            zt_mapa_kratka.Teren__Rodzaj__ZmieÒ__Mk( Definicje.mapa__teren__jednostki__obszar__wykupiony_c );

          end;
        //---//if not ztb then



        if jednostki_t_f_f[ i ].Typ__Odczytaj__Je() <> Definicje.jt_pusta then
          begin

            ztb := false;

            for j := 0 to Self.jednostki__jednostki__gl_dummy_cube__wi.Count - 1 do
              if    ( Self.jednostki__jednostki__gl_dummy_cube__wi.Children[ j ] is Wizualizacja__Obiekty__Jednostki.TWizualizacja__Jednostka )
                and (  Wizualizacja__Obiekty__Jednostki.TWizualizacja__Jednostka(Self.jednostki__jednostki__gl_dummy_cube__wi.Children[ j ]).Id__PorÛwnaj__Wj( dominium__numer_f_f, jednostki_t_f_f[ i ].Id__Odczytaj__Je() )  ) then
                begin

                  ztb := true;

                  Wizualizacja__Obiekty__Jednostki.TWizualizacja__Jednostka(Self.jednostki__jednostki__gl_dummy_cube__wi.Children[ j ]).Wyglπd_Aktualizuj__Wj(  przed_starciem_f_f, bitwa_starcie_etap_f_f, i, Wizualizacja.TWizualizacja.Jednostka__W__Jednostka__Wyglπd_Aktualizuj( jednostki_t_f_f[ i ] )  );

                  Break;

                end;
              //---//if    ( Self.jednostki__jednostki__gl_dummy_cube__wi.Children[ j ] is Wizualizacja__Obiekty__Mapa.TMapa_Kratka ) (...)


            if not ztb then
              begin

                zt_wizualizacja__jednostka := Wizualizacja__Obiekty__Jednostki.TWizualizacja__Jednostka.Create( Self.jednostki__jednostki__gl_dummy_cube__wi, dominium__numer_f_f, Wizualizacja.kratka__wielkoúÊ_c );
                zt_wizualizacja__jednostka.Parent := Self.jednostki__jednostki__gl_dummy_cube__wi;
                zt_wizualizacja__jednostka.Id__ZmieÒ__Wj( jednostki_t_f_f[ i ].Id__Odczytaj__Je() );
                zt_wizualizacja__jednostka.Indeks__ZmieÒ__Wj( i );
                zt_wizualizacja__jednostka.CubeSize := Wizualizacja.kratka__wielkoúÊ_c;
                zt_wizualizacja__jednostka.Position.X := i;

                if dominium__numer_f_f = Definicje.dominium__numer__gracz__1_c then
                  zt_wizualizacja__jednostka.Position.Y := Dominium__Numer__Y__Ustal_L( dominium__numer_f_f )
                else
                if dominium__numer_f_f = Definicje.dominium__numer__gracz__2_c then
                  zt_wizualizacja__jednostka.Position.Y := Dominium__Numer__Y__Ustal_L( dominium__numer_f_f );

                zt_wizualizacja__jednostka.Position__X__Poczπtkowe__ZmieÒ__Wj( zt_wizualizacja__jednostka.Position.X );
                zt_wizualizacja__jednostka.Wyglπd_Aktualizuj__Wj(  przed_starciem_f_f, bitwa_starcie_etap_f_f, i, Wizualizacja.TWizualizacja.Jednostka__W__Jednostka__Wyglπd_Aktualizuj( jednostki_t_f_f[ i ] )  );

              end;
            //---//if not ztb then

          end;
        //---//if jednostki_t_f_f[ i ].Typ__Odczytaj__Je() <> Definicje.jt_pusta then

      end;
    //---//for i := 0 to Length( jednostki_t_f_f ) - 1 do


    if not przed_starciem_f_f then
      begin

        for j := 0 to Self.jednostki__jednostki__gl_dummy_cube__wi.Count - 1 do
          if    ( Self.jednostki__jednostki__gl_dummy_cube__wi.Children[ j ] is Wizualizacja__Obiekty__Jednostki.TWizualizacja__Jednostka )
            and (  Wizualizacja__Obiekty__Jednostki.TWizualizacja__Jednostka(Self.jednostki__jednostki__gl_dummy_cube__wi.Children[ j ]).Dominium__Numer__PorÛwnaj__Wj( dominium__numer_f_f )  ) then
            begin

              ztb := false;

              for i := 0 to Length( jednostki_t_f_f ) - 1 do
                if Wizualizacja__Obiekty__Jednostki.TWizualizacja__Jednostka(Self.jednostki__jednostki__gl_dummy_cube__wi.Children[ j ]).Id__PorÛwnaj__Wj( dominium__numer_f_f, jednostki_t_f_f[ i ].Id__Odczytaj__Je() ) then
                  begin

                    ztb := true;

                    Break;

                  end;
                //---//if Wizualizacja__Obiekty__Jednostki.TWizualizacja__Jednostka(Self.jednostki__jednostki__gl_dummy_cube__wi.Children[ j ]).Id__PorÛwnaj__Wj( dominium__numer_f_f, jednostki_t_f_f[ i ].Id__Odczytaj__Je() ) then


              if not ztb then
                Wizualizacja__Obiekty__Jednostki.TWizualizacja__Jednostka(Self.jednostki__jednostki__gl_dummy_cube__wi.Children[ j ]).WidocznoúÊ__Ustaw__Wj( false );

            end;
          //---//if    ( Self.jednostki__jednostki__gl_dummy_cube__wi.Children[ j ] is Wizualizacja__Obiekty__Jednostki.TWizualizacja__Jednostka ) (...)

      end
    else//if not przed_starciem_f_f then
      begin

        for j := Self.jednostki__jednostki__gl_dummy_cube__wi.Count - 1 downto 0 do
          if Self.jednostki__jednostki__gl_dummy_cube__wi.Children[ j ] is Wizualizacja__Obiekty__Jednostki.TWizualizacja__Jednostka then
            begin

              ztb := false;

              for i := 0 to Length( jednostki_t_f_f ) - 1 do
                if    (  Wizualizacja__Obiekty__Jednostki.TWizualizacja__Jednostka(Self.jednostki__jednostki__gl_dummy_cube__wi.Children[ j ]).Dominium__Numer__PorÛwnaj__Wj( dominium__numer_f_f )  )
                  and (  Wizualizacja__Obiekty__Jednostki.TWizualizacja__Jednostka(Self.jednostki__jednostki__gl_dummy_cube__wi.Children[ j ]).Id__PorÛwnaj__Wj( dominium__numer_f_f, jednostki_t_f_f[ i ].Id__Odczytaj__Je() )  ) then
                  begin


                    if jednostki_t_f_f[ i ].Typ__Odczytaj__Je() = Definicje.jt_pusta then
                      ztb := true
                    else//if jednostki_t_f_f[ i ].Typ__Odczytaj__Je() = Definicje.jt_pusta then
                      Wizualizacja__Obiekty__Jednostki.TWizualizacja__Jednostka(Self.jednostki__jednostki__gl_dummy_cube__wi.Children[ j ]).Position.X := i;


                    Break;

                  end;
                //---//if   ( not Wizualizacja__Obiekty__Jednostki.TWizualizacja__Jednostka(Self.jednostki__jednostki__gl_dummy_cube__wi.Children[ j ]).Dominium__Numer__PorÛwnaj__Wj( dominium__numer_f_f )  ) (...)


              if ztb then
                System.SysUtils.FreeAndNil( Self.jednostki__jednostki__gl_dummy_cube__wi.Children[ j ] );

            end;
          //---//if Self.jednostki__jednostki__gl_dummy_cube__wi.Children[ j ] is Wizualizacja__Obiekty__Jednostki.TWizualizacja__Jednostka then

      end;
    //---//if not przed_starciem_f_f then

  end;//---//Funkcja Jednostka__Rysuj__L() w Jednostki__Rysuj__Wi().

begin//Funkcja Jednostki__Rysuj__Wi().

  if Self.jednostki__jednostki__gl_dummy_cube__wi = nil then
    Exit;


  Jednostka__Rysuj__L( przed_starciem_f, Definicje.dominium__numer__gracz__1_c, bitwa_starcie_etap_f, dominium__1__jednostki_t_f );
  Jednostka__Rysuj__L( przed_starciem_f, Definicje.dominium__numer__gracz__2_c, bitwa_starcie_etap_f, dominium__2__jednostki_t_f );

end;//---//Funkcja Jednostki__Rysuj__Wi().

class procedure TWizualizacja.Jednostki__Obszar__Rysuj__Wi( obszar_wielkoúÊ_f : integer );

  //Funkcja Teren__Rodzaj__ZmieÒ_L() w Jednostki__Obszar__Rysuj__Wi().
  procedure Teren__Rodzaj__ZmieÒ_L( const x_f,  y_f, obszar_wielkoúÊ_f_f : integer; zt_mapa_kratka_f : Wizualizacja__Obiekty__Mapa.TMapa_Kratka );
  begin

    if zt_mapa_kratka_f = nil then
      Exit;


    if   ( x_f < 0 )
      or ( x_f >= obszar_wielkoúÊ_f_f )
      or ( y_f <= 1 )
      or ( y_f >= Wizualizacja.jednostki__obszar__wysokoúÊ__y_c ) then
      zt_mapa_kratka_f.Teren__Rodzaj__ZmieÒ__Mk( Definicje.mapa__teren__niedostÍpny_c )
    else
      zt_mapa_kratka_f.Teren__Rodzaj__ZmieÒ__Mk( Definicje.mapa__teren__jednostki__obszar_c );

  end;//---//Funkcja Teren__Rodzaj__ZmieÒ_L() w Jednostki__Obszar__Rysuj__Wi().

var
  ztb : boolean;

  i,
  x_l,
  y_l
    : integer;

  zt_mapa_kratka : Wizualizacja__Obiekty__Mapa.TMapa_Kratka;
begin//Funkcja Jednostki__Obszar__Rysuj__Wi().

  if Self.jednostki__obszar__gl_dummy_cube__wi = nil then
    Exit;


  if obszar_wielkoúÊ_f < 1 then
    obszar_wielkoúÊ_f := 1;

  for x_l := -1 to obszar_wielkoúÊ_f do
    for y_l := 1 to Wizualizacja.jednostki__obszar__wysokoúÊ__y_c do
      begin

        ztb := false;

        for i := 0 to Self.jednostki__obszar__gl_dummy_cube__wi.Count - 1 do
          if    ( Self.jednostki__obszar__gl_dummy_cube__wi.Children[ i ] is Wizualizacja__Obiekty__Mapa.TMapa_Kratka )
            and (  Wizualizacja__Obiekty__Mapa.TMapa_Kratka(Self.jednostki__obszar__gl_dummy_cube__wi.Children[ i ]).Id__PorÛwnaj__Mk( x_l, y_l )  ) then
            begin

              ztb := true;

              Teren__Rodzaj__ZmieÒ_L( x_l, y_l, obszar_wielkoúÊ_f, Wizualizacja__Obiekty__Mapa.TMapa_Kratka(Self.jednostki__obszar__gl_dummy_cube__wi.Children[ i ]) );

              Break;

            end;
          //---//if    ( Self.jednostki__obszar__gl_dummy_cube__wi.Children[ i ] is Wizualizacja__Obiekty__Mapa.TMapa_Kratka ) (...)


        if not ztb then
          begin

            zt_mapa_kratka := Wizualizacja__Obiekty__Mapa.TMapa_Kratka.Create( Self.jednostki__obszar__gl_dummy_cube__wi );
            zt_mapa_kratka.Parent := Self.jednostki__obszar__gl_dummy_cube__wi;
            zt_mapa_kratka.Id__ZmieÒ__Mk( x_l, y_l );
            zt_mapa_kratka.CubeSize := Wizualizacja.kratka__wielkoúÊ_c;

            Teren__Rodzaj__ZmieÒ_L( x_l, y_l, obszar_wielkoúÊ_f, zt_mapa_kratka );

          end;
        //---//if not ztb then

      end;
    //---//for y_l := 0 to Wizualizacja.jednostki__obszar__wysokoúÊ__y_c do

end;//---//Funkcja Jednostki__Obszar__Rysuj__Wi().

class procedure TWizualizacja.Mapa__Jednostki__Rysuj__Wi( const mapa_jednostki_f : Definicje.TMapa_Jednostki );
var
  ztb : boolean;

  i,
  j
    : integer;

  zt_wizualizacja__mapa_jednostka : Wizualizacja__Obiekty__Mapa_Jednostki.TWizualizacja__Mapa_Jednostka;
begin

  if Self.mapa__jednostki__gl_dummy_cube__wi = nil then
    Exit;


  for i := 0 to Length( mapa_jednostki_f ) - 1 do
    begin

      ztb := false;

      for j := 0 to Self.mapa__jednostki__gl_dummy_cube__wi.Count - 1 do
        if    ( Self.mapa__jednostki__gl_dummy_cube__wi.Children[ j ] is Wizualizacja__Obiekty__Mapa_Jednostki.TWizualizacja__Mapa_Jednostka )
          and (  Wizualizacja__Obiekty__Mapa_Jednostki.TWizualizacja__Mapa_Jednostka(Self.mapa__jednostki__gl_dummy_cube__wi.Children[ j ]).Id__PorÛwnaj__Wmj( mapa_jednostki_f[ i ].id__mj )  ) then
          begin

            ztb := true;

            Wizualizacja__Obiekty__Mapa_Jednostki.TWizualizacja__Mapa_Jednostka(Self.mapa__jednostki__gl_dummy_cube__wi.Children[ j ]).Efekt__Atak__ZmieÒ__Wmj( mapa_jednostki_f[ i ].atak__w_trakcie__mj );
            Wizualizacja__Obiekty__Mapa_Jednostki.TWizualizacja__Mapa_Jednostka(Self.mapa__jednostki__gl_dummy_cube__wi.Children[ j ]).Efekt__Obraøenia__ZmieÒ__Wmj( mapa_jednostki_f[ i ].obraøenia__w_trakcie__mj );
            Wizualizacja__Obiekty__Mapa_Jednostki.TWizualizacja__Mapa_Jednostka(Self.mapa__jednostki__gl_dummy_cube__wi.Children[ j ]).WspÛ≥rzÍdne__Ustaw__Wmj( mapa_jednostki_f[ i ].wspÛ≥rzÍdna__y__mj, mapa_jednostki_f[ i ].wspÛ≥rzÍdna__x__mj );


            Break;

          end;
        //---//if    ( Self.mapa__jednostki__gl_dummy_cube__wi.Children[ j ] is Wizualizacja__Obiekty__Mapa_Jednostki.TWizualizacja__Mapa_Jednostka ) (...)


      if not ztb then
        begin

          zt_wizualizacja__mapa_jednostka := Wizualizacja__Obiekty__Mapa_Jednostki.TWizualizacja__Mapa_Jednostka.Create
            (
              Self.mapa__jednostki__gl_dummy_cube__wi,
              mapa_jednostki_f[ i ].dominium__numer__mj,
              mapa_jednostki_f[ i ].id__mj
            );
          zt_wizualizacja__mapa_jednostka.Parent := Self.mapa__jednostki__gl_dummy_cube__wi;
          zt_wizualizacja__mapa_jednostka.CubeSize := Wizualizacja.kratka__wielkoúÊ_c;
          zt_wizualizacja__mapa_jednostka.WspÛ≥rzÍdne__Ustaw__Wmj( mapa_jednostki_f[ i ].wspÛ≥rzÍdna__y__mj, mapa_jednostki_f[ i ].wspÛ≥rzÍdna__x__mj );
          zt_wizualizacja__mapa_jednostka.Position.X := mapa_jednostki_f[ i ].wspÛ≥rzÍdna__x__mj;
          zt_wizualizacja__mapa_jednostka.Position.Y := mapa_jednostki_f[ i ].wspÛ≥rzÍdna__y__mj;
          zt_wizualizacja__mapa_jednostka.Position.Z := -zt_wizualizacja__mapa_jednostka.CubeSize * 0.5;

        end;
      //---//if not ztb then

    end;
  //---//for i := 0 to Length( mapa_jednostki_f ) - 1 do


  for j := 0 to Self.mapa__jednostki__gl_dummy_cube__wi.Count - 1 do
    if Self.mapa__jednostki__gl_dummy_cube__wi.Children[ j ] is Wizualizacja__Obiekty__Mapa_Jednostki.TWizualizacja__Mapa_Jednostka then
      begin

        ztb := false;

        for i := 0 to Length( mapa_jednostki_f ) - 1 do
          if Wizualizacja__Obiekty__Mapa_Jednostki.TWizualizacja__Mapa_Jednostka(Self.mapa__jednostki__gl_dummy_cube__wi.Children[ j ]).Id__PorÛwnaj__Wmj( mapa_jednostki_f[ i ].id__mj ) then
            begin

              ztb := true;

              Break;

            end;
          //---//if Wizualizacja__Obiekty__Mapa_Jednostki.TWizualizacja__Mapa_Jednostka(Self.mapa__jednostki__gl_dummy_cube__wi.Children[ j ]).Id__PorÛwnaj__Wmj( mapa_jednostki_f[ i ].id__mj ) then


        if not ztb then
          Wizualizacja.TWizualizacja.Mapa__Jednostka__Zwolnij__Jednπ__Wi( Wizualizacja__Obiekty__Mapa_Jednostki.TWizualizacja__Mapa_Jednostka(Self.mapa__jednostki__gl_dummy_cube__wi.Children[ j ]).Id__Odczytaj__Wmj() );

      end;
    //---//if Self.mapa__jednostki__gl_dummy_cube__wi.Children[ j ] is Wizualizacja__Obiekty__Mapa_Jednostki.TWizualizacja__Mapa_Jednostka then

end;//---//Funkcja Mapa__Jednostki__Rysuj__Wi().

class procedure TWizualizacja.Mapa__Rysuj__Wi( const teren_t_f : Poszukiwacz.TTablica2D_Integer );
var
  ztb,
  czy__kamera__resetuj_l
    : boolean;

  i,
  x_l,
  y_l
    : integer;

  zt_mapa_kratka : Wizualizacja__Obiekty__Mapa.TMapa_Kratka;
begin

  if Self.mapa__obiekty__gl_dummy_cube__wi = nil then
    Exit;


  czy__kamera__resetuj_l := true;


  for y_l := 0 to Length( teren_t_f ) - 1 do
    for x_l := 0 to Length( teren_t_f[ y_l ] ) - 1 do
      begin

        ztb := false;

        for i := 0 to Self.mapa__obiekty__gl_dummy_cube__wi.Count - 1 do
          if    ( Self.mapa__obiekty__gl_dummy_cube__wi.Children[ i ] is Wizualizacja__Obiekty__Mapa.TMapa_Kratka )
            and (  Wizualizacja__Obiekty__Mapa.TMapa_Kratka(Self.mapa__obiekty__gl_dummy_cube__wi.Children[ i ]).Id__PorÛwnaj__Mk( x_l, y_l )  ) then
            begin

              ztb := true;

              if czy__kamera__resetuj_l then
                czy__kamera__resetuj_l := false;

              Wizualizacja__Obiekty__Mapa.TMapa_Kratka(Self.mapa__obiekty__gl_dummy_cube__wi.Children[ i ]).Teren__Rodzaj__ZmieÒ__Mk( teren_t_f[ y_l, x_l ] );

              Break;

            end;
          //---//if    ( Self.mapa__obiekty__gl_dummy_cube__wi.Children[ i ] is Wizualizacja__Obiekty__Mapa.TMapa_Kratka ) (...)


        if not ztb then
          begin

            if    ( x_l = 0 )
              and ( y_l = 0 ) then
              begin

                Self.mapa__úrodek__x__wi := Length( teren_t_f[ y_l ] ) * 0.5;
                Self.mapa__úrodek__y__wi := Length( teren_t_f ) * 0.5;

                Self.jednostki__obszar__gl_dummy_cube__wi.Position.X := Self.mapa__úrodek__x__wi * Wizualizacja.jednostki__obszar__przesuniÍcie__x_c;
                Self.jednostki__obszar__gl_dummy_cube__wi.Position.Y := Self.mapa__úrodek__y__wi - 4 + Wizualizacja.kratka__wielkoúÊ_c * 0.5;


                if Self.jednostki__jednostki__gl_dummy_cube__wi <> nil then
                  Self.jednostki__jednostki__gl_dummy_cube__wi.Position := Self.jednostki__obszar__gl_dummy_cube__wi.Position;

              end;
            //---//if    ( x_l = 0 ) (...)


            zt_mapa_kratka := Wizualizacja__Obiekty__Mapa.TMapa_Kratka.Create( Self.mapa__obiekty__gl_dummy_cube__wi );
            zt_mapa_kratka.Parent := Self.mapa__obiekty__gl_dummy_cube__wi;
            zt_mapa_kratka.Id__ZmieÒ__Mk( x_l, y_l );
            zt_mapa_kratka.CubeSize := Wizualizacja.kratka__wielkoúÊ_c;
            zt_mapa_kratka.Teren__Rodzaj__ZmieÒ__Mk( teren_t_f[ y_l, x_l ] );

          end;
        //---//if not ztb then

      end;
    //---//for x_l := 0 to Length( teren_t_f[ y_l ] ) - 1 do


  if    ( czy__kamera__resetuj_l )
    and ( @Self.Kamera__Resetuj__Wi <> nil ) then
    Self.Kamera__Resetuj__Wi();

end;//---//Funkcja Mapa__Rysuj__Wi().

class procedure TWizualizacja.Surowce__Rysuj__Wi( const surowce_ürÛd≥o_t_f : Definicje.TSurowce_èrÛd≥o );
var
  ztb : boolean;

  i,
  j
    : integer;

  zt_wizualizacja__surowiec : Wizualizacja__Obiekty__Budowle.TWizualizacja__Surowiec;
begin

  if Self.surowce__obiekty__gl_dummy_cube__wi = nil then
    Exit;


  for i := 0 to Length( surowce_ürÛd≥o_t_f ) - 1 do
    if surowce_ürÛd≥o_t_f[ i ].surowiec__rodzaj__sü in [ Definicje.sr_kryszta≥, Definicje.sr_kwiatki, Definicje.sr_magma, Definicje.sr_woda, Definicje.sr_øywio≥ ] then
      begin

        ztb := false;

        for j := 0 to Self.surowce__obiekty__gl_dummy_cube__wi.Count - 1 do
          if    ( Self.surowce__obiekty__gl_dummy_cube__wi.Children[ j ] is Wizualizacja__Obiekty__Budowle.TWizualizacja__Surowiec )
            and (  Wizualizacja__Obiekty__Budowle.TWizualizacja__Surowiec(Self.surowce__obiekty__gl_dummy_cube__wi.Children[ j ]).Id__PorÛwnaj__Wo( surowce_ürÛd≥o_t_f[ i ].id__sü )  ) then
            begin

              ztb := true;

              Wizualizacja__Obiekty__Budowle.TWizualizacja__Surowiec(Self.surowce__obiekty__gl_dummy_cube__wi.Children[ j ]).Domki__IloúÊ__ZmieÒ__Wsu( surowce_ürÛd≥o_t_f[ i ].domki__iloúÊ__sü );
              Wizualizacja__Obiekty__Budowle.TWizualizacja__Surowiec(Self.surowce__obiekty__gl_dummy_cube__wi.Children[ j ]).PrzynaleønoúÊ__ZmieÒ__Wo( surowce_ürÛd≥o_t_f[ i ].dominium__numer__sü );

              Break;

            end;
          //---//if    ( Self.surowce__obiekty__gl_dummy_cube__wi.Children[ j ] is Wizualizacja__Obiekty__Budowle.TWizualizacja__Surowiec ) (...)


        if not ztb then
          begin

            zt_wizualizacja__surowiec := Wizualizacja__Obiekty__Budowle.TWizualizacja__Surowiec.Create
              (
                Self.surowce__obiekty__gl_dummy_cube__wi,
                surowce_ürÛd≥o_t_f[ i ].id__sü,
                surowce_ürÛd≥o_t_f[ i ].surowiec__rodzaj__sü
              );
            zt_wizualizacja__surowiec.Parent := Self.surowce__obiekty__gl_dummy_cube__wi;
            zt_wizualizacja__surowiec.CubeSize := Wizualizacja.kratka__wielkoúÊ_c;
            zt_wizualizacja__surowiec.Position.X := surowce_ürÛd≥o_t_f[ i ].wspÛ≥rzÍdna__x__sü;
            zt_wizualizacja__surowiec.Position.Y := surowce_ürÛd≥o_t_f[ i ].wspÛ≥rzÍdna__y__sü;
            zt_wizualizacja__surowiec.Position.Z := -zt_wizualizacja__surowiec.CubeSize * 0.5;

          end;
        //---//if not ztb then

      end;
    //---//if surowce_ürÛd≥o_t_f[ i ].surowiec__rodzaj__sü in [ Definicje.sr_kryszta≥, Definicje.sr_kwiatki, Definicje.sr_magma, Definicje.sr_woda, Definicje.sr_øywio≥ ] then

end;//---//Funkcja Surowce__Rysuj__Wi().

class procedure TWizualizacja.Wizualizacja__Zwolnij__Wi();
var
  i : integer;
begin

  if Self.budowle__obiekty__gl_dummy_cube__wi <> nil then
    for i := Self.budowle__obiekty__gl_dummy_cube__wi.Count - 1 downto 0 do
      System.SysUtils.FreeAndNil( Self.budowle__obiekty__gl_dummy_cube__wi.Children[ i ] );

  if Self.droga__obiekty__gl_dummy_cube__wi <> nil then
    for i := Self.droga__obiekty__gl_dummy_cube__wi.Count - 1 downto 0 do
      System.SysUtils.FreeAndNil( Self.droga__obiekty__gl_dummy_cube__wi.Children[ i ] );

  if Self.jednostki__jednostki__gl_dummy_cube__wi <> nil then
    for i := Self.jednostki__jednostki__gl_dummy_cube__wi.Count - 1 downto 0 do
      System.SysUtils.FreeAndNil( Self.jednostki__jednostki__gl_dummy_cube__wi.Children[ i ] );

  if Self.jednostki__obszar__gl_dummy_cube__wi <> nil then
    for i := Self.jednostki__obszar__gl_dummy_cube__wi.Count - 1 downto 0 do
      System.SysUtils.FreeAndNil( Self.jednostki__obszar__gl_dummy_cube__wi.Children[ i ] );

  if Self.mapa__jednostki__gl_dummy_cube__wi <> nil then
    for i := Self.mapa__jednostki__gl_dummy_cube__wi.Count - 1 downto 0 do
      System.SysUtils.FreeAndNil( Self.mapa__jednostki__gl_dummy_cube__wi.Children[ i ] );

  if Self.mapa__obiekty__gl_dummy_cube__wi <> nil then
    for i := Self.mapa__obiekty__gl_dummy_cube__wi.Count - 1 downto 0 do
      System.SysUtils.FreeAndNil( Self.mapa__obiekty__gl_dummy_cube__wi.Children[ i ] );

  if Self.surowce__obiekty__gl_dummy_cube__wi <> nil then
    for i := Self.surowce__obiekty__gl_dummy_cube__wi.Count - 1 downto 0 do
      System.SysUtils.FreeAndNil( Self.surowce__obiekty__gl_dummy_cube__wi.Children[ i ] );

end;//---//Funkcja Wizualizacja__Zwolnij__Wi().

class procedure TWizualizacja.Zwolnij__Wszystko__Wi();
var
  i : integer;
begin

  Self.Kamera__Resetuj__Wi := nil;


  Self.Wizualizacja__Zwolnij__Wi();


  if Self.gra__obiekty__gl_dummy_cube__wi = nil then
    Exit;


  for i := Self.gra__obiekty__gl_dummy_cube__wi.Count - 1 downto 0 do
    System.SysUtils.FreeAndNil( Self.gra__obiekty__gl_dummy_cube__wi.Children[ i ] );


  Self.gra__obiekty__gl_dummy_cube__wi := nil;

end;//---//Funkcja Zwolnij__Wszystko__Wi().

end.
