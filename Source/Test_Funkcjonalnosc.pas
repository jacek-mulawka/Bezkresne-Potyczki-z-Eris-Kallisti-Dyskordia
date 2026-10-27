unit Test_Funkcjonalnosc;{27.Sie.2026}

interface

uses
  Vcl.Dialogs,

  Poszukiwacz,
  Wizualizacja;

procedure ShowMessage( const Msg: string = '' );

procedure Wizualizacja__Droga__Rysuj__Wi( const droga__punkty_f : Poszukiwacz.TTablica2D_Integer; const y_f, x_f : integer; const droga_zablokowana_f : boolean = false );


implementation

procedure ShowMessage( const Msg: string = '' );
begin

  Vcl.Dialogs.ShowMessage( Msg );

end;//---//Funkcja ShowMessage().

procedure Wizualizacja__Droga__Rysuj__Wi( const droga__punkty_f : Poszukiwacz.TTablica2D_Integer; const y_f, x_f : integer; const droga_zablokowana_f : boolean = false );
begin

  Wizualizacja.TWizualizacja.Droga__Rysuj__Wi( droga__punkty_f, y_f, x_f, droga_zablokowana_f );

end;//---//Funkcja Wizualizacja__Droga__Rysuj__Wi().

end.
