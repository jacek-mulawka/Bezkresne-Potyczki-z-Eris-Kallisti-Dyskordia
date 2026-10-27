unit Definicje;{26.Sie.2026}

interface

uses
  Stage.Color,

  Vcl.Graphics,
  Winapi.Windows;

const
  bitwa_dominia__przeliczeÒ_w_turze_c : integer = 60;

  budowa__koszt__domek_c : integer = 15;
  budowa__koszt__wieøa__obronna_c : integer = 30;
  budowa__koszt__wieøa__zwiadowcza_c : integer = 10;

  dominium__numer__gracz__1_c : smallint = 1;
  dominium__numer__gracz__2_c : smallint = 2;
  dominium__numer__puste_c : smallint = 0;
  dominium__wytrzyma≥oúÊ_punkty_c : integer = 5;

  identyfikator_pusty_c : integer = -99;

  jednostka__koszt__obszar__zakup_c : integer = 5;
  jednostka__koszt__po≥πczenie_c : integer = 10;
  jednostka__koszt__zakup_c : integer = 10;
  jednostka__w_zwarciu_z_indeks__pusty_c : integer = -1;

  kolor__dominium__1_c : Stage.Color.TGSColorVector = ( X : 0; Y : 0; Z : 1; W : 1 ); // clrBlue.
  kolor__dominium__2_c : Stage.Color.TGSColorVector = ( X : 1; Y : 0; Z : 0; W : 1 ); // clrRed.
  kolor__dominium__brak_c : Stage.Color.TGSColorVector = ( X : 1; Y : 1; Z : 1; W : 1 ); // clrWhite.

  kolor__budowla__wytrzyma≥oúÊ_punkty__wskaünik_c : Stage.Color.TGSColorVector = ( X : 0.196078; Y : 0.8; Z : 0.196078; W : 1 ); // clrLimeGreen.

  kolor__mapa__nie_kopiuj_c : Winapi.Windows.TRGBTriple = ( rgbtBlue : 0; rgbtGreen : 255; rgbtRed : 255 ); // ØÛ≥ty.
  kolor__surowiec__kryszta≥_c : Winapi.Windows.TRGBTriple = ( rgbtBlue : 255; rgbtGreen : 255; rgbtRed : 0 ); // B≥Íkitny.
  kolor__surowiec__kwiatki_c : Winapi.Windows.TRGBTriple = ( rgbtBlue : 0; rgbtGreen : 255; rgbtRed : 0 ); // Zielony.
  kolor__surowiec__magma_c : Winapi.Windows.TRGBTriple = ( rgbtBlue : 0; rgbtGreen : 0; rgbtRed : 255 ); // Czerwony.
  kolor__surowiec__woda_c : Winapi.Windows.TRGBTriple = ( rgbtBlue : 255; rgbtGreen : 0; rgbtRed : 0 ); // Niebieski.
  kolor__surowiec__øywio≥_c : Winapi.Windows.TRGBTriple = ( rgbtBlue : 255; rgbtGreen : 0; rgbtRed : 255 ); // RÛøowy.
  kolor__teren__dostÍpny_c : Winapi.Windows.TRGBTriple = ( rgbtBlue : 255; rgbtGreen : 255; rgbtRed : 255 ); // Bia≥y.
  kolor__zamek_c : Winapi.Windows.TRGBTriple = ( rgbtBlue : 0; rgbtGreen : 0; rgbtRed : 0 ); // Czarny.

  mapa__teren__dostÍpny_c : integer = 0;
  mapa__teren__jednostki__obszar_c : integer = -2;
  mapa__teren__jednostki__obszar__wykupiony_c : integer = -3;
  mapa__teren__niedostÍpny_c : integer = -1;

  obserwacja__zasiÍg___wieøa__obronna_c : integer = 2;
  obserwacja__zasiÍg___wieøa__zwiadowcza_c : integer = 3;
  obserwacja__zasiÍg___zamek_c : integer = 4;

  pomoc_c =
      'Backspace - Podglπd surowcÛw przeciwnika' + #13 +
      '            <Ressourcen des Gegners ansehen>' + #13 +
      '            <View opponent''s resources>' + #13 +
      'Enter - pe≥ny ekran <Vollbildschirm> <full screen>' + #13 +
        '        potyczka. <Scharm¸tzel.> <skirmish.>' + #13 +
      'Esc - wyjúcie <Ausgang> <Exit>' + #13 +
      'F1 - zakup i ≥πcz jednostki automatycznie' + #13 +
      '     <Einheiten automatisch kaufen und zusammenf¸hren>' + #13 +
      '     <buy and merge units automatically>' + #13 +
      'F3 - zawsze kupuj i ≥πcz jednostki automatycznie - prze≥πcz' + #13 +
      '     <immer Einheiten automatisch kaufen und' + #13 +
      '      zusammenf¸hren - schalten>' + #13 +
      '     <always buy and merge units automatically - switch>' + #13 +
      'F5 - stocz bitwÍ jednostek' + #13 +
      '     <k‰mpfe in einer Einheitenschlacht>' + #13 +
      '     <fight a unit battle>' + #13 +
      'F11 - informacje zwiÒ / rozwiÒ' + #13 +
      '      <Informationen zuklappen / erweitern>' + #13 +
      '      <collapse / expand information>' + #13 +
      'F12 - informacje wyúwietl / ukryj' + #13 +
      '      <Informationen ein-/ausblenden>' + #13 +
      '      <show / hide information>' + #13 +
      'K - resetuj kamerÍ <Kamera zur¸cksetzen> <reset camera>' + #13 +
      'P, Pause Break - pauza <Pause> <pause>' + #13 +
      'W, S, A, D, R, F, Q, E, Z, X, PPM <rechte Maustaste> <RMB>' + #13 +
        '        ruch kamery' + #13 +
        '        <Kamerabewegung>' + #13 +
        '        <camera movement>' + #13 +
      '+, -, * - prÍdkoúÊ gry zwiÍksz, zmniejsz, domyúlna' + #13 +
        '        <Spielgeschwindigkeit erhˆhen, verringern, Standard>' + #13 +
        '        <game speed increase, decrease, default>' + #13 +
      '` - wy≥πcz tryb budowania' + #13 +
        '    <Baumodus deaktivieren>' + #13 +
        '    <turn off build mode>' + #13 +
      '. - wyúwietlaj statystyki gracza' + #13 +
        '    <Spielerstatistiken anzeigen>' + #13 +
        '    <display player stats>' + #13 +
      '? - pomoc <Hilfe> <help>' + #13 +
      'buduj <bauen> <build>' + #13 +
        '        1 - wieøa zwiadowcza <Aufkl‰rungsturm>' + #13 +
        '            <observation tower>' + #13 +
        '        2 - domek <H¸tte> <cottage>' + #13 +
        '        3 - wieøa obronna <Wehrturm> <defensive tower>' + #13 +
        '        4 - koszary <Kaserne> <barracks>' + #13 +
      '1 - kup piechotÍ <Infanterie kaufen> <buy infantry>' + #13 +
      '2 - kup jazdÍ <Kavallerie kaufen> <buy cavalry>' + #13 +
      '3 - po≥πcz jednostki' + #13 +
        '    <Einheiten zusammenf¸hren>' + #13 +
        '    <merge units>' + #13 +
      '4 - teren powiÍksz' + #13 +
      '    <Vergrˆﬂere das Gel‰nde>' + #13 +
      '    <enlarge the terrain>' + #13;

  wydobycie__zasiÍg__domek_c : integer = 1;

type
  TBitwa_Starcie_Etap = ( bse_atak__zwarcie, bse_atak__dystans, bse_dπøenie_do_zwarcia );

  TBitwa_Jednostki_Wynik = ( bjw_poraøka, bjw_remis, bjw_zwyciÍstwo );

  TBudowla_Rodzaj =
    (
      br_domek,
      br_koszary,
      br_wieøa__obronna,
      br_wieøa__zwiadowcza,
      br_zamek
    );

  TGracz_WspÛ≥czynnik_Rodzaj = ( gwr_atak, gwr_obrona, gwr_obserwacja, gwr_surowiec__produkcja, gwr_zamek__produkcja );

  TJednostka_BroÒ_Rodzaj = ( jbr_dystans, jbr_zwarcie );

  TJednostka_Typ = ( jt_jazda, jt_piechota, jt_pusta );

  TSurowiec_Rodzaj = // Indeksuje od zera.
    (
      sr_kryszta≥, // budowa domkÛw (+ magma pola bitewne)
      sr_kwiatki, // koniki (+ woda)
      sr_magma, // budowle wojenne (+ kryszta≥ pola bitewne)
      sr_woda, // ludziki
      sr_øywio≥ // ≥πczenie jednostek
    );

  TBudowla = record
    atak__w_trakcie__bu,
    ruch_grupπ__bu,
    obraøenia__w_trakcie__bu
      : boolean;

    dominium__numer__bu : smallint;

    id__bu,
    id__surowiec_ürÛd≥o__bu,
    atak__cel__wspÛ≥rzÍdna__x__bu,
    atak__cel__wspÛ≥rzÍdna__y__bu,
    koszary__mapa_jednostki__iloúÊ__bu,
    wspÛ≥rzÍdna__x__bu,
    wspÛ≥rzÍdna__y__bu
      : integer;

    koszary__produkcja_wspÛ≥czynnik__skumulowany__bu,
    wytrzyma≥oúÊ_punkty__bu
      : real;

    budowla_rodzaj__bu : Definicje.TBudowla_Rodzaj;

    surowiec__rodzaj__bu : Definicje.TSurowiec_Rodzaj;
  end;//---//TBudowla = record

  TBudowle = array of Definicje.TBudowla;

  TMapa_Jednostka = record
    atak__w_trakcie__mj,
    ruch__mj,
    obraøenia__w_trakcie__mj,
    poza_koszarami__mj
      : boolean;

    dominium__numer__mj : smallint;

    id__mj,
    id__budowla__mj,
    wspÛ≥rzÍdna__x__mj,
    wspÛ≥rzÍdna__y__mj
      : integer;

    wytrzyma≥oúÊ_punkty__mj : real;
  end;//---//TMapa_Jednostka = record

  TMapa_Jednostki = array of Definicje.TMapa_Jednostka;

  TStrategia_Typ = ( st_agresywna_bardzo, st_agresywna, st_wywaøona, st_zachowawcza, st_zachowawcza_bardzo );

  TSurowce_Rodzaj = set of Definicje.TSurowiec_Rodzaj;

  TSurowiec_ZasÛb = record
    domki__iloúÊ__sz,
    surowiec__iloúÊ__sz
      : integer;

    surowiec__produkcja_wspÛ≥czynnik__skumulowany__sz : real;

    surowiec__rodzaj__sz : TSurowiec_Rodzaj;
  end;//---//TSurowiec_ZasÛb = record

  TSurowce_Zasoby = array of Definicje.TSurowiec_ZasÛb;

  TSurowiec_èrÛd≥o = record
    dominium__numer__sü, // 0 = domek nie zajÍty, 1, 2.
    domki__iloúÊ__sü
      : smallint;

    id__sü,
    wspÛ≥rzÍdna__x__sü,
    wspÛ≥rzÍdna__y__sü
      : integer;

    surowiec__rodzaj__sü : Definicje.TSurowiec_Rodzaj;
  end;//---//TSurowiec_èrÛd≥o = record

  TSurowce_èrÛd≥o = array of Definicje.TSurowiec_èrÛd≥o;

function RGBTriple_To_Color( const rgb_triple_f : Winapi.Windows.TRGBTriple ) : Vcl.Graphics.TColor;

implementation

function RGBTriple_To_Color( const rgb_triple_f : Winapi.Windows.TRGBTriple ) : Vcl.Graphics.TColor;
begin

  Result := Winapi.Windows.RGB
    (
      rgb_triple_f.rgbtRed,
      rgb_triple_f.rgbtGreen,
      rgb_triple_f.rgbtBlue
    );

end;//---//Funkcja RGBTriple_To_Color() w Konstruktor klasy TWizualizacja__Surowiec.

end.
