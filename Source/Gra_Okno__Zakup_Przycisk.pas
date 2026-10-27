unit Gra_Okno__Zakup_Przycisk;{09.Wrz.2026}

interface

uses
  System.Classes,
  System.SysUtils,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.StdCtrls,

  Definicje;

type
  TBudowa__Tryb__Zmieñ = procedure( const budowla_rodzaj_f : Definicje.TBudowla_Rodzaj ) of object;
  TJednostki__Zakup__Obs³uga = procedure( const jednostki_po³¹cz_f, teren_kup_f : boolean; const jednostka_typ_f : Definicje.TJednostka_Typ; const jednostka_typ__po³¹cz_f : Definicje.TJednostka_Typ = Definicje.jt_pusta ) of object;

  TZakup_Przycisk = class( Vcl.StdCtrls.TGroupBox )
  private
    { Private declarations }
    aktywne__zp,
    budowla__kup__zp,
    jednostki_po³¹cz__zp,
    teren_kup__zp
      : boolean;

    budowla_rodzaj__zp : Definicje.TBudowla_Rodzaj;

    jednostka_typ__zp,
    jednostka_typ__po³¹cz__zp
      : Definicje.TJednostka_Typ;

    surowiec__1_iloœæ_napis,
    surowiec__2_iloœæ_napis
      : Vcl.StdCtrls.TLabel;

    surowce_panel,
    surowiec__1_panel,
    surowiec__2_panel,
    surowiec__1__kolor_panel,
    surowiec__2__kolor_panel
      : Vcl.ExtCtrls.TPanel;

    obrazek : Vcl.ExtCtrls.TImage;

    Budowa__Tryb__Zmieñ__Zp : Gra_Okno__Zakup_Przycisk.TBudowa__Tryb__Zmieñ;

    Jednostki__Zakup__Obs³uga__Zp : Gra_Okno__Zakup_Przycisk.TJednostki__Zakup__Obs³uga;

    constructor Create( AOwner : System.Classes.TComponent; AParent : Vcl.Controls.TWinControl; const budowla_rodzaj_f : Definicje.TBudowla_Rodzaj; const jednostka_typ_f : Definicje.TJednostka_Typ; const jednostki_po³¹cz_f, teren_kup_f : boolean; budowa__tryb__zmieñ_f : Gra_Okno__Zakup_Przycisk.TBudowa__Tryb__Zmieñ; jednostki__zakup__obs³uga_f : Gra_Okno__Zakup_Przycisk.TJednostki__Zakup__Obs³uga ); overload;
  public
    { Public declarations }
    constructor Create( AOwner : System.Classes.TComponent; AParent : Vcl.Controls.TWinControl; const budowla_rodzaj_f : Definicje.TBudowla_Rodzaj; budowa__tryb__zmieñ_f : Gra_Okno__Zakup_Przycisk.TBudowa__Tryb__Zmieñ ); overload;
    constructor Create( AOwner : System.Classes.TComponent; AParent : Vcl.Controls.TWinControl; const jednostka_typ_f : Definicje.TJednostka_Typ; const jednostki_po³¹cz_f, teren_kup_f : boolean; jednostki__zakup__obs³uga_f : Gra_Okno__Zakup_Przycisk.TJednostki__Zakup__Obs³uga ); overload;
    destructor Destroy(); override;

    procedure Aktywnoœæ__Ustaw__Zp( const aktywne_f : boolean ); overload;
    procedure Aktywnoœæ__Ustaw__Zp( const aktywne_f, aktywne_kolor_f : boolean ); overload;
    function Budowla__Kup__Odczytaj__Zp() : boolean;
    function Budowla__Rodzaj__Odczytaj__Zp() : Definicje.TBudowla_Rodzaj;
    function Jednostka_Typ__Odczytaj__Zp() : Definicje.TJednostka_Typ;
    function Jednostka_Typ__Po³¹cz__Odczytaj__Zp() : Definicje.TJednostka_Typ;
    function Jednostki_Po³¹cz__Odczytaj__Zp() : boolean;
    procedure On_Click__Zp( Sender : TObject );
    function Teren_Kup__Odczytaj__Zp() : boolean;
    procedure Wartoœci__Ustaw__Zp( const jednostka_typ_f : Definicje.TJednostka_Typ; const surowiec__1__iloœæ_f : integer ); overload;
    procedure Wartoœci__Ustaw__Zp( const surowiec__1__iloœæ_f, surowiec__2__iloœæ_f : integer ); overload;
  end;//---//TZakup_Przycisk = class

const
  obrazki__katalog__nazwa_c : string = 'Obrazki';
  obrazki__plik__nazwa__domek_c : string = 'domek';
  obrazki__plik__nazwa__jazda_c : string = 'jazda';
  obrazki__plik__nazwa__koszary_c : string = 'koszary';
  obrazki__plik__nazwa__piechota_c : string = 'piechota';
  obrazki__plik__nazwa__po³¹cz__jazda_c : string = 'po³¹cz__jazda';
  obrazki__plik__nazwa__po³¹cz__piechota_c : string = 'po³¹cz__piechota';
  obrazki__plik__nazwa__teren_c : string = 'teren';
  obrazki__plik__nazwa__wie¿a__obronna_c : string = 'wie¿a__obronna';
  obrazki__plik__nazwa__wie¿a__zwiadowcza_c : string = 'wie¿a__zwiadowcza';

implementation

constructor TZakup_Przycisk.Create( AOwner : System.Classes.TComponent; AParent : Vcl.Controls.TWinControl; const budowla_rodzaj_f : Definicje.TBudowla_Rodzaj; budowa__tryb__zmieñ_f : Gra_Okno__Zakup_Przycisk.TBudowa__Tryb__Zmieñ );
var
  jednostka_typ_l : Definicje.TJednostka_Typ; // Tylko aby wywo³aæ funkcjê.
begin

  jednostka_typ_l := Definicje.jt_pusta;


  Self.Create( AOwner, AParent, budowla_rodzaj_f, jednostka_typ_l, false, false, budowa__tryb__zmieñ_f, nil );

end;//---//Konstruktor klasy TZakup_Przycisk.

constructor TZakup_Przycisk.Create( AOwner : System.Classes.TComponent; AParent : Vcl.Controls.TWinControl; const jednostka_typ_f : Definicje.TJednostka_Typ; const jednostki_po³¹cz_f, teren_kup_f : boolean; jednostki__zakup__obs³uga_f : Gra_Okno__Zakup_Przycisk.TJednostki__Zakup__Obs³uga );
var
  budowla_rodzaj_l : Definicje.TBudowla_Rodzaj; // Tylko aby wywo³aæ funkcjê.
begin

  budowla_rodzaj_l := Definicje.br_domek;


  Self.Create( AOwner, AParent, budowla_rodzaj_l, jednostka_typ_f, jednostki_po³¹cz_f, teren_kup_f, nil, jednostki__zakup__obs³uga_f );

end;//---//Konstruktor klasy TZakup_Przycisk.

constructor TZakup_Przycisk.Create( AOwner : System.Classes.TComponent; AParent : Vcl.Controls.TWinControl; const budowla_rodzaj_f : Definicje.TBudowla_Rodzaj; const jednostka_typ_f : Definicje.TJednostka_Typ; const jednostki_po³¹cz_f, teren_kup_f : boolean; budowa__tryb__zmieñ_f : Gra_Okno__Zakup_Przycisk.TBudowa__Tryb__Zmieñ; jednostki__zakup__obs³uga_f : Gra_Okno__Zakup_Przycisk.TJednostki__Zakup__Obs³uga );
var
  zts : string;
begin

  inherited Create( AOwner );

  Self.aktywne__zp := false;
  Self.Budowa__Tryb__Zmieñ__Zp := budowa__tryb__zmieñ_f;
  Self.budowla_rodzaj__zp := budowla_rodzaj_f;
  Self.jednostka_typ__zp := jednostka_typ_f;
  Self.jednostka_typ__po³¹cz__zp := Definicje.jt_pusta;
  Self.jednostki_po³¹cz__zp := jednostki_po³¹cz_f;
  Self.Jednostki__Zakup__Obs³uga__Zp := jednostki__zakup__obs³uga_f;
  Self.teren_kup__zp := teren_kup_f;

  Self.budowla__kup__zp :=
        ( Self.jednostka_typ__zp = Definicje.jt_pusta )
    and ( not Self.jednostki_po³¹cz__zp )
    and ( not Self.teren_kup__zp );

  Self.Parent := AParent;
  Self.Align := Vcl.Controls.alTop;
  Self.Height := 90;
  Self.Parent.Height := Self.Parent.Height + Self.Height;
  Self.ShowHint := true;
  Self.OnClick := Self.On_Click__Zp;

  Self.surowce_panel := TPanel.Create( Self );
  Self.surowce_panel.Parent := Self;
  Self.surowce_panel.Align := Vcl.Controls.alBottom;
  Self.surowce_panel.Height := 30;
  Self.surowce_panel.OnClick := Self.On_Click__Zp;

  Self.obrazek := Vcl.ExtCtrls.TImage.Create( Self );
  Self.obrazek.Parent := Self;
  Self.obrazek.Align := Vcl.Controls.alClient;
  Self.obrazek.Stretch := true;
  Self.obrazek.OnClick := Self.On_Click__Zp;


  if   ( Self.budowla_rodzaj__zp in [ Definicje.br_koszary ]  )
    or ( Self.jednostka_typ__zp in [ Definicje.jt_jazda ]  )
    or ( Self.jednostki_po³¹cz__zp )
    or ( Self.teren_kup__zp ) then
    begin

      Self.surowiec__2_panel := TPanel.Create( Self );
      Self.surowiec__2_panel.Parent := Self.surowce_panel;
      Self.surowiec__2_panel.Align := Vcl.Controls.alLeft;
      Self.surowiec__2_panel.ParentBackground := false;
      Self.surowiec__2_panel.Width := Round( Self.surowiec__2_panel.Parent.Width * 0.5 );
      Self.surowiec__2_panel.OnClick := Self.On_Click__Zp;

      if not Self.jednostki_po³¹cz__zp then
        begin

          Self.surowiec__2__kolor_panel := TPanel.Create( Self );
          Self.surowiec__2__kolor_panel.Parent := Self.surowiec__2_panel;
          Self.surowiec__2__kolor_panel.Align := Vcl.Controls.alLeft;
          Self.surowiec__2__kolor_panel.Width := 30;
          Self.surowiec__2__kolor_panel.ParentBackground := false;
          Self.surowiec__2__kolor_panel.ShowHint := true;
          Self.surowiec__2__kolor_panel.OnClick := Self.On_Click__Zp;

        end;
      //---//if not Self.jednostki_po³¹cz__zp then

      Self.surowiec__2_iloœæ_napis := TLabel.Create( Self );
      Self.surowiec__2_iloœæ_napis.Parent := Self.surowiec__2_panel;
      Self.surowiec__2_iloœæ_napis.Align := Vcl.Controls.alClient;
      Self.surowiec__2_iloœæ_napis.Alignment := taCenter;
      Self.surowiec__2_iloœæ_napis.Caption := '<?>';
      Self.surowiec__2_iloœæ_napis.Font.Size := 12;
      Self.surowiec__2_iloœæ_napis.Font.Style := [ Vcl.Graphics.TFontStyle.fsBold ];
      Self.surowiec__2_iloœæ_napis.Layout := tlCenter;
      Self.surowiec__2_iloœæ_napis.ShowHint := true;
      Self.surowiec__2_iloœæ_napis.OnClick := Self.On_Click__Zp;

    end
  else//if   ( Self.budowla_rodzaj__zp in [ Definicje.br_koszary ]  ) (...)
    begin

      Self.surowiec__2_panel := nil;
      Self.surowiec__2__kolor_panel := nil;
      Self.surowiec__2_iloœæ_napis := nil;

    end;
  //---//if   ( Self.budowla_rodzaj__zp in [ Definicje.br_koszary ]  ) (...)


  Self.surowiec__1_panel := TPanel.Create( Self );
  Self.surowiec__1_panel.Parent := Self.surowce_panel;
  Self.surowiec__1_panel.Align := Vcl.Controls.alLeft;
  Self.surowiec__1_panel.ParentBackground := false;
  Self.surowiec__1_panel.Width := Round( Self.surowiec__1_panel.Parent.Width * 0.5 );
  Self.surowiec__1_panel.OnClick := Self.On_Click__Zp;

  Self.surowiec__1__kolor_panel := TPanel.Create( Self );
  Self.surowiec__1__kolor_panel.Parent := Self.surowiec__1_panel;
  Self.surowiec__1__kolor_panel.Align := Vcl.Controls.alLeft;
  Self.surowiec__1__kolor_panel.Width := 30;
  Self.surowiec__1__kolor_panel.ParentBackground := false;
  Self.surowiec__1__kolor_panel.ShowHint := true;
  Self.surowiec__1__kolor_panel.OnClick := Self.On_Click__Zp;

  Self.surowiec__1_iloœæ_napis := TLabel.Create( Self );
  Self.surowiec__1_iloœæ_napis.Parent := Self.surowiec__1_panel;
  Self.surowiec__1_iloœæ_napis.Align := Vcl.Controls.alClient;
  Self.surowiec__1_iloœæ_napis.Alignment := taCenter;
  Self.surowiec__1_iloœæ_napis.Caption := '<?>';
  Self.surowiec__1_iloœæ_napis.Font.Size := 12;
  Self.surowiec__1_iloœæ_napis.Font.Style := [ Vcl.Graphics.TFontStyle.fsBold ];
  Self.surowiec__1_iloœæ_napis.Layout := tlCenter;
  Self.surowiec__1_iloœæ_napis.ShowHint := true;
  Self.surowiec__1_iloœæ_napis.OnClick := Self.On_Click__Zp;



  if Self.jednostki_po³¹cz__zp then
    begin

      Self.Caption := 'Po³¹cz';
      Self.Hint := 'Po³¹cz jednostki.' + #13 + #13 + '<Einheiten zusammenführen.>' + #13 + #13 + '<Merge units.>';

      Self.surowiec__1__kolor_panel.Color := Definicje.RGBTriple_To_Color( Definicje.kolor__surowiec__¿ywio³_c );
      Self.surowiec__1__kolor_panel.Hint := '¯ywio³.' + #13 + #13 + '<Elemente.>' + #13 + #13 + '<Element.>';

      Self.surowiec__1_iloœæ_napis.Caption := System.SysUtils.Trim(  System.SysUtils.FormatFloat( '### ### ##0', Definicje.jednostka__koszt__po³¹czenie_c )  );

    end
  else//if Self.jednostki_po³¹cz__zp then
  if Self.teren_kup__zp then
    begin

      Self.Caption := 'Teren';
      Self.Hint := 'Teren powiêksz.' + #13 + #13 + '<Vergrößere das Gelände.>' + #13 + #13 + '<Enlarge the terrain.>';

      Self.surowiec__1__kolor_panel.Color := Definicje.RGBTriple_To_Color( Definicje.kolor__surowiec__kryszta³_c );
      Self.surowiec__1__kolor_panel.Hint := 'Kryszta³.' + #13 + #13 + '<Kristall.>' + #13 + #13 + '<Crystal.>';

      Self.surowiec__1_iloœæ_napis.Caption := System.SysUtils.Trim(  System.SysUtils.FormatFloat( '### ### ##0', Definicje.jednostka__koszt__obszar__zakup_c )  );

      Self.surowiec__2__kolor_panel.Color := Definicje.RGBTriple_To_Color( Definicje.kolor__surowiec__magma_c );
      Self.surowiec__2__kolor_panel.Hint := 'Magma.' + #13 + #13 + '<Magma.>' + #13 + #13 + '<Magma.>';

      Self.surowiec__2_iloœæ_napis.Caption := System.SysUtils.Trim(  System.SysUtils.FormatFloat( '### ### ##0', Definicje.jednostka__koszt__obszar__zakup_c )  );


      zts := System.SysUtils.ExtractFilePath( Vcl.Forms.Application.ExeName ) + obrazki__katalog__nazwa_c + System.SysUtils.PathDelim + obrazki__plik__nazwa__teren_c + '.bmp';

      if System.SysUtils.FileExists( zts ) then
        Self.obrazek.Picture.LoadFromFile( zts );

    end
  else//if Self.teren_kup__zp then
  if Self.jednostka_typ__zp = Definicje.jt_pusta then
    begin

      if Self.budowla_rodzaj__zp = Definicje.br_domek then
        begin

          Self.Caption := 'Domek';
          Self.Hint := 'Domek (produkcja).' + #13 + #13 + '<Hütte (Produktion).>' + #13 + #13 + '<Cottage (production).>';

          Self.surowiec__1__kolor_panel.Color := Definicje.RGBTriple_To_Color( Definicje.kolor__surowiec__kryszta³_c );
          Self.surowiec__1__kolor_panel.Hint := 'Kryszta³.' + #13 + #13 + '<Kristall.>' + #13 + #13 + '<Crystal.>';

          Self.surowiec__1_iloœæ_napis.Caption := System.SysUtils.Trim(  System.SysUtils.FormatFloat( '### ### ##0', Definicje.budowa__koszt__domek_c )  );


          zts := System.SysUtils.ExtractFilePath( Vcl.Forms.Application.ExeName ) + obrazki__katalog__nazwa_c + System.SysUtils.PathDelim + obrazki__plik__nazwa__domek_c + '.bmp';

          if System.SysUtils.FileExists( zts ) then
            Self.obrazek.Picture.LoadFromFile( zts );

        end
      else//if Self.budowla_rodzaj__zp = Definicje.br_domek then
      if Self.budowla_rodzaj__zp = Definicje.br_koszary then
        begin

          Self.Caption := 'Koszary';
          Self.Hint := 'Koszary.' + #13 + #13 + '<Kaserne.>' + #13 + #13 + '<Barracks.>';

          Self.surowiec__1__kolor_panel.Color := Definicje.RGBTriple_To_Color( Definicje.kolor__surowiec__kryszta³_c );
          Self.surowiec__1__kolor_panel.Hint := 'Kryszta³.' + #13 + #13 + '<Kristall.>' + #13 + #13 + '<Crystal.>';

          Self.surowiec__1_iloœæ_napis.Caption := System.SysUtils.Trim(  System.SysUtils.FormatFloat( '### ### ##0', Definicje.budowa__koszt__wie¿a__obronna_c )  );

          Self.surowiec__2__kolor_panel.Color := Definicje.RGBTriple_To_Color( Definicje.kolor__surowiec__magma_c );
          Self.surowiec__2__kolor_panel.Hint := 'Magma.' + #13 + #13 + '<Magma.>' + #13 + #13 + '<Magma.>';

          Self.surowiec__2_iloœæ_napis.Caption := System.SysUtils.Trim(  System.SysUtils.FormatFloat( '### ### ##0', Definicje.budowa__koszt__wie¿a__obronna_c )  );


          zts := System.SysUtils.ExtractFilePath( Vcl.Forms.Application.ExeName ) + obrazki__katalog__nazwa_c + System.SysUtils.PathDelim + obrazki__plik__nazwa__koszary_c + '.bmp';

          if System.SysUtils.FileExists( zts ) then
            Self.obrazek.Picture.LoadFromFile( zts );

        end
      else//if Self.budowla_rodzaj__zp = Definicje.br_koszary then
      if Self.budowla_rodzaj__zp = Definicje.br_wie¿a__obronna then
        begin

          Self.Caption := 'Wie¿a obronna';
          Self.Hint := 'Wie¿a obronna.' + #13 + #13 + '<Wehrturm.>' + #13 + #13 + '<Defensive tower.>';

          Self.surowiec__1__kolor_panel.Color := Definicje.RGBTriple_To_Color( Definicje.kolor__surowiec__magma_c );
          Self.surowiec__1__kolor_panel.Hint := 'Magma.' + #13 + #13 + '<Magma.>' + #13 + #13 + '<Magma.>';

          Self.surowiec__1_iloœæ_napis.Caption := System.SysUtils.Trim(  System.SysUtils.FormatFloat( '### ### ##0', Definicje.budowa__koszt__wie¿a__obronna_c )  );


          zts := System.SysUtils.ExtractFilePath( Vcl.Forms.Application.ExeName ) + obrazki__katalog__nazwa_c + System.SysUtils.PathDelim + obrazki__plik__nazwa__wie¿a__obronna_c + '.bmp';

          if System.SysUtils.FileExists( zts ) then
            Self.obrazek.Picture.LoadFromFile( zts );

        end
      else//if Self.budowla_rodzaj__zp = Definicje.br_wie¿a__obronna then
      if Self.budowla_rodzaj__zp = Definicje.br_wie¿a__zwiadowcza then
        begin

          Self.Caption := 'Wie¿a zwiadowcza';
          Self.Hint := 'Wie¿a zwiadowcza.' + #13 + #13 + '<Aufklärungsturm.>' + #13 + #13 + '<Observation tower.>';

          Self.surowiec__1__kolor_panel.Color := Definicje.RGBTriple_To_Color( Definicje.kolor__surowiec__kryszta³_c );
          Self.surowiec__1__kolor_panel.Hint := 'Kryszta³.' + #13 + #13 + '<Kristall.>' + #13 + #13 + '<Crystal.>';

          Self.surowiec__1_iloœæ_napis.Caption := System.SysUtils.Trim(  System.SysUtils.FormatFloat( '### ### ##0', Definicje.budowa__koszt__wie¿a__zwiadowcza_c )  );


          zts := System.SysUtils.ExtractFilePath( Vcl.Forms.Application.ExeName ) + obrazki__katalog__nazwa_c + System.SysUtils.PathDelim + obrazki__plik__nazwa__wie¿a__zwiadowcza_c + '.bmp';

          if System.SysUtils.FileExists( zts ) then
            Self.obrazek.Picture.LoadFromFile( zts );

        end;
      //---//if Self.budowla_rodzaj__zp = Definicje.br_wie¿a__zwiadowcza then

    end
  else//if Self.jednostka_typ__zp = Definicje.jt_pusta then
    begin

      if Self.jednostka_typ__zp = Definicje.jt_jazda then
        begin

          Self.Caption := 'Kawaleria';
          Self.Hint := 'Kawaleria.' + #13 + #13 + '<Kavallerie.>' + #13 + #13 + '<Cavalry.>';

          Self.surowiec__1__kolor_panel.Color := Definicje.RGBTriple_To_Color( Definicje.kolor__surowiec__woda_c );
          Self.surowiec__1__kolor_panel.Hint := 'Woda.' + #13 + #13 + '<Wasser.>' + #13 + #13 + '<Water.>';

          Self.surowiec__1_iloœæ_napis.Caption := System.SysUtils.Trim(  System.SysUtils.FormatFloat( '### ### ##0', Definicje.jednostka__koszt__zakup_c )  );

          Self.surowiec__2__kolor_panel.Color := Definicje.RGBTriple_To_Color( Definicje.kolor__surowiec__kwiatki_c );
          Self.surowiec__2__kolor_panel.Hint := 'Kwiatki.' + #13 + #13 + '<Blumen.>' + #13 + #13 + '<Flowers.>';

          Self.surowiec__2_iloœæ_napis.Caption := System.SysUtils.Trim(  System.SysUtils.FormatFloat( '### ### ##0', Definicje.jednostka__koszt__zakup_c * 2 )  );


          zts := System.SysUtils.ExtractFilePath( Vcl.Forms.Application.ExeName ) + obrazki__katalog__nazwa_c + System.SysUtils.PathDelim + obrazki__plik__nazwa__jazda_c + '.bmp';

          if System.SysUtils.FileExists( zts ) then
            Self.obrazek.Picture.LoadFromFile( zts );

        end
      else//if Self.jednostka_typ__zp = Definicje.jt_jazda then
      if Self.jednostka_typ__zp = Definicje.jt_piechota then
        begin

          Self.Caption := 'Piechota';
          Self.Hint := 'Piechota.' + #13 + #13 + '<Infanterie.>' + #13 + #13 + '<Infantry.>';

          Self.surowiec__1__kolor_panel.Color := Definicje.RGBTriple_To_Color( Definicje.kolor__surowiec__woda_c );
          Self.surowiec__1__kolor_panel.Hint := 'Woda.' + #13 + #13 + '<Wasser.>' + #13 + #13 + '<Water.>';

          Self.surowiec__1_iloœæ_napis.Caption := System.SysUtils.Trim(  System.SysUtils.FormatFloat( '### ### ##0', Definicje.jednostka__koszt__zakup_c )  );


          zts := System.SysUtils.ExtractFilePath( Vcl.Forms.Application.ExeName ) + obrazki__katalog__nazwa_c + System.SysUtils.PathDelim + obrazki__plik__nazwa__piechota_c + '.bmp';

          if System.SysUtils.FileExists( zts ) then
            Self.obrazek.Picture.LoadFromFile( zts );

        end;
      //---//if Self.jednostka_typ__zp = Definicje.jt_piechota then

    end;
  //---//if Self.jednostka_typ__zp = Definicje.jt_pusta then


  Self.surowiec__1_iloœæ_napis.Hint := Self.surowiec__1_iloœæ_napis.Caption + '.';

  if Self.surowiec__2_iloœæ_napis <> nil then
    Self.surowiec__2_iloœæ_napis.Hint := Self.surowiec__2_iloœæ_napis.Caption + '.';


  Self.Aktywnoœæ__Ustaw__Zp( Self.aktywne__zp );

end;//---//Konstruktor klasy TZakup_Przycisk.

destructor TZakup_Przycisk.Destroy();
begin

  System.SysUtils.FreeAndNil( Self.surowiec__1_iloœæ_napis );

  if Self.surowiec__2_iloœæ_napis <> nil then
    System.SysUtils.FreeAndNil( Self.surowiec__2_iloœæ_napis );


  System.SysUtils.FreeAndNil( Self.surowiec__1__kolor_panel );

  if Self.surowiec__2__kolor_panel <> nil then
    System.SysUtils.FreeAndNil( Self.surowiec__2__kolor_panel );


  System.SysUtils.FreeAndNil( Self.surowiec__1_panel );

  if Self.surowiec__2_panel <> nil then
    System.SysUtils.FreeAndNil( Self.surowiec__2_panel );


  System.SysUtils.FreeAndNil( Self.obrazek );
  System.SysUtils.FreeAndNil( Self.surowce_panel );


  inherited;

end;//---//Destruktor klasy TZakup_Przycisk.

procedure TZakup_Przycisk.On_Click__Zp( Sender : TObject );
begin

  if not Self.aktywne__zp then
    Exit;


  if Self.Budowla__Kup__Odczytaj__Zp() then
    begin

      if @Self.Budowa__Tryb__Zmieñ__Zp <> nil then
        Self.Budowa__Tryb__Zmieñ__Zp( Self.budowla_rodzaj__zp );

    end
  else//if Self.Budowla__Kup__Odczytaj__Zp() then
    begin

      if @Self.Jednostki__Zakup__Obs³uga__Zp <> nil then
        Self.Jednostki__Zakup__Obs³uga__Zp( Self.Jednostki_Po³¹cz__Odczytaj__Zp(), Self.Teren_Kup__Odczytaj__Zp(), Self.Jednostka_Typ__Odczytaj__Zp(), Self.Jednostka_Typ__Po³¹cz__Odczytaj__Zp() );

    end;
  //---//if Self.Budowla__Kup__Odczytaj__Zp() then

end;//---//Funkcja On_Click__Zp().

procedure TZakup_Przycisk.Aktywnoœæ__Ustaw__Zp( const aktywne_f : boolean );
begin

  Self.Aktywnoœæ__Ustaw__Zp( aktywne_f, aktywne_f );

end;//---//Funkcja Aktywnoœæ__Ustaw__Zp().

procedure TZakup_Przycisk.Aktywnoœæ__Ustaw__Zp( const aktywne_f, aktywne_kolor_f : boolean );
begin

  Self.aktywne__zp := aktywne_f;


  Self.surowce_panel.Enabled := Self.aktywne__zp;

  if aktywne_kolor_f then
      begin

        Self.surowiec__1_iloœæ_napis.Font.Color := Vcl.Graphics.clWindowText;
        Self.surowiec__1_iloœæ_napis.Font.Style := Self.surowiec__1_iloœæ_napis.Font.Style
          - [ Vcl.Graphics.fsUnderline ];

      end
  else//if aktywne_kolor_f then
    begin

      Self.surowiec__1_iloœæ_napis.Font.Color := Vcl.Graphics.clMaroon;
      Self.surowiec__1_iloœæ_napis.Font.Style := Self.surowiec__1_iloœæ_napis.Font.Style
        + [ Vcl.Graphics.fsUnderline ];

    end;
  //---//if aktywne_kolor_f then


  if aktywne_f then
    Self.surowiec__1_panel.Color := Vcl.Graphics.clBtnFace
  else//if kolor_niedostêpnoœci_f then
    Self.surowiec__1_panel.Color := Vcl.Graphics.clInactiveCaption;

  Self.surowiec__1_panel.Enabled := Self.aktywne__zp;
  Self.surowiec__1__kolor_panel.Enabled := Self.aktywne__zp;

  if Self.surowiec__2_iloœæ_napis <> nil then
    begin

      Self.surowiec__2_iloœæ_napis.Font.Color := Self.surowiec__1_iloœæ_napis.Font.Color;

      if not Self.jednostki_po³¹cz__zp then
        Self.surowiec__2_iloœæ_napis.Font.Style := Self.surowiec__1_iloœæ_napis.Font.Style;

    end;
  //---//if Self.surowiec__2_iloœæ_napis <> nil then

  if Self.surowiec__2__kolor_panel <> nil then
    Self.surowiec__2__kolor_panel.Enabled := Self.aktywne__zp;

  if Self.surowiec__2_panel<> nil then
    begin

      Self.surowiec__2_panel.Color := Self.surowiec__1_panel.Color;
      Self.surowiec__2_panel.Enabled := Self.aktywne__zp;

    end;
  //---//if Self.surowiec__2_panel<> nil then

end;//---//Funkcja Aktywnoœæ__Ustaw__Zp().

function TZakup_Przycisk.Budowla__Kup__Odczytaj__Zp() : boolean;
begin

  Result := Self.budowla__kup__zp;

end;//---//Funkcja Budowla__Kup__Odczytaj__Zp().

function TZakup_Przycisk.Budowla__Rodzaj__Odczytaj__Zp() : Definicje.TBudowla_Rodzaj;
begin

  Result := Self.budowla_rodzaj__zp;

end;//---//Funkcja Budowla__Rodzaj__Odczytaj__Zp().

function TZakup_Przycisk.Jednostka_Typ__Odczytaj__Zp() : Definicje.TJednostka_Typ;
begin

  Result := Self.jednostka_typ__zp;

end;//---//Funkcja Jednostka_Typ__Odczytaj__Zp().

function TZakup_Przycisk.Jednostka_Typ__Po³¹cz__Odczytaj__Zp() : Definicje.TJednostka_Typ;
begin

  Result := Self.jednostka_typ__po³¹cz__zp;

end;//---//Funkcja Jednostka_Typ__Po³¹cz__Odczytaj__Zp().

function TZakup_Przycisk.Jednostki_Po³¹cz__Odczytaj__Zp() : boolean;
begin

  Result := Self.jednostki_po³¹cz__zp;

end;//---//Funkcja Jednostki_Po³¹cz__Odczytaj__Zp().

function TZakup_Przycisk.Teren_Kup__Odczytaj__Zp() : boolean;
begin

  Result := Self.teren_kup__zp;

end;//---//Funkcja Teren_Kup__Odczytaj__Zp().

procedure TZakup_Przycisk.Wartoœci__Ustaw__Zp( const jednostka_typ_f : Definicje.TJednostka_Typ; const surowiec__1__iloœæ_f : integer );
var
  zts : string;
begin

  Self.surowiec__1_iloœæ_napis.Caption := System.SysUtils.Trim(  System.SysUtils.FormatFloat( '### ### ##0', surowiec__1__iloœæ_f )  );

  if Self.Jednostki_Po³¹cz__Odczytaj__Zp() then
    Self.jednostka_typ__po³¹cz__zp := jednostka_typ_f;


  if Self.surowiec__2_iloœæ_napis <> nil then
    begin

      if Self.Jednostka_Typ__Po³¹cz__Odczytaj__Zp() = Definicje.jt_jazda then
        begin

          Self.surowiec__2_iloœæ_napis.Caption := 'jazda';


          zts := System.SysUtils.ExtractFilePath( Vcl.Forms.Application.ExeName ) + obrazki__katalog__nazwa_c + System.SysUtils.PathDelim + obrazki__plik__nazwa__po³¹cz__jazda_c + '.bmp';

          if System.SysUtils.FileExists( zts ) then
            Self.obrazek.Picture.LoadFromFile( zts );

        end
      else//if Self.Jednostka_Typ__Po³¹cz__Odczytaj__Zp() = Definicje.jt_jazda then
      if Self.Jednostka_Typ__Po³¹cz__Odczytaj__Zp() = Definicje.jt_piechota then
        begin

          Self.surowiec__2_iloœæ_napis.Caption := 'piechota';


          zts := System.SysUtils.ExtractFilePath( Vcl.Forms.Application.ExeName ) + obrazki__katalog__nazwa_c + System.SysUtils.PathDelim + obrazki__plik__nazwa__po³¹cz__piechota_c + '.bmp';

          if System.SysUtils.FileExists( zts ) then
            Self.obrazek.Picture.LoadFromFile( zts );

        end
      else//if Self.Jednostka_Typ__Po³¹cz__Odczytaj__Zp() = Definicje.jt_piechota then
        begin

          Self.surowiec__2_iloœæ_napis.Caption := 'niedostêpne';


          Self.obrazek.Picture := nil;

        end;
      //---//if Self.Jednostka_Typ__Po³¹cz__Odczytaj__Zp() = Definicje.jt_piechota then

    end;
  //---//if Self.surowiec__2_iloœæ_napis <> nil then

end;//---//Funkcja Wartoœci__Ustaw__Zp().

procedure TZakup_Przycisk.Wartoœci__Ustaw__Zp( const surowiec__1__iloœæ_f, surowiec__2__iloœæ_f : integer );
begin

  Self.surowiec__1_iloœæ_napis.Caption := System.SysUtils.Trim(  System.SysUtils.FormatFloat( '### ### ##0', surowiec__1__iloœæ_f )  );

  if Self.surowiec__2_iloœæ_napis <> nil then
    Self.surowiec__2_iloœæ_napis.Caption := System.SysUtils.Trim(  System.SysUtils.FormatFloat( '### ### ##0', surowiec__2__iloœæ_f )  );

end;//---//Funkcja Wartoœci__Ustaw__Zp().

end.
