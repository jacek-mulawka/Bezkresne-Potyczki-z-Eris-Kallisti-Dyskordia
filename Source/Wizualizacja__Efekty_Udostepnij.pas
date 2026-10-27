unit Wizualizacja__Efekty_Udostepnij;{23.Wrz.2026}

interface

uses
  GLS.ParticleFX,
  GLS.PerlinPFX,
  GLS.ThorFX,

  Definicje,
  Gra_Okno,
  Wizualizacja__Obiekty__Budowle;

type
  TWizualizacja__Efekty_Udostepnij = class
  private
    { Private declarations }
  public
    { Public declarations }
    class var gra_okno_form__weu : Gra_Okno.TGra_Okno_Form;
  end;//---//TWizualizacja__Efekty_Udostepnij = class

function B³yskawica( const dominium__numer_f : smallint ) : GLS.ThorFX.TGLThorFXManager;
function Ogieñ() : GLS.ParticleFX.TGLPolygonPFXManager;
function Œwiat³a_Wie¿( const dominium__numer_f : smallint ) : GLS.PerlinPFX.TGLPerlinPFXManager;

implementation

function B³yskawica( const dominium__numer_f : smallint ) : GLS.ThorFX.TGLThorFXManager;
begin

  Result := nil;

  if Wizualizacja__Efekty_Udostepnij.TWizualizacja__Efekty_Udostepnij.gra_okno_form__weu = nil then
    Exit;


  if dominium__numer_f = Definicje.dominium__numer__gracz__1_c then
    Result := Wizualizacja__Efekty_Udostepnij.TWizualizacja__Efekty_Udostepnij.gra_okno_form__weu.B³yskawica__1_GLThorFXManager
  else//if dominium__numer_f = Definicje.dominium__numer__gracz__1_c then
  if dominium__numer_f = Definicje.dominium__numer__gracz__2_c then
    Result := Wizualizacja__Efekty_Udostepnij.TWizualizacja__Efekty_Udostepnij.gra_okno_form__weu.B³yskawica__2_GLThorFXManager;

end;//---//Funkcja B³yskawica().

function Ogieñ() : GLS.ParticleFX.TGLPolygonPFXManager;
begin

  Result := nil;

  if Wizualizacja__Efekty_Udostepnij.TWizualizacja__Efekty_Udostepnij.gra_okno_form__weu = nil then
    Exit;


  Result := Wizualizacja__Efekty_Udostepnij.TWizualizacja__Efekty_Udostepnij.gra_okno_form__weu.Ogieñ_GLPolygonPFXManager;

end;//---//Funkcja Ogieñ().

function Œwiat³a_Wie¿( const dominium__numer_f : smallint ) : GLS.PerlinPFX.TGLPerlinPFXManager;
begin

  Result := nil;

  if Wizualizacja__Efekty_Udostepnij.TWizualizacja__Efekty_Udostepnij.gra_okno_form__weu = nil then
    Exit;


  if dominium__numer_f = Definicje.dominium__numer__gracz__1_c then
    Result := Wizualizacja__Efekty_Udostepnij.TWizualizacja__Efekty_Udostepnij.gra_okno_form__weu.Œwiat³a_Wie¿__1_GLPerlinPFXManager
  else//if dominium__numer_f = Definicje.dominium__numer__gracz__1_c then
  if dominium__numer_f = Definicje.dominium__numer__gracz__2_c then
    Result := Wizualizacja__Efekty_Udostepnij.TWizualizacja__Efekty_Udostepnij.gra_okno_form__weu.Œwiat³a_Wie¿__2_GLPerlinPFXManager;

end;//---//Funkcja Œwiat³a_Wie¿().


initialization
  Wizualizacja__Efekty_Udostepnij.TWizualizacja__Efekty_Udostepnij.gra_okno_form__weu := nil;

end.
