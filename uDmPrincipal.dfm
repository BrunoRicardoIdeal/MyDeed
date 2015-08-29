object dmPrincipal: TdmPrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 406
  Width = 215
  object SQLiteConn: TFDConnection
    Params.Strings = (
      'Database=D:\Projetos\MyDeed\MyDeed\BD\MyDeedDB.db'
      'DateTimeFormat=DateTime'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 88
    Top = 32
  end
  object qryNoticiasFeed: TFDQuery
    Connection = SQLiteConn
    SQL.Strings = (
      'SELECT     ID   ,'
      '    COD_NOTICIA ,'
      '    AUTOR       ,'
      '    DESCRICAO   ,'
      '    DT_POSTAGEM ,'
      '    DT_CHEGADA  ,'
      '    DT_SAIDA    ,'
      '    EQUIPAMENTO ,'
      '    OBSERVACAO  ,'
      '    CLIENTE      '
      'FROM NOTICIASFEED'
      'WHERE ID <= :ID'
      'ORDER BY ID DESC'
      'LIMIT 2'
      '')
    Left = 40
    Top = 96
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qryNoticiasFeedID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryNoticiasFeedCOD_NOTICIA: TIntegerField
      FieldName = 'COD_NOTICIA'
      Origin = 'COD_NOTICIA'
    end
    object qryNoticiasFeedAUTOR: TStringField
      FieldName = 'AUTOR'
      Origin = 'AUTOR'
      Size = 30
    end
    object qryNoticiasFeedDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 40
    end
    object qryNoticiasFeedDT_POSTAGEM: TDateTimeField
      FieldName = 'DT_POSTAGEM'
      Origin = 'DT_POSTAGEM'
    end
    object qryNoticiasFeedDT_CHEGADA: TDateTimeField
      FieldName = 'DT_CHEGADA'
      Origin = 'DT_CHEGADA'
    end
    object qryNoticiasFeedDT_SAIDA: TDateTimeField
      FieldName = 'DT_SAIDA'
      Origin = 'DT_SAIDA'
    end
    object qryNoticiasFeedEQUIPAMENTO: TStringField
      FieldName = 'EQUIPAMENTO'
      Origin = 'EQUIPAMENTO'
      Size = 40
    end
    object qryNoticiasFeedOBSERVACAO: TWideStringField
      FieldName = 'OBSERVACAO'
      Origin = 'OBSERVACAO'
      Size = 400
    end
    object qryNoticiasFeedCLIENTE: TStringField
      FieldName = 'CLIENTE'
      Origin = 'CLIENTE'
      Size = 40
    end
  end
  object qryAcoesNoticias: TFDQuery
    Connection = SQLiteConn
    SQL.Strings = (
      'SELECT * FROM AcoesRealizadas')
    Left = 40
    Top = 200
    object qryAcoesNoticiasID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryAcoesNoticiasCOD_NOTICIA: TIntegerField
      FieldName = 'COD_NOTICIA'
      Origin = 'COD_NOTICIA'
    end
    object qryAcoesNoticiasDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 40
    end
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 88
    Top = 184
  end
end
