object frmFileHeaderOptions: TfrmFileHeaderOptions
  Left = 0
  Top = 0
  Width = 370
  Height = 339
  TabOrder = 0
  DesignSize = (
    370
    339)
  object Label2: TLabel
    Left = 20
    Top = 20
    Width = 57
    Height = 16
    Caption = 'File Type:'
  end
  object Label3: TLabel
    Left = 20
    Top = 56
    Width = 75
    Height = 16
    Caption = 'Header Text:'
  end
  object ComboBox1: TComboBox
    Left = 100
    Top = 17
    Width = 145
    Height = 24
    TabOrder = 0
    Text = 'ComboBox1'
  end
  object Memo1: TMemo
    Left = 20
    Top = 75
    Width = 314
    Height = 210
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Hack'
    Font.Style = []
    Lines.Strings = (
      
        '{              Copyright (C) 2020 Gateway Ticketing Systems, Inc' +
        '.            }'
      
        '{                                                               ' +
        '             }'
      
        '{                             ALL RIGHTS RESERVED               ' +
        '             }'
      
        '{                                                               ' +
        '             }'
      
        '{   Use, copy, photocopy, reproduction, translation, reduction, ' +
        'disassembly  }'
      
        '{   or  distribution  in  whole  or in part,  of this software b' +
        'y any means  }'
      
        '{   mechanical,  electronic,  optical,  chemical,  magnetic,  or' +
        ' otherwise,  }'
      
        '{   without the express, written consent of Gateway Ticketing Sy' +
        'stems, Inc.  }'
      
        '{   is strictly prohibited.                                     ' +
        '             }')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
  end
end
