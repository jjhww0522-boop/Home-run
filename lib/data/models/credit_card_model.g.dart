// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCreditCardModelCollection on Isar {
  IsarCollection<CreditCardModel> get creditCardModels => this.collection();
}

const CreditCardModelSchema = CollectionSchema(
  name: r'CreditCardModel',
  id: 5536749382818049299,
  properties: {
    r'achievementColorCode': PropertySchema(
      id: 0,
      name: r'achievementColorCode',
      type: IsarType.long,
    ),
    r'achievementRate': PropertySchema(
      id: 1,
      name: r'achievementRate',
      type: IsarType.double,
    ),
    r'achievementStatus': PropertySchema(
      id: 2,
      name: r'achievementStatus',
      type: IsarType.string,
    ),
    r'annualFee': PropertySchema(
      id: 3,
      name: r'annualFee',
      type: IsarType.long,
    ),
    r'billingCycleStartDay': PropertySchema(
      id: 4,
      name: r'billingCycleStartDay',
      type: IsarType.long,
    ),
    r'cardNumber': PropertySchema(
      id: 5,
      name: r'cardNumber',
      type: IsarType.string,
    ),
    r'cardType': PropertySchema(
      id: 6,
      name: r'cardType',
      type: IsarType.string,
      enumMap: _CreditCardModelcardTypeEnumValueMap,
    ),
    r'createdAt': PropertySchema(
      id: 7,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'currentUsage': PropertySchema(
      id: 8,
      name: r'currentUsage',
      type: IsarType.long,
    ),
    r'daysUntilPayment': PropertySchema(
      id: 9,
      name: r'daysUntilPayment',
      type: IsarType.long,
    ),
    r'isActive': PropertySchema(
      id: 10,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'isTargetAchieved': PropertySchema(
      id: 11,
      name: r'isTargetAchieved',
      type: IsarType.bool,
    ),
    r'issuer': PropertySchema(
      id: 12,
      name: r'issuer',
      type: IsarType.string,
    ),
    r'linkedAccountId': PropertySchema(
      id: 13,
      name: r'linkedAccountId',
      type: IsarType.string,
    ),
    r'memo': PropertySchema(
      id: 14,
      name: r'memo',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 15,
      name: r'name',
      type: IsarType.string,
    ),
    r'nextPaymentDate': PropertySchema(
      id: 16,
      name: r'nextPaymentDate',
      type: IsarType.dateTime,
    ),
    r'paymentDay': PropertySchema(
      id: 17,
      name: r'paymentDay',
      type: IsarType.long,
    ),
    r'remainingToTarget': PropertySchema(
      id: 18,
      name: r'remainingToTarget',
      type: IsarType.long,
    ),
    r'sortOrder': PropertySchema(
      id: 19,
      name: r'sortOrder',
      type: IsarType.long,
    ),
    r'targetAmount': PropertySchema(
      id: 20,
      name: r'targetAmount',
      type: IsarType.long,
    ),
    r'uid': PropertySchema(
      id: 21,
      name: r'uid',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 22,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _creditCardModelEstimateSize,
  serialize: _creditCardModelSerialize,
  deserialize: _creditCardModelDeserialize,
  deserializeProp: _creditCardModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'uid': IndexSchema(
      id: 8193695471701937315,
      name: r'uid',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'uid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _creditCardModelGetId,
  getLinks: _creditCardModelGetLinks,
  attach: _creditCardModelAttach,
  version: '3.1.0+1',
);

int _creditCardModelEstimateSize(
  CreditCardModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.achievementStatus.length * 3;
  {
    final value = object.cardNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.cardType.name.length * 3;
  bytesCount += 3 + object.issuer.length * 3;
  {
    final value = object.linkedAccountId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.memo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.uid.length * 3;
  return bytesCount;
}

void _creditCardModelSerialize(
  CreditCardModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.achievementColorCode);
  writer.writeDouble(offsets[1], object.achievementRate);
  writer.writeString(offsets[2], object.achievementStatus);
  writer.writeLong(offsets[3], object.annualFee);
  writer.writeLong(offsets[4], object.billingCycleStartDay);
  writer.writeString(offsets[5], object.cardNumber);
  writer.writeString(offsets[6], object.cardType.name);
  writer.writeDateTime(offsets[7], object.createdAt);
  writer.writeLong(offsets[8], object.currentUsage);
  writer.writeLong(offsets[9], object.daysUntilPayment);
  writer.writeBool(offsets[10], object.isActive);
  writer.writeBool(offsets[11], object.isTargetAchieved);
  writer.writeString(offsets[12], object.issuer);
  writer.writeString(offsets[13], object.linkedAccountId);
  writer.writeString(offsets[14], object.memo);
  writer.writeString(offsets[15], object.name);
  writer.writeDateTime(offsets[16], object.nextPaymentDate);
  writer.writeLong(offsets[17], object.paymentDay);
  writer.writeLong(offsets[18], object.remainingToTarget);
  writer.writeLong(offsets[19], object.sortOrder);
  writer.writeLong(offsets[20], object.targetAmount);
  writer.writeString(offsets[21], object.uid);
  writer.writeDateTime(offsets[22], object.updatedAt);
}

CreditCardModel _creditCardModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CreditCardModel();
  object.annualFee = reader.readLongOrNull(offsets[3]);
  object.billingCycleStartDay = reader.readLongOrNull(offsets[4]);
  object.cardNumber = reader.readStringOrNull(offsets[5]);
  object.cardType = _CreditCardModelcardTypeValueEnumMap[
          reader.readStringOrNull(offsets[6])] ??
      CardType.credit;
  object.createdAt = reader.readDateTime(offsets[7]);
  object.currentUsage = reader.readLong(offsets[8]);
  object.id = id;
  object.isActive = reader.readBool(offsets[10]);
  object.issuer = reader.readString(offsets[12]);
  object.linkedAccountId = reader.readStringOrNull(offsets[13]);
  object.memo = reader.readStringOrNull(offsets[14]);
  object.name = reader.readString(offsets[15]);
  object.paymentDay = reader.readLong(offsets[17]);
  object.sortOrder = reader.readLong(offsets[19]);
  object.targetAmount = reader.readLong(offsets[20]);
  object.uid = reader.readString(offsets[21]);
  object.updatedAt = reader.readDateTime(offsets[22]);
  return object;
}

P _creditCardModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (_CreditCardModelcardTypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          CardType.credit) as P;
    case 7:
      return (reader.readDateTime(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readBool(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readDateTime(offset)) as P;
    case 17:
      return (reader.readLong(offset)) as P;
    case 18:
      return (reader.readLong(offset)) as P;
    case 19:
      return (reader.readLong(offset)) as P;
    case 20:
      return (reader.readLong(offset)) as P;
    case 21:
      return (reader.readString(offset)) as P;
    case 22:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CreditCardModelcardTypeEnumValueMap = {
  r'credit': r'credit',
  r'check': r'check',
  r'localCurrency': r'localCurrency',
};
const _CreditCardModelcardTypeValueEnumMap = {
  r'credit': CardType.credit,
  r'check': CardType.check,
  r'localCurrency': CardType.localCurrency,
};

Id _creditCardModelGetId(CreditCardModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _creditCardModelGetLinks(CreditCardModel object) {
  return [];
}

void _creditCardModelAttach(
    IsarCollection<dynamic> col, Id id, CreditCardModel object) {
  object.id = id;
}

extension CreditCardModelByIndex on IsarCollection<CreditCardModel> {
  Future<CreditCardModel?> getByUid(String uid) {
    return getByIndex(r'uid', [uid]);
  }

  CreditCardModel? getByUidSync(String uid) {
    return getByIndexSync(r'uid', [uid]);
  }

  Future<bool> deleteByUid(String uid) {
    return deleteByIndex(r'uid', [uid]);
  }

  bool deleteByUidSync(String uid) {
    return deleteByIndexSync(r'uid', [uid]);
  }

  Future<List<CreditCardModel?>> getAllByUid(List<String> uidValues) {
    final values = uidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uid', values);
  }

  List<CreditCardModel?> getAllByUidSync(List<String> uidValues) {
    final values = uidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'uid', values);
  }

  Future<int> deleteAllByUid(List<String> uidValues) {
    final values = uidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'uid', values);
  }

  int deleteAllByUidSync(List<String> uidValues) {
    final values = uidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'uid', values);
  }

  Future<Id> putByUid(CreditCardModel object) {
    return putByIndex(r'uid', object);
  }

  Id putByUidSync(CreditCardModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'uid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUid(List<CreditCardModel> objects) {
    return putAllByIndex(r'uid', objects);
  }

  List<Id> putAllByUidSync(List<CreditCardModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uid', objects, saveLinks: saveLinks);
  }
}

extension CreditCardModelQueryWhereSort
    on QueryBuilder<CreditCardModel, CreditCardModel, QWhere> {
  QueryBuilder<CreditCardModel, CreditCardModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CreditCardModelQueryWhere
    on QueryBuilder<CreditCardModel, CreditCardModel, QWhereClause> {
  QueryBuilder<CreditCardModel, CreditCardModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterWhereClause> uidEqualTo(
      String uid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uid',
        value: [uid],
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterWhereClause>
      uidNotEqualTo(String uid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uid',
              lower: [],
              upper: [uid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uid',
              lower: [uid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uid',
              lower: [uid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uid',
              lower: [],
              upper: [uid],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CreditCardModelQueryFilter
    on QueryBuilder<CreditCardModel, CreditCardModel, QFilterCondition> {
  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      achievementColorCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'achievementColorCode',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      achievementColorCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'achievementColorCode',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      achievementColorCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'achievementColorCode',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      achievementColorCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'achievementColorCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      achievementRateEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'achievementRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      achievementRateGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'achievementRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      achievementRateLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'achievementRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      achievementRateBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'achievementRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      achievementStatusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'achievementStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      achievementStatusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'achievementStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      achievementStatusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'achievementStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      achievementStatusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'achievementStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      achievementStatusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'achievementStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      achievementStatusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'achievementStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      achievementStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'achievementStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      achievementStatusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'achievementStatus',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      achievementStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'achievementStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      achievementStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'achievementStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      annualFeeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'annualFee',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      annualFeeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'annualFee',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      annualFeeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'annualFee',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      annualFeeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'annualFee',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      annualFeeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'annualFee',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      annualFeeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'annualFee',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      billingCycleStartDayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'billingCycleStartDay',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      billingCycleStartDayIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'billingCycleStartDay',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      billingCycleStartDayEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'billingCycleStartDay',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      billingCycleStartDayGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'billingCycleStartDay',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      billingCycleStartDayLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'billingCycleStartDay',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      billingCycleStartDayBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'billingCycleStartDay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      cardNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cardNumber',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      cardNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cardNumber',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      cardNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cardNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      cardNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cardNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      cardNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cardNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      cardNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cardNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      cardNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cardNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      cardNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cardNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      cardNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cardNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      cardNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cardNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      cardNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cardNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      cardNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cardNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      cardTypeEqualTo(
    CardType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cardType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      cardTypeGreaterThan(
    CardType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cardType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      cardTypeLessThan(
    CardType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cardType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      cardTypeBetween(
    CardType lower,
    CardType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cardType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      cardTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cardType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      cardTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cardType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      cardTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cardType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      cardTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cardType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      cardTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cardType',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      cardTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cardType',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      currentUsageEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentUsage',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      currentUsageGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentUsage',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      currentUsageLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentUsage',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      currentUsageBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentUsage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      daysUntilPaymentEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'daysUntilPayment',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      daysUntilPaymentGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'daysUntilPayment',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      daysUntilPaymentLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'daysUntilPayment',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      daysUntilPaymentBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'daysUntilPayment',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      isActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      isTargetAchievedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isTargetAchieved',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      issuerEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'issuer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      issuerGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'issuer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      issuerLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'issuer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      issuerBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'issuer',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      issuerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'issuer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      issuerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'issuer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      issuerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'issuer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      issuerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'issuer',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      issuerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'issuer',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      issuerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'issuer',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      linkedAccountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'linkedAccountId',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      linkedAccountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'linkedAccountId',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      linkedAccountIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'linkedAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      linkedAccountIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'linkedAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      linkedAccountIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'linkedAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      linkedAccountIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'linkedAccountId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      linkedAccountIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'linkedAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      linkedAccountIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'linkedAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      linkedAccountIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'linkedAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      linkedAccountIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'linkedAccountId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      linkedAccountIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'linkedAccountId',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      linkedAccountIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'linkedAccountId',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      memoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'memo',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      memoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'memo',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      memoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      memoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      memoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      memoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'memo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      memoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      memoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      memoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      memoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'memo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      memoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memo',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      memoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'memo',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      nextPaymentDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextPaymentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      nextPaymentDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextPaymentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      nextPaymentDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextPaymentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      nextPaymentDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextPaymentDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      paymentDayEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentDay',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      paymentDayGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paymentDay',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      paymentDayLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paymentDay',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      paymentDayBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paymentDay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      remainingToTargetEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remainingToTarget',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      remainingToTargetGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'remainingToTarget',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      remainingToTargetLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'remainingToTarget',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      remainingToTargetBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'remainingToTarget',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      sortOrderEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sortOrder',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      sortOrderGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sortOrder',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      sortOrderLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sortOrder',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      sortOrderBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sortOrder',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      targetAmountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      targetAmountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      targetAmountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      targetAmountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      uidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      uidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      uidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      uidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      uidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      uidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      uidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      uidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      uidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      uidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CreditCardModelQueryObject
    on QueryBuilder<CreditCardModel, CreditCardModel, QFilterCondition> {}

extension CreditCardModelQueryLinks
    on QueryBuilder<CreditCardModel, CreditCardModel, QFilterCondition> {}

extension CreditCardModelQuerySortBy
    on QueryBuilder<CreditCardModel, CreditCardModel, QSortBy> {
  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByAchievementColorCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementColorCode', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByAchievementColorCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementColorCode', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByAchievementRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementRate', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByAchievementRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementRate', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByAchievementStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementStatus', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByAchievementStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementStatus', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByAnnualFee() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'annualFee', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByAnnualFeeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'annualFee', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByBillingCycleStartDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'billingCycleStartDay', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByBillingCycleStartDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'billingCycleStartDay', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByCardNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardNumber', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByCardNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardNumber', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByCardType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardType', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByCardTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardType', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByCurrentUsage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentUsage', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByCurrentUsageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentUsage', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByDaysUntilPayment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysUntilPayment', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByDaysUntilPaymentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysUntilPayment', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByIsTargetAchieved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTargetAchieved', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByIsTargetAchievedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTargetAchieved', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy> sortByIssuer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'issuer', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByIssuerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'issuer', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByLinkedAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedAccountId', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByLinkedAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedAccountId', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy> sortByMemo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByMemoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByNextPaymentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextPaymentDate', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByNextPaymentDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextPaymentDate', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByPaymentDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentDay', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByPaymentDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentDay', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByRemainingToTarget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remainingToTarget', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByRemainingToTargetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remainingToTarget', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortBySortOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortBySortOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByTargetAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetAmount', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByTargetAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetAmount', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy> sortByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy> sortByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension CreditCardModelQuerySortThenBy
    on QueryBuilder<CreditCardModel, CreditCardModel, QSortThenBy> {
  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByAchievementColorCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementColorCode', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByAchievementColorCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementColorCode', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByAchievementRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementRate', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByAchievementRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementRate', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByAchievementStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementStatus', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByAchievementStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementStatus', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByAnnualFee() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'annualFee', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByAnnualFeeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'annualFee', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByBillingCycleStartDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'billingCycleStartDay', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByBillingCycleStartDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'billingCycleStartDay', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByCardNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardNumber', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByCardNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardNumber', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByCardType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardType', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByCardTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardType', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByCurrentUsage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentUsage', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByCurrentUsageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentUsage', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByDaysUntilPayment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysUntilPayment', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByDaysUntilPaymentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysUntilPayment', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByIsTargetAchieved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTargetAchieved', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByIsTargetAchievedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTargetAchieved', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy> thenByIssuer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'issuer', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByIssuerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'issuer', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByLinkedAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedAccountId', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByLinkedAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedAccountId', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy> thenByMemo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByMemoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByNextPaymentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextPaymentDate', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByNextPaymentDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextPaymentDate', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByPaymentDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentDay', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByPaymentDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentDay', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByRemainingToTarget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remainingToTarget', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByRemainingToTargetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remainingToTarget', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenBySortOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenBySortOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByTargetAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetAmount', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByTargetAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetAmount', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy> thenByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy> thenByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension CreditCardModelQueryWhereDistinct
    on QueryBuilder<CreditCardModel, CreditCardModel, QDistinct> {
  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct>
      distinctByAchievementColorCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'achievementColorCode');
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct>
      distinctByAchievementRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'achievementRate');
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct>
      distinctByAchievementStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'achievementStatus',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct>
      distinctByAnnualFee() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'annualFee');
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct>
      distinctByBillingCycleStartDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'billingCycleStartDay');
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct>
      distinctByCardNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cardNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct> distinctByCardType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cardType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct>
      distinctByCurrentUsage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentUsage');
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct>
      distinctByDaysUntilPayment() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'daysUntilPayment');
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct>
      distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct>
      distinctByIsTargetAchieved() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isTargetAchieved');
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct> distinctByIssuer(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'issuer', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct>
      distinctByLinkedAccountId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'linkedAccountId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct> distinctByMemo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'memo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct>
      distinctByNextPaymentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextPaymentDate');
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct>
      distinctByPaymentDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paymentDay');
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct>
      distinctByRemainingToTarget() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remainingToTarget');
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct>
      distinctBySortOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sortOrder');
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct>
      distinctByTargetAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetAmount');
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct> distinctByUid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension CreditCardModelQueryProperty
    on QueryBuilder<CreditCardModel, CreditCardModel, QQueryProperty> {
  QueryBuilder<CreditCardModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CreditCardModel, int, QQueryOperations>
      achievementColorCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'achievementColorCode');
    });
  }

  QueryBuilder<CreditCardModel, double, QQueryOperations>
      achievementRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'achievementRate');
    });
  }

  QueryBuilder<CreditCardModel, String, QQueryOperations>
      achievementStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'achievementStatus');
    });
  }

  QueryBuilder<CreditCardModel, int?, QQueryOperations> annualFeeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'annualFee');
    });
  }

  QueryBuilder<CreditCardModel, int?, QQueryOperations>
      billingCycleStartDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'billingCycleStartDay');
    });
  }

  QueryBuilder<CreditCardModel, String?, QQueryOperations>
      cardNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cardNumber');
    });
  }

  QueryBuilder<CreditCardModel, CardType, QQueryOperations> cardTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cardType');
    });
  }

  QueryBuilder<CreditCardModel, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CreditCardModel, int, QQueryOperations> currentUsageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentUsage');
    });
  }

  QueryBuilder<CreditCardModel, int, QQueryOperations>
      daysUntilPaymentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'daysUntilPayment');
    });
  }

  QueryBuilder<CreditCardModel, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<CreditCardModel, bool, QQueryOperations>
      isTargetAchievedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isTargetAchieved');
    });
  }

  QueryBuilder<CreditCardModel, String, QQueryOperations> issuerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'issuer');
    });
  }

  QueryBuilder<CreditCardModel, String?, QQueryOperations>
      linkedAccountIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'linkedAccountId');
    });
  }

  QueryBuilder<CreditCardModel, String?, QQueryOperations> memoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'memo');
    });
  }

  QueryBuilder<CreditCardModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<CreditCardModel, DateTime, QQueryOperations>
      nextPaymentDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextPaymentDate');
    });
  }

  QueryBuilder<CreditCardModel, int, QQueryOperations> paymentDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paymentDay');
    });
  }

  QueryBuilder<CreditCardModel, int, QQueryOperations>
      remainingToTargetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remainingToTarget');
    });
  }

  QueryBuilder<CreditCardModel, int, QQueryOperations> sortOrderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sortOrder');
    });
  }

  QueryBuilder<CreditCardModel, int, QQueryOperations> targetAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetAmount');
    });
  }

  QueryBuilder<CreditCardModel, String, QQueryOperations> uidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uid');
    });
  }

  QueryBuilder<CreditCardModel, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
