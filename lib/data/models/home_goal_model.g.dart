// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_goal_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHomeGoalModelCollection on Isar {
  IsarCollection<HomeGoalModel> get homeGoalModels => this.collection();
}

const HomeGoalModelSchema = CollectionSchema(
  name: r'HomeGoalModel',
  id: -3132815584388763358,
  properties: {
    r'address': PropertySchema(
      id: 0,
      name: r'address',
      type: IsarType.string,
    ),
    r'apartmentName': PropertySchema(
      id: 1,
      name: r'apartmentName',
      type: IsarType.string,
    ),
    r'balance': PropertySchema(
      id: 2,
      name: r'balance',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'downPayment': PropertySchema(
      id: 4,
      name: r'downPayment',
      type: IsarType.long,
    ),
    r'exclusiveArea': PropertySchema(
      id: 5,
      name: r'exclusiveArea',
      type: IsarType.double,
    ),
    r'intermediatePayment': PropertySchema(
      id: 6,
      name: r'intermediatePayment',
      type: IsarType.long,
    ),
    r'memo': PropertySchema(
      id: 7,
      name: r'memo',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 8,
      name: r'name',
      type: IsarType.string,
    ),
    r'regionCode': PropertySchema(
      id: 9,
      name: r'regionCode',
      type: IsarType.string,
    ),
    r'targetDate': PropertySchema(
      id: 10,
      name: r'targetDate',
      type: IsarType.dateTime,
    ),
    r'targetPrice': PropertySchema(
      id: 11,
      name: r'targetPrice',
      type: IsarType.long,
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
  estimateSize: _homeGoalModelEstimateSize,
  serialize: _homeGoalModelSerialize,
  deserialize: _homeGoalModelDeserialize,
  deserializeProp: _homeGoalModelDeserializeProp,
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
  getId: _homeGoalModelGetId,
  getLinks: _homeGoalModelGetLinks,
  attach: _homeGoalModelAttach,
  version: '3.1.0+1',
);

int _homeGoalModelEstimateSize(
  HomeGoalModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.address;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.apartmentName;
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
  {
    final value = object.regionCode;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.uid.length * 3;
  return bytesCount;
}

void _homeGoalModelSerialize(
  HomeGoalModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.address);
  writer.writeString(offsets[1], object.apartmentName);
  writer.writeLong(offsets[2], object.balance);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeLong(offsets[4], object.downPayment);
  writer.writeDouble(offsets[5], object.exclusiveArea);
  writer.writeLong(offsets[6], object.intermediatePayment);
  writer.writeString(offsets[7], object.memo);
  writer.writeString(offsets[8], object.name);
  writer.writeString(offsets[9], object.regionCode);
  writer.writeDateTime(offsets[10], object.targetDate);
  writer.writeLong(offsets[11], object.targetPrice);
  writer.writeString(offsets[12], object.uid);
  writer.writeDateTime(offsets[13], object.updatedAt);
}

HomeGoalModel _homeGoalModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HomeGoalModel();
  object.address = reader.readStringOrNull(offsets[0]);
  object.apartmentName = reader.readStringOrNull(offsets[1]);
  object.balance = reader.readLongOrNull(offsets[2]);
  object.createdAt = reader.readDateTime(offsets[3]);
  object.downPayment = reader.readLongOrNull(offsets[4]);
  object.exclusiveArea = reader.readDoubleOrNull(offsets[5]);
  object.id = id;
  object.intermediatePayment = reader.readLongOrNull(offsets[6]);
  object.memo = reader.readStringOrNull(offsets[7]);
  object.name = reader.readString(offsets[8]);
  object.regionCode = reader.readStringOrNull(offsets[9]);
  object.targetDate = reader.readDateTimeOrNull(offsets[10]);
  object.targetPrice = reader.readLong(offsets[11]);
  object.uid = reader.readString(offsets[12]);
  object.updatedAt = reader.readDateTime(offsets[13]);
  return object;
}

P _homeGoalModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _homeGoalModelGetId(HomeGoalModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _homeGoalModelGetLinks(HomeGoalModel object) {
  return [];
}

void _homeGoalModelAttach(
    IsarCollection<dynamic> col, Id id, HomeGoalModel object) {
  object.id = id;
}

extension HomeGoalModelByIndex on IsarCollection<HomeGoalModel> {
  Future<HomeGoalModel?> getByUid(String uid) {
    return getByIndex(r'uid', [uid]);
  }

  HomeGoalModel? getByUidSync(String uid) {
    return getByIndexSync(r'uid', [uid]);
  }

  Future<bool> deleteByUid(String uid) {
    return deleteByIndex(r'uid', [uid]);
  }

  bool deleteByUidSync(String uid) {
    return deleteByIndexSync(r'uid', [uid]);
  }

  Future<List<HomeGoalModel?>> getAllByUid(List<String> uidValues) {
    final values = uidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uid', values);
  }

  List<HomeGoalModel?> getAllByUidSync(List<String> uidValues) {
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

  Future<Id> putByUid(HomeGoalModel object) {
    return putByIndex(r'uid', object);
  }

  Id putByUidSync(HomeGoalModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'uid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUid(List<HomeGoalModel> objects) {
    return putAllByIndex(r'uid', objects);
  }

  List<Id> putAllByUidSync(List<HomeGoalModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uid', objects, saveLinks: saveLinks);
  }
}

extension HomeGoalModelQueryWhereSort
    on QueryBuilder<HomeGoalModel, HomeGoalModel, QWhere> {
  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension HomeGoalModelQueryWhere
    on QueryBuilder<HomeGoalModel, HomeGoalModel, QWhereClause> {
  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterWhereClause> uidEqualTo(
      String uid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uid',
        value: [uid],
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterWhereClause> uidNotEqualTo(
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

extension HomeGoalModelQueryFilter
    on QueryBuilder<HomeGoalModel, HomeGoalModel, QFilterCondition> {
  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      addressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'address',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      addressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'address',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      addressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      addressGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      addressLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      addressBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'address',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      addressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      addressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      addressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      addressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'address',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      addressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      addressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      apartmentNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'apartmentName',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      apartmentNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'apartmentName',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      apartmentNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'apartmentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      apartmentNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'apartmentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      apartmentNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'apartmentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      apartmentNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'apartmentName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      apartmentNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'apartmentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      apartmentNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'apartmentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      apartmentNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'apartmentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      apartmentNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'apartmentName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      apartmentNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'apartmentName',
        value: '',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      apartmentNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'apartmentName',
        value: '',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      balanceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'balance',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      balanceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'balance',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      balanceEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'balance',
        value: value,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      balanceGreaterThan(
    int? value, {
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      balanceLessThan(
    int? value, {
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      balanceBetween(
    int? lower,
    int? upper, {
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      downPaymentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'downPayment',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      downPaymentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'downPayment',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      downPaymentEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'downPayment',
        value: value,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      downPaymentGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'downPayment',
        value: value,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      downPaymentLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'downPayment',
        value: value,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      downPaymentBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'downPayment',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      exclusiveAreaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'exclusiveArea',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      exclusiveAreaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'exclusiveArea',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      exclusiveAreaEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exclusiveArea',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      exclusiveAreaGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exclusiveArea',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      exclusiveAreaLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exclusiveArea',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      exclusiveAreaBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exclusiveArea',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      intermediatePaymentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'intermediatePayment',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      intermediatePaymentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'intermediatePayment',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      intermediatePaymentEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'intermediatePayment',
        value: value,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      intermediatePaymentGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'intermediatePayment',
        value: value,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      intermediatePaymentLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'intermediatePayment',
        value: value,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      intermediatePaymentBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'intermediatePayment',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      memoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'memo',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      memoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'memo',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition> memoEqualTo(
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition> memoBetween(
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      memoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition> memoMatches(
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      memoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memo',
        value: '',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      memoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'memo',
        value: '',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      regionCodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'regionCode',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      regionCodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'regionCode',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      regionCodeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'regionCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      regionCodeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'regionCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      regionCodeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'regionCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      regionCodeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'regionCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      regionCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'regionCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      regionCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'regionCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      regionCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'regionCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      regionCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'regionCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      regionCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'regionCode',
        value: '',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      regionCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'regionCode',
        value: '',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      targetDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'targetDate',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      targetDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'targetDate',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      targetDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetDate',
        value: value,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      targetDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetDate',
        value: value,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      targetDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetDate',
        value: value,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      targetDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      targetPriceEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetPrice',
        value: value,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      targetPriceGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetPrice',
        value: value,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      targetPriceLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetPrice',
        value: value,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      targetPriceBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition> uidEqualTo(
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition> uidLessThan(
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition> uidBetween(
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition> uidEndsWith(
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition> uidContains(
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition> uidMatches(
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      uidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      uidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
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

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterFilterCondition>
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

extension HomeGoalModelQueryObject
    on QueryBuilder<HomeGoalModel, HomeGoalModel, QFilterCondition> {}

extension HomeGoalModelQueryLinks
    on QueryBuilder<HomeGoalModel, HomeGoalModel, QFilterCondition> {}

extension HomeGoalModelQuerySortBy
    on QueryBuilder<HomeGoalModel, HomeGoalModel, QSortBy> {
  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> sortByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> sortByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy>
      sortByApartmentName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apartmentName', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy>
      sortByApartmentNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apartmentName', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> sortByBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balance', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> sortByBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balance', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> sortByDownPayment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downPayment', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy>
      sortByDownPaymentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downPayment', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy>
      sortByExclusiveArea() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exclusiveArea', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy>
      sortByExclusiveAreaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exclusiveArea', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy>
      sortByIntermediatePayment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intermediatePayment', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy>
      sortByIntermediatePaymentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intermediatePayment', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> sortByMemo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> sortByMemoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> sortByRegionCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'regionCode', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy>
      sortByRegionCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'regionCode', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> sortByTargetDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetDate', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy>
      sortByTargetDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetDate', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> sortByTargetPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetPrice', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy>
      sortByTargetPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetPrice', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> sortByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> sortByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension HomeGoalModelQuerySortThenBy
    on QueryBuilder<HomeGoalModel, HomeGoalModel, QSortThenBy> {
  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> thenByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> thenByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy>
      thenByApartmentName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apartmentName', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy>
      thenByApartmentNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apartmentName', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> thenByBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balance', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> thenByBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balance', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> thenByDownPayment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downPayment', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy>
      thenByDownPaymentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downPayment', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy>
      thenByExclusiveArea() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exclusiveArea', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy>
      thenByExclusiveAreaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exclusiveArea', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy>
      thenByIntermediatePayment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intermediatePayment', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy>
      thenByIntermediatePaymentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intermediatePayment', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> thenByMemo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> thenByMemoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> thenByRegionCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'regionCode', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy>
      thenByRegionCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'regionCode', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> thenByTargetDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetDate', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy>
      thenByTargetDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetDate', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> thenByTargetPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetPrice', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy>
      thenByTargetPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetPrice', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> thenByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> thenByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension HomeGoalModelQueryWhereDistinct
    on QueryBuilder<HomeGoalModel, HomeGoalModel, QDistinct> {
  QueryBuilder<HomeGoalModel, HomeGoalModel, QDistinct> distinctByAddress(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'address', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QDistinct> distinctByApartmentName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'apartmentName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QDistinct> distinctByBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'balance');
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QDistinct>
      distinctByDownPayment() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'downPayment');
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QDistinct>
      distinctByExclusiveArea() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exclusiveArea');
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QDistinct>
      distinctByIntermediatePayment() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'intermediatePayment');
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QDistinct> distinctByMemo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'memo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QDistinct> distinctByRegionCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'regionCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QDistinct> distinctByTargetDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetDate');
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QDistinct>
      distinctByTargetPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetPrice');
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QDistinct> distinctByUid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HomeGoalModel, HomeGoalModel, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension HomeGoalModelQueryProperty
    on QueryBuilder<HomeGoalModel, HomeGoalModel, QQueryProperty> {
  QueryBuilder<HomeGoalModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<HomeGoalModel, String?, QQueryOperations> addressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'address');
    });
  }

  QueryBuilder<HomeGoalModel, String?, QQueryOperations>
      apartmentNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'apartmentName');
    });
  }

  QueryBuilder<HomeGoalModel, int?, QQueryOperations> balanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'balance');
    });
  }

  QueryBuilder<HomeGoalModel, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<HomeGoalModel, int?, QQueryOperations> downPaymentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'downPayment');
    });
  }

  QueryBuilder<HomeGoalModel, double?, QQueryOperations>
      exclusiveAreaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exclusiveArea');
    });
  }

  QueryBuilder<HomeGoalModel, int?, QQueryOperations>
      intermediatePaymentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'intermediatePayment');
    });
  }

  QueryBuilder<HomeGoalModel, String?, QQueryOperations> memoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'memo');
    });
  }

  QueryBuilder<HomeGoalModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<HomeGoalModel, String?, QQueryOperations> regionCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'regionCode');
    });
  }

  QueryBuilder<HomeGoalModel, DateTime?, QQueryOperations>
      targetDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetDate');
    });
  }

  QueryBuilder<HomeGoalModel, int, QQueryOperations> targetPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetPrice');
    });
  }

  QueryBuilder<HomeGoalModel, String, QQueryOperations> uidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uid');
    });
  }

  QueryBuilder<HomeGoalModel, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
