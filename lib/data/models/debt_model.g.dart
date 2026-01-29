// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDebtModelCollection on Isar {
  IsarCollection<DebtModel> get debtModels => this.collection();
}

const DebtModelSchema = CollectionSchema(
  name: r'DebtModel',
  id: 7879871328374011369,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'endDate': PropertySchema(
      id: 1,
      name: r'endDate',
      type: IsarType.dateTime,
    ),
    r'institution': PropertySchema(
      id: 2,
      name: r'institution',
      type: IsarType.string,
    ),
    r'interestRate': PropertySchema(
      id: 3,
      name: r'interestRate',
      type: IsarType.double,
    ),
    r'interestType': PropertySchema(
      id: 4,
      name: r'interestType',
      type: IsarType.string,
      enumMap: _DebtModelinterestTypeEnumValueMap,
    ),
    r'memo': PropertySchema(
      id: 5,
      name: r'memo',
      type: IsarType.string,
    ),
    r'monthlyPayment': PropertySchema(
      id: 6,
      name: r'monthlyPayment',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 7,
      name: r'name',
      type: IsarType.string,
    ),
    r'principalAmount': PropertySchema(
      id: 8,
      name: r'principalAmount',
      type: IsarType.long,
    ),
    r'remainingAmount': PropertySchema(
      id: 9,
      name: r'remainingAmount',
      type: IsarType.long,
    ),
    r'startDate': PropertySchema(
      id: 10,
      name: r'startDate',
      type: IsarType.dateTime,
    ),
    r'type': PropertySchema(
      id: 11,
      name: r'type',
      type: IsarType.string,
      enumMap: _DebtModeltypeEnumValueMap,
    ),
    r'uid': PropertySchema(
      id: 12,
      name: r'uid',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 13,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _debtModelEstimateSize,
  serialize: _debtModelSerialize,
  deserialize: _debtModelDeserialize,
  deserializeProp: _debtModelDeserializeProp,
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
  getId: _debtModelGetId,
  getLinks: _debtModelGetLinks,
  attach: _debtModelAttach,
  version: '3.1.0+1',
);

int _debtModelEstimateSize(
  DebtModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.institution;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.interestType.name.length * 3;
  {
    final value = object.memo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.type.name.length * 3;
  bytesCount += 3 + object.uid.length * 3;
  return bytesCount;
}

void _debtModelSerialize(
  DebtModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeDateTime(offsets[1], object.endDate);
  writer.writeString(offsets[2], object.institution);
  writer.writeDouble(offsets[3], object.interestRate);
  writer.writeString(offsets[4], object.interestType.name);
  writer.writeString(offsets[5], object.memo);
  writer.writeLong(offsets[6], object.monthlyPayment);
  writer.writeString(offsets[7], object.name);
  writer.writeLong(offsets[8], object.principalAmount);
  writer.writeLong(offsets[9], object.remainingAmount);
  writer.writeDateTime(offsets[10], object.startDate);
  writer.writeString(offsets[11], object.type.name);
  writer.writeString(offsets[12], object.uid);
  writer.writeDateTime(offsets[13], object.updatedAt);
}

DebtModel _debtModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DebtModel();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.endDate = reader.readDateTimeOrNull(offsets[1]);
  object.id = id;
  object.institution = reader.readStringOrNull(offsets[2]);
  object.interestRate = reader.readDouble(offsets[3]);
  object.interestType =
      _DebtModelinterestTypeValueEnumMap[reader.readStringOrNull(offsets[4])] ??
          InterestRateType.fixed;
  object.memo = reader.readStringOrNull(offsets[5]);
  object.monthlyPayment = reader.readLong(offsets[6]);
  object.name = reader.readString(offsets[7]);
  object.principalAmount = reader.readLong(offsets[8]);
  object.remainingAmount = reader.readLong(offsets[9]);
  object.startDate = reader.readDateTime(offsets[10]);
  object.type =
      _DebtModeltypeValueEnumMap[reader.readStringOrNull(offsets[11])] ??
          DebtType.bankLoanFixed;
  object.uid = reader.readString(offsets[12]);
  object.updatedAt = reader.readDateTime(offsets[13]);
  return object;
}

P _debtModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (_DebtModelinterestTypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          InterestRateType.fixed) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readDateTime(offset)) as P;
    case 11:
      return (_DebtModeltypeValueEnumMap[reader.readStringOrNull(offset)] ??
          DebtType.bankLoanFixed) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _DebtModelinterestTypeEnumValueMap = {
  r'fixed': r'fixed',
  r'variable': r'variable',
};
const _DebtModelinterestTypeValueEnumMap = {
  r'fixed': InterestRateType.fixed,
  r'variable': InterestRateType.variable,
};
const _DebtModeltypeEnumValueMap = {
  r'bankLoanFixed': r'bankLoanFixed',
  r'bankLoanVariable': r'bankLoanVariable',
  r'companyLoan': r'companyLoan',
  r'other': r'other',
};
const _DebtModeltypeValueEnumMap = {
  r'bankLoanFixed': DebtType.bankLoanFixed,
  r'bankLoanVariable': DebtType.bankLoanVariable,
  r'companyLoan': DebtType.companyLoan,
  r'other': DebtType.other,
};

Id _debtModelGetId(DebtModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _debtModelGetLinks(DebtModel object) {
  return [];
}

void _debtModelAttach(IsarCollection<dynamic> col, Id id, DebtModel object) {
  object.id = id;
}

extension DebtModelByIndex on IsarCollection<DebtModel> {
  Future<DebtModel?> getByUid(String uid) {
    return getByIndex(r'uid', [uid]);
  }

  DebtModel? getByUidSync(String uid) {
    return getByIndexSync(r'uid', [uid]);
  }

  Future<bool> deleteByUid(String uid) {
    return deleteByIndex(r'uid', [uid]);
  }

  bool deleteByUidSync(String uid) {
    return deleteByIndexSync(r'uid', [uid]);
  }

  Future<List<DebtModel?>> getAllByUid(List<String> uidValues) {
    final values = uidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uid', values);
  }

  List<DebtModel?> getAllByUidSync(List<String> uidValues) {
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

  Future<Id> putByUid(DebtModel object) {
    return putByIndex(r'uid', object);
  }

  Id putByUidSync(DebtModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'uid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUid(List<DebtModel> objects) {
    return putAllByIndex(r'uid', objects);
  }

  List<Id> putAllByUidSync(List<DebtModel> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'uid', objects, saveLinks: saveLinks);
  }
}

extension DebtModelQueryWhereSort
    on QueryBuilder<DebtModel, DebtModel, QWhere> {
  QueryBuilder<DebtModel, DebtModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DebtModelQueryWhere
    on QueryBuilder<DebtModel, DebtModel, QWhereClause> {
  QueryBuilder<DebtModel, DebtModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<DebtModel, DebtModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<DebtModel, DebtModel, QAfterWhereClause> uidEqualTo(String uid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uid',
        value: [uid],
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterWhereClause> uidNotEqualTo(
      String uid) {
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

extension DebtModelQueryFilter
    on QueryBuilder<DebtModel, DebtModel, QFilterCondition> {
  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> endDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endDate',
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> endDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endDate',
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> endDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> endDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> endDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> endDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      institutionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'institution',
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      institutionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'institution',
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> institutionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'institution',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      institutionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'institution',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> institutionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'institution',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> institutionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'institution',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      institutionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'institution',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> institutionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'institution',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> institutionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'institution',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> institutionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'institution',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      institutionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'institution',
        value: '',
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      institutionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'institution',
        value: '',
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> interestRateEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interestRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      interestRateGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'interestRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      interestRateLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'interestRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> interestRateBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'interestRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> interestTypeEqualTo(
    InterestRateType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interestType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      interestTypeGreaterThan(
    InterestRateType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'interestType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      interestTypeLessThan(
    InterestRateType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'interestType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> interestTypeBetween(
    InterestRateType lower,
    InterestRateType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'interestType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      interestTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'interestType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      interestTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'interestType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      interestTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'interestType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> interestTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'interestType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      interestTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interestType',
        value: '',
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      interestTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'interestType',
        value: '',
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> memoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'memo',
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> memoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'memo',
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> memoEqualTo(
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> memoGreaterThan(
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> memoLessThan(
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> memoBetween(
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> memoStartsWith(
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> memoEndsWith(
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> memoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> memoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'memo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> memoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memo',
        value: '',
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> memoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'memo',
        value: '',
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      monthlyPaymentEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monthlyPayment',
        value: value,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      monthlyPaymentGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'monthlyPayment',
        value: value,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      monthlyPaymentLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'monthlyPayment',
        value: value,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      monthlyPaymentBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'monthlyPayment',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      principalAmountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'principalAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      principalAmountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'principalAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      principalAmountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'principalAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      principalAmountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'principalAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      remainingAmountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remainingAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      remainingAmountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'remainingAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      remainingAmountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'remainingAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      remainingAmountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'remainingAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> startDateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
      startDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> startDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> startDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> typeEqualTo(
    DebtType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> typeGreaterThan(
    DebtType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> typeLessThan(
    DebtType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> typeBetween(
    DebtType lower,
    DebtType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> uidEqualTo(
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> uidGreaterThan(
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> uidLessThan(
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> uidBetween(
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> uidStartsWith(
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> uidEndsWith(
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> uidContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> uidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> uidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> uidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> updatedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition>
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> updatedAtLessThan(
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

  QueryBuilder<DebtModel, DebtModel, QAfterFilterCondition> updatedAtBetween(
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

extension DebtModelQueryObject
    on QueryBuilder<DebtModel, DebtModel, QFilterCondition> {}

extension DebtModelQueryLinks
    on QueryBuilder<DebtModel, DebtModel, QFilterCondition> {}

extension DebtModelQuerySortBy on QueryBuilder<DebtModel, DebtModel, QSortBy> {
  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByInstitution() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'institution', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByInstitutionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'institution', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByInterestRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interestRate', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByInterestRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interestRate', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByInterestType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interestType', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByInterestTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interestType', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByMemo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByMemoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByMonthlyPayment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthlyPayment', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByMonthlyPaymentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthlyPayment', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByPrincipalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'principalAmount', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByPrincipalAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'principalAmount', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByRemainingAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remainingAmount', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByRemainingAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remainingAmount', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension DebtModelQuerySortThenBy
    on QueryBuilder<DebtModel, DebtModel, QSortThenBy> {
  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByInstitution() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'institution', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByInstitutionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'institution', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByInterestRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interestRate', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByInterestRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interestRate', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByInterestType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interestType', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByInterestTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interestType', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByMemo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByMemoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByMonthlyPayment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthlyPayment', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByMonthlyPaymentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthlyPayment', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByPrincipalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'principalAmount', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByPrincipalAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'principalAmount', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByRemainingAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remainingAmount', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByRemainingAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remainingAmount', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension DebtModelQueryWhereDistinct
    on QueryBuilder<DebtModel, DebtModel, QDistinct> {
  QueryBuilder<DebtModel, DebtModel, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<DebtModel, DebtModel, QDistinct> distinctByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endDate');
    });
  }

  QueryBuilder<DebtModel, DebtModel, QDistinct> distinctByInstitution(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'institution', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QDistinct> distinctByInterestRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'interestRate');
    });
  }

  QueryBuilder<DebtModel, DebtModel, QDistinct> distinctByInterestType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'interestType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QDistinct> distinctByMemo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'memo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QDistinct> distinctByMonthlyPayment() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'monthlyPayment');
    });
  }

  QueryBuilder<DebtModel, DebtModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QDistinct> distinctByPrincipalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'principalAmount');
    });
  }

  QueryBuilder<DebtModel, DebtModel, QDistinct> distinctByRemainingAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remainingAmount');
    });
  }

  QueryBuilder<DebtModel, DebtModel, QDistinct> distinctByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startDate');
    });
  }

  QueryBuilder<DebtModel, DebtModel, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QDistinct> distinctByUid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DebtModel, DebtModel, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension DebtModelQueryProperty
    on QueryBuilder<DebtModel, DebtModel, QQueryProperty> {
  QueryBuilder<DebtModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DebtModel, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<DebtModel, DateTime?, QQueryOperations> endDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endDate');
    });
  }

  QueryBuilder<DebtModel, String?, QQueryOperations> institutionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'institution');
    });
  }

  QueryBuilder<DebtModel, double, QQueryOperations> interestRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'interestRate');
    });
  }

  QueryBuilder<DebtModel, InterestRateType, QQueryOperations>
      interestTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'interestType');
    });
  }

  QueryBuilder<DebtModel, String?, QQueryOperations> memoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'memo');
    });
  }

  QueryBuilder<DebtModel, int, QQueryOperations> monthlyPaymentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'monthlyPayment');
    });
  }

  QueryBuilder<DebtModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<DebtModel, int, QQueryOperations> principalAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'principalAmount');
    });
  }

  QueryBuilder<DebtModel, int, QQueryOperations> remainingAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remainingAmount');
    });
  }

  QueryBuilder<DebtModel, DateTime, QQueryOperations> startDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startDate');
    });
  }

  QueryBuilder<DebtModel, DebtType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<DebtModel, String, QQueryOperations> uidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uid');
    });
  }

  QueryBuilder<DebtModel, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
