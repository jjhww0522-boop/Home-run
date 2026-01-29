// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fixed_expense_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFixedExpenseModelCollection on Isar {
  IsarCollection<FixedExpenseModel> get fixedExpenseModels => this.collection();
}

const FixedExpenseModelSchema = CollectionSchema(
  name: r'FixedExpenseModel',
  id: 7937932144567558964,
  properties: {
    r'amount': PropertySchema(
      id: 0,
      name: r'amount',
      type: IsarType.long,
    ),
    r'category': PropertySchema(
      id: 1,
      name: r'category',
      type: IsarType.string,
      enumMap: _FixedExpenseModelcategoryEnumValueMap,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'customCategoryId': PropertySchema(
      id: 3,
      name: r'customCategoryId',
      type: IsarType.string,
    ),
    r'daysUntilDue': PropertySchema(
      id: 4,
      name: r'daysUntilDue',
      type: IsarType.long,
    ),
    r'dueDate': PropertySchema(
      id: 5,
      name: r'dueDate',
      type: IsarType.long,
    ),
    r'isActive': PropertySchema(
      id: 6,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'isOverdue': PropertySchema(
      id: 7,
      name: r'isOverdue',
      type: IsarType.bool,
    ),
    r'isRecurringMonthly': PropertySchema(
      id: 8,
      name: r'isRecurringMonthly',
      type: IsarType.bool,
    ),
    r'isVariableAmount': PropertySchema(
      id: 9,
      name: r'isVariableAmount',
      type: IsarType.bool,
    ),
    r'linkedAccountId': PropertySchema(
      id: 10,
      name: r'linkedAccountId',
      type: IsarType.long,
    ),
    r'linkedPaymentMethodId': PropertySchema(
      id: 11,
      name: r'linkedPaymentMethodId',
      type: IsarType.long,
    ),
    r'nextMonthDueDate': PropertySchema(
      id: 12,
      name: r'nextMonthDueDate',
      type: IsarType.dateTime,
    ),
    r'thisMonthDueDate': PropertySchema(
      id: 13,
      name: r'thisMonthDueDate',
      type: IsarType.dateTime,
    ),
    r'title': PropertySchema(
      id: 14,
      name: r'title',
      type: IsarType.string,
    ),
    r'uid': PropertySchema(
      id: 15,
      name: r'uid',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 16,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _fixedExpenseModelEstimateSize,
  serialize: _fixedExpenseModelSerialize,
  deserialize: _fixedExpenseModelDeserialize,
  deserializeProp: _fixedExpenseModelDeserializeProp,
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
    ),
    r'dueDate': IndexSchema(
      id: -7871003637559820552,
      name: r'dueDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dueDate',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isActive': IndexSchema(
      id: 8092228061260947457,
      name: r'isActive',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isActive',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _fixedExpenseModelGetId,
  getLinks: _fixedExpenseModelGetLinks,
  attach: _fixedExpenseModelAttach,
  version: '3.1.0+1',
);

int _fixedExpenseModelEstimateSize(
  FixedExpenseModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.category.name.length * 3;
  {
    final value = object.customCategoryId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.uid.length * 3;
  return bytesCount;
}

void _fixedExpenseModelSerialize(
  FixedExpenseModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.amount);
  writer.writeString(offsets[1], object.category.name);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeString(offsets[3], object.customCategoryId);
  writer.writeLong(offsets[4], object.daysUntilDue);
  writer.writeLong(offsets[5], object.dueDate);
  writer.writeBool(offsets[6], object.isActive);
  writer.writeBool(offsets[7], object.isOverdue);
  writer.writeBool(offsets[8], object.isRecurringMonthly);
  writer.writeBool(offsets[9], object.isVariableAmount);
  writer.writeLong(offsets[10], object.linkedAccountId);
  writer.writeLong(offsets[11], object.linkedPaymentMethodId);
  writer.writeDateTime(offsets[12], object.nextMonthDueDate);
  writer.writeDateTime(offsets[13], object.thisMonthDueDate);
  writer.writeString(offsets[14], object.title);
  writer.writeString(offsets[15], object.uid);
  writer.writeDateTime(offsets[16], object.updatedAt);
}

FixedExpenseModel _fixedExpenseModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FixedExpenseModel();
  object.amount = reader.readLongOrNull(offsets[0]);
  object.category = _FixedExpenseModelcategoryValueEnumMap[
          reader.readStringOrNull(offsets[1])] ??
      FixedExpenseCategory.housing;
  object.createdAt = reader.readDateTime(offsets[2]);
  object.customCategoryId = reader.readStringOrNull(offsets[3]);
  object.dueDate = reader.readLong(offsets[5]);
  object.id = id;
  object.isActive = reader.readBool(offsets[6]);
  object.isRecurringMonthly = reader.readBool(offsets[8]);
  object.isVariableAmount = reader.readBool(offsets[9]);
  object.linkedAccountId = reader.readLongOrNull(offsets[10]);
  object.linkedPaymentMethodId = reader.readLongOrNull(offsets[11]);
  object.title = reader.readString(offsets[14]);
  object.uid = reader.readString(offsets[15]);
  object.updatedAt = reader.readDateTime(offsets[16]);
  return object;
}

P _fixedExpenseModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (_FixedExpenseModelcategoryValueEnumMap[
              reader.readStringOrNull(offset)] ??
          FixedExpenseCategory.housing) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readLongOrNull(offset)) as P;
    case 11:
      return (reader.readLongOrNull(offset)) as P;
    case 12:
      return (reader.readDateTime(offset)) as P;
    case 13:
      return (reader.readDateTime(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _FixedExpenseModelcategoryEnumValueMap = {
  r'housing': r'housing',
  r'communication': r'communication',
  r'insurance': r'insurance',
  r'subscription': r'subscription',
  r'etc': r'etc',
};
const _FixedExpenseModelcategoryValueEnumMap = {
  r'housing': FixedExpenseCategory.housing,
  r'communication': FixedExpenseCategory.communication,
  r'insurance': FixedExpenseCategory.insurance,
  r'subscription': FixedExpenseCategory.subscription,
  r'etc': FixedExpenseCategory.etc,
};

Id _fixedExpenseModelGetId(FixedExpenseModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _fixedExpenseModelGetLinks(
    FixedExpenseModel object) {
  return [];
}

void _fixedExpenseModelAttach(
    IsarCollection<dynamic> col, Id id, FixedExpenseModel object) {
  object.id = id;
}

extension FixedExpenseModelByIndex on IsarCollection<FixedExpenseModel> {
  Future<FixedExpenseModel?> getByUid(String uid) {
    return getByIndex(r'uid', [uid]);
  }

  FixedExpenseModel? getByUidSync(String uid) {
    return getByIndexSync(r'uid', [uid]);
  }

  Future<bool> deleteByUid(String uid) {
    return deleteByIndex(r'uid', [uid]);
  }

  bool deleteByUidSync(String uid) {
    return deleteByIndexSync(r'uid', [uid]);
  }

  Future<List<FixedExpenseModel?>> getAllByUid(List<String> uidValues) {
    final values = uidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uid', values);
  }

  List<FixedExpenseModel?> getAllByUidSync(List<String> uidValues) {
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

  Future<Id> putByUid(FixedExpenseModel object) {
    return putByIndex(r'uid', object);
  }

  Id putByUidSync(FixedExpenseModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'uid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUid(List<FixedExpenseModel> objects) {
    return putAllByIndex(r'uid', objects);
  }

  List<Id> putAllByUidSync(List<FixedExpenseModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uid', objects, saveLinks: saveLinks);
  }
}

extension FixedExpenseModelQueryWhereSort
    on QueryBuilder<FixedExpenseModel, FixedExpenseModel, QWhere> {
  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterWhere> anyDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'dueDate'),
      );
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterWhere>
      anyIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isActive'),
      );
    });
  }
}

extension FixedExpenseModelQueryWhere
    on QueryBuilder<FixedExpenseModel, FixedExpenseModel, QWhereClause> {
  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterWhereClause>
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

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterWhereClause>
      idBetween(
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

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterWhereClause>
      uidEqualTo(String uid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uid',
        value: [uid],
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterWhereClause>
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

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterWhereClause>
      dueDateEqualTo(int dueDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dueDate',
        value: [dueDate],
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterWhereClause>
      dueDateNotEqualTo(int dueDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dueDate',
              lower: [],
              upper: [dueDate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dueDate',
              lower: [dueDate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dueDate',
              lower: [dueDate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dueDate',
              lower: [],
              upper: [dueDate],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterWhereClause>
      dueDateGreaterThan(
    int dueDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dueDate',
        lower: [dueDate],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterWhereClause>
      dueDateLessThan(
    int dueDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dueDate',
        lower: [],
        upper: [dueDate],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterWhereClause>
      dueDateBetween(
    int lowerDueDate,
    int upperDueDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dueDate',
        lower: [lowerDueDate],
        includeLower: includeLower,
        upper: [upperDueDate],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterWhereClause>
      isActiveEqualTo(bool isActive) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isActive',
        value: [isActive],
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterWhereClause>
      isActiveNotEqualTo(bool isActive) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isActive',
              lower: [],
              upper: [isActive],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isActive',
              lower: [isActive],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isActive',
              lower: [isActive],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isActive',
              lower: [],
              upper: [isActive],
              includeUpper: false,
            ));
      }
    });
  }
}

extension FixedExpenseModelQueryFilter
    on QueryBuilder<FixedExpenseModel, FixedExpenseModel, QFilterCondition> {
  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      amountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'amount',
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      amountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'amount',
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      amountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      amountGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      amountLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      amountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      categoryEqualTo(
    FixedExpenseCategory value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      categoryGreaterThan(
    FixedExpenseCategory value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      categoryLessThan(
    FixedExpenseCategory value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      categoryBetween(
    FixedExpenseCategory lower,
    FixedExpenseCategory upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
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

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
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

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
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

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      customCategoryIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customCategoryId',
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      customCategoryIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customCategoryId',
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      customCategoryIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customCategoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      customCategoryIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customCategoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      customCategoryIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customCategoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      customCategoryIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customCategoryId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      customCategoryIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'customCategoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      customCategoryIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'customCategoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      customCategoryIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customCategoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      customCategoryIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customCategoryId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      customCategoryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customCategoryId',
        value: '',
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      customCategoryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customCategoryId',
        value: '',
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      daysUntilDueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'daysUntilDue',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      daysUntilDueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'daysUntilDue',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      daysUntilDueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'daysUntilDue',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      daysUntilDueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'daysUntilDue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      dueDateEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      dueDateGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      dueDateLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      dueDateBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dueDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
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

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
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

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
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

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      isActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      isOverdueEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isOverdue',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      isRecurringMonthlyEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRecurringMonthly',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      isVariableAmountEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isVariableAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      linkedAccountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'linkedAccountId',
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      linkedAccountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'linkedAccountId',
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      linkedAccountIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'linkedAccountId',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      linkedAccountIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'linkedAccountId',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      linkedAccountIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'linkedAccountId',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      linkedAccountIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'linkedAccountId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      linkedPaymentMethodIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'linkedPaymentMethodId',
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      linkedPaymentMethodIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'linkedPaymentMethodId',
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      linkedPaymentMethodIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'linkedPaymentMethodId',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      linkedPaymentMethodIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'linkedPaymentMethodId',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      linkedPaymentMethodIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'linkedPaymentMethodId',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      linkedPaymentMethodIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'linkedPaymentMethodId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      nextMonthDueDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextMonthDueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      nextMonthDueDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextMonthDueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      nextMonthDueDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextMonthDueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      nextMonthDueDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextMonthDueDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      thisMonthDueDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thisMonthDueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      thisMonthDueDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'thisMonthDueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      thisMonthDueDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'thisMonthDueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      thisMonthDueDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'thisMonthDueDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
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

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
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

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
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

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
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

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
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

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
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

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      uidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      uidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      uidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      uidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
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

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
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

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterFilterCondition>
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

extension FixedExpenseModelQueryObject
    on QueryBuilder<FixedExpenseModel, FixedExpenseModel, QFilterCondition> {}

extension FixedExpenseModelQueryLinks
    on QueryBuilder<FixedExpenseModel, FixedExpenseModel, QFilterCondition> {}

extension FixedExpenseModelQuerySortBy
    on QueryBuilder<FixedExpenseModel, FixedExpenseModel, QSortBy> {
  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByCustomCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customCategoryId', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByCustomCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customCategoryId', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByDaysUntilDue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysUntilDue', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByDaysUntilDueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysUntilDue', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByIsOverdue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOverdue', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByIsOverdueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOverdue', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByIsRecurringMonthly() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRecurringMonthly', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByIsRecurringMonthlyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRecurringMonthly', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByIsVariableAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVariableAmount', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByIsVariableAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVariableAmount', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByLinkedAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedAccountId', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByLinkedAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedAccountId', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByLinkedPaymentMethodId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedPaymentMethodId', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByLinkedPaymentMethodIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedPaymentMethodId', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByNextMonthDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextMonthDueDate', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByNextMonthDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextMonthDueDate', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByThisMonthDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thisMonthDueDate', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByThisMonthDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thisMonthDueDate', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy> sortByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension FixedExpenseModelQuerySortThenBy
    on QueryBuilder<FixedExpenseModel, FixedExpenseModel, QSortThenBy> {
  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByCustomCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customCategoryId', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByCustomCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customCategoryId', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByDaysUntilDue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysUntilDue', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByDaysUntilDueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysUntilDue', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByIsOverdue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOverdue', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByIsOverdueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOverdue', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByIsRecurringMonthly() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRecurringMonthly', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByIsRecurringMonthlyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRecurringMonthly', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByIsVariableAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVariableAmount', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByIsVariableAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVariableAmount', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByLinkedAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedAccountId', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByLinkedAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedAccountId', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByLinkedPaymentMethodId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedPaymentMethodId', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByLinkedPaymentMethodIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedPaymentMethodId', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByNextMonthDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextMonthDueDate', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByNextMonthDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextMonthDueDate', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByThisMonthDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thisMonthDueDate', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByThisMonthDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thisMonthDueDate', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy> thenByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension FixedExpenseModelQueryWhereDistinct
    on QueryBuilder<FixedExpenseModel, FixedExpenseModel, QDistinct> {
  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QDistinct>
      distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QDistinct>
      distinctByCategory({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QDistinct>
      distinctByCustomCategoryId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customCategoryId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QDistinct>
      distinctByDaysUntilDue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'daysUntilDue');
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QDistinct>
      distinctByDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dueDate');
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QDistinct>
      distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QDistinct>
      distinctByIsOverdue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isOverdue');
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QDistinct>
      distinctByIsRecurringMonthly() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRecurringMonthly');
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QDistinct>
      distinctByIsVariableAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isVariableAmount');
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QDistinct>
      distinctByLinkedAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'linkedAccountId');
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QDistinct>
      distinctByLinkedPaymentMethodId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'linkedPaymentMethodId');
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QDistinct>
      distinctByNextMonthDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextMonthDueDate');
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QDistinct>
      distinctByThisMonthDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'thisMonthDueDate');
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QDistinct> distinctByUid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseModel, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension FixedExpenseModelQueryProperty
    on QueryBuilder<FixedExpenseModel, FixedExpenseModel, QQueryProperty> {
  QueryBuilder<FixedExpenseModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FixedExpenseModel, int?, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<FixedExpenseModel, FixedExpenseCategory, QQueryOperations>
      categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<FixedExpenseModel, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<FixedExpenseModel, String?, QQueryOperations>
      customCategoryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customCategoryId');
    });
  }

  QueryBuilder<FixedExpenseModel, int, QQueryOperations>
      daysUntilDueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'daysUntilDue');
    });
  }

  QueryBuilder<FixedExpenseModel, int, QQueryOperations> dueDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dueDate');
    });
  }

  QueryBuilder<FixedExpenseModel, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<FixedExpenseModel, bool, QQueryOperations> isOverdueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isOverdue');
    });
  }

  QueryBuilder<FixedExpenseModel, bool, QQueryOperations>
      isRecurringMonthlyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRecurringMonthly');
    });
  }

  QueryBuilder<FixedExpenseModel, bool, QQueryOperations>
      isVariableAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isVariableAmount');
    });
  }

  QueryBuilder<FixedExpenseModel, int?, QQueryOperations>
      linkedAccountIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'linkedAccountId');
    });
  }

  QueryBuilder<FixedExpenseModel, int?, QQueryOperations>
      linkedPaymentMethodIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'linkedPaymentMethodId');
    });
  }

  QueryBuilder<FixedExpenseModel, DateTime, QQueryOperations>
      nextMonthDueDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextMonthDueDate');
    });
  }

  QueryBuilder<FixedExpenseModel, DateTime, QQueryOperations>
      thisMonthDueDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'thisMonthDueDate');
    });
  }

  QueryBuilder<FixedExpenseModel, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<FixedExpenseModel, String, QQueryOperations> uidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uid');
    });
  }

  QueryBuilder<FixedExpenseModel, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
