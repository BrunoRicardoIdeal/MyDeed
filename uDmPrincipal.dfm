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
      'SELECT * FROM NoticiasFeed')
    Left = 40
    Top = 96
    object qryNoticiasFeedID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
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
  object FdWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 152
    Top = 72
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
end
