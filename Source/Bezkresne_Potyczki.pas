unit Bezkresne_Potyczki;{06.Sie.2026}

  //
  // MIT License
  //
  // Copyright (c) 2026 Jacek Mulawka
  //
  // j.mulawka@interia.pl
  //
  // https://github.com/jacek-mulawka
  //

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids,
  Vcl.Samples.Spin,

  Definicje,
  Ranking;

type
  TGracz_Szukaj_Kolumna = ( gsk_id, gsk_lp, gsk_nazwa );

  TBezkresne_Potyczki_Form = class( TForm )
    PageControl1: TPageControl;
    Opcje_TabSheet: TTabSheet;
    O_Programie_TabSheet: TTabSheet;
    O_Programie_Label: TLabel;
    Logo_Image: TImage;
    Pomoc_BitBtn: TBitBtn;
    Ranking_TabSheet: TTabSheet;
    Gracz_Nazwa_Etykieta_Label: TLabel;
    Gracz_Nazwa_Edit: TEdit;
    Gracz_Nazwa_Panel: TPanel;
    Gra_Nowa_Button: TButton;
    Ranking__Gracz_Panel: TPanel;
    Ranking_StringGrid: TStringGrid;
    Ranking_Label: TLabel;
    Potyczka_Button: TButton;
    Ranking__Wczytaj_Button: TButton;
    Potyczki__Iloœæ_Label: TLabel;
    Ranking__Statystyki_Gracza_Panel: TPanel;
    Ranking__Statystyki_Gracza_Splitter: TSplitter;
    Ranking__Statystyki_Gracza_Label: TLabel;
    Ranking__Statystyki_Gracza_CheckBox: TCheckBox;
    Potyczka_ProgressBar: TProgressBar;
    Rozbudowa_TabSheet: TTabSheet;
    Rozbudowa_Panel: TPanel;
    Rozbudowa__Punkty_GroupBox: TGroupBox;
    Rozbudowa__Punkty_Label: TLabel;
    Bitwa_Dominia__Przeliczeñ_W_Turze_Etykieta_Label: TLabel;
    Bitwa_Dominia__Przeliczeñ_W_Turze_SpinEdit: TSpinEdit;
    Dominium__Wytrzyma³oœæ_Punkty_Etykieta_Label: TLabel;
    Dominium__Wytrzyma³oœæ_Punkty_SpinEdit: TSpinEdit;
    Gracz_Szukaj_GroupBox: TGroupBox;
    Gracz_Szukaj_Edit: TEdit;
    Gracz_Szukaj__Id_RadioButton: TRadioButton;
    Gracz_Szukaj__Lp_RadioButton: TRadioButton;
    Gracz_Szukaj__Nazwa_RadioButton: TRadioButton;
    Gra_Nowa__Gracze_Iloœæ_SpinEdit: TSpinEdit;
    Gra_Nowa__Gracze_Iloœæ_Etykieta_Label: TLabel;
    Potyczka__Przeliczaj_W_Tle_CheckBox: TCheckBox;
    Potyczka__Przeliczaj_W_Tle__W¹tki__Iloœæ_Etykieta_Label: TLabel;
    Potyczka__Przeliczaj_W_Tle__W¹tki__Iloœæ_SpinEdit: TSpinEdit;
    Gracz_Szukaj__Dok³adnie_CheckBox: TCheckBox;
    procedure FormShow( Sender: TObject );
    procedure FormClose( Sender: TObject; var Action: TCloseAction );
    procedure FormResize( Sender: TObject );

    procedure Gra_Nowa_ButtonClick( Sender: TObject );

    procedure Gracz_Szukaj_EditChange( Sender: TObject );
    procedure Gracz_Szukaj_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Pomoc_BitBtnClick( Sender: TObject );
    procedure Potyczka_ButtonClick( Sender: TObject );
    procedure Ranking__Statystyki_Gracza_CheckBoxClick( Sender: TObject );
    procedure Ranking__Wczytaj_ButtonClick( Sender: TObject );

    procedure PageControl1Change( Sender: TObject );

    procedure Ranking_StringGridDrawCell( Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState );
    procedure Ranking_StringGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Ranking_StringGridSelectCell( Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean );
  private
    { Private declarations }
    potyczki_w_trakcie_g,
    ranking__statystyki_gracza_blokuj_g
      : boolean;

    gracz__i__wartoœæ__poprzednia_g : integer;

    kolor__gracz__ranking_g : TColor;

    potyczka__start__data_czas_g : TDateTime;

    okno__etykieta_kopia_g,
    rozbudowa__etykieta_kopia_g
      : string;

    ranking_g : Ranking.TRanking;

    procedure Gracz__Rozbuduj( const wspó³czynnik_rodzaj_f : Definicje.TGracz_Wspó³czynnik_Rodzaj );
    procedure Gracz__Szukaj( const gracz_szukaj_kolumna_f : Bezkresne_Potyczki.TGracz_Szukaj_Kolumna; const wartoœæ_f : string; const wprzód_f : boolean = false; const wstecz_f : boolean = false );
    function Gracz__Szukaj__Kolumna__Odczytaj() : Bezkresne_Potyczki.TGracz_Szukaj_Kolumna;

    procedure Postêp__Odœwie¿();
    procedure Potyczka__Przeliczanie__Zakoñczone();
    procedure Potyczki__Iloœæ__Wyœwietl();

    procedure Ranking__Wyœwietl( const tylko_gracz_f : boolean = false );
    procedure Rozbudowa__Dane__Wyœwietl( const gracz_id_f : integer );
    procedure Statystyki_Gracza__Wyœwietl( const wiersz_numer_f : integer );
  public
    { Public declarations }
  end;//---//TBezkresne_Potyczki_Form = class

const
  ranking__wyœwietl__kolumna_indeks__id_c : integer = 4;
  ranking__wyœwietl__kolumna_indeks__l_p_c : integer = 0;
  ranking__wyœwietl__kolumna_indeks__nazwa_gracza_c : integer = 2;
  ranking__wyœwietl__kolumna_indeks__ranking_c : integer = 1;
  ranking__wyœwietl__kolumna_indeks__strategia_typ_c : integer = 3;

var
  Bezkresne_Potyczki_Form: TBezkresne_Potyczki_Form;

implementation

uses
  System.DateUtils,

  Gracz__Rozbudowa_Przycisk;

{$R *.dfm}

//      ***      Funkcje      ***      //

procedure TBezkresne_Potyczki_Form.Gracz__Rozbuduj( const wspó³czynnik_rodzaj_f : Definicje.TGracz_Wspó³czynnik_Rodzaj );
var
  gracz_id_l : integer;
begin

  gracz_id_l := ranking_g.Gracz__Gra_Gracz__Id_ZnajdŸ__Ra();

  if gracz_id_l = Definicje.identyfikator_pusty_c then
    Exit;


  ranking_g.Gracz__Rozbuduj__Ra( gracz_id_l, wspó³czynnik_rodzaj_f );

  Self.Rozbudowa__Dane__Wyœwietl( gracz_id_l );

end;//---//Funkcja Gracz__Rozbuduj().

procedure TBezkresne_Potyczki_Form.Gracz__Szukaj( const gracz_szukaj_kolumna_f : Bezkresne_Potyczki.TGracz_Szukaj_Kolumna; const wartoœæ_f : string; const wprzód_f : boolean = false; const wstecz_f : boolean = false );

  //Funkcja Gracz__Szukaj_L() w Gracz__Szukaj().
  function Gracz__Szukaj_L( const indeks_f : integer; const gracz_szukaj_kolumna_f_f : Bezkresne_Potyczki.TGracz_Szukaj_Kolumna; const wartoœæ_f_f : string ) : boolean;
  var
    zts : string;
  begin

    if gracz_szukaj_kolumna_f_f = Bezkresne_Potyczki.gsk_id then
      zts := Ranking_StringGrid.Cells[ Bezkresne_Potyczki.ranking__wyœwietl__kolumna_indeks__id_c, indeks_f ]
    else
    if gracz_szukaj_kolumna_f_f = Bezkresne_Potyczki.gsk_lp then
      zts := Ranking_StringGrid.Cells[ Bezkresne_Potyczki.ranking__wyœwietl__kolumna_indeks__l_p_c, indeks_f ]
    else
      zts := AnsiLowerCase( Ranking_StringGrid.Cells[ Bezkresne_Potyczki.ranking__wyœwietl__kolumna_indeks__nazwa_gracza_c, indeks_f ] );

    if gracz_szukaj_kolumna_f_f in [ Bezkresne_Potyczki.gsk_id, Bezkresne_Potyczki.gsk_lp ] then
      zts := StringReplace( zts, ' ', '', [ rfReplaceAll ] );


    if   (
               ( Gracz_Szukaj__Dok³adnie_CheckBox.Checked )
           and ( AnsiLowerCase( wartoœæ_f_f ) = zts  )
         )
      or (
               ( not Gracz_Szukaj__Dok³adnie_CheckBox.Checked )
           and (   Pos(  AnsiLowerCase( wartoœæ_f_f ), zts  ) > 0   )
         ) then
      begin

        Ranking_StringGrid.Row := indeks_f;

        Result := true;


        Gracz_Szukaj_Edit.Color := clWindow;

      end
    else//if   ( (...)
      begin

        Result := false;


        if Length( wartoœæ_f_f ) > 0 then
          Gracz_Szukaj_Edit.Color := clInfoBk;

      end;
    //---//if   ( (...)

  end;//---//Funkcja Gracz__Szukaj_L() w Gracz__Szukaj().

var
  i,
  zti
    : integer;
begin//Funkcja Gracz__Szukaj().

  if wprzód_f then
    zti := Ranking_StringGrid.Row + 1
  else//if wprzód_f then
  if wstecz_f then
    zti := Ranking_StringGrid.Row - 1
  else//if wstecz_f then
    zti := 1;


  if wstecz_f then
    begin

      for i := zti downto 1 do
        if Gracz__Szukaj_L( i, gracz_szukaj_kolumna_f, wartoœæ_f ) then
          Break;

    end
  else//if wstecz_f then
    for i := zti to Ranking_StringGrid.RowCount - 1 do
      if Gracz__Szukaj_L( i, gracz_szukaj_kolumna_f, wartoœæ_f ) then
        Break;

end;//---//Funkcja Gracz__Szukaj().

function TBezkresne_Potyczki_Form.Gracz__Szukaj__Kolumna__Odczytaj() : Bezkresne_Potyczki.TGracz_Szukaj_Kolumna;
begin

  if Gracz_Szukaj__Id_RadioButton.Checked then
    Result := Bezkresne_Potyczki.gsk_id
  else
  if Gracz_Szukaj__Lp_RadioButton.Checked then
    Result := Bezkresne_Potyczki.gsk_lp
  else
    Result := Bezkresne_Potyczki.gsk_nazwa;

end;//---//Funkcja Gracz__Szukaj__Kolumna__Odczytaj().

procedure TBezkresne_Potyczki_Form.Postêp__Odœwie¿();
begin

  Potyczka_ProgressBar.StepIt();


  Self.Caption := Trim(  FormatFloat( '### ### ##0', Potyczka_ProgressBar.Position )  ) + ' ' + okno__etykieta_kopia_g;


  if not Potyczka__Przeliczaj_W_Tle_CheckBox.Checked then
    if Potyczka_ProgressBar.Position mod 10 = 0 then
      Application.ProcessMessages();

end;//---//Funkcja Postêp__Odœwie¿().

procedure TBezkresne_Potyczki_Form.Potyczka__Przeliczanie__Zakoñczone();
var
  zti : integer;
begin

  zti := System.DateUtils.SecondsBetween( Now(), potyczka__start__data_czas_g );


  ranking_g.Ranking__Zapisz();

  Self.Ranking__Wyœwietl();


  Potyczka_ProgressBar.Visible := false;
  Ranking__Gracz_Panel.Height := Ranking__Gracz_Panel.Height - Potyczka_ProgressBar.Height;


  potyczki_w_trakcie_g := false;

  Gracz_Nazwa_Panel.Enabled := not potyczki_w_trakcie_g;
  Potyczka_Button.Enabled := not potyczki_w_trakcie_g;
  Rozbudowa_Panel.Enabled := not potyczki_w_trakcie_g;


  Self.Caption := okno__etykieta_kopia_g;


  Potyczka__Przeliczaj_W_Tle__W¹tki__Iloœæ_SpinEdit.Hint :=
    Trim(  FormatFloat( '### ### ##0', zti )  ) + ' [s]' + #13 +
    Trim(  FormatFloat( '### ### ##0', zti div 60 )  ) + '.' + Trim(   FormatFloat(  '00', zti - 60 * ( zti div 60 )  )   ) + ' [m]';


  Screen.Cursor := crDefault;


  {$IFNDEF DEBUG}
  if Application.MessageBox( PChar('Czy stoczyæ kolejn¹ potyczkê?' + #13 + #13 + '<Ein weiteres Scharmützel austragen?>' + #13 + #13 + '<Fight another skirmish?>' + #13 + #13 + #13 + Potyczka__Przeliczaj_W_Tle__W¹tki__Iloœæ_SpinEdit.Hint), 'Potwierdzenie', MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) = IDYES then
    Self.Potyczka_ButtonClick( nil );
  {$ENDIF}

end;//---//Funkcja Potyczka__Przeliczanie__Zakoñczone().

procedure TBezkresne_Potyczki_Form.Potyczki__Iloœæ__Wyœwietl();
begin

  Potyczki__Iloœæ_Label.Caption := Trim(  FormatFloat( '### ### ##0', ranking_g.Potyczki__Iloœæ__Odczytaj__Ra() )  );

end;//---//Funkcja Potyczki__Iloœæ__Wyœwietl().

procedure TBezkresne_Potyczki_Form.Ranking__Wyœwietl( const tylko_gracz_f : boolean = false );
var
  i : integer;

  zts : string;
begin

  ranking__statystyki_gracza_blokuj_g := true;


  Self.Potyczki__Iloœæ__Wyœwietl();


  for i := 1 to Ranking_StringGrid.RowCount - 1 do
    Ranking_StringGrid.Rows[ i ].Clear();


  Ranking_StringGrid.RowCount := ranking_g.Gracze__Iloœæ__Odczytaj__Ra() + 1;


  for i := 0 to ranking_g.Gracze__Iloœæ__Odczytaj__Ra() - 1 do
    begin

      if not tylko_gracz_f then
        begin

          Ranking_StringGrid.Cells[ Bezkresne_Potyczki.ranking__wyœwietl__kolumna_indeks__l_p_c, i + 1 ] := Trim(  FormatFloat( '### ### ##0', i + 1 )  );
          Ranking_StringGrid.Cells[ Bezkresne_Potyczki.ranking__wyœwietl__kolumna_indeks__ranking_c, i + 1 ] := Trim(   FormatFloat(  '### ### ##0', ranking_g.Gracz__Ranking__Wartoœæ__Odczytaj__Ra( i )  )   );
          Ranking_StringGrid.Cells[ Bezkresne_Potyczki.ranking__wyœwietl__kolumna_indeks__nazwa_gracza_c, i + 1 ] := ranking_g.Gracz__Nazwa__Odczytaj__Ra( i );

          if not ranking_g.Gracz__Gra_Gracz__Ra( i ) then
            Ranking_StringGrid.Cells[ Bezkresne_Potyczki.ranking__wyœwietl__kolumna_indeks__strategia_typ_c, i + 1 ] := ranking_g.Gracz__Strategia_Typ__Napis__Odczytaj__Ra( i )
          else//if not ranking_g.Gracz__Gra_Gracz__Ra( i ) then
            Ranking_StringGrid.Cells[ Bezkresne_Potyczki.ranking__wyœwietl__kolumna_indeks__strategia_typ_c, i + 1 ] := '';

          Ranking_StringGrid.Cells[ Bezkresne_Potyczki.ranking__wyœwietl__kolumna_indeks__id_c, i + 1 ] := Trim(   FormatFloat(  '### ### ##0', ranking_g.Gracz__Id__Odczytaj__Ra( i )  )   );

        end;
      //---//if not tylko_gracz_f then


      if ranking_g.Gracz__Gra_Gracz__Ra( i ) then
        begin

          if   ( gracz__i__wartoœæ__poprzednia_g = Definicje.identyfikator_pusty_c )
            or ( gracz__i__wartoœæ__poprzednia_g = i ) then
            zts := ''
          else//if   ( gracz__i__wartoœæ__poprzednia_g = Definicje.identyfikator_pusty_c ) (...)
            begin

              zts := '    <';

              if gracz__i__wartoœæ__poprzednia_g > i then
                begin

                  zts := zts +
                    '+';

                  kolor__gracz__ranking_g := clMoneyGreen;

                end
              else//if gracz__i__wartoœæ__poprzednia_g > i then
              if gracz__i__wartoœæ__poprzednia_g < i then
                begin

                  zts := zts +
                    '-';

                  kolor__gracz__ranking_g := clInfoBk;

                end
              else//if gracz__i__wartoœæ__poprzednia_g < i then
                kolor__gracz__ranking_g := clSkyBlue;


              zts := zts +
                Trim(   FormatFloat(  '### ### ##0', Abs( gracz__i__wartoœæ__poprzednia_g - i )  )   ) +
                '>';

            end;
          //---//if   ( gracz__i__wartoœæ__poprzednia_g = Definicje.identyfikator_pusty_c ) (...)


          Ranking_Label.Caption :=
            ranking_g.Gracz__Nazwa__Odczytaj__Ra( i ) +
            ': ' + Trim(   FormatFloat(  '### ### ##0', ranking_g.Gracz__Ranking__Wartoœæ__Odczytaj__Ra( i )  )   ) +
            zts +
            #13 + #10 +
            '          ' +
            '(l.p. ' + Trim(  FormatFloat( '### ### ##0', i + 1 )  ) + ')' +
            ' [id: ' + Trim(   FormatFloat(  '### ### ##0', ranking_g.Gracz__Id__Odczytaj__Ra( i )  )   ) + '] ';

          Ranking_Label.Hint := ranking_g.Gracz__Parametry_Wyœwietl__Ra(  ranking_g.Gracz__Id__Odczytaj__Ra( i )  );


          gracz__i__wartoœæ__poprzednia_g := i;


          Ranking_StringGrid.Row := i + 1;


          Self.Rozbudowa__Dane__Wyœwietl(  ranking_g.Gracz__Id__Odczytaj__Ra( i )  );


          if tylko_gracz_f then
            Break;

        end;
      //---//if ranking_g.Gracz__Gra_Gracz__Ra( i ) then

    end;
  //---//for i := 0 to ranking_g.Gracze__Iloœæ__Odczytaj__Ra() - 1 do


  ranking__statystyki_gracza_blokuj_g := false;


  Self.Statystyki_Gracza__Wyœwietl( Ranking_StringGrid.Row );

end;//---//Funkcja Ranking__Wyœwietl().

procedure TBezkresne_Potyczki_Form.Rozbudowa__Dane__Wyœwietl( const gracz_id_f : integer );
var
  ztb : boolean;

  i,
  atak__koszt_l,
  obrona__koszt_l,
  obserwacja__koszt_l,
  rozbudowa__punkty_l,
  surowiec__produkcja__koszt_l,
  zamek__produkcja__koszt_l
    : integer;

  atak__wspó³czynnik_l,
  obrona__wspó³czynnik_l,
  obserwacja__wspó³czynnik_l,
  surowiec__produkcja__wspó³czynnik_l,
  zamek__produkcja__wspó³czynnik_l
    : real;
begin

  Rozbudowa_TabSheet.Caption := rozbudowa__etykieta_kopia_g;
  Rozbudowa__Punkty_Label.Caption := '<?>';

  if ranking_g.Gracz__Rozbudowa__Dane__Odczytaj__Ra( gracz_id_f, atak__koszt_l, obrona__koszt_l, obserwacja__koszt_l, rozbudowa__punkty_l, surowiec__produkcja__koszt_l, zamek__produkcja__koszt_l, atak__wspó³czynnik_l, obrona__wspó³czynnik_l, obserwacja__wspó³czynnik_l, surowiec__produkcja__wspó³czynnik_l, zamek__produkcja__wspó³czynnik_l ) then
    begin

      ztb := false;

      Rozbudowa__Punkty_Label.Caption := Trim(  FormatFloat( '### ### ##0.00', rozbudowa__punkty_l )  );


      for i := 0 to Rozbudowa_Panel.ControlCount - 1 do
        if Rozbudowa_Panel.Controls[ i ].ClassType = Gracz__Rozbudowa_Przycisk.TGracz__Rozbudowa_Przycisk then
          begin

            if Gracz__Rozbudowa_Przycisk.TGracz__Rozbudowa_Przycisk(Rozbudowa_Panel.Controls[ i ]).Wspó³czynnik_Rodzaj__Odczytaj__Grp() = Definicje.gwr_atak then
              Gracz__Rozbudowa_Przycisk.TGracz__Rozbudowa_Przycisk(Rozbudowa_Panel.Controls[ i ]).Wartoœci__Ustaw__Grp( atak__koszt_l, atak__wspó³czynnik_l, rozbudowa__punkty_l )
            else
            if Gracz__Rozbudowa_Przycisk.TGracz__Rozbudowa_Przycisk(Rozbudowa_Panel.Controls[ i ]).Wspó³czynnik_Rodzaj__Odczytaj__Grp() = Definicje.gwr_obrona then
              Gracz__Rozbudowa_Przycisk.TGracz__Rozbudowa_Przycisk(Rozbudowa_Panel.Controls[ i ]).Wartoœci__Ustaw__Grp( obrona__koszt_l, obrona__wspó³czynnik_l, rozbudowa__punkty_l )
            else
            if Gracz__Rozbudowa_Przycisk.TGracz__Rozbudowa_Przycisk(Rozbudowa_Panel.Controls[ i ]).Wspó³czynnik_Rodzaj__Odczytaj__Grp() = Definicje.gwr_obserwacja then
              Gracz__Rozbudowa_Przycisk.TGracz__Rozbudowa_Przycisk(Rozbudowa_Panel.Controls[ i ]).Wartoœci__Ustaw__Grp( obserwacja__koszt_l, obserwacja__wspó³czynnik_l, rozbudowa__punkty_l )
            else
            if Gracz__Rozbudowa_Przycisk.TGracz__Rozbudowa_Przycisk(Rozbudowa_Panel.Controls[ i ]).Wspó³czynnik_Rodzaj__Odczytaj__Grp() = Definicje.gwr_surowiec__produkcja then
              Gracz__Rozbudowa_Przycisk.TGracz__Rozbudowa_Przycisk(Rozbudowa_Panel.Controls[ i ]).Wartoœci__Ustaw__Grp( surowiec__produkcja__koszt_l, surowiec__produkcja__wspó³czynnik_l, rozbudowa__punkty_l )
            else
            if Gracz__Rozbudowa_Przycisk.TGracz__Rozbudowa_Przycisk(Rozbudowa_Panel.Controls[ i ]).Wspó³czynnik_Rodzaj__Odczytaj__Grp() = Definicje.gwr_zamek__produkcja then
              Gracz__Rozbudowa_Przycisk.TGracz__Rozbudowa_Przycisk(Rozbudowa_Panel.Controls[ i ]).Wartoœci__Ustaw__Grp( zamek__produkcja__koszt_l, zamek__produkcja__wspó³czynnik_l, rozbudowa__punkty_l );


            if Gracz__Rozbudowa_Przycisk.TGracz__Rozbudowa_Przycisk(Rozbudowa_Panel.Controls[ i ]).Aktywnoœæ__Odczytaj__Grp() then
              ztb := true;

          end;
        //---//if Rozbudowa_Panel.Controls[ i ].ClassType = Gracz__Rozbudowa_Przycisk.TGracz__Rozbudowa_Przycisk then


      if ztb then
        Rozbudowa_TabSheet.Caption := Rozbudowa_TabSheet.Caption + '***';

    end
  else//if ranking_g.Gracz__Rozbudowa__Dane__Odczytaj__Ra( gracz_id_f, atak__koszt_l, obrona__koszt_l, obserwacja__koszt_l, rozbudowa__punkty_l, surowiec__produkcja__koszt_l, zamek__produkcja__koszt_l, atak__wspó³czynnik_l, obrona__wspó³czynnik_l, obserwacja__wspó³czynnik_l, surowiec__produkcja__wspó³czynnik_l, zamek__produkcja__wspó³czynnik_l ) then
    Application.MessageBox(  PChar('Nie odnaleziono gracza (id:' + IntToStr( gracz_id_f ) + ').' + #13 + #13 + '<Spieler nicht gefunden (id:' + IntToStr( gracz_id_f ) + ')>.' + #13 + #13 + '<Player not found (id:' + IntToStr( gracz_id_f ) + ')>.'), 'Informacja', MB_ICONEXCLAMATION  );

end;//---//Funkcja Rozbudowa__Dane__Wyœwietl().

procedure TBezkresne_Potyczki_Form.Statystyki_Gracza__Wyœwietl( const wiersz_numer_f : integer );
var
  zti : integer;

  zts : string;
begin

  if   ( ranking__statystyki_gracza_blokuj_g )
    or ( wiersz_numer_f = Definicje.identyfikator_pusty_c )
    or ( not Ranking__Statystyki_Gracza_Panel.Visible ) then
    begin

      if Ranking__Statystyki_Gracza_Label.Caption <> '<?>' then
        Ranking__Statystyki_Gracza_Label.Caption := '<?>';

      Exit;

    end;
  //---//if   ( ranking__statystyki_gracza_blokuj_g ) (...)


  zts := Trim( Ranking_StringGrid.Cells[ Bezkresne_Potyczki.ranking__wyœwietl__kolumna_indeks__id_c, wiersz_numer_f ] );
  zts := StringReplace( zts, ' ', '', [ rfReplaceAll ] );

  zti := StrToIntDef( zts, Definicje.identyfikator_pusty_c );

  if zti >= 0 then
    Ranking__Statystyki_Gracza_Label.Caption := ranking_g.Gracz__Parametry_Wyœwietl__Ra( zti )
  else//if zti >= 0 then
    Ranking__Statystyki_Gracza_Label.Caption := '<?>';

end;//---//Funkcja Statystyki_Gracza__Wyœwietl().

//---//      ***      Funkcje      ***      //---//

procedure TBezkresne_Potyczki_Form.FormShow( Sender: TObject );
var
  i : integer;
begin

  gracz__i__wartoœæ__poprzednia_g := Definicje.identyfikator_pusty_c;
  kolor__gracz__ranking_g := clSkyBlue;
  potyczka__start__data_czas_g := 0;
  potyczki_w_trakcie_g := false;
  ranking__statystyki_gracza_blokuj_g := true;

  okno__etykieta_kopia_g := Self.Caption;
  rozbudowa__etykieta_kopia_g := Rozbudowa_TabSheet.Caption;

  Bitwa_Dominia__Przeliczeñ_W_Turze_SpinEdit.Value := Definicje.bitwa_dominia__przeliczeñ_w_turze_c;
  Dominium__Wytrzyma³oœæ_Punkty_SpinEdit.Value := Definicje.dominium__wytrzyma³oœæ_punkty_c;

  Ranking_StringGrid.ColCount := 5;
  Ranking_StringGrid.ColWidths[ Bezkresne_Potyczki.ranking__wyœwietl__kolumna_indeks__nazwa_gracza_c ] := 350;
  Ranking_StringGrid.ColWidths[ Bezkresne_Potyczki.ranking__wyœwietl__kolumna_indeks__strategia_typ_c ] := 150;

  Ranking_StringGrid.Cells[ Bezkresne_Potyczki.ranking__wyœwietl__kolumna_indeks__l_p_c, 0 ] := 'L.p.';
  Ranking_StringGrid.Cells[ Bezkresne_Potyczki.ranking__wyœwietl__kolumna_indeks__ranking_c, 0 ] := 'Ranking';
  Ranking_StringGrid.Cells[ Bezkresne_Potyczki.ranking__wyœwietl__kolumna_indeks__nazwa_gracza_c, 0 ] := 'Nazwa gracza';
  Ranking_StringGrid.Cells[ Bezkresne_Potyczki.ranking__wyœwietl__kolumna_indeks__strategia_typ_c, 0 ] := 'Strategia typ';
  Ranking_StringGrid.Cells[ Bezkresne_Potyczki.ranking__wyœwietl__kolumna_indeks__id_c, 0 ] := 'Id';


  PageControl1.Align := alClient;
  Ranking__Statystyki_Gracza_Label.Align := alClient;


  ranking_g := Ranking.TRanking.Create();
  ranking_g.Postêp__Odœwie¿__Ra := Self.Postêp__Odœwie¿;
  ranking_g.Przeliczanie_W_Tle__Zakoñczone__Ra := Self.Potyczka__Przeliczanie__Zakoñczone;


  Self.Ranking__Statystyki_Gracza_CheckBoxClick( Sender );


  Rozbudowa_Panel.Height := 1;

  //for i := Ord(  High( Definicje.TGracz_Wspó³czynnik_Rodzaj )  ) downto Ord(  Low( Definicje.TGracz_Wspó³czynnik_Rodzaj )  ) do
  for i := Ord(  Low( Definicje.TGracz_Wspó³czynnik_Rodzaj )  ) to Ord(  High( Definicje.TGracz_Wspó³czynnik_Rodzaj )  ) do
    Gracz__Rozbudowa_Przycisk.TGracz__Rozbudowa_Przycisk.Create( Self, Rozbudowa_Panel, Definicje.TGracz_Wspó³czynnik_Rodzaj(i), Self.Gracz__Rozbuduj );


  ranking_g.Ranking__Wczytaj();

  if ranking_g.Gracze__Iloœæ__Odczytaj__Ra() < 2 then
    PageControl1.ActivePage := Opcje_TabSheet
  else//if ranking_g.Gracze__Iloœæ__Odczytaj__Ra() < 2 then
    PageControl1.ActivePage := Ranking_TabSheet;


  Self.Ranking__Wyœwietl();


  if PageControl1.ActivePage = Opcje_TabSheet then
    Gracz_Nazwa_Edit.SetFocus()
  else//if PageControl1.ActivePage = Opcje_TabSheet then
  if PageControl1.ActivePage = Ranking_TabSheet then
    //Potyczka_Button.SetFocus();
    Ranking_StringGrid.SetFocus();


  {$IFDEF DEBUG}
  //Dominium__Wytrzyma³oœæ_Punkty_SpinEdit.Value := 50;
  //Bitwa_Dominia__Przeliczeñ_W_Turze_SpinEdit.Value := 1000;
  //Self.Potyczka_ButtonClick( Sender );
  {$ENDIF}

end;//---//FormShow().

procedure TBezkresne_Potyczki_Form.FormClose( Sender: TObject; var Action: TCloseAction );
begin

  if potyczki_w_trakcie_g then
    begin

      Action := caNone;

      Application.MessageBox( 'Nale¿y zaczekaæ na zakoñczenie obliczeñ.' + #13 + #13 + '<Bitte warten Sie, bis die Berechnungen abgeschlossen sind.>' + #13 + #13 + '<Please wait for the calculations to complete.>', 'Informacja', MB_OK + MB_ICONINFORMATION );

      Exit;

    end;
  //---//if potyczki_w_trakcie_g then


  {$IFNDEF DEBUG}
  if Application.MessageBox( 'Czy wyjœæ z gry?' + #13 + #13 + '<Das Spiel benden?>' + #13 + #13 + '<Quit the game?>', 'Potwierdzenie', MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    begin

      Action := caNone;
      Exit;

    end;
  //---//if Application.MessageBox( 'Czy wyjœæ z gry?' + #13 + #13 + '<Das Spiel benden?>' + #13 + #13 + '<Quit the game?>', 'Potwierdzenie', MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
  {$ENDIF}


  FreeAndNil( ranking_g );

end;//---//FormClose().

procedure TBezkresne_Potyczki_Form.FormResize( Sender: TObject );
var
  i : integer;
begin

  for i := 0 to Rozbudowa_Panel.ControlCount - 1 do
    if Rozbudowa_Panel.Controls[ i ].ClassType = Gracz__Rozbudowa_Przycisk.TGracz__Rozbudowa_Przycisk then
      Gracz__Rozbudowa_Przycisk.TGracz__Rozbudowa_Przycisk(Rozbudowa_Panel.Controls[ i ]).Rozmiar_Dostosuj__Grp();

end;//---//FormResize().

procedure TBezkresne_Potyczki_Form.Gra_Nowa_ButtonClick( Sender: TObject );
begin

  if Application.MessageBox( 'Czy rozpocz¹æ now¹ grê (postêp zostanie utracony)?' + #13 + #13 + '<Neues Spiel starten (Fortschritt geht verloren)?>' + #13 + #13 + '<Start a new game (progress will be lost)?>', 'Potwierdzenie', MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  if Trim( Gracz_Nazwa_Edit.Text ) = '' then
    Gracz_Nazwa_Edit.Text := 'Gracz 1';


  if Gra_Nowa__Gracze_Iloœæ_SpinEdit.Value <= 0 then
    Gra_Nowa__Gracze_Iloœæ_SpinEdit.Value := 2
  else
  if Odd( Gra_Nowa__Gracze_Iloœæ_SpinEdit.Value ) then
    Gra_Nowa__Gracze_Iloœæ_SpinEdit.Value := Gra_Nowa__Gracze_Iloœæ_SpinEdit.Value
      + 1;

  ranking_g.Gracze__Wylosuj( Gra_Nowa__Gracze_Iloœæ_SpinEdit.Value, Gracz_Nazwa_Edit.Text );


  gracz__i__wartoœæ__poprzednia_g := Definicje.identyfikator_pusty_c;

  Self.Ranking__Wyœwietl();


  PageControl1.ActivePage := Ranking_TabSheet;

end;//---//Gra_Nowa_ButtonClick().

procedure TBezkresne_Potyczki_Form.Gracz_Szukaj_EditChange( Sender: TObject );
begin

  Self.Gracz__Szukaj( Self.Gracz__Szukaj__Kolumna__Odczytaj(), Gracz_Szukaj_Edit.Text );

end;//---//Gracz_Szukaj_EditChange()

procedure TBezkresne_Potyczki_Form.Gracz_Szukaj_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_NEXT then // Page Down
    Self.Gracz__Szukaj( Self.Gracz__Szukaj__Kolumna__Odczytaj(), Gracz_Szukaj_Edit.Text, true, false )
  else
  if Key = VK_PRIOR then // Page Up
    Self.Gracz__Szukaj( Self.Gracz__Szukaj__Kolumna__Odczytaj(), Gracz_Szukaj_Edit.Text, false, true );

end;//---//Gracz_Szukaj_EditKeyDown().

procedure TBezkresne_Potyczki_Form.Pomoc_BitBtnClick( Sender: TObject );
begin

  ShowMessage( Definicje.pomoc_c );

end;//---//Pomoc_BitBtnClick().

procedure TBezkresne_Potyczki_Form.Potyczka_ButtonClick( Sender: TObject );
begin

  if ranking_g.Gracze__Iloœæ__Odczytaj__Ra() < 2 then
    begin

      PageControl1.ActivePage := Opcje_TabSheet;

      Application.MessageBox( 'Najpierw nale¿y rozpocz¹æ now¹ grê.' + #13 + #13 + '<Zuerst müssen Sie ein neues Spiel starten.>' + #13 + #13 + '<First you must start a new game.>', 'Informacja', MB_OK + MB_ICONINFORMATION );

      Exit;

    end;
  //---//if ranking_g.Gracze__Iloœæ__Odczytaj__Ra() < 2 then


  if potyczki_w_trakcie_g then
    begin

      Application.MessageBox( 'Nale¿y zaczekaæ na zakoñczenie obliczeñ.' + #13 + #13 + '<Bitte warten Sie, bis die Berechnungen abgeschlossen sind.>' + #13 + #13 + '<You must wait for the calculations to complete.>', 'Informacja', MB_OK + MB_ICONINFORMATION );

      Exit;

    end;
  //---//if potyczki_w_trakcie_g then


  potyczki_w_trakcie_g := true;

  Gracz_Nazwa_Panel.Enabled := not potyczki_w_trakcie_g;
  Potyczka_Button.Enabled := not potyczki_w_trakcie_g;
  Rozbudowa_Panel.Enabled := not potyczki_w_trakcie_g;


  Screen.Cursor := crHourGlass;


  if Bitwa_Dominia__Przeliczeñ_W_Turze_SpinEdit.Value <= 0 then
    Bitwa_Dominia__Przeliczeñ_W_Turze_SpinEdit.Value := Definicje.bitwa_dominia__przeliczeñ_w_turze_c;

  if Dominium__Wytrzyma³oœæ_Punkty_SpinEdit.Value <= 0 then
    Dominium__Wytrzyma³oœæ_Punkty_SpinEdit.Value := Definicje.dominium__wytrzyma³oœæ_punkty_c;

  if Potyczka__Przeliczaj_W_Tle__W¹tki__Iloœæ_SpinEdit.Value <= 0 then
    Potyczka__Przeliczaj_W_Tle__W¹tki__Iloœæ_SpinEdit.Value := 1;

  Potyczka_ProgressBar.Position := 0;

  if Potyczka__Przeliczaj_W_Tle_CheckBox.Checked then
    Potyczka_ProgressBar.Max := Potyczka__Przeliczaj_W_Tle__W¹tki__Iloœæ_SpinEdit.Value
  else//if Potyczka__Przeliczaj_W_Tle_CheckBox.Checked then
    Potyczka_ProgressBar.Max := ranking_g.Gracze__Iloœæ__Odczytaj__Ra();

  Ranking__Gracz_Panel.Height := Ranking__Gracz_Panel.Height + Potyczka_ProgressBar.Height;
  Potyczka_ProgressBar.Visible := true;
  Ranking__Gracz_Panel.Repaint();


  potyczka__start__data_czas_g := Now();


  ranking_g.Potyczki__Runda__Przelicz__Ra( Bitwa_Dominia__Przeliczeñ_W_Turze_SpinEdit.Value, Dominium__Wytrzyma³oœæ_Punkty_SpinEdit.Value, Potyczka__Przeliczaj_W_Tle__W¹tki__Iloœæ_SpinEdit.Value, Potyczka__Przeliczaj_W_Tle_CheckBox.Checked );


  if Potyczka__Przeliczaj_W_Tle_CheckBox.Checked then
    Exit;


  Self.Potyczka__Przeliczanie__Zakoñczone();

end;//---//Potyczka_ButtonClick().

procedure TBezkresne_Potyczki_Form.Ranking__Statystyki_Gracza_CheckBoxClick( Sender: TObject );
begin

  Ranking__Statystyki_Gracza_Panel.Visible := Ranking__Statystyki_Gracza_CheckBox.Checked;
  Ranking__Statystyki_Gracza_Splitter.Visible := Ranking__Statystyki_Gracza_Panel.Visible;

  if Ranking__Statystyki_Gracza_Splitter.Visible then
    begin

      Ranking__Statystyki_Gracza_Splitter.Align := alTop;
      Ranking__Statystyki_Gracza_Splitter.Align := alBottom;


      Self.Statystyki_Gracza__Wyœwietl( Ranking_StringGrid.Row );

    end
  else//if Ranking__Statystyki_Gracza_Splitter.Visible then
    Self.Statystyki_Gracza__Wyœwietl( Definicje.identyfikator_pusty_c );

end;//---//Ranking__Statystyki_Gracza_CheckBoxClick().

procedure TBezkresne_Potyczki_Form.Ranking__Wczytaj_ButtonClick( Sender: TObject );
begin

  if Application.MessageBox( 'Wczytaæ ranking?' + #13 + #13 + '<Ranking laden?>' + #13 + #13 + '<Load ranking?>', 'Potwierdzenie', MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ranking_g.Ranking__Wczytaj();

  gracz__i__wartoœæ__poprzednia_g := Definicje.identyfikator_pusty_c;

  Self.Ranking__Wyœwietl();

  PageControl1.ActivePage := Ranking_TabSheet;

end;//---//Ranking__Wczytaj_ButtonClick().

procedure TBezkresne_Potyczki_Form.PageControl1Change( Sender: TObject );
begin

  if PageControl1.ActivePage = Rozbudowa_TabSheet then
    Self.FormResize( Sender );

end;//---//PageControl1Change().

procedure TBezkresne_Potyczki_Form.Ranking_StringGridDrawCell( Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState );
begin

  // Kolor wskazanego wiersza.
  if    ( ARow = gracz__i__wartoœæ__poprzednia_g + 1 )
    and ( ACol = Bezkresne_Potyczki.ranking__wyœwietl__kolumna_indeks__ranking_c ) then
    begin

      TStringGrid(Sender).Canvas.Brush.Color := kolor__gracz__ranking_g;
      TStringGrid(Sender).Canvas.FillRect( Rect );
      TStringGrid(Sender).Canvas.TextOut(   Rect.Left + 7, Rect.Top + Round( Rect.Height * 0.5 ) - Round(  TStringGrid(Sender).Canvas.TextHeight( 'I' ) * 0.5  ), TStringGrid(Sender).Cells[ ACol, ARow ]   );

    end
  else//if    ( ARow = gracz__i__wartoœæ__poprzednia_g + 1 ) (...)
  if    ( ARow > 0 )
    and (  not ranking_g.Gracz__Gra_Gracz__Ra( ARow - 1 )  )
    and ( ACol = Bezkresne_Potyczki.ranking__wyœwietl__kolumna_indeks__strategia_typ_c )
    and (  ranking_g.Gracz__Strategia_Typ__Odczytaj__Ra( ARow - 1 ) <> Definicje.st_wywa¿ona  ) then
    begin

      if ranking_g.Gracz__Strategia_Typ__Odczytaj__Ra( ARow - 1 ) in [ Definicje.st_agresywna_bardzo, Definicje.st_agresywna ] then
        TStringGrid(Sender).Canvas.Brush.Color := $00F0F0FF // Czerwony jasny.
      else//if ranking_g.Gracz__Strategia_Typ__Odczytaj__Ra( ARow - 1 ) in [ Definicje.st_agresywna_bardzo, Definicje.st_agresywna ] then
        TStringGrid(Sender).Canvas.Brush.Color := $00FFF3F3; // Fioletowy jasny.

      TStringGrid(Sender).Canvas.FillRect( Rect );
      TStringGrid(Sender).Canvas.TextOut(   Rect.Left + 7, Rect.Top + Round( Rect.Height * 0.5 ) - Round(  TStringGrid(Sender).Canvas.TextHeight( 'I' ) * 0.5  ), TStringGrid(Sender).Cells[ ACol, ARow ]   );

    end;
  //---//if    ( ARow > 0 ) (...)

end;//---//Ranking_StringGridDrawCell().

procedure TBezkresne_Potyczki_Form.Ranking_StringGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
var
  zti : integer;
begin

  if Key = VK_ESCAPE then
    Self.Close()
  else
  if Key = VK_OEM_2 then // ?
    Self.Pomoc_BitBtnClick( Sender )
  else
  if Key = VK_OEM_PERIOD then // .
    Ranking__Statystyki_Gracza_CheckBox.Checked := not Ranking__Statystyki_Gracza_CheckBox.Checked
  else
  if Key = VK_RETURN then
    begin

      if not potyczki_w_trakcie_g then
        Self.Potyczka_ButtonClick( Sender );

    end
  else//if Key = VK_RETURN then
  if Key = VK_SPACE then
    begin

      zti := StrToIntDef( Ranking_StringGrid.Cells[ Bezkresne_Potyczki.ranking__wyœwietl__kolumna_indeks__id_c, Ranking_StringGrid.Row ], Definicje.identyfikator_pusty_c );

      if zti >= 0 then
        begin

          Application.MessageBox( PChar(ranking_g.Gracz__Parametry_Wyœwietl__Ra( zti )), 'Informacja', MB_OK + MB_ICONINFORMATION );

        end;
      //---//if zti >= 0 then

    end;
  //---//if Key = VK_SPACE then

end;//---//Ranking_StringGridKeyDown().

procedure TBezkresne_Potyczki_Form.Ranking_StringGridSelectCell( Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean );
begin

  Self.Statystyki_Gracza__Wyœwietl( ARow );

end;//---//Ranking_StringGridSelectCell().

end.
