unit Gracz__Rozbudowa_Przycisk;{15.Wrz.2026}

interface

uses
  System.Classes,
  System.SysUtils,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Graphics,
  Vcl.StdCtrls,

  Definicje;

type
  TGracz_Rozbuduj = procedure( const wspó³czynnik_rodzaj_f : Definicje.TGracz_Wspó³czynnik_Rodzaj ) of object;

  TGracz__Rozbudowa_Przycisk = class( Vcl.StdCtrls.TGroupBox )
  private
    { Private declarations }
    aktywne__grp : boolean;

    wspó³czynnik_rodzaj__grp : Definicje.TGracz_Wspó³czynnik_Rodzaj;

    wspó³czynnik__zwiêksz_przycisk : Vcl.StdCtrls.TButton;

    wspó³czynnik__koszt_napis,
    wspó³czynnik__wartoœæ_napis
      : Vcl.StdCtrls.TLabel;

    wspó³czynnik_panel,
    wspó³czynnik__koszt_panel,
    wspó³czynnik__wartoœæ_panel
      : Vcl.ExtCtrls.TPanel;

    Gracz_Rozbuduj__Grp : Gracz__Rozbudowa_Przycisk.TGracz_Rozbuduj;
  public
    { Public declarations }
    constructor Create( AOwner : System.Classes.TComponent; AParent : Vcl.Controls.TWinControl; const wspó³czynnik_rodzaj_f : Definicje.TGracz_Wspó³czynnik_Rodzaj; gracz_rozbuduj_f : Gracz__Rozbudowa_Przycisk.TGracz_Rozbuduj );
    destructor Destroy(); override;

    function Aktywnoœæ__Odczytaj__Grp() : boolean;
    procedure Aktywnoœæ__Ustaw__Grp( const aktywne_f : boolean );
    procedure On_Click__Grp( Sender : TObject );
    procedure Rozmiar_Dostosuj__Grp();
    function Wspó³czynnik_Rodzaj__Odczytaj__Grp() : Definicje.TGracz_Wspó³czynnik_Rodzaj;
    procedure Wartoœci__Ustaw__Grp( const wspó³czynnik__koszt_f, wspó³czynnik__wartoœæ_f : real; const rozbudowa__punkty_f : integer = -1 );
  end;//---//TGracz__Rozbudowa_Przycisk = class

implementation

constructor TGracz__Rozbudowa_Przycisk.Create( AOwner : System.Classes.TComponent; AParent : Vcl.Controls.TWinControl; const wspó³czynnik_rodzaj_f : Definicje.TGracz_Wspó³czynnik_Rodzaj; gracz_rozbuduj_f : Gracz__Rozbudowa_Przycisk.TGracz_Rozbuduj );
begin

  inherited Create( AOwner );

  Self.aktywne__grp := false;
  Self.Gracz_Rozbuduj__Grp := gracz_rozbuduj_f;
  Self.wspó³czynnik_rodzaj__grp := wspó³czynnik_rodzaj_f;


  Self.Parent := AParent;
  Self.Align := Vcl.Controls.alTop;
  Self.Height := 60;
  Self.Parent.Height := Self.Parent.Height + Self.Height;
  Self.ShowHint := true;


  Self.wspó³czynnik__zwiêksz_przycisk := Vcl.StdCtrls.TButton.Create(Self );
  Self.wspó³czynnik__zwiêksz_przycisk.Parent := Self;
  Self.wspó³czynnik__zwiêksz_przycisk.Align := Vcl.Controls.alRight;
  Self.wspó³czynnik__zwiêksz_przycisk.Caption := '+';
  Self.wspó³czynnik__zwiêksz_przycisk.Hint := 'Ulepsz.' + #13 + #13 + '<Verbessern.>' + #13 + #13 + '<Upgrade.>';
  Self.wspó³czynnik__zwiêksz_przycisk.ShowHint := true;
  Self.wspó³czynnik__zwiêksz_przycisk.Width := 50;
  Self.wspó³czynnik__zwiêksz_przycisk.OnClick := Self.On_Click__Grp;


  Self.wspó³czynnik_panel := TPanel.Create( Self );
  Self.wspó³czynnik_panel.Parent := Self;
  Self.wspó³czynnik_panel.Align := Vcl.Controls.alClient;

  Self.wspó³czynnik__koszt_panel := TPanel.Create( Self );
  Self.wspó³czynnik__koszt_panel.Parent := Self.wspó³czynnik_panel;
  Self.wspó³czynnik__koszt_panel.Align := Vcl.Controls.alLeft;
  Self.wspó³czynnik__koszt_panel.ParentBackground := false;

  Self.wspó³czynnik__koszt_napis := TLabel.Create( Self );
  Self.wspó³czynnik__koszt_napis.Parent := Self.wspó³czynnik__koszt_panel;
  Self.wspó³czynnik__koszt_napis.Align := Vcl.Controls.alClient;
  Self.wspó³czynnik__koszt_napis.Alignment := taCenter;
  Self.wspó³czynnik__koszt_napis.Caption := '<?>';
  Self.wspó³czynnik__koszt_napis.Font.Size := 12;
  Self.wspó³czynnik__koszt_napis.Font.Style := [ Vcl.Graphics.TFontStyle.fsBold ];
  Self.wspó³czynnik__koszt_napis.Layout := tlCenter;
  Self.wspó³czynnik__koszt_napis.ShowHint := true;


  Self.wspó³czynnik__wartoœæ_panel := TPanel.Create( Self );
  Self.wspó³czynnik__wartoœæ_panel.Parent := Self.wspó³czynnik_panel;
  Self.wspó³czynnik__wartoœæ_panel.Align := Vcl.Controls.alLeft;
  Self.wspó³czynnik__wartoœæ_panel.Color := Vcl.Graphics.clMoneyGreen;
  Self.wspó³czynnik__wartoœæ_panel.ParentBackground := false;

  Self.wspó³czynnik__wartoœæ_napis := TLabel.Create( Self );
  Self.wspó³czynnik__wartoœæ_napis.Parent := Self.wspó³czynnik__wartoœæ_panel;
  Self.wspó³czynnik__wartoœæ_napis.Align := Vcl.Controls.alClient;
  Self.wspó³czynnik__wartoœæ_napis.Alignment := taCenter;
  Self.wspó³czynnik__wartoœæ_napis.Caption := '<?>';
  Self.wspó³czynnik__wartoœæ_napis.Font.Size := 12;
  Self.wspó³czynnik__wartoœæ_napis.Font.Style := [ Vcl.Graphics.TFontStyle.fsBold ];
  Self.wspó³czynnik__wartoœæ_napis.Layout := tlCenter;
  Self.wspó³czynnik__wartoœæ_napis.ShowHint := true;


  if Self.wspó³czynnik_rodzaj__grp = Definicje.gwr_atak then
    begin

      Self.Caption := 'Atak';
      Self.Hint := 'Atak.' + #13 + #13 + '<Angriff.>' + #13 + #13 + '<Attack.>';

    end
  else//if Self.wspó³czynnik_rodzaj__grp = Definicje.gwr_atak then
  if Self.wspó³czynnik_rodzaj__grp = Definicje.gwr_obrona then
    begin

      Self.Caption := 'Obrona';
      Self.Hint := 'Obrona.' + #13 + #13 + '<Verteidigung.>' + #13 + #13 + '<Defense.>';

    end
  else//if Self.wspó³czynnik_rodzaj__grp = Definicje.gwr_obrona then
  if Self.wspó³czynnik_rodzaj__grp = Definicje.gwr_obserwacja then
    begin

      Self.Caption := 'Obserwacja';
      Self.Hint := 'Obserwacja.' + #13 + #13 + '<Beobachtung.>' + #13 + #13 + '<Observation.>';

    end
  else//if Self.wspó³czynnik_rodzaj__grp = Definicje.gwr_obserwacja then
  if Self.wspó³czynnik_rodzaj__grp = Definicje.gwr_surowiec__produkcja then
    begin

      Self.Caption := 'Produkcja';
      Self.Hint := 'Produkcja (surowce).' + #13 + #13 + '<Produktion (Rohstoffe).>' + #13 + #13 + '<Production (raw materials).>';

    end
  else//if Self.wspó³czynnik_rodzaj__grp = Definicje.gwr_surowiec__produkcja then
  if Self.wspó³czynnik_rodzaj__grp = Definicje.gwr_zamek__produkcja then
    begin

      Self.Caption := 'Zamek produkcja';
      Self.Hint := 'Zamek produkcja.' + #13 + #13 + '<Schloss Produktion.>' + #13 + #13 + '<Castle production.>';

    end;
  //---//if Self.wspó³czynnik_rodzaj__grp = Definicje.gwr_zamek__produkcja then


  Self.wspó³czynnik__koszt_napis.Hint := Self.wspó³czynnik__koszt_napis.Caption + '.';
  Self.wspó³czynnik__wartoœæ_napis.Hint := Self.wspó³czynnik__wartoœæ_napis.Caption + '.';


  Self.Aktywnoœæ__Ustaw__Grp( Self.aktywne__grp );


  Self.Rozmiar_Dostosuj__Grp();

end;//---//Konstruktor klasy TGracz__Rozbudowa_Przycisk.

destructor TGracz__Rozbudowa_Przycisk.Destroy();
begin

  System.SysUtils.FreeAndNil( Self.wspó³czynnik__koszt_napis );
  System.SysUtils.FreeAndNil( Self.wspó³czynnik__wartoœæ_napis );
  System.SysUtils.FreeAndNil( Self.wspó³czynnik__koszt_panel );
  System.SysUtils.FreeAndNil( Self.wspó³czynnik__wartoœæ_panel );
  System.SysUtils.FreeAndNil( Self.wspó³czynnik__zwiêksz_przycisk );
  System.SysUtils.FreeAndNil( Self.wspó³czynnik_panel );


  inherited;

end;//---//Destruktor klasy TGracz__Rozbudowa_Przycisk.

procedure TGracz__Rozbudowa_Przycisk.On_Click__Grp( Sender : TObject );
begin

  if not Self.aktywne__grp then
    Exit;


  if @Self.Gracz_Rozbuduj__Grp <> nil then
    Self.Gracz_Rozbuduj__Grp( Self.wspó³czynnik_rodzaj__grp );

end;//---//Funkcja On_Click__Grp().

function TGracz__Rozbudowa_Przycisk.Aktywnoœæ__Odczytaj__Grp() : boolean;
begin

  Result := Self.aktywne__grp;

end;//---//Funkcja Aktywnoœæ__Odczytaj__Grp().

procedure TGracz__Rozbudowa_Przycisk.Aktywnoœæ__Ustaw__Grp( const aktywne_f : boolean );
begin

  Self.aktywne__grp := aktywne_f;


  Self.wspó³czynnik__zwiêksz_przycisk.Enabled := Self.aktywne__grp;


  if Self.aktywne__grp then
    Self.wspó³czynnik__koszt_panel.Color := Vcl.Graphics.clSkyBlue
  else//if Self.aktywne__grp then
    Self.wspó³czynnik__koszt_panel.Color := Vcl.Graphics.clBtnFace;

end;//---//Funkcja Aktywnoœæ__Ustaw__Grp().

procedure TGracz__Rozbudowa_Przycisk.Rozmiar_Dostosuj__Grp();
begin

  if    ( Self.wspó³czynnik__koszt_panel <> nil )
    and ( Self.wspó³czynnik__koszt_panel.Parent <> nil ) then
    Self.wspó³czynnik__koszt_panel.Width := Round( Self.wspó³czynnik__koszt_panel.Parent.Width * 0.5 );


  if    ( Self.wspó³czynnik__wartoœæ_panel <> nil )
    and ( Self.wspó³czynnik__wartoœæ_panel.Parent <> nil ) then
    Self.wspó³czynnik__wartoœæ_panel.Width := Round( Self.wspó³czynnik__wartoœæ_panel.Parent.Width * 0.5 );

end;//---//Funkcja Rozmiar_Dostosuj__Grp().

function TGracz__Rozbudowa_Przycisk.Wspó³czynnik_Rodzaj__Odczytaj__Grp() : Definicje.TGracz_Wspó³czynnik_Rodzaj;
begin

  Result := Self.wspó³czynnik_rodzaj__grp;

end;//---//Funkcja Wspó³czynnik_Rodzaj__Odczytaj__Grp().

procedure TGracz__Rozbudowa_Przycisk.Wartoœci__Ustaw__Grp( const wspó³czynnik__koszt_f, wspó³czynnik__wartoœæ_f : real; const rozbudowa__punkty_f : integer = -1 );
begin

  Self.wspó³czynnik__koszt_napis.Caption := System.SysUtils.Trim(  System.SysUtils.FormatFloat( '### ### ##0.00', wspó³czynnik__koszt_f )  );
  Self.wspó³czynnik__koszt_napis.Hint := Self.wspó³czynnik__koszt_napis.Caption + '.' + #13 + #13 + 'Koszt rozbudowy.' + #13 + #13 + '<Entwicklungskosten.>' + #13 + #13 + '<Upgrade cost.>';

  Self.wspó³czynnik__wartoœæ_napis.Caption := System.SysUtils.Trim(  System.SysUtils.FormatFloat( '### ### ##0.00', wspó³czynnik__wartoœæ_f )  );
  Self.wspó³czynnik__wartoœæ_napis.Hint := Self.wspó³czynnik__wartoœæ_napis.Caption + '.' + #13 + #13 + 'Wartoœæ.' + #13 + #13 + '<Wert.>' + #13 + #13 + '<Value.>';


  if rozbudowa__punkty_f >= 0 then
    Self.Aktywnoœæ__Ustaw__Grp( wspó³czynnik__koszt_f <= rozbudowa__punkty_f );

end;//---//Funkcja Wartoœci__Ustaw__Grp().

end.
