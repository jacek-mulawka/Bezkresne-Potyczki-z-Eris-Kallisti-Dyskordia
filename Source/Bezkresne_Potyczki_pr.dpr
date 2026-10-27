program Bezkresne_Potyczki_pr;

uses
  Vcl.Forms,
  Bezkresne_Potyczki in 'Bezkresne_Potyczki.pas' {Bezkresne_Potyczki_Form},
  Bitwa_Dominia in 'Bitwa_Dominia.pas',
  Bitwa_Jednostki in 'Bitwa_Jednostki.pas',
  Definicje in 'Definicje.pas',
  Dominium in 'Dominium.pas',
  Gra_Okno in 'Gra_Okno.pas' {Gra_Okno_Form},
  Gra_Okno__Surowiec_Informacja in 'Gra_Okno__Surowiec_Informacja.pas',
  Gra_Okno__Zakup_Przycisk in 'Gra_Okno__Zakup_Przycisk.pas',
  Gracz in 'Gracz.pas',
  Gracz__Rozbudowa_Przycisk in 'Gracz__Rozbudowa_Przycisk.pas',
  Jednostka in 'Jednostka.pas',
  Mapa in 'Mapa.pas',
  Poszukiwacz in 'Poszukiwacz.pas',
  Ranking in 'Ranking.pas',
  Test_Funkcjonalnosc in 'Test_Funkcjonalnosc.pas',
  Wizualizacja in 'Wizualizacja.pas',
  Wizualizacja__Efekty_Udostepnij in 'Wizualizacja__Efekty_Udostepnij.pas',
  Wizualizacja__Obiekty__Budowle in 'Wizualizacja__Obiekty__Budowle.pas',
  Wizualizacja__Obiekty__Jednostki in 'Wizualizacja__Obiekty__Jednostki.pas',
  Wizualizacja__Obiekty__Mapa in 'Wizualizacja__Obiekty__Mapa.pas',
  Wizualizacja__Obiekty__Mapa_Jednostki in 'Wizualizacja__Obiekty__Mapa_Jednostki.pas';

{$R *.res}

begin

  ReportMemoryLeaksOnShutdown := DebugHook <> 0;

  Application.Initialize();
  Application.MainFormOnTaskbar := True;
  Application.HintHidePause := 30000;
  Application.CreateForm( TBezkresne_Potyczki_Form, Bezkresne_Potyczki_Form );
  Application.Run();

end.