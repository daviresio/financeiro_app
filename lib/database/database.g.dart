// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Despesa extends DataClass implements Insertable<Despesa> {
  final int id;
  final String nome;
  final String anexo;
  final String localizacao;
  final String observacao;
  final bool despesaFixa;
  final bool pago;
  final bool favorito;
  final DateTime data;
  final DateTime lembrete;
  final int categoriaId;
  final int contaId;
  final DateTime createdAt;
  final DateTime updatedAt;
  Despesa(
      {@required this.id,
      @required this.nome,
      @required this.anexo,
      @required this.localizacao,
      @required this.observacao,
      @required this.despesaFixa,
      @required this.pago,
      @required this.favorito,
      @required this.data,
      @required this.lembrete,
      @required this.categoriaId,
      @required this.contaId,
      @required this.createdAt,
      @required this.updatedAt});
  factory Despesa.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Despesa(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      nome: stringType.mapFromDatabaseResponse(data['${effectivePrefix}nome']),
      anexo:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}anexo']),
      localizacao: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}localizacao']),
      observacao: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}observacao']),
      despesaFixa: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}despesa_fixa']),
      pago: boolType.mapFromDatabaseResponse(data['${effectivePrefix}pago']),
      favorito:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}favorito']),
      data:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}data']),
      lembrete: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}lembrete']),
      categoriaId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}categoria_id']),
      contaId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}conta_id']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory Despesa.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Despesa(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      anexo: serializer.fromJson<String>(json['anexo']),
      localizacao: serializer.fromJson<String>(json['localizacao']),
      observacao: serializer.fromJson<String>(json['observacao']),
      despesaFixa: serializer.fromJson<bool>(json['despesaFixa']),
      pago: serializer.fromJson<bool>(json['pago']),
      favorito: serializer.fromJson<bool>(json['favorito']),
      data: serializer.fromJson<DateTime>(json['data']),
      lembrete: serializer.fromJson<DateTime>(json['lembrete']),
      categoriaId: serializer.fromJson<int>(json['categoriaId']),
      contaId: serializer.fromJson<int>(json['contaId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
      'anexo': serializer.toJson<String>(anexo),
      'localizacao': serializer.toJson<String>(localizacao),
      'observacao': serializer.toJson<String>(observacao),
      'despesaFixa': serializer.toJson<bool>(despesaFixa),
      'pago': serializer.toJson<bool>(pago),
      'favorito': serializer.toJson<bool>(favorito),
      'data': serializer.toJson<DateTime>(data),
      'lembrete': serializer.toJson<DateTime>(lembrete),
      'categoriaId': serializer.toJson<int>(categoriaId),
      'contaId': serializer.toJson<int>(contaId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  DespesasCompanion createCompanion(bool nullToAbsent) {
    return DespesasCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      nome: nome == null && nullToAbsent ? const Value.absent() : Value(nome),
      anexo:
          anexo == null && nullToAbsent ? const Value.absent() : Value(anexo),
      localizacao: localizacao == null && nullToAbsent
          ? const Value.absent()
          : Value(localizacao),
      observacao: observacao == null && nullToAbsent
          ? const Value.absent()
          : Value(observacao),
      despesaFixa: despesaFixa == null && nullToAbsent
          ? const Value.absent()
          : Value(despesaFixa),
      pago: pago == null && nullToAbsent ? const Value.absent() : Value(pago),
      favorito: favorito == null && nullToAbsent
          ? const Value.absent()
          : Value(favorito),
      data: data == null && nullToAbsent ? const Value.absent() : Value(data),
      lembrete: lembrete == null && nullToAbsent
          ? const Value.absent()
          : Value(lembrete),
      categoriaId: categoriaId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoriaId),
      contaId: contaId == null && nullToAbsent
          ? const Value.absent()
          : Value(contaId),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  Despesa copyWith(
          {int id,
          String nome,
          String anexo,
          String localizacao,
          String observacao,
          bool despesaFixa,
          bool pago,
          bool favorito,
          DateTime data,
          DateTime lembrete,
          int categoriaId,
          int contaId,
          DateTime createdAt,
          DateTime updatedAt}) =>
      Despesa(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        anexo: anexo ?? this.anexo,
        localizacao: localizacao ?? this.localizacao,
        observacao: observacao ?? this.observacao,
        despesaFixa: despesaFixa ?? this.despesaFixa,
        pago: pago ?? this.pago,
        favorito: favorito ?? this.favorito,
        data: data ?? this.data,
        lembrete: lembrete ?? this.lembrete,
        categoriaId: categoriaId ?? this.categoriaId,
        contaId: contaId ?? this.contaId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Despesa(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('anexo: $anexo, ')
          ..write('localizacao: $localizacao, ')
          ..write('observacao: $observacao, ')
          ..write('despesaFixa: $despesaFixa, ')
          ..write('pago: $pago, ')
          ..write('favorito: $favorito, ')
          ..write('data: $data, ')
          ..write('lembrete: $lembrete, ')
          ..write('categoriaId: $categoriaId, ')
          ..write('contaId: $contaId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          nome.hashCode,
          $mrjc(
              anexo.hashCode,
              $mrjc(
                  localizacao.hashCode,
                  $mrjc(
                      observacao.hashCode,
                      $mrjc(
                          despesaFixa.hashCode,
                          $mrjc(
                              pago.hashCode,
                              $mrjc(
                                  favorito.hashCode,
                                  $mrjc(
                                      data.hashCode,
                                      $mrjc(
                                          lembrete.hashCode,
                                          $mrjc(
                                              categoriaId.hashCode,
                                              $mrjc(
                                                  contaId.hashCode,
                                                  $mrjc(
                                                      createdAt.hashCode,
                                                      updatedAt
                                                          .hashCode))))))))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Despesa &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.anexo == this.anexo &&
          other.localizacao == this.localizacao &&
          other.observacao == this.observacao &&
          other.despesaFixa == this.despesaFixa &&
          other.pago == this.pago &&
          other.favorito == this.favorito &&
          other.data == this.data &&
          other.lembrete == this.lembrete &&
          other.categoriaId == this.categoriaId &&
          other.contaId == this.contaId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DespesasCompanion extends UpdateCompanion<Despesa> {
  final Value<int> id;
  final Value<String> nome;
  final Value<String> anexo;
  final Value<String> localizacao;
  final Value<String> observacao;
  final Value<bool> despesaFixa;
  final Value<bool> pago;
  final Value<bool> favorito;
  final Value<DateTime> data;
  final Value<DateTime> lembrete;
  final Value<int> categoriaId;
  final Value<int> contaId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const DespesasCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.anexo = const Value.absent(),
    this.localizacao = const Value.absent(),
    this.observacao = const Value.absent(),
    this.despesaFixa = const Value.absent(),
    this.pago = const Value.absent(),
    this.favorito = const Value.absent(),
    this.data = const Value.absent(),
    this.lembrete = const Value.absent(),
    this.categoriaId = const Value.absent(),
    this.contaId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DespesasCompanion.insert({
    this.id = const Value.absent(),
    @required String nome,
    @required String anexo,
    @required String localizacao,
    @required String observacao,
    this.despesaFixa = const Value.absent(),
    this.pago = const Value.absent(),
    this.favorito = const Value.absent(),
    @required DateTime data,
    @required DateTime lembrete,
    @required int categoriaId,
    @required int contaId,
    @required DateTime createdAt,
    @required DateTime updatedAt,
  })  : nome = Value(nome),
        anexo = Value(anexo),
        localizacao = Value(localizacao),
        observacao = Value(observacao),
        data = Value(data),
        lembrete = Value(lembrete),
        categoriaId = Value(categoriaId),
        contaId = Value(contaId),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  DespesasCompanion copyWith(
      {Value<int> id,
      Value<String> nome,
      Value<String> anexo,
      Value<String> localizacao,
      Value<String> observacao,
      Value<bool> despesaFixa,
      Value<bool> pago,
      Value<bool> favorito,
      Value<DateTime> data,
      Value<DateTime> lembrete,
      Value<int> categoriaId,
      Value<int> contaId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return DespesasCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      anexo: anexo ?? this.anexo,
      localizacao: localizacao ?? this.localizacao,
      observacao: observacao ?? this.observacao,
      despesaFixa: despesaFixa ?? this.despesaFixa,
      pago: pago ?? this.pago,
      favorito: favorito ?? this.favorito,
      data: data ?? this.data,
      lembrete: lembrete ?? this.lembrete,
      categoriaId: categoriaId ?? this.categoriaId,
      contaId: contaId ?? this.contaId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $DespesasTable extends Despesas with TableInfo<$DespesasTable, Despesa> {
  final GeneratedDatabase _db;
  final String _alias;
  $DespesasTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nomeMeta = const VerificationMeta('nome');
  GeneratedTextColumn _nome;
  @override
  GeneratedTextColumn get nome => _nome ??= _constructNome();
  GeneratedTextColumn _constructNome() {
    return GeneratedTextColumn(
      'nome',
      $tableName,
      false,
    );
  }

  final VerificationMeta _anexoMeta = const VerificationMeta('anexo');
  GeneratedTextColumn _anexo;
  @override
  GeneratedTextColumn get anexo => _anexo ??= _constructAnexo();
  GeneratedTextColumn _constructAnexo() {
    return GeneratedTextColumn(
      'anexo',
      $tableName,
      false,
    );
  }

  final VerificationMeta _localizacaoMeta =
      const VerificationMeta('localizacao');
  GeneratedTextColumn _localizacao;
  @override
  GeneratedTextColumn get localizacao =>
      _localizacao ??= _constructLocalizacao();
  GeneratedTextColumn _constructLocalizacao() {
    return GeneratedTextColumn(
      'localizacao',
      $tableName,
      false,
    );
  }

  final VerificationMeta _observacaoMeta = const VerificationMeta('observacao');
  GeneratedTextColumn _observacao;
  @override
  GeneratedTextColumn get observacao => _observacao ??= _constructObservacao();
  GeneratedTextColumn _constructObservacao() {
    return GeneratedTextColumn(
      'observacao',
      $tableName,
      false,
    );
  }

  final VerificationMeta _despesaFixaMeta =
      const VerificationMeta('despesaFixa');
  GeneratedBoolColumn _despesaFixa;
  @override
  GeneratedBoolColumn get despesaFixa =>
      _despesaFixa ??= _constructDespesaFixa();
  GeneratedBoolColumn _constructDespesaFixa() {
    return GeneratedBoolColumn('despesa_fixa', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _pagoMeta = const VerificationMeta('pago');
  GeneratedBoolColumn _pago;
  @override
  GeneratedBoolColumn get pago => _pago ??= _constructPago();
  GeneratedBoolColumn _constructPago() {
    return GeneratedBoolColumn('pago', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _favoritoMeta = const VerificationMeta('favorito');
  GeneratedBoolColumn _favorito;
  @override
  GeneratedBoolColumn get favorito => _favorito ??= _constructFavorito();
  GeneratedBoolColumn _constructFavorito() {
    return GeneratedBoolColumn('favorito', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _dataMeta = const VerificationMeta('data');
  GeneratedDateTimeColumn _data;
  @override
  GeneratedDateTimeColumn get data => _data ??= _constructData();
  GeneratedDateTimeColumn _constructData() {
    return GeneratedDateTimeColumn(
      'data',
      $tableName,
      false,
    );
  }

  final VerificationMeta _lembreteMeta = const VerificationMeta('lembrete');
  GeneratedDateTimeColumn _lembrete;
  @override
  GeneratedDateTimeColumn get lembrete => _lembrete ??= _constructLembrete();
  GeneratedDateTimeColumn _constructLembrete() {
    return GeneratedDateTimeColumn(
      'lembrete',
      $tableName,
      false,
    );
  }

  final VerificationMeta _categoriaIdMeta =
      const VerificationMeta('categoriaId');
  GeneratedIntColumn _categoriaId;
  @override
  GeneratedIntColumn get categoriaId =>
      _categoriaId ??= _constructCategoriaId();
  GeneratedIntColumn _constructCategoriaId() {
    return GeneratedIntColumn(
      'categoria_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _contaIdMeta = const VerificationMeta('contaId');
  GeneratedIntColumn _contaId;
  @override
  GeneratedIntColumn get contaId => _contaId ??= _constructContaId();
  GeneratedIntColumn _constructContaId() {
    return GeneratedIntColumn(
      'conta_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        nome,
        anexo,
        localizacao,
        observacao,
        despesaFixa,
        pago,
        favorito,
        data,
        lembrete,
        categoriaId,
        contaId,
        createdAt,
        updatedAt
      ];
  @override
  $DespesasTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'despesas';
  @override
  final String actualTableName = 'despesas';
  @override
  VerificationContext validateIntegrity(DespesasCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.nome.present) {
      context.handle(
          _nomeMeta, nome.isAcceptableValue(d.nome.value, _nomeMeta));
    } else if (nome.isRequired && isInserting) {
      context.missing(_nomeMeta);
    }
    if (d.anexo.present) {
      context.handle(
          _anexoMeta, anexo.isAcceptableValue(d.anexo.value, _anexoMeta));
    } else if (anexo.isRequired && isInserting) {
      context.missing(_anexoMeta);
    }
    if (d.localizacao.present) {
      context.handle(_localizacaoMeta,
          localizacao.isAcceptableValue(d.localizacao.value, _localizacaoMeta));
    } else if (localizacao.isRequired && isInserting) {
      context.missing(_localizacaoMeta);
    }
    if (d.observacao.present) {
      context.handle(_observacaoMeta,
          observacao.isAcceptableValue(d.observacao.value, _observacaoMeta));
    } else if (observacao.isRequired && isInserting) {
      context.missing(_observacaoMeta);
    }
    if (d.despesaFixa.present) {
      context.handle(_despesaFixaMeta,
          despesaFixa.isAcceptableValue(d.despesaFixa.value, _despesaFixaMeta));
    } else if (despesaFixa.isRequired && isInserting) {
      context.missing(_despesaFixaMeta);
    }
    if (d.pago.present) {
      context.handle(
          _pagoMeta, pago.isAcceptableValue(d.pago.value, _pagoMeta));
    } else if (pago.isRequired && isInserting) {
      context.missing(_pagoMeta);
    }
    if (d.favorito.present) {
      context.handle(_favoritoMeta,
          favorito.isAcceptableValue(d.favorito.value, _favoritoMeta));
    } else if (favorito.isRequired && isInserting) {
      context.missing(_favoritoMeta);
    }
    if (d.data.present) {
      context.handle(
          _dataMeta, data.isAcceptableValue(d.data.value, _dataMeta));
    } else if (data.isRequired && isInserting) {
      context.missing(_dataMeta);
    }
    if (d.lembrete.present) {
      context.handle(_lembreteMeta,
          lembrete.isAcceptableValue(d.lembrete.value, _lembreteMeta));
    } else if (lembrete.isRequired && isInserting) {
      context.missing(_lembreteMeta);
    }
    if (d.categoriaId.present) {
      context.handle(_categoriaIdMeta,
          categoriaId.isAcceptableValue(d.categoriaId.value, _categoriaIdMeta));
    } else if (categoriaId.isRequired && isInserting) {
      context.missing(_categoriaIdMeta);
    }
    if (d.contaId.present) {
      context.handle(_contaIdMeta,
          contaId.isAcceptableValue(d.contaId.value, _contaIdMeta));
    } else if (contaId.isRequired && isInserting) {
      context.missing(_contaIdMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Despesa map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Despesa.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(DespesasCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.nome.present) {
      map['nome'] = Variable<String, StringType>(d.nome.value);
    }
    if (d.anexo.present) {
      map['anexo'] = Variable<String, StringType>(d.anexo.value);
    }
    if (d.localizacao.present) {
      map['localizacao'] = Variable<String, StringType>(d.localizacao.value);
    }
    if (d.observacao.present) {
      map['observacao'] = Variable<String, StringType>(d.observacao.value);
    }
    if (d.despesaFixa.present) {
      map['despesa_fixa'] = Variable<bool, BoolType>(d.despesaFixa.value);
    }
    if (d.pago.present) {
      map['pago'] = Variable<bool, BoolType>(d.pago.value);
    }
    if (d.favorito.present) {
      map['favorito'] = Variable<bool, BoolType>(d.favorito.value);
    }
    if (d.data.present) {
      map['data'] = Variable<DateTime, DateTimeType>(d.data.value);
    }
    if (d.lembrete.present) {
      map['lembrete'] = Variable<DateTime, DateTimeType>(d.lembrete.value);
    }
    if (d.categoriaId.present) {
      map['categoria_id'] = Variable<int, IntType>(d.categoriaId.value);
    }
    if (d.contaId.present) {
      map['conta_id'] = Variable<int, IntType>(d.contaId.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $DespesasTable createAlias(String alias) {
    return $DespesasTable(_db, alias);
  }
}

class Categoria extends DataClass implements Insertable<Categoria> {
  final int id;
  final String nome;
  final String icone;
  final String cor;
  final String tipo;
  final DateTime createdAt;
  final DateTime updatedAt;
  Categoria(
      {@required this.id,
      @required this.nome,
      @required this.icone,
      @required this.cor,
      @required this.tipo,
      @required this.createdAt,
      @required this.updatedAt});
  factory Categoria.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Categoria(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      nome: stringType.mapFromDatabaseResponse(data['${effectivePrefix}nome']),
      icone:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}icone']),
      cor: stringType.mapFromDatabaseResponse(data['${effectivePrefix}cor']),
      tipo: stringType.mapFromDatabaseResponse(data['${effectivePrefix}tipo']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory Categoria.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Categoria(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      icone: serializer.fromJson<String>(json['icone']),
      cor: serializer.fromJson<String>(json['cor']),
      tipo: serializer.fromJson<String>(json['tipo']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
      'icone': serializer.toJson<String>(icone),
      'cor': serializer.toJson<String>(cor),
      'tipo': serializer.toJson<String>(tipo),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  CategoriasCompanion createCompanion(bool nullToAbsent) {
    return CategoriasCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      nome: nome == null && nullToAbsent ? const Value.absent() : Value(nome),
      icone:
          icone == null && nullToAbsent ? const Value.absent() : Value(icone),
      cor: cor == null && nullToAbsent ? const Value.absent() : Value(cor),
      tipo: tipo == null && nullToAbsent ? const Value.absent() : Value(tipo),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  Categoria copyWith(
          {int id,
          String nome,
          String icone,
          String cor,
          String tipo,
          DateTime createdAt,
          DateTime updatedAt}) =>
      Categoria(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        icone: icone ?? this.icone,
        cor: cor ?? this.cor,
        tipo: tipo ?? this.tipo,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Categoria(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('icone: $icone, ')
          ..write('cor: $cor, ')
          ..write('tipo: $tipo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          nome.hashCode,
          $mrjc(
              icone.hashCode,
              $mrjc(
                  cor.hashCode,
                  $mrjc(tipo.hashCode,
                      $mrjc(createdAt.hashCode, updatedAt.hashCode)))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Categoria &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.icone == this.icone &&
          other.cor == this.cor &&
          other.tipo == this.tipo &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CategoriasCompanion extends UpdateCompanion<Categoria> {
  final Value<int> id;
  final Value<String> nome;
  final Value<String> icone;
  final Value<String> cor;
  final Value<String> tipo;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CategoriasCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.icone = const Value.absent(),
    this.cor = const Value.absent(),
    this.tipo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CategoriasCompanion.insert({
    this.id = const Value.absent(),
    @required String nome,
    @required String icone,
    @required String cor,
    @required String tipo,
    @required DateTime createdAt,
    @required DateTime updatedAt,
  })  : nome = Value(nome),
        icone = Value(icone),
        cor = Value(cor),
        tipo = Value(tipo),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  CategoriasCompanion copyWith(
      {Value<int> id,
      Value<String> nome,
      Value<String> icone,
      Value<String> cor,
      Value<String> tipo,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return CategoriasCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      icone: icone ?? this.icone,
      cor: cor ?? this.cor,
      tipo: tipo ?? this.tipo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $CategoriasTable extends Categorias
    with TableInfo<$CategoriasTable, Categoria> {
  final GeneratedDatabase _db;
  final String _alias;
  $CategoriasTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nomeMeta = const VerificationMeta('nome');
  GeneratedTextColumn _nome;
  @override
  GeneratedTextColumn get nome => _nome ??= _constructNome();
  GeneratedTextColumn _constructNome() {
    return GeneratedTextColumn(
      'nome',
      $tableName,
      false,
    );
  }

  final VerificationMeta _iconeMeta = const VerificationMeta('icone');
  GeneratedTextColumn _icone;
  @override
  GeneratedTextColumn get icone => _icone ??= _constructIcone();
  GeneratedTextColumn _constructIcone() {
    return GeneratedTextColumn(
      'icone',
      $tableName,
      false,
    );
  }

  final VerificationMeta _corMeta = const VerificationMeta('cor');
  GeneratedTextColumn _cor;
  @override
  GeneratedTextColumn get cor => _cor ??= _constructCor();
  GeneratedTextColumn _constructCor() {
    return GeneratedTextColumn(
      'cor',
      $tableName,
      false,
    );
  }

  final VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  GeneratedTextColumn _tipo;
  @override
  GeneratedTextColumn get tipo => _tipo ??= _constructTipo();
  GeneratedTextColumn _constructTipo() {
    return GeneratedTextColumn(
      'tipo',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, nome, icone, cor, tipo, createdAt, updatedAt];
  @override
  $CategoriasTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'categorias';
  @override
  final String actualTableName = 'categorias';
  @override
  VerificationContext validateIntegrity(CategoriasCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.nome.present) {
      context.handle(
          _nomeMeta, nome.isAcceptableValue(d.nome.value, _nomeMeta));
    } else if (nome.isRequired && isInserting) {
      context.missing(_nomeMeta);
    }
    if (d.icone.present) {
      context.handle(
          _iconeMeta, icone.isAcceptableValue(d.icone.value, _iconeMeta));
    } else if (icone.isRequired && isInserting) {
      context.missing(_iconeMeta);
    }
    if (d.cor.present) {
      context.handle(_corMeta, cor.isAcceptableValue(d.cor.value, _corMeta));
    } else if (cor.isRequired && isInserting) {
      context.missing(_corMeta);
    }
    if (d.tipo.present) {
      context.handle(
          _tipoMeta, tipo.isAcceptableValue(d.tipo.value, _tipoMeta));
    } else if (tipo.isRequired && isInserting) {
      context.missing(_tipoMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Categoria map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Categoria.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(CategoriasCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.nome.present) {
      map['nome'] = Variable<String, StringType>(d.nome.value);
    }
    if (d.icone.present) {
      map['icone'] = Variable<String, StringType>(d.icone.value);
    }
    if (d.cor.present) {
      map['cor'] = Variable<String, StringType>(d.cor.value);
    }
    if (d.tipo.present) {
      map['tipo'] = Variable<String, StringType>(d.tipo.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $CategoriasTable createAlias(String alias) {
    return $CategoriasTable(_db, alias);
  }
}

class Subcategoria extends DataClass implements Insertable<Subcategoria> {
  final int id;
  final String nome;
  final int categoriaId;
  final DateTime createdAt;
  final DateTime updatedAt;
  Subcategoria(
      {@required this.id,
      @required this.nome,
      @required this.categoriaId,
      @required this.createdAt,
      @required this.updatedAt});
  factory Subcategoria.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Subcategoria(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      nome: stringType.mapFromDatabaseResponse(data['${effectivePrefix}nome']),
      categoriaId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}categoria_id']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory Subcategoria.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Subcategoria(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      categoriaId: serializer.fromJson<int>(json['categoriaId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
      'categoriaId': serializer.toJson<int>(categoriaId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  SubcategoriasCompanion createCompanion(bool nullToAbsent) {
    return SubcategoriasCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      nome: nome == null && nullToAbsent ? const Value.absent() : Value(nome),
      categoriaId: categoriaId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoriaId),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  Subcategoria copyWith(
          {int id,
          String nome,
          int categoriaId,
          DateTime createdAt,
          DateTime updatedAt}) =>
      Subcategoria(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        categoriaId: categoriaId ?? this.categoriaId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Subcategoria(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('categoriaId: $categoriaId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          nome.hashCode,
          $mrjc(categoriaId.hashCode,
              $mrjc(createdAt.hashCode, updatedAt.hashCode)))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Subcategoria &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.categoriaId == this.categoriaId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SubcategoriasCompanion extends UpdateCompanion<Subcategoria> {
  final Value<int> id;
  final Value<String> nome;
  final Value<int> categoriaId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SubcategoriasCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.categoriaId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SubcategoriasCompanion.insert({
    this.id = const Value.absent(),
    @required String nome,
    @required int categoriaId,
    @required DateTime createdAt,
    @required DateTime updatedAt,
  })  : nome = Value(nome),
        categoriaId = Value(categoriaId),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  SubcategoriasCompanion copyWith(
      {Value<int> id,
      Value<String> nome,
      Value<int> categoriaId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return SubcategoriasCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      categoriaId: categoriaId ?? this.categoriaId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $SubcategoriasTable extends Subcategorias
    with TableInfo<$SubcategoriasTable, Subcategoria> {
  final GeneratedDatabase _db;
  final String _alias;
  $SubcategoriasTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nomeMeta = const VerificationMeta('nome');
  GeneratedTextColumn _nome;
  @override
  GeneratedTextColumn get nome => _nome ??= _constructNome();
  GeneratedTextColumn _constructNome() {
    return GeneratedTextColumn(
      'nome',
      $tableName,
      false,
    );
  }

  final VerificationMeta _categoriaIdMeta =
      const VerificationMeta('categoriaId');
  GeneratedIntColumn _categoriaId;
  @override
  GeneratedIntColumn get categoriaId =>
      _categoriaId ??= _constructCategoriaId();
  GeneratedIntColumn _constructCategoriaId() {
    return GeneratedIntColumn(
      'categoria_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, nome, categoriaId, createdAt, updatedAt];
  @override
  $SubcategoriasTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'subcategorias';
  @override
  final String actualTableName = 'subcategorias';
  @override
  VerificationContext validateIntegrity(SubcategoriasCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.nome.present) {
      context.handle(
          _nomeMeta, nome.isAcceptableValue(d.nome.value, _nomeMeta));
    } else if (nome.isRequired && isInserting) {
      context.missing(_nomeMeta);
    }
    if (d.categoriaId.present) {
      context.handle(_categoriaIdMeta,
          categoriaId.isAcceptableValue(d.categoriaId.value, _categoriaIdMeta));
    } else if (categoriaId.isRequired && isInserting) {
      context.missing(_categoriaIdMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subcategoria map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Subcategoria.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(SubcategoriasCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.nome.present) {
      map['nome'] = Variable<String, StringType>(d.nome.value);
    }
    if (d.categoriaId.present) {
      map['categoria_id'] = Variable<int, IntType>(d.categoriaId.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $SubcategoriasTable createAlias(String alias) {
    return $SubcategoriasTable(_db, alias);
  }
}

class Conta extends DataClass implements Insertable<Conta> {
  final int id;
  final String nome;
  final String tipo;
  final String cor;
  final bool incluirSomaTelaInicial;
  final DateTime createdAt;
  final DateTime updatedAt;
  Conta(
      {@required this.id,
      @required this.nome,
      @required this.tipo,
      @required this.cor,
      @required this.incluirSomaTelaInicial,
      @required this.createdAt,
      @required this.updatedAt});
  factory Conta.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Conta(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      nome: stringType.mapFromDatabaseResponse(data['${effectivePrefix}nome']),
      tipo: stringType.mapFromDatabaseResponse(data['${effectivePrefix}tipo']),
      cor: stringType.mapFromDatabaseResponse(data['${effectivePrefix}cor']),
      incluirSomaTelaInicial: boolType.mapFromDatabaseResponse(
          data['${effectivePrefix}incluir_soma_tela_inicial']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory Conta.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Conta(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      tipo: serializer.fromJson<String>(json['tipo']),
      cor: serializer.fromJson<String>(json['cor']),
      incluirSomaTelaInicial:
          serializer.fromJson<bool>(json['incluirSomaTelaInicial']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
      'tipo': serializer.toJson<String>(tipo),
      'cor': serializer.toJson<String>(cor),
      'incluirSomaTelaInicial': serializer.toJson<bool>(incluirSomaTelaInicial),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  ContasCompanion createCompanion(bool nullToAbsent) {
    return ContasCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      nome: nome == null && nullToAbsent ? const Value.absent() : Value(nome),
      tipo: tipo == null && nullToAbsent ? const Value.absent() : Value(tipo),
      cor: cor == null && nullToAbsent ? const Value.absent() : Value(cor),
      incluirSomaTelaInicial: incluirSomaTelaInicial == null && nullToAbsent
          ? const Value.absent()
          : Value(incluirSomaTelaInicial),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  Conta copyWith(
          {int id,
          String nome,
          String tipo,
          String cor,
          bool incluirSomaTelaInicial,
          DateTime createdAt,
          DateTime updatedAt}) =>
      Conta(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        tipo: tipo ?? this.tipo,
        cor: cor ?? this.cor,
        incluirSomaTelaInicial:
            incluirSomaTelaInicial ?? this.incluirSomaTelaInicial,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Conta(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('tipo: $tipo, ')
          ..write('cor: $cor, ')
          ..write('incluirSomaTelaInicial: $incluirSomaTelaInicial, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          nome.hashCode,
          $mrjc(
              tipo.hashCode,
              $mrjc(
                  cor.hashCode,
                  $mrjc(incluirSomaTelaInicial.hashCode,
                      $mrjc(createdAt.hashCode, updatedAt.hashCode)))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Conta &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.tipo == this.tipo &&
          other.cor == this.cor &&
          other.incluirSomaTelaInicial == this.incluirSomaTelaInicial &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ContasCompanion extends UpdateCompanion<Conta> {
  final Value<int> id;
  final Value<String> nome;
  final Value<String> tipo;
  final Value<String> cor;
  final Value<bool> incluirSomaTelaInicial;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ContasCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.tipo = const Value.absent(),
    this.cor = const Value.absent(),
    this.incluirSomaTelaInicial = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ContasCompanion.insert({
    this.id = const Value.absent(),
    @required String nome,
    @required String tipo,
    @required String cor,
    this.incluirSomaTelaInicial = const Value.absent(),
    @required DateTime createdAt,
    @required DateTime updatedAt,
  })  : nome = Value(nome),
        tipo = Value(tipo),
        cor = Value(cor),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  ContasCompanion copyWith(
      {Value<int> id,
      Value<String> nome,
      Value<String> tipo,
      Value<String> cor,
      Value<bool> incluirSomaTelaInicial,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return ContasCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      tipo: tipo ?? this.tipo,
      cor: cor ?? this.cor,
      incluirSomaTelaInicial:
          incluirSomaTelaInicial ?? this.incluirSomaTelaInicial,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $ContasTable extends Contas with TableInfo<$ContasTable, Conta> {
  final GeneratedDatabase _db;
  final String _alias;
  $ContasTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nomeMeta = const VerificationMeta('nome');
  GeneratedTextColumn _nome;
  @override
  GeneratedTextColumn get nome => _nome ??= _constructNome();
  GeneratedTextColumn _constructNome() {
    return GeneratedTextColumn(
      'nome',
      $tableName,
      false,
    );
  }

  final VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  GeneratedTextColumn _tipo;
  @override
  GeneratedTextColumn get tipo => _tipo ??= _constructTipo();
  GeneratedTextColumn _constructTipo() {
    return GeneratedTextColumn(
      'tipo',
      $tableName,
      false,
    );
  }

  final VerificationMeta _corMeta = const VerificationMeta('cor');
  GeneratedTextColumn _cor;
  @override
  GeneratedTextColumn get cor => _cor ??= _constructCor();
  GeneratedTextColumn _constructCor() {
    return GeneratedTextColumn(
      'cor',
      $tableName,
      false,
    );
  }

  final VerificationMeta _incluirSomaTelaInicialMeta =
      const VerificationMeta('incluirSomaTelaInicial');
  GeneratedBoolColumn _incluirSomaTelaInicial;
  @override
  GeneratedBoolColumn get incluirSomaTelaInicial =>
      _incluirSomaTelaInicial ??= _constructIncluirSomaTelaInicial();
  GeneratedBoolColumn _constructIncluirSomaTelaInicial() {
    return GeneratedBoolColumn('incluir_soma_tela_inicial', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, nome, tipo, cor, incluirSomaTelaInicial, createdAt, updatedAt];
  @override
  $ContasTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'contas';
  @override
  final String actualTableName = 'contas';
  @override
  VerificationContext validateIntegrity(ContasCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.nome.present) {
      context.handle(
          _nomeMeta, nome.isAcceptableValue(d.nome.value, _nomeMeta));
    } else if (nome.isRequired && isInserting) {
      context.missing(_nomeMeta);
    }
    if (d.tipo.present) {
      context.handle(
          _tipoMeta, tipo.isAcceptableValue(d.tipo.value, _tipoMeta));
    } else if (tipo.isRequired && isInserting) {
      context.missing(_tipoMeta);
    }
    if (d.cor.present) {
      context.handle(_corMeta, cor.isAcceptableValue(d.cor.value, _corMeta));
    } else if (cor.isRequired && isInserting) {
      context.missing(_corMeta);
    }
    if (d.incluirSomaTelaInicial.present) {
      context.handle(
          _incluirSomaTelaInicialMeta,
          incluirSomaTelaInicial.isAcceptableValue(
              d.incluirSomaTelaInicial.value, _incluirSomaTelaInicialMeta));
    } else if (incluirSomaTelaInicial.isRequired && isInserting) {
      context.missing(_incluirSomaTelaInicialMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Conta map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Conta.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ContasCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.nome.present) {
      map['nome'] = Variable<String, StringType>(d.nome.value);
    }
    if (d.tipo.present) {
      map['tipo'] = Variable<String, StringType>(d.tipo.value);
    }
    if (d.cor.present) {
      map['cor'] = Variable<String, StringType>(d.cor.value);
    }
    if (d.incluirSomaTelaInicial.present) {
      map['incluir_soma_tela_inicial'] =
          Variable<bool, BoolType>(d.incluirSomaTelaInicial.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $ContasTable createAlias(String alias) {
    return $ContasTable(_db, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final int id;
  final String nome;
  final int despesaId;
  final int receitaId;
  final DateTime createdAt;
  final DateTime updatedAt;
  Tag(
      {@required this.id,
      @required this.nome,
      @required this.despesaId,
      @required this.receitaId,
      @required this.createdAt,
      @required this.updatedAt});
  factory Tag.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Tag(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      nome: stringType.mapFromDatabaseResponse(data['${effectivePrefix}nome']),
      despesaId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}despesa_id']),
      receitaId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}receita_id']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory Tag.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Tag(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      despesaId: serializer.fromJson<int>(json['despesaId']),
      receitaId: serializer.fromJson<int>(json['receitaId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
      'despesaId': serializer.toJson<int>(despesaId),
      'receitaId': serializer.toJson<int>(receitaId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  TagsCompanion createCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      nome: nome == null && nullToAbsent ? const Value.absent() : Value(nome),
      despesaId: despesaId == null && nullToAbsent
          ? const Value.absent()
          : Value(despesaId),
      receitaId: receitaId == null && nullToAbsent
          ? const Value.absent()
          : Value(receitaId),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  Tag copyWith(
          {int id,
          String nome,
          int despesaId,
          int receitaId,
          DateTime createdAt,
          DateTime updatedAt}) =>
      Tag(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        despesaId: despesaId ?? this.despesaId,
        receitaId: receitaId ?? this.receitaId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('despesaId: $despesaId, ')
          ..write('receitaId: $receitaId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          nome.hashCode,
          $mrjc(
              despesaId.hashCode,
              $mrjc(receitaId.hashCode,
                  $mrjc(createdAt.hashCode, updatedAt.hashCode))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.despesaId == this.despesaId &&
          other.receitaId == this.receitaId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<int> id;
  final Value<String> nome;
  final Value<int> despesaId;
  final Value<int> receitaId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.despesaId = const Value.absent(),
    this.receitaId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TagsCompanion.insert({
    this.id = const Value.absent(),
    @required String nome,
    @required int despesaId,
    @required int receitaId,
    @required DateTime createdAt,
    @required DateTime updatedAt,
  })  : nome = Value(nome),
        despesaId = Value(despesaId),
        receitaId = Value(receitaId),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  TagsCompanion copyWith(
      {Value<int> id,
      Value<String> nome,
      Value<int> despesaId,
      Value<int> receitaId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return TagsCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      despesaId: despesaId ?? this.despesaId,
      receitaId: receitaId ?? this.receitaId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  final GeneratedDatabase _db;
  final String _alias;
  $TagsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nomeMeta = const VerificationMeta('nome');
  GeneratedTextColumn _nome;
  @override
  GeneratedTextColumn get nome => _nome ??= _constructNome();
  GeneratedTextColumn _constructNome() {
    return GeneratedTextColumn(
      'nome',
      $tableName,
      false,
    );
  }

  final VerificationMeta _despesaIdMeta = const VerificationMeta('despesaId');
  GeneratedIntColumn _despesaId;
  @override
  GeneratedIntColumn get despesaId => _despesaId ??= _constructDespesaId();
  GeneratedIntColumn _constructDespesaId() {
    return GeneratedIntColumn(
      'despesa_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _receitaIdMeta = const VerificationMeta('receitaId');
  GeneratedIntColumn _receitaId;
  @override
  GeneratedIntColumn get receitaId => _receitaId ??= _constructReceitaId();
  GeneratedIntColumn _constructReceitaId() {
    return GeneratedIntColumn(
      'receita_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, nome, despesaId, receitaId, createdAt, updatedAt];
  @override
  $TagsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tags';
  @override
  final String actualTableName = 'tags';
  @override
  VerificationContext validateIntegrity(TagsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.nome.present) {
      context.handle(
          _nomeMeta, nome.isAcceptableValue(d.nome.value, _nomeMeta));
    } else if (nome.isRequired && isInserting) {
      context.missing(_nomeMeta);
    }
    if (d.despesaId.present) {
      context.handle(_despesaIdMeta,
          despesaId.isAcceptableValue(d.despesaId.value, _despesaIdMeta));
    } else if (despesaId.isRequired && isInserting) {
      context.missing(_despesaIdMeta);
    }
    if (d.receitaId.present) {
      context.handle(_receitaIdMeta,
          receitaId.isAcceptableValue(d.receitaId.value, _receitaIdMeta));
    } else if (receitaId.isRequired && isInserting) {
      context.missing(_receitaIdMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Tag.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TagsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.nome.present) {
      map['nome'] = Variable<String, StringType>(d.nome.value);
    }
    if (d.despesaId.present) {
      map['despesa_id'] = Variable<int, IntType>(d.despesaId.value);
    }
    if (d.receitaId.present) {
      map['receita_id'] = Variable<int, IntType>(d.receitaId.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(_db, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $DespesasTable _despesas;
  $DespesasTable get despesas => _despesas ??= $DespesasTable(this);
  $CategoriasTable _categorias;
  $CategoriasTable get categorias => _categorias ??= $CategoriasTable(this);
  $SubcategoriasTable _subcategorias;
  $SubcategoriasTable get subcategorias =>
      _subcategorias ??= $SubcategoriasTable(this);
  $ContasTable _contas;
  $ContasTable get contas => _contas ??= $ContasTable(this);
  $TagsTable _tags;
  $TagsTable get tags => _tags ??= $TagsTable(this);
  TagDao _tagDao;
  TagDao get tagDao => _tagDao ??= TagDao(this as Database);
  @override
  List<TableInfo> get allTables =>
      [despesas, categorias, subcategorias, contas, tags];
}
