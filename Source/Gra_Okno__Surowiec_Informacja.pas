unit Gra_Okno__Surowiec_Informacja;{09.Wrz.2026}

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
  TSurowiec_Informacja = class( Vcl.StdCtrls.TGroupBox )
  private
    { Private declarations }
    surowiec__rodzaj__si : Definicje.TSurowiec_Rodzaj;

    iloœæ_napis : Vcl.StdCtrls.TLabel;
    kolor_panel : Vcl.ExtCtrls.TPanel;
  public
    { Public declarations }
    constructor Create( AOwner : System.Classes.TComponent; AParent : Vcl.Controls.TWinControl; const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj );
    destructor Destroy(); override;

    procedure Iloœæ_Ustaw__Si( const wartoœæ_f : integer );
    function Surowiec__Rodzaj__Odczytaj__Si() : Definicje.TSurowiec_Rodzaj;
  end;//---//TSurowiec_Informacja = class

implementation

constructor TSurowiec_Informacja.Create( AOwner : System.Classes.TComponent; AParent : Vcl.Controls.TWinControl; const surowiec__rodzaj_f : Definicje.TSurowiec_Rodzaj );
begin

  inherited Create( AOwner );

  Self.Parent := AParent;
  Self.Align := Vcl.Controls.alTop;
  Self.Height := 45;
  Self.ShowHint := true;
  Self.surowiec__rodzaj__si := surowiec__rodzaj_f;

  Self.kolor_panel := TPanel.Create( Self );
  Self.kolor_panel.Parent := Self;
  Self.kolor_panel.Align := Vcl.Controls.alRight;
  Self.kolor_panel.AlignWithMargins := true;
  Self.kolor_panel.Margins.Bottom := 5;
  Self.kolor_panel.Margins.Left := Self.kolor_panel.Margins.Bottom;
  Self.kolor_panel.Margins.Right := Self.kolor_panel.Margins.Bottom;
  Self.kolor_panel.Margins.Top := Self.kolor_panel.Margins.Bottom;
  Self.kolor_panel.ParentBackground := false;
  Self.kolor_panel.Width := 30;

  Self.iloœæ_napis := TLabel.Create( Self );
  Self.iloœæ_napis.Parent := Self;
  Self.iloœæ_napis.Align := Vcl.Controls.alClient;
  Self.iloœæ_napis.Alignment := taRightJustify;
  Self.iloœæ_napis.AlignWithMargins := true;
  Self.iloœæ_napis.Caption := '<?>';
  Self.iloœæ_napis.Font.Size := 12;
  Self.iloœæ_napis.Font.Style := [ Vcl.Graphics.TFontStyle.fsBold ];
  Self.iloœæ_napis.Layout := tlCenter;
  Self.iloœæ_napis.Margins.Bottom := 0;
  Self.iloœæ_napis.Margins.Left := Self.iloœæ_napis.Margins.Bottom;
  Self.iloœæ_napis.Margins.Right := 5;
  Self.iloœæ_napis.Margins.Top := Self.iloœæ_napis.Margins.Bottom;


  if Self.surowiec__rodzaj__si = Definicje.sr_kryszta³ then
    begin

      Self.Caption := 'Kryszta³';
      Self.Hint := 'Kryszta³.' + #13 + #13 + '<Kristall.>' + #13 + #13 + '<Crystal.>';

      Self.kolor_panel.Color := Definicje.RGBTriple_To_Color( Definicje.kolor__surowiec__kryszta³_c );

    end
  else//if Self.surowiec__rodzaj__si = Definicje.sr_kryszta³ then
  if Self.surowiec__rodzaj__si = Definicje.sr_kwiatki then
    begin

      Self.Caption := 'Kwiatki';
      Self.Hint := 'Kwiatki.' + #13 + #13 + '<Blumen.>' + #13 + #13 + '<Flowers.>';

      Self.kolor_panel.Color := Definicje.RGBTriple_To_Color( Definicje.kolor__surowiec__kwiatki_c );

    end
  else//if Self.surowiec__rodzaj__si = Definicje.sr_kwiatki then
  if Self.surowiec__rodzaj__si = Definicje.sr_magma then
    begin

      Self.Caption := 'Magma';
      Self.Hint := 'Magma.' + #13 + #13 + '<Magma.>' + #13 + #13 + '<Magma.>';

      Self.kolor_panel.Color := Definicje.RGBTriple_To_Color( Definicje.kolor__surowiec__magma_c );

    end
  else//if Self.surowiec__rodzaj__si = Definicje.sr_magma then
  if Self.surowiec__rodzaj__si = Definicje.sr_woda then
    begin

      Self.Caption := 'Woda';
      Self.Hint := 'Woda.' + #13 + #13 + '<Wasser.>' + #13 + #13 + '<Water.>';

      Self.kolor_panel.Color := Definicje.RGBTriple_To_Color( Definicje.kolor__surowiec__woda_c );

    end
  else//if Self.surowiec__rodzaj__si = Definicje.sr_woda then
  if Self.surowiec__rodzaj__si = Definicje.sr_¿ywio³ then
    begin

      Self.Caption := '¯ywio³';
      Self.Hint := '¯ywio³.' + #13 + #13 + '<Elemente.>' + #13 + #13 + '<Element.>';

      Self.kolor_panel.Color := Definicje.RGBTriple_To_Color( Definicje.kolor__surowiec__¿ywio³_c );

    end;
  //---//if Self.surowiec__rodzaj__si = Definicje.sr_¿ywio³ then

end;//---//Konstruktor klasy TSurowiec_Informacja.

destructor TSurowiec_Informacja.Destroy();
begin

  System.SysUtils.FreeAndNil( Self.iloœæ_napis );
  System.SysUtils.FreeAndNil( Self.kolor_panel );


  inherited;

end;//---//Destruktor klasy TSurowiec_Informacja.

procedure TSurowiec_Informacja.Iloœæ_Ustaw__Si( const wartoœæ_f : integer );
begin

  Self.iloœæ_napis.Caption := System.SysUtils.Trim(  System.SysUtils.FormatFloat( '### ### ##0', wartoœæ_f )  );

end;//---//Funkcja Iloœæ_Ustaw__Si().

function TSurowiec_Informacja.Surowiec__Rodzaj__Odczytaj__Si() : Definicje.TSurowiec_Rodzaj;
begin

  Result := Self.surowiec__rodzaj__si;

end;//---//Funkcja Surowiec__Rodzaj__Odczytaj__Si().

end.
