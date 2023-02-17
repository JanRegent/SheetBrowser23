// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'rels.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetRelCollection on Isar {
  IsarCollection<Rel> get rels => getCollection();
}

const RelSchema = CollectionSchema(
  name: 'Rel',
  schema:
      '{"name":"Rel","idName":"id","properties":[{"name":"localId","type":"Long"},{"name":"selName","type":"String"},{"name":"sheetID","type":"Long"},{"name":"sheetName","type":"String"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {'localId': 0, 'selName': 1, 'sheetID': 2, 'sheetName': 3},
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _relGetId,
  setId: _relSetId,
  getLinks: _relGetLinks,
  attachLinks: _relAttachLinks,
  serializeNative: _relSerializeNative,
  deserializeNative: _relDeserializeNative,
  deserializePropNative: _relDeserializePropNative,
  serializeWeb: _relSerializeWeb,
  deserializeWeb: _relDeserializeWeb,
  deserializePropWeb: _relDeserializePropWeb,
  version: 3,
);

int? _relGetId(Rel object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _relSetId(Rel object, int id) {
  object.id = id;
}

List<IsarLinkBase> _relGetLinks(Rel object) {
  return [];
}

void _relSerializeNative(IsarCollection<Rel> collection, IsarRawObject rawObj,
    Rel object, int staticSize, List<int> offsets, AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.localId;
  final _localId = value0;
  final value1 = object.selName;
  final _selName = IsarBinaryWriter.utf8Encoder.convert(value1);
  dynamicSize += (_selName.length) as int;
  final value2 = object.sheetID;
  final _sheetID = value2;
  final value3 = object.sheetName;
  final _sheetName = IsarBinaryWriter.utf8Encoder.convert(value3);
  dynamicSize += (_sheetName.length) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeLong(offsets[0], _localId);
  writer.writeBytes(offsets[1], _selName);
  writer.writeLong(offsets[2], _sheetID);
  writer.writeBytes(offsets[3], _sheetName);
}

Rel _relDeserializeNative(IsarCollection<Rel> collection, int id,
    IsarBinaryReader reader, List<int> offsets) {
  final object = Rel();
  object.id = id;
  object.localId = reader.readLong(offsets[0]);
  object.selName = reader.readString(offsets[1]);
  object.sheetID = reader.readLong(offsets[2]);
  object.sheetName = reader.readString(offsets[3]);
  return object;
}

P _relDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _relSerializeWeb(IsarCollection<Rel> collection, Rel object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'localId', object.localId);
  IsarNative.jsObjectSet(jsObj, 'selName', object.selName);
  IsarNative.jsObjectSet(jsObj, 'sheetID', object.sheetID);
  IsarNative.jsObjectSet(jsObj, 'sheetName', object.sheetName);
  return jsObj;
}

Rel _relDeserializeWeb(IsarCollection<Rel> collection, dynamic jsObj) {
  final object = Rel();
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.localId =
      IsarNative.jsObjectGet(jsObj, 'localId') ?? double.negativeInfinity;
  object.selName = IsarNative.jsObjectGet(jsObj, 'selName') ?? '';
  object.sheetID =
      IsarNative.jsObjectGet(jsObj, 'sheetID') ?? double.negativeInfinity;
  object.sheetName = IsarNative.jsObjectGet(jsObj, 'sheetName') ?? '';
  return object;
}

P _relDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'localId':
      return (IsarNative.jsObjectGet(jsObj, 'localId') ??
          double.negativeInfinity) as P;
    case 'selName':
      return (IsarNative.jsObjectGet(jsObj, 'selName') ?? '') as P;
    case 'sheetID':
      return (IsarNative.jsObjectGet(jsObj, 'sheetID') ??
          double.negativeInfinity) as P;
    case 'sheetName':
      return (IsarNative.jsObjectGet(jsObj, 'sheetName') ?? '') as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _relAttachLinks(IsarCollection col, int id, Rel object) {}

extension RelQueryWhereSort on QueryBuilder<Rel, Rel, QWhere> {
  QueryBuilder<Rel, Rel, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension RelQueryWhere on QueryBuilder<Rel, Rel, QWhereClause> {
  QueryBuilder<Rel, Rel, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterWhereClause> idNotEqualTo(int id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      ).addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      );
    } else {
      return addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      ).addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      );
    }
  }

  QueryBuilder<Rel, Rel, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<Rel, Rel, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<Rel, Rel, QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: lowerId,
      includeLower: includeLower,
      upper: upperId,
      includeUpper: includeUpper,
    ));
  }
}

extension RelQueryFilter on QueryBuilder<Rel, Rel, QFilterCondition> {
  QueryBuilder<Rel, Rel, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> idLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> localIdEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'localId',
      value: value,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> localIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'localId',
      value: value,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> localIdLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'localId',
      value: value,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> localIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'localId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> selNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'selName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> selNameGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'selName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> selNameLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'selName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> selNameBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'selName',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> selNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'selName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> selNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'selName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> selNameContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'selName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> selNameMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'selName',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> sheetIDEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'sheetID',
      value: value,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> sheetIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'sheetID',
      value: value,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> sheetIDLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'sheetID',
      value: value,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> sheetIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'sheetID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> sheetNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'sheetName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> sheetNameGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'sheetName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> sheetNameLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'sheetName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> sheetNameBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'sheetName',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> sheetNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'sheetName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> sheetNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'sheetName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> sheetNameContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'sheetName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rel, Rel, QAfterFilterCondition> sheetNameMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'sheetName',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension RelQueryLinks on QueryBuilder<Rel, Rel, QFilterCondition> {}

extension RelQueryWhereSortBy on QueryBuilder<Rel, Rel, QSortBy> {
  QueryBuilder<Rel, Rel, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Rel, Rel, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Rel, Rel, QAfterSortBy> sortByLocalId() {
    return addSortByInternal('localId', Sort.asc);
  }

  QueryBuilder<Rel, Rel, QAfterSortBy> sortByLocalIdDesc() {
    return addSortByInternal('localId', Sort.desc);
  }

  QueryBuilder<Rel, Rel, QAfterSortBy> sortBySelName() {
    return addSortByInternal('selName', Sort.asc);
  }

  QueryBuilder<Rel, Rel, QAfterSortBy> sortBySelNameDesc() {
    return addSortByInternal('selName', Sort.desc);
  }

  QueryBuilder<Rel, Rel, QAfterSortBy> sortBySheetID() {
    return addSortByInternal('sheetID', Sort.asc);
  }

  QueryBuilder<Rel, Rel, QAfterSortBy> sortBySheetIDDesc() {
    return addSortByInternal('sheetID', Sort.desc);
  }

  QueryBuilder<Rel, Rel, QAfterSortBy> sortBySheetName() {
    return addSortByInternal('sheetName', Sort.asc);
  }

  QueryBuilder<Rel, Rel, QAfterSortBy> sortBySheetNameDesc() {
    return addSortByInternal('sheetName', Sort.desc);
  }
}

extension RelQueryWhereSortThenBy on QueryBuilder<Rel, Rel, QSortThenBy> {
  QueryBuilder<Rel, Rel, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Rel, Rel, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Rel, Rel, QAfterSortBy> thenByLocalId() {
    return addSortByInternal('localId', Sort.asc);
  }

  QueryBuilder<Rel, Rel, QAfterSortBy> thenByLocalIdDesc() {
    return addSortByInternal('localId', Sort.desc);
  }

  QueryBuilder<Rel, Rel, QAfterSortBy> thenBySelName() {
    return addSortByInternal('selName', Sort.asc);
  }

  QueryBuilder<Rel, Rel, QAfterSortBy> thenBySelNameDesc() {
    return addSortByInternal('selName', Sort.desc);
  }

  QueryBuilder<Rel, Rel, QAfterSortBy> thenBySheetID() {
    return addSortByInternal('sheetID', Sort.asc);
  }

  QueryBuilder<Rel, Rel, QAfterSortBy> thenBySheetIDDesc() {
    return addSortByInternal('sheetID', Sort.desc);
  }

  QueryBuilder<Rel, Rel, QAfterSortBy> thenBySheetName() {
    return addSortByInternal('sheetName', Sort.asc);
  }

  QueryBuilder<Rel, Rel, QAfterSortBy> thenBySheetNameDesc() {
    return addSortByInternal('sheetName', Sort.desc);
  }
}

extension RelQueryWhereDistinct on QueryBuilder<Rel, Rel, QDistinct> {
  QueryBuilder<Rel, Rel, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Rel, Rel, QDistinct> distinctByLocalId() {
    return addDistinctByInternal('localId');
  }

  QueryBuilder<Rel, Rel, QDistinct> distinctBySelName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('selName', caseSensitive: caseSensitive);
  }

  QueryBuilder<Rel, Rel, QDistinct> distinctBySheetID() {
    return addDistinctByInternal('sheetID');
  }

  QueryBuilder<Rel, Rel, QDistinct> distinctBySheetName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('sheetName', caseSensitive: caseSensitive);
  }
}

extension RelQueryProperty on QueryBuilder<Rel, Rel, QQueryProperty> {
  QueryBuilder<Rel, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Rel, int, QQueryOperations> localIdProperty() {
    return addPropertyNameInternal('localId');
  }

  QueryBuilder<Rel, String, QQueryOperations> selNameProperty() {
    return addPropertyNameInternal('selName');
  }

  QueryBuilder<Rel, int, QQueryOperations> sheetIDProperty() {
    return addPropertyNameInternal('sheetID');
  }

  QueryBuilder<Rel, String, QQueryOperations> sheetNameProperty() {
    return addPropertyNameInternal('sheetName');
  }
}
