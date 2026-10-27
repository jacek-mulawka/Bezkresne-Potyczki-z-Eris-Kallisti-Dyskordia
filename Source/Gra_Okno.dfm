object Gra_Okno_Form: TGra_Okno_Form
  Left = 0
  Top = 0
  Caption = 'Bezkresne Potyczki z Eris Kallisti Dyskordia'
  ClientHeight = 761
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Informacje_Splitter: TSplitter
    Left = 576
    Top = 0
    Width = 8
    Height = 761
    Align = alRight
    Color = clSkyBlue
    ParentColor = False
    ExplicitLeft = 626
    ExplicitTop = -386
    ExplicitHeight = 723
  end
  object Gra_GLSceneViewer: TGLSceneViewer
    Left = 5
    Top = 5
    Width = 300
    Height = 300
    Camera = Gra_GLCamera
    FieldOfView = 143.130096435546900000
    PenAsTouch = False
    OnClick = Gra_GLSceneViewerClick
    OnMouseDown = Gra_GLSceneViewerMouseDown
    OnMouseMove = Gra_GLSceneViewerMouseMove
    OnMouseUp = Gra_GLSceneViewerMouseUp
    OnMouseWheel = Gra_GLSceneViewerMouseWheel
    OnKeyDown = Gra_GLSceneViewerKeyDown
    TabOrder = 0
  end
  object Informacje_Panel: TPanel
    Left = 584
    Top = 0
    Width = 200
    Height = 761
    Align = alRight
    TabOrder = 1
    object Tura_Panel: TPanel
      Left = 1
      Top = 1
      Width = 198
      Height = 30
      Hint = 'Tury.'#13#10#13#10'<Spielz'#252'ge.>'#13#10#13#10'<Turns.>'
      Align = alTop
      BevelOuter = bvLowered
      Caption = '<?> / <?>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object Gracz_Panel: TPanel
      Left = 1
      Top = 31
      Width = 198
      Height = 145
      Align = alTop
      TabOrder = 1
      object Gracz__1__Tło_Panel: TPanel
        AlignWithMargins = True
        Left = 6
        Top = 86
        Width = 186
        Height = 10
        Margins.Left = 5
        Margins.Top = 20
        Margins.Right = 5
        Margins.Bottom = 0
        Align = alTop
        ParentBackground = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object Gracz__2__Tło_Panel: TPanel
        AlignWithMargins = True
        Left = 6
        Top = 11
        Width = 186
        Height = 10
        Margins.Left = 5
        Margins.Top = 10
        Margins.Right = 5
        Margins.Bottom = 0
        Align = alTop
        ParentBackground = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
      object Gracz__1_Panel: TPanel
        Left = 1
        Top = 96
        Width = 196
        Height = 45
        Align = alTop
        BevelOuter = bvNone
        Enabled = False
        TabOrder = 2
        object Gracz__1_RadioGroup: TRadioGroup
          AlignWithMargins = True
          Left = 5
          Top = 0
          Width = 186
          Height = 40
          Margins.Left = 5
          Margins.Top = 0
          Margins.Right = 5
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Gracz 1'
          TabOrder = 0
        end
      end
      object Gracz__2_Panel: TPanel
        Left = 1
        Top = 21
        Width = 196
        Height = 45
        Align = alTop
        BevelOuter = bvNone
        Enabled = False
        TabOrder = 3
        object Gracz__2_RadioGroup: TRadioGroup
          AlignWithMargins = True
          Left = 5
          Top = 0
          Width = 186
          Height = 40
          Margins.Left = 5
          Margins.Top = 0
          Margins.Right = 5
          Margins.Bottom = 20
          Align = alTop
          Caption = 'Gracz 2'
          TabOrder = 0
        end
      end
    end
    object Surowce_Panel: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 285
      Width = 185
      Height = 41
      Margins.Left = 0
      Margins.Top = 30
      Margins.Right = 0
      Margins.Bottom = 0
      TabOrder = 2
    end
    object Przyciski_Panel: TPanel
      Left = 1
      Top = 719
      Width = 198
      Height = 41
      Align = alBottom
      TabOrder = 5
      object Gra_Współczynnik_Prędkości_Label: TLabel
        Left = 5
        Top = 25
        Width = 112
        Height = 13
        Hint = 
          'Pr'#281'dko'#347#263' tury / Pr'#281'dko'#347#263' bitwa jednostek'#13#10#13#10'<Spielz'#252'ge Geschwind' +
          'igkeit / Einheitenschlacht Geschwindigkeit>'#13#10#13#10'<Turns speed / Un' +
          'its battle speed>'
        Caption = 'Pt: <?> | Pb: <?> [ms]'
        ParentShowHint = False
        ShowHint = True
      end
      object Surowce_Przeciwnik_Podgląd_CheckBox: TCheckBox
        Left = 145
        Top = 5
        Width = 50
        Height = 17
        Hint = 
          'Podgl'#261'd surowc'#243'w przeciwnika. [Backspace]'#13#10#13#10'<Ressourcen des Geg' +
          'ners ansehen.>'#13#10#13#10'<View opponent'#39's resources.>'
        Caption = 'S. p.'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = Surowce_Przeciwnik_Podgląd_CheckBoxClick
      end
      object Zakup__Jednostki__Automatycznie__Zawsze_CheckBox: TCheckBox
        Left = 5
        Top = 5
        Width = 130
        Height = 17
        Hint = 
          'Zawsze kupuj i '#322#261'cz jednostki automatycznie. [F3]'#13#10#13#10'<Immer Einh' +
          'eiten automatisch kaufen und zusammenf'#252'hren.>'#13#10#13#10'<Always buy and' +
          ' merge units automatically.>'
        Caption = 'Automatyczny zakup'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
    end
    object Zakup__Budynki_Panel: TPanel
      Left = 5
      Top = 400
      Width = 185
      Height = 41
      TabOrder = 3
    end
    object Zakup__Jednostki_Panel: TPanel
      Left = 5
      Top = 455
      Width = 185
      Height = 120
      TabOrder = 4
      object Zakup__Jednostki__Automatycznie_Button: TButton
        AlignWithMargins = True
        Left = 6
        Top = 49
        Width = 173
        Height = 25
        Hint = 
          'Zakup i '#322#261'cz jednostki automatycznie. [F1]'#13#10#13#10'<Einheiten automat' +
          'isch kaufen und zusammenf'#252'hren.>'#13#10#13#10'<Buy and merge units automat' +
          'ically.>'
        Margins.Left = 5
        Margins.Top = 15
        Margins.Right = 5
        Margins.Bottom = 15
        Align = alBottom
        Caption = 'Automatycznie'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = Zakup__Jednostki__Automatycznie_ButtonClick
      end
      object Bitwa__Jednostki__Wynik__Ustal_Button: TButton
        AlignWithMargins = True
        Left = 6
        Top = 89
        Width = 173
        Height = 25
        Hint = 
          'Stocz bitw'#281' jednostek. [F5]'#13#10#13#10'<K'#228'mpfe in einer Einheitenschlach' +
          't.>'#13#10#13#10'<Fight a units battle.>'
        Margins.Left = 5
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alBottom
        Caption = 'Stocz bitw'#281
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = Bitwa__Jednostki__Wynik__Ustal_ButtonClick
      end
    end
    object Jednostki__Wytrzymałość_Punkty__Panel: TPanel
      AlignWithMargins = True
      Left = 1
      Top = 649
      Width = 198
      Height = 60
      Margins.Left = 0
      Margins.Top = 10
      Margins.Right = 0
      Margins.Bottom = 10
      Align = alBottom
      TabOrder = 6
      DesignSize = (
        198
        60)
      object Jednostki__Wytrzymałość_Punkty__Gracz__1_Panel: TPanel
        Left = 5
        Top = 30
        Width = 100
        Height = 25
        Anchors = [akLeft, akTop, akRight]
        Caption = '<?>'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object Jednostki__Wytrzymałość_Punkty__Gracz__2_Panel: TPanel
        Left = 5
        Top = 5
        Width = 100
        Height = 25
        Anchors = [akLeft, akTop, akRight]
        Caption = '<?>'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
    end
  end
  object Gra_GLScene: TGLScene
    Left = 335
    Top = 10
    object Gra_GLCamera: TGLCamera
      DepthOfView = 100.000000000000000000
      FocalLength = 50.000000000000000000
      Position.Coordinates = {0000000000000000000020C10000803F}
      Direction.Coordinates = {00000080000000000000803F00000000}
      Up.Coordinates = {00000000000080BF0000000000000000}
    end
    object Dół_GLLightSource: TGLLightSource
      ConstAttenuation = 1.000000000000000000
      Diffuse.Color = {0000003F0000003F0000003F0000803F}
      Position.Coordinates = {0000000000000000000020C10000803F}
      SpotCutOff = 180.000000000000000000
    end
    object Góra_GLLightSource: TGLLightSource
      ConstAttenuation = 1.000000000000000000
      Diffuse.Color = {6666263F6666263F6666263F0000803F}
      Position.Coordinates = {00000000000000000000C8C20000803F}
      SpotCutOff = 180.000000000000000000
    end
    object Zero_GLSphere: TGLSphere
      Radius = 0.500000000000000000
    end
    object Lewo_GLCube: TGLCube
      Position.Coordinates = {000040C000000000000000000000803F}
    end
    object Gra_Obiekty_GLDummyCube: TGLDummyCube
      CubeSize = 1.000000000000000000
    end
    object Mapa_Tło_GLPlane: TGLPlane
      Material.FrontProperties.Diffuse.Color = {3333B33E3333B33E1F852B3F0000803F}
      Direction.Coordinates = {0000000000000080000080BF00000000}
      Position.Coordinates = {000080BF000000C05839343C0000803F}
      Height = 2.000000000000000000
      Width = 2.000000000000000000
    end
    object Jednostki_Obszar_Tło_GLPlane: TGLPlane
      Direction.Coordinates = {0000000000000000000080BF00000000}
      Position.Coordinates = {00004040000000000AD7233C0000803F}
      Height = 5.000000000000000000
      Width = 3.000000000000000000
    end
    object Ziemia_GLPlane: TGLPlane
      Material.FrontProperties.Diffuse.Color = {9484843EDBDEDE3E9484843E0000803F}
      Direction.Coordinates = {0000000000000080000080BF00000000}
      Position.Coordinates = {00000000000000000AD7233C0000803F}
      Height = 2.000000000000000000
      Width = 2.000000000000000000
    end
    object Pauza_GLHUDSprite: TGLHUDSprite
      Material.FrontProperties.Ambient.Color = {00000000000000000000000000000000}
      Material.FrontProperties.Diffuse.Color = {CDCC4C3FCDCC4C3FCDCC4C3F9A99993E}
      Material.FrontProperties.Emission.Color = {00000000000000000000000000000000}
      Material.BlendingMode = bmCustom
      Material.BlendingParams.UseAlphaFunc = True
      Position.Coordinates = {0000164300004842000000000000803F}
      Pickable = False
      Width = 200.000000000000000000
      Height = 80.000000000000000000
      Rotation = 0.000000000000000000
    end
    object Pauza_GLHUDText: TGLHUDText
      Position.Coordinates = {0000164300004842000000000000803F}
      Pickable = False
      BitmapFont = GLWindowsBitmapFont1
      Text = 'Pauza'
      Rotation = 0.000000000000000000
      Alignment = taCenter
      Layout = tlCenter
    end
    object GLParticleFXRenderer1: TGLParticleFXRenderer
    end
  end
  object GLCadencer1: TGLCadencer
    Scene = Gra_GLScene
    Enabled = False
    OnProgress = GLCadencer1Progress
    Left = 335
    Top = 70
  end
  object Tura_Timer: TTimer
    Enabled = False
    OnTimer = Tura_TimerTimer
    Left = 445
    Top = 135
  end
  object GLWindowsBitmapFont1: TGLWindowsBitmapFont
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWhite
    Font.Height = -64
    Font.Name = 'Georgia'
    Font.Style = []
    Left = 450
    Top = 10
  end
  object Bitwa_Jednostki_Timer: TTimer
    Enabled = False
    OnTimer = Bitwa_Jednostki_TimerTimer
    Left = 335
    Top = 135
  end
  object Światła_Wież__1_GLPerlinPFXManager: TGLPerlinPFXManager
    Cadencer = GLCadencer1
    Renderer = GLParticleFXRenderer1
    Friction = 1.000000000000000000
    Smoothness = 1.000000000000000000
    Brightness = 1.000000000000000000
    Gamma = 1.000000000000000000
    ParticleSize = 1.000000000000000000
    LifeColors = <
      item
        LifeTime = 3.000000000000000000
        SizeScale = 1.000000000000000000
      end>
    Left = 335
    Top = 535
  end
  object Światła_Wież__2_GLPerlinPFXManager: TGLPerlinPFXManager
    Cadencer = GLCadencer1
    Renderer = GLParticleFXRenderer1
    Friction = 1.000000000000000000
    Smoothness = 1.000000000000000000
    Brightness = 1.000000000000000000
    Gamma = 1.000000000000000000
    ParticleSize = 1.000000000000000000
    LifeColors = <
      item
        LifeTime = 3.000000000000000000
        SizeScale = 1.000000000000000000
      end>
    Left = 335
    Top = 595
  end
  object Błyskawica__1_GLThorFXManager: TGLThorFXManager
    Cadencer = GLCadencer1
    Maxpoints = 64
    GlowSize = 0.200000002980232200
    OuterColor.Color = {00000000000000000000803F00000000}
    Disabled = False
    Core = True
    Glow = True
    Wildness = 1.000000000000000000
    Left = 335
    Top = 350
  end
  object Błyskawica__2_GLThorFXManager: TGLThorFXManager
    Cadencer = GLCadencer1
    Maxpoints = 64
    GlowSize = 0.200000002980232200
    OuterColor.Color = {00000000000000000000803F00000000}
    Disabled = False
    Core = True
    Glow = True
    Wildness = 1.000000000000000000
    Left = 335
    Top = 410
  end
  object Ogień_GLPolygonPFXManager: TGLPolygonPFXManager
    Cadencer = GLCadencer1
    Renderer = GLParticleFXRenderer1
    Friction = 1.000000000000000000
    ParticleSize = 1.000000000000000000
    LifeColors = <
      item
        LifeTime = 3.000000000000000000
        SizeScale = 1.000000000000000000
      end>
    Left = 335
    Top = 475
  end
end
