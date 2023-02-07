// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'star.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetStarCollection on Isar {
  IsarCollection<Star> get stars => getCollection();
}

const StarSchema = CollectionSchema(
  name: 'Star',
  schema:
      '{"name":"Star","idName":"id","properties":[{"name":"sheetID","type":"Long"},{"name":"sheetName","type":"String"},{"name":"stars","type":"String"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {'sheetID': 0, 'sheetName': 1, 'stars': 2},
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _starGetId,
  setId: _starSetId,
  getLinks: _starGetLinks,
  attachLinks: _starAttachLinks,
  serializeNative: _starSerializeNative,
  deserializeNative: _starDeserializeNative,
  deserializePropNative: _starDeserializePropNative,
  serializeWeb: _starSerializeWeb,
  deserializeWeb: _starDeserializeWeb,
  deserializePropWeb: _starDeserializePropWeb,
  version: 3,
);

int? _starGetId(Star object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _starSetId(Star object, int id) {
  object.id = id;
}

List<IsarLinkBase> _starGetLinks(Star object) {
  return [];
}

void _starSerializeNative(IsarCollection<Star> collection, IsarRawObject rawObj,
    Star object, int staticSize, List<int> offsets, AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.sheetID;
  final _sheetID = value0;
  final value1 = object.sheetName;
  final _sheetName = IsarBinaryWriter.utf8Encoder.convert(value1);
  dynamicSize += (_sheetName.length) as int;
  final value2 = object.stars;
  final _stars = IsarBinaryWriter.utf8Encoder.convert(value2);
  dynamicSize += (_stars.length) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeLong(offsets[0], _sheetID);
  writer.writeBytes(offsets[1], _sheetName);
  writer.writeBytes(offsets[2], _stars);
}

Star _starDeserializeNative(IsarCollection<Star> collection, int id,
    IsarBinaryReader reader, List<int> offsets) {
  final object = Star();
  object.id = id;
  object.sheetID = reader.readLong(offsets[0]);
  object.sheetName = reader.readString(offsets[1]);
  object.stars = reader.readString(offsets[2]);
  return object;
}

P _starDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _starSerializeWeb(IsarCollection<Star> collection, Star object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'sheetID', object.sheetID);
  IsarNative.jsObjectSet(jsObj, 'sheetName', object.sheetName);
  IsarNative.jsObjectSet(jsObj, 'stars', object.stars);
  return jsObj;
}

Star _starDeserializeWeb(IsarCollection<Star> collection, dynamic jsObj) {
  final object = Star();
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.sheetID =
      IsarNative.jsObjectGet(jsObj, 'sheetID') ?? double.negativeInfinity;
  object.sheetName = IsarNative.jsObjectGet(jsObj, 'sheetName') ?? '';
  object.stars = IsarNative.jsObjectGet(jsObj, 'stars') ?? '';
  return object;
}

P _starDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'sheetID':
      return (IsarNative.jsObjectGet(jsObj, 'sheetID') ??
          double.negativeInfinity) as P;
    case 'sheetName':
      return (IsarNative.jsObjectGet(jsObj, 'sheetName') ?? '') as P;
    case 'stars':
      return (IsarNative.jsObjectGet(jsObj, 'stars') ?? '') as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _starAttachLinks(IsarCollection col, int id, Star object) {}

extension StarQueryWhereSort on QueryBuilder<Star, Star, QWhere> {
  QueryBuilder<Star, Star, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension StarQueryWhere on QueryBuilder<Star, Star, QWhereClause> {
  QueryBuilder<Star, Star, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<Star, Star, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<Star, Star, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<Star, Star, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<Star, Star, QAfterWhereClause> idBetween(
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

extension StarQueryFilter on QueryBuilder<Star, Star, QFilterCondition> {
  QueryBuilder<Star, Star, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Star, Star, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Star, Star, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Star, Star, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Star, Star, QAfterFilterCondition> sheetIDEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'sheetID',
      value: value,
    ));
  }

  QueryBuilder<Star, Star, QAfterFilterCondition> sheetIDGreaterThan(
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

  QueryBuilder<Star, Star, QAfterFilterCondition> sheetIDLessThan(
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

  QueryBuilder<Star, Star, QAfterFilterCondition> sheetIDBetween(
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

  QueryBuilder<Star, Star, QAfterFilterCondition> sheetNameEqualTo(
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

  QueryBuilder<Star, Star, QAfterFilterCondition> sheetNameGreaterThan(
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

  QueryBuilder<Star, Star, QAfterFilterCondition> sheetNameLessThan(
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

  QueryBuilder<Star, Star, QAfterFilterCondition> sheetNameBetween(
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

  QueryBuilder<Star, Star, QAfterFilterCondition> sheetNameStartsWith(
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

  QueryBuilder<Star, Star, QAfterFilterCondition> sheetNameEndsWith(
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

  QueryBuilder<Star, Star, QAfterFilterCondition> sheetNameContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'sheetName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Star, Star, QAfterFilterCondition> sheetNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'sheetName',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Star, Star, QAfterFilterCondition> starsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'stars',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Star, Star, QAfterFilterCondition> starsGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'stars',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Star, Star, QAfterFilterCondition> starsLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'stars',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Star, Star, QAfterFilterCondition> starsBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'stars',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Star, Star, QAfterFilterCondition> starsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'stars',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Star, Star, QAfterFilterCondition> starsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'stars',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Star, Star, QAfterFilterCondition> starsContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'stars',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Star, Star, QAfterFilterCondition> starsMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'stars',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension StarQueryLinks on QueryBuilder<Star, Star, QFilterCondition> {}

extension StarQueryWhereSortBy on QueryBuilder<Star, Star, QSortBy> {
  QueryBuilder<Star, Star, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Star, Star, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Star, Star, QAfterSortBy> sortBySheetID() {
    return addSortByInternal('sheetID', Sort.asc);
  }

  QueryBuilder<Star, Star, QAfterSortBy> sortBySheetIDDesc() {
    return addSortByInternal('sheetID', Sort.desc);
  }

  QueryBuilder<Star, Star, QAfterSortBy> sortBySheetName() {
    return addSortByInternal('sheetName', Sort.asc);
  }

  QueryBuilder<Star, Star, QAfterSortBy> sortBySheetNameDesc() {
    return addSortByInternal('sheetName', Sort.desc);
  }

  QueryBuilder<Star, Star, QAfterSortBy> sortByStars() {
    return addSortByInternal('stars', Sort.asc);
  }

  QueryBuilder<Star, Star, QAfterSortBy> sortByStarsDesc() {
    return addSortByInternal('stars', Sort.desc);
  }
}

extension StarQueryWhereSortThenBy on QueryBuilder<Star, Star, QSortThenBy> {
  QueryBuilder<Star, Star, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Star, Star, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Star, Star, QAfterSortBy> thenBySheetID() {
    return addSortByInternal('sheetID', Sort.asc);
  }

  QueryBuilder<Star, Star, QAfterSortBy> thenBySheetIDDesc() {
    return addSortByInternal('sheetID', Sort.desc);
  }

  QueryBuilder<Star, Star, QAfterSortBy> thenBySheetName() {
    return addSortByInternal('sheetName', Sort.asc);
  }

  QueryBuilder<Star, Star, QAfterSortBy> thenBySheetNameDesc() {
    return addSortByInternal('sheetName', Sort.desc);
  }

  QueryBuilder<Star, Star, QAfterSortBy> thenByStars() {
    return addSortByInternal('stars', Sort.asc);
  }

  QueryBuilder<Star, Star, QAfterSortBy> thenByStarsDesc() {
    return addSortByInternal('stars', Sort.desc);
  }
}

extension StarQueryWhereDistinct on QueryBuilder<Star, Star, QDistinct> {
  QueryBuilder<Star, Star, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Star, Star, QDistinct> distinctBySheetID() {
    return addDistinctByInternal('sheetID');
  }

  QueryBuilder<Star, Star, QDistinct> distinctBySheetName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('sheetName', caseSensitive: caseSensitive);
  }

  QueryBuilder<Star, Star, QDistinct> distinctByStars(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('stars', caseSensitive: caseSensitive);
  }
}

extension StarQueryProperty on QueryBuilder<Star, Star, QQueryProperty> {
  QueryBuilder<Star, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Star, int, QQueryOperations> sheetIDProperty() {
    return addPropertyNameInternal('sheetID');
  }

  QueryBuilder<Star, String, QQueryOperations> sheetNameProperty() {
    return addPropertyNameInternal('sheetName');
  }

  QueryBuilder<Star, String, QQueryOperations> starsProperty() {
    return addPropertyNameInternal('stars');
  }
}
