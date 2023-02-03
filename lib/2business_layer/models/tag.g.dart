// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'tag.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetTagCollection on Isar {
  IsarCollection<Tag> get tags => getCollection();
}

const TagSchema = CollectionSchema(
  name: 'Tag',
  schema:
      '{"name":"Tag","idName":"id","properties":[{"name":"sheetrowIds","type":"LongList"},{"name":"tag","type":"String"}],"indexes":[{"name":"tag","unique":true,"properties":[{"name":"tag","type":"Hash","caseSensitive":true}]}],"links":[]}',
  idName: 'id',
  propertyIds: {'sheetrowIds': 0, 'tag': 1},
  listProperties: {'sheetrowIds'},
  indexIds: {'tag': 0},
  indexValueTypes: {
    'tag': [
      IndexValueType.stringHash,
    ]
  },
  linkIds: {},
  backlinkLinkNames: {},
  getId: _tagGetId,
  setId: _tagSetId,
  getLinks: _tagGetLinks,
  attachLinks: _tagAttachLinks,
  serializeNative: _tagSerializeNative,
  deserializeNative: _tagDeserializeNative,
  deserializePropNative: _tagDeserializePropNative,
  serializeWeb: _tagSerializeWeb,
  deserializeWeb: _tagDeserializeWeb,
  deserializePropWeb: _tagDeserializePropWeb,
  version: 3,
);

int? _tagGetId(Tag object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _tagSetId(Tag object, int id) {
  object.id = id;
}

List<IsarLinkBase> _tagGetLinks(Tag object) {
  return [];
}

void _tagSerializeNative(IsarCollection<Tag> collection, IsarRawObject rawObj,
    Tag object, int staticSize, List<int> offsets, AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.sheetrowIds;
  dynamicSize += (value0.length) * 8;
  final _sheetrowIds = value0;
  final value1 = object.tag;
  final _tag = IsarBinaryWriter.utf8Encoder.convert(value1);
  dynamicSize += (_tag.length) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeLongList(offsets[0], _sheetrowIds);
  writer.writeBytes(offsets[1], _tag);
}

Tag _tagDeserializeNative(IsarCollection<Tag> collection, int id,
    IsarBinaryReader reader, List<int> offsets) {
  final object = Tag();
  object.id = id;
  object.sheetrowIds = reader.readLongList(offsets[0]) ?? [];
  object.tag = reader.readString(offsets[1]);
  return object;
}

P _tagDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readLongList(offset) ?? []) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _tagSerializeWeb(IsarCollection<Tag> collection, Tag object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'sheetrowIds', object.sheetrowIds);
  IsarNative.jsObjectSet(jsObj, 'tag', object.tag);
  return jsObj;
}

Tag _tagDeserializeWeb(IsarCollection<Tag> collection, dynamic jsObj) {
  final object = Tag();
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.sheetrowIds = (IsarNative.jsObjectGet(jsObj, 'sheetrowIds') as List?)
          ?.map((e) => e ?? double.negativeInfinity)
          .toList()
          .cast<int>() ??
      [];
  object.tag = IsarNative.jsObjectGet(jsObj, 'tag') ?? '';
  return object;
}

P _tagDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'sheetrowIds':
      return ((IsarNative.jsObjectGet(jsObj, 'sheetrowIds') as List?)
              ?.map((e) => e ?? double.negativeInfinity)
              .toList()
              .cast<int>() ??
          []) as P;
    case 'tag':
      return (IsarNative.jsObjectGet(jsObj, 'tag') ?? '') as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _tagAttachLinks(IsarCollection col, int id, Tag object) {}

extension TagByIndex on IsarCollection<Tag> {
  Future<Tag?> getByTag(String tag) {
    return getByIndex('tag', [tag]);
  }

  Tag? getByTagSync(String tag) {
    return getByIndexSync('tag', [tag]);
  }

  Future<bool> deleteByTag(String tag) {
    return deleteByIndex('tag', [tag]);
  }

  bool deleteByTagSync(String tag) {
    return deleteByIndexSync('tag', [tag]);
  }

  Future<List<Tag?>> getAllByTag(List<String> tagValues) {
    final values = tagValues.map((e) => [e]).toList();
    return getAllByIndex('tag', values);
  }

  List<Tag?> getAllByTagSync(List<String> tagValues) {
    final values = tagValues.map((e) => [e]).toList();
    return getAllByIndexSync('tag', values);
  }

  Future<int> deleteAllByTag(List<String> tagValues) {
    final values = tagValues.map((e) => [e]).toList();
    return deleteAllByIndex('tag', values);
  }

  int deleteAllByTagSync(List<String> tagValues) {
    final values = tagValues.map((e) => [e]).toList();
    return deleteAllByIndexSync('tag', values);
  }
}

extension TagQueryWhereSort on QueryBuilder<Tag, Tag, QWhere> {
  QueryBuilder<Tag, Tag, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }

  QueryBuilder<Tag, Tag, QAfterWhere> anyTag() {
    return addWhereClauseInternal(const IndexWhereClause.any(indexName: 'tag'));
  }
}

extension TagQueryWhere on QueryBuilder<Tag, Tag, QWhereClause> {
  QueryBuilder<Tag, Tag, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<Tag, Tag, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<Tag, Tag, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<Tag, Tag, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<Tag, Tag, QAfterWhereClause> idBetween(
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

  QueryBuilder<Tag, Tag, QAfterWhereClause> tagEqualTo(String tag) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'tag',
      value: [tag],
    ));
  }

  QueryBuilder<Tag, Tag, QAfterWhereClause> tagNotEqualTo(String tag) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'tag',
        upper: [tag],
        includeUpper: false,
      )).addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'tag',
        lower: [tag],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'tag',
        lower: [tag],
        includeLower: false,
      )).addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'tag',
        upper: [tag],
        includeUpper: false,
      ));
    }
  }
}

extension TagQueryFilter on QueryBuilder<Tag, Tag, QFilterCondition> {
  QueryBuilder<Tag, Tag, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Tag, Tag, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Tag, Tag, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Tag, Tag, QAfterFilterCondition> sheetrowIdsAnyEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'sheetrowIds',
      value: value,
    ));
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> sheetrowIdsAnyGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'sheetrowIds',
      value: value,
    ));
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> sheetrowIdsAnyLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'sheetrowIds',
      value: value,
    ));
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> sheetrowIdsAnyBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'sheetrowIds',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> tagEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'tag',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> tagGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'tag',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> tagLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'tag',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> tagBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'tag',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> tagStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'tag',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> tagEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'tag',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> tagContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'tag',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> tagMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'tag',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension TagQueryLinks on QueryBuilder<Tag, Tag, QFilterCondition> {}

extension TagQueryWhereSortBy on QueryBuilder<Tag, Tag, QSortBy> {
  QueryBuilder<Tag, Tag, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByTag() {
    return addSortByInternal('tag', Sort.asc);
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByTagDesc() {
    return addSortByInternal('tag', Sort.desc);
  }
}

extension TagQueryWhereSortThenBy on QueryBuilder<Tag, Tag, QSortThenBy> {
  QueryBuilder<Tag, Tag, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByTag() {
    return addSortByInternal('tag', Sort.asc);
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByTagDesc() {
    return addSortByInternal('tag', Sort.desc);
  }
}

extension TagQueryWhereDistinct on QueryBuilder<Tag, Tag, QDistinct> {
  QueryBuilder<Tag, Tag, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Tag, Tag, QDistinct> distinctByTag({bool caseSensitive = true}) {
    return addDistinctByInternal('tag', caseSensitive: caseSensitive);
  }
}

extension TagQueryProperty on QueryBuilder<Tag, Tag, QQueryProperty> {
  QueryBuilder<Tag, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Tag, List<int>, QQueryOperations> sheetrowIdsProperty() {
    return addPropertyNameInternal('sheetrowIds');
  }

  QueryBuilder<Tag, String, QQueryOperations> tagProperty() {
    return addPropertyNameInternal('tag');
  }
}
