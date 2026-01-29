// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAccountModelCollection on Isar {
  IsarCollection<AccountModel> get accountModels => this.collection();
}

const AccountModelSchema = CollectionSchema(
  name: r'AccountModel',
  id: -4417758972305866022,
  properties: {
    r'accountNumber': PropertySchema(
      id: 0,
      name: r'accountNumber',
      type: IsarType.string,
    ),
    r'balance': PropertySchema(
      id: 1,
      name: r'balance',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'currentPayments': PropertySchema(
      id: 3,
      name: r'currentPayments',
      type: IsarType.long,
    ),
    r'daysUntilMaturity': PropertySchema(
      id: 4,
      name: r'daysUntilMaturity',
      type: IsarType.long,
    ),
    r'expectedInterest': PropertySchema(
      id: 5,
      name: r'expectedInterest',
      type: IsarType.double,
    ),
    r'expectedInterestAfterTax': PropertySchema(
      id: 6,
      name: r'expectedInterestAfterTax',
      type: IsarType.double,
    ),
    r'expectedTotalAtMaturity': PropertySchema(
      id: 7,
      name: r'expectedTotalAtMaturity',
      type: IsarType.double,
    ),
    r'institution': PropertySchema(
      id: 8,
      name: r'institution',
      type: IsarType.string,
    ),
    r'interestRate': PropertySchema(
      id: 9,
      name: r'interestRate',
      type: IsarType.double,
    ),
    r'isActive': PropertySchema(
      id: 10,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'isMatured': PropertySchema(
      id: 11,
      name: r'isMatured',
      type: IsarType.bool,
    ),
    r'maturityDate': PropertySchema(
      id: 12,
      name: r'maturityDate',
      type: IsarType.dateTime,
    ),
    r'memo': PropertySchema(
      id: 13,
      name: r'memo',
      type: IsarType.string,
    ),
    r'monthlyPayment': PropertySchema(
      id: 14,
      name: r'monthlyPayment',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 15,
      name: r'name',
      type: IsarType.string,
    ),
    r'progressRate': PropertySchema(
      id: 16,
      name: r'progressRate',
      type: IsarType.double,
    ),
    r'sortOrder': PropertySchema(
      id: 17,
      name: r'sortOrder',
      type: IsarType.long,
    ),
    r'startDate': PropertySchema(
      id: 18,
      name: r'startDate',
      type: IsarType.dateTime,
    ),
    r'totalPayments': PropertySchema(
      id: 19,
      name: r'totalPayments',
      type: IsarType.long,
    ),
    r'type': PropertySchema(
      id: 20,
      name: r'type',
      type: IsarType.string,
      enumMap: _AccountModeltypeEnumValueMap,
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
  estimateSize: _accountModelEstimateSize,
  serialize: _accountModelSerialize,
  deserialize: _accountModelDeserialize,
  deserializeProp: _accountModelDeserializeProp,
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
  getId: _accountModelGetId,
  getLinks: _accountModelGetLinks,
  attach: _accountModelAttach,
  version: '3.1.0+1',
);

int _accountModelEstimateSize(
  AccountModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.accountNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.institution;
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
  bytesCount += 3 + object.type.name.length * 3;
  bytesCount += 3 + object.uid.length * 3;
  return bytesCount;
}

void _accountModelSerialize(
  AccountModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.accountNumber);
  writer.writeLong(offsets[1], object.balance);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeLong(offsets[3], object.currentPayments);
  writer.writeLong(offsets[4], object.daysUntilMaturity);
  writer.writeDouble(offsets[5], object.expectedInterest);
  writer.writeDouble(offsets[6], object.expectedInterestAfterTax);
  writer.writeDouble(offsets[7], object.expectedTotalAtMaturity);
  writer.writeString(offsets[8], object.institution);
  writer.writeDouble(offsets[9], object.interestRate);
  writer.writeBool(offsets[10], object.isActive);
  writer.writeBool(offsets[11], object.isMatured);
  writer.writeDateTime(offsets[12], object.maturityDate);
  writer.writeString(offsets[13], object.memo);
  writer.writeLong(offsets[14], object.monthlyPayment);
  writer.writeString(offsets[15], object.name);
  writer.writeDouble(offsets[16], object.progressRate);
  writer.writeLong(offsets[17], object.sortOrder);
  writer.writeDateTime(offsets[18], object.startDate);
  writer.writeLong(offsets[19], object.totalPayments);
  writer.writeString(offsets[20], object.type.name);
  writer.writeString(offsets[21], object.uid);
  writer.writeDateTime(offsets[22], object.updatedAt);
}

AccountModel _accountModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AccountModel();
  object.accountNumber = reader.readStringOrNull(offsets[0]);
  object.balance = reader.readLong(offsets[1]);
  object.createdAt = reader.readDateTime(offsets[2]);
  object.currentPayments = reader.readLongOrNull(offsets[3]);
  object.id = id;
  object.institution = reader.readStringOrNull(offsets[8]);
  object.interestRate = reader.readDoubleOrNull(offsets[9]);
  object.isActive = reader.readBool(offsets[10]);
  object.maturityDate = reader.readDateTimeOrNull(offsets[12]);
  object.memo = reader.readStringOrNull(offsets[13]);
  object.monthlyPayment = reader.readLongOrNull(offsets[14]);
  object.name = reader.readString(offsets[15]);
  object.sortOrder = reader.readLong(offsets[17]);
  object.startDate = reader.readDateTimeOrNull(offsets[18]);
  object.totalPayments = reader.readLongOrNull(offsets[19]);
  object.type =
      _AccountModeltypeValueEnumMap[reader.readStringOrNull(offsets[20])] ??
          AccountType.checking;
  object.uid = reader.readString(offsets[21]);
  object.updatedAt = reader.readDateTime(offsets[22]);
  return object;
}

P _accountModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readDoubleOrNull(offset)) as P;
    case 7:
      return (reader.readDoubleOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readDoubleOrNull(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readBool(offset)) as P;
    case 12:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readLongOrNull(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readDoubleOrNull(offset)) as P;
    case 17:
      return (reader.readLong(offset)) as P;
    case 18:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 19:
      return (reader.readLongOrNull(offset)) as P;
    case 20:
      return (_AccountModeltypeValueEnumMap[reader.readStringOrNull(offset)] ??
          AccountType.checking) as P;
    case 21:
      return (reader.readString(offset)) as P;
    case 22:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _AccountModeltypeEnumValueMap = {
  r'checking': r'checking',
  r'parking': r'parking',
  r'deposit': r'deposit',
  r'savings': r'savings',
  r'subscription': r'subscription',
};
const _AccountModeltypeValueEnumMap = {
  r'checking': AccountType.checking,
  r'parking': AccountType.parking,
  r'deposit': AccountType.deposit,
  r'savings': AccountType.savings,
  r'subscription': AccountType.subscription,
};

Id _accountModelGetId(AccountModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _accountModelGetLinks(AccountModel object) {
  return [];
}

void _accountModelAttach(
    IsarCollection<dynamic> col, Id id, AccountModel object) {
  object.id = id;
}

extension AccountModelByIndex on IsarCollection<AccountModel> {
  Future<AccountModel?> getByUid(String uid) {
    return getByIndex(r'uid', [uid]);
  }

  AccountModel? getByUidSync(String uid) {
    return getByIndexSync(r'uid', [uid]);
  }

  Future<bool> deleteByUid(String uid) {
    return deleteByIndex(r'uid', [uid]);
  }

  bool deleteByUidSync(String uid) {
    return deleteByIndexSync(r'uid', [uid]);
  }

  Future<List<AccountModel?>> getAllByUid(List<String> uidValues) {
    final values = uidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uid', values);
  }

  List<AccountModel?> getAllByUidSync(List<String> uidValues) {
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

  Future<Id> putByUid(AccountModel object) {
    return putByIndex(r'uid', object);
  }

  Id putByUidSync(AccountModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'uid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUid(List<AccountModel> objects) {
    return putAllByIndex(r'uid', objects);
  }

  List<Id> putAllByUidSync(List<AccountModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uid', objects, saveLinks: saveLinks);
  }
}

extension AccountModelQueryWhereSort
    on QueryBuilder<AccountModel, AccountModel, QWhere> {
  QueryBuilder<AccountModel, AccountModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AccountModelQueryWhere
    on QueryBuilder<AccountModel, AccountModel, QWhereClause> {
  QueryBuilder<AccountModel, AccountModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<AccountModel, AccountModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<AccountModel, AccountModel, QAfterWhereClause> uidEqualTo(
      String uid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uid',
        value: [uid],
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterWhereClause> uidNotEqualTo(
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

extension AccountModelQueryFilter
    on QueryBuilder<AccountModel, AccountModel, QFilterCondition> {
  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      accountNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'accountNumber',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      accountNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'accountNumber',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      accountNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      accountNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'accountNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      accountNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'accountNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      accountNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'accountNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      accountNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'accountNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      accountNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'accountNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      accountNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'accountNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      accountNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'accountNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      accountNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      accountNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'accountNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      balanceEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'balance',
        value: value,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      balanceGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'balance',
        value: value,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      balanceLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'balance',
        value: value,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      balanceBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'balance',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      currentPaymentsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'currentPayments',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      currentPaymentsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'currentPayments',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      currentPaymentsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentPayments',
        value: value,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      currentPaymentsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentPayments',
        value: value,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      currentPaymentsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentPayments',
        value: value,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      currentPaymentsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentPayments',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      daysUntilMaturityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'daysUntilMaturity',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      daysUntilMaturityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'daysUntilMaturity',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      daysUntilMaturityEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'daysUntilMaturity',
        value: value,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      daysUntilMaturityGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'daysUntilMaturity',
        value: value,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      daysUntilMaturityLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'daysUntilMaturity',
        value: value,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      daysUntilMaturityBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'daysUntilMaturity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      expectedInterestIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'expectedInterest',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      expectedInterestIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'expectedInterest',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      expectedInterestEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expectedInterest',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      expectedInterestGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expectedInterest',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      expectedInterestLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expectedInterest',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      expectedInterestBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expectedInterest',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      expectedInterestAfterTaxIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'expectedInterestAfterTax',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      expectedInterestAfterTaxIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'expectedInterestAfterTax',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      expectedInterestAfterTaxEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expectedInterestAfterTax',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      expectedInterestAfterTaxGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expectedInterestAfterTax',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      expectedInterestAfterTaxLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expectedInterestAfterTax',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      expectedInterestAfterTaxBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expectedInterestAfterTax',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      expectedTotalAtMaturityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'expectedTotalAtMaturity',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      expectedTotalAtMaturityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'expectedTotalAtMaturity',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      expectedTotalAtMaturityEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expectedTotalAtMaturity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      expectedTotalAtMaturityGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expectedTotalAtMaturity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      expectedTotalAtMaturityLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expectedTotalAtMaturity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      expectedTotalAtMaturityBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expectedTotalAtMaturity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      institutionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'institution',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      institutionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'institution',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      institutionEqualTo(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      institutionLessThan(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      institutionBetween(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      institutionEndsWith(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      institutionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'institution',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      institutionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'institution',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      institutionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'institution',
        value: '',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      institutionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'institution',
        value: '',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      interestRateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'interestRate',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      interestRateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'interestRate',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      interestRateEqualTo(
    double? value, {
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      interestRateGreaterThan(
    double? value, {
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      interestRateLessThan(
    double? value, {
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      interestRateBetween(
    double? lower,
    double? upper, {
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      isActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      isMaturedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMatured',
        value: value,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      maturityDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maturityDate',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      maturityDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maturityDate',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      maturityDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maturityDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      maturityDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maturityDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      maturityDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maturityDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      maturityDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maturityDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> memoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'memo',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      memoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'memo',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> memoEqualTo(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> memoLessThan(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> memoBetween(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> memoEndsWith(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> memoContains(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> memoMatches(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      memoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memo',
        value: '',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      memoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'memo',
        value: '',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      monthlyPaymentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'monthlyPayment',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      monthlyPaymentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'monthlyPayment',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      monthlyPaymentEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monthlyPayment',
        value: value,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      monthlyPaymentGreaterThan(
    int? value, {
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      monthlyPaymentLessThan(
    int? value, {
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      monthlyPaymentBetween(
    int? lower,
    int? upper, {
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> nameContains(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      progressRateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'progressRate',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      progressRateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'progressRate',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      progressRateEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'progressRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      progressRateGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'progressRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      progressRateLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'progressRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      progressRateBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'progressRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      sortOrderEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sortOrder',
        value: value,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      startDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'startDate',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      startDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'startDate',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      startDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      startDateGreaterThan(
    DateTime? value, {
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      startDateLessThan(
    DateTime? value, {
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      startDateBetween(
    DateTime? lower,
    DateTime? upper, {
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      totalPaymentsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'totalPayments',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      totalPaymentsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'totalPayments',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      totalPaymentsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalPayments',
        value: value,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      totalPaymentsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalPayments',
        value: value,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      totalPaymentsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalPayments',
        value: value,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      totalPaymentsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalPayments',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> typeEqualTo(
    AccountType value, {
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      typeGreaterThan(
    AccountType value, {
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> typeLessThan(
    AccountType value, {
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> typeBetween(
    AccountType lower,
    AccountType upper, {
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      typeStartsWith(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> typeEndsWith(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> typeContains(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> typeMatches(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> uidEqualTo(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> uidLessThan(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> uidBetween(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> uidStartsWith(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> uidEndsWith(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> uidContains(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> uidMatches(
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition> uidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      uidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
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

  QueryBuilder<AccountModel, AccountModel, QAfterFilterCondition>
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

extension AccountModelQueryObject
    on QueryBuilder<AccountModel, AccountModel, QFilterCondition> {}

extension AccountModelQueryLinks
    on QueryBuilder<AccountModel, AccountModel, QFilterCondition> {}

extension AccountModelQuerySortBy
    on QueryBuilder<AccountModel, AccountModel, QSortBy> {
  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByAccountNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountNumber', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      sortByAccountNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountNumber', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balance', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balance', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      sortByCurrentPayments() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentPayments', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      sortByCurrentPaymentsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentPayments', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      sortByDaysUntilMaturity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysUntilMaturity', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      sortByDaysUntilMaturityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysUntilMaturity', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      sortByExpectedInterest() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedInterest', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      sortByExpectedInterestDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedInterest', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      sortByExpectedInterestAfterTax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedInterestAfterTax', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      sortByExpectedInterestAfterTaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedInterestAfterTax', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      sortByExpectedTotalAtMaturity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedTotalAtMaturity', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      sortByExpectedTotalAtMaturityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedTotalAtMaturity', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByInstitution() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'institution', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      sortByInstitutionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'institution', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByInterestRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interestRate', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      sortByInterestRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interestRate', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByIsMatured() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMatured', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByIsMaturedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMatured', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByMaturityDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maturityDate', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      sortByMaturityDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maturityDate', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByMemo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByMemoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      sortByMonthlyPayment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthlyPayment', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      sortByMonthlyPaymentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthlyPayment', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByProgressRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progressRate', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      sortByProgressRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progressRate', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortBySortOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortBySortOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByTotalPayments() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPayments', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      sortByTotalPaymentsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPayments', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension AccountModelQuerySortThenBy
    on QueryBuilder<AccountModel, AccountModel, QSortThenBy> {
  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByAccountNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountNumber', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      thenByAccountNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountNumber', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balance', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balance', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      thenByCurrentPayments() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentPayments', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      thenByCurrentPaymentsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentPayments', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      thenByDaysUntilMaturity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysUntilMaturity', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      thenByDaysUntilMaturityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysUntilMaturity', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      thenByExpectedInterest() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedInterest', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      thenByExpectedInterestDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedInterest', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      thenByExpectedInterestAfterTax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedInterestAfterTax', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      thenByExpectedInterestAfterTaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedInterestAfterTax', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      thenByExpectedTotalAtMaturity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedTotalAtMaturity', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      thenByExpectedTotalAtMaturityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedTotalAtMaturity', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByInstitution() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'institution', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      thenByInstitutionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'institution', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByInterestRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interestRate', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      thenByInterestRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interestRate', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByIsMatured() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMatured', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByIsMaturedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMatured', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByMaturityDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maturityDate', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      thenByMaturityDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maturityDate', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByMemo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByMemoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      thenByMonthlyPayment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthlyPayment', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      thenByMonthlyPaymentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthlyPayment', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByProgressRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progressRate', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      thenByProgressRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progressRate', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenBySortOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenBySortOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByTotalPayments() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPayments', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy>
      thenByTotalPaymentsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPayments', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension AccountModelQueryWhereDistinct
    on QueryBuilder<AccountModel, AccountModel, QDistinct> {
  QueryBuilder<AccountModel, AccountModel, QDistinct> distinctByAccountNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accountNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QDistinct> distinctByBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'balance');
    });
  }

  QueryBuilder<AccountModel, AccountModel, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<AccountModel, AccountModel, QDistinct>
      distinctByCurrentPayments() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentPayments');
    });
  }

  QueryBuilder<AccountModel, AccountModel, QDistinct>
      distinctByDaysUntilMaturity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'daysUntilMaturity');
    });
  }

  QueryBuilder<AccountModel, AccountModel, QDistinct>
      distinctByExpectedInterest() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expectedInterest');
    });
  }

  QueryBuilder<AccountModel, AccountModel, QDistinct>
      distinctByExpectedInterestAfterTax() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expectedInterestAfterTax');
    });
  }

  QueryBuilder<AccountModel, AccountModel, QDistinct>
      distinctByExpectedTotalAtMaturity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expectedTotalAtMaturity');
    });
  }

  QueryBuilder<AccountModel, AccountModel, QDistinct> distinctByInstitution(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'institution', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QDistinct> distinctByInterestRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'interestRate');
    });
  }

  QueryBuilder<AccountModel, AccountModel, QDistinct> distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<AccountModel, AccountModel, QDistinct> distinctByIsMatured() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isMatured');
    });
  }

  QueryBuilder<AccountModel, AccountModel, QDistinct> distinctByMaturityDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maturityDate');
    });
  }

  QueryBuilder<AccountModel, AccountModel, QDistinct> distinctByMemo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'memo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QDistinct>
      distinctByMonthlyPayment() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'monthlyPayment');
    });
  }

  QueryBuilder<AccountModel, AccountModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QDistinct> distinctByProgressRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'progressRate');
    });
  }

  QueryBuilder<AccountModel, AccountModel, QDistinct> distinctBySortOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sortOrder');
    });
  }

  QueryBuilder<AccountModel, AccountModel, QDistinct> distinctByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startDate');
    });
  }

  QueryBuilder<AccountModel, AccountModel, QDistinct>
      distinctByTotalPayments() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalPayments');
    });
  }

  QueryBuilder<AccountModel, AccountModel, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QDistinct> distinctByUid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountModel, AccountModel, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension AccountModelQueryProperty
    on QueryBuilder<AccountModel, AccountModel, QQueryProperty> {
  QueryBuilder<AccountModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AccountModel, String?, QQueryOperations>
      accountNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accountNumber');
    });
  }

  QueryBuilder<AccountModel, int, QQueryOperations> balanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'balance');
    });
  }

  QueryBuilder<AccountModel, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<AccountModel, int?, QQueryOperations> currentPaymentsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentPayments');
    });
  }

  QueryBuilder<AccountModel, int?, QQueryOperations>
      daysUntilMaturityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'daysUntilMaturity');
    });
  }

  QueryBuilder<AccountModel, double?, QQueryOperations>
      expectedInterestProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expectedInterest');
    });
  }

  QueryBuilder<AccountModel, double?, QQueryOperations>
      expectedInterestAfterTaxProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expectedInterestAfterTax');
    });
  }

  QueryBuilder<AccountModel, double?, QQueryOperations>
      expectedTotalAtMaturityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expectedTotalAtMaturity');
    });
  }

  QueryBuilder<AccountModel, String?, QQueryOperations> institutionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'institution');
    });
  }

  QueryBuilder<AccountModel, double?, QQueryOperations> interestRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'interestRate');
    });
  }

  QueryBuilder<AccountModel, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<AccountModel, bool, QQueryOperations> isMaturedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isMatured');
    });
  }

  QueryBuilder<AccountModel, DateTime?, QQueryOperations>
      maturityDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maturityDate');
    });
  }

  QueryBuilder<AccountModel, String?, QQueryOperations> memoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'memo');
    });
  }

  QueryBuilder<AccountModel, int?, QQueryOperations> monthlyPaymentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'monthlyPayment');
    });
  }

  QueryBuilder<AccountModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<AccountModel, double?, QQueryOperations> progressRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'progressRate');
    });
  }

  QueryBuilder<AccountModel, int, QQueryOperations> sortOrderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sortOrder');
    });
  }

  QueryBuilder<AccountModel, DateTime?, QQueryOperations> startDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startDate');
    });
  }

  QueryBuilder<AccountModel, int?, QQueryOperations> totalPaymentsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalPayments');
    });
  }

  QueryBuilder<AccountModel, AccountType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<AccountModel, String, QQueryOperations> uidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uid');
    });
  }

  QueryBuilder<AccountModel, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
