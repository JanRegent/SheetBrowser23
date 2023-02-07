// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'starredvals.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetStarredValCollection on Isar {
  IsarCollection<StarredVal> get starredVals => getCollection();
}

const StarredValSchema = CollectionSchema(
  name: 'StarredVal',
  schema:
      '{"name":"StarredVal","idName":"id","properties":[{"name":"sheetID","type":"Long"},{"name":"sheetName","type":"String"},{"name":"stars","type":"String"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {'sheetID': 0, 'sheetName': 1, 'stars': 2},
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _starredValGetId,
  setId: _starredValSetId,
  getLinks: _starredValGetLinks,
  attachLinks: _starredValAttachLinks,
  serializeNative: _starredValSerializeNative,
  deserializeNative: _starredValDeserializeNative,
  deserializePropNative: _starredValDeserializePropNative,
  serializeWeb: _starredValSerializeWeb,
  deserializeWeb: _starredValDeserializeWeb,
  deserializePropWeb: _starredValDeserializePropWeb,
  version: 3,
);

int? _starredValGetId(StarredVal object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _starredValSetId(StarredVal object, int id) {
  object.id = id;
}

List<IsarLinkBase> _starredValGetLinks(StarredVal object) {
  return [];
}

void _starredValSerializeNative(
    IsarCollection<StarredVal> collection,
    IsarRawObject rawObj,
    StarredVal object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
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

StarredVal _starredValDeserializeNative(IsarCollection<StarredVal> collection,
    int id, IsarBinaryReader reader, List<int> offsets) {
  final object = StarredVal();
  object.id = id;
  object.sheetID = reader.readLong(offsets[0]);
  object.sheetName = reader.readString(offsets[1]);
  object.stars = reader.readString(offsets[2]);
  return object;
}

P _starredValDeserializePropNative<P>(
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

dynamic _starredValSerializeWeb(
    IsarCollection<StarredVal> collection, StarredVal object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'sheetID', object.sheetID);
  IsarNative.jsObjectSet(jsObj, 'sheetName', object.sheetName);
  IsarNative.jsObjectSet(jsObj, 'stars', object.stars);
  return jsObj;
}

StarredVal _starredValDeserializeWeb(
    IsarCollection<StarredVal> collection, dynamic jsObj) {
  final object = StarredVal();
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.sheetID =
      IsarNative.jsObjectGet(jsObj, 'sheetID') ?? double.negativeInfinity;
  object.sheetName = IsarNative.jsObjectGet(jsObj, 'sheetName') ?? '';
  object.stars = IsarNative.jsObjectGet(jsObj, 'stars') ?? '';
  return object;
}

P _starredValDeserializePropWeb<P>(Object jsObj, String propertyName) {
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

void _starredValAttachLinks(IsarCollection col, int id, StarredVal object) {}

extension StarredValQueryWhereSort
    on QueryBuilder<StarredVal, StarredVal, QWhere> {
  QueryBuilder<StarredVal, StarredVal, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension StarredValQueryWhere
    on QueryBuilder<StarredVal, StarredVal, QWhereClause> {
  QueryBuilder<StarredVal, StarredVal, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<StarredVal, StarredVal, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<StarredVal, StarredVal, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<StarredVal, StarredVal, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<StarredVal, StarredVal, QAfterWhereClause> idBetween(
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

extension StarredValQueryFilter
    on QueryBuilder<StarredVal, StarredVal, QFilterCondition> {
  QueryBuilder<StarredVal, StarredVal, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<StarredVal, StarredVal, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<StarredVal, StarredVal, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<StarredVal, StarredVal, QAfterFilterCondition> idBetween(
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

  QueryBuilder<StarredVal, StarredVal, QAfterFilterCondition> sheetIDEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'sheetID',
      value: value,
    ));
  }

  QueryBuilder<StarredVal, StarredVal, QAfterFilterCondition>
      sheetIDGreaterThan(
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

  QueryBuilder<StarredVal, StarredVal, QAfterFilterCondition> sheetIDLessThan(
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

  QueryBuilder<StarredVal, StarredVal, QAfterFilterCondition> sheetIDBetween(
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

  QueryBuilder<StarredVal, StarredVal, QAfterFilterCondition> sheetNameEqualTo(
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

  QueryBuilder<StarredVal, StarredVal, QAfterFilterCondition>
      sheetNameGreaterThan(
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

  QueryBuilder<StarredVal, StarredVal, QAfterFilterCondition> sheetNameLessThan(
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

  QueryBuilder<StarredVal, StarredVal, QAfterFilterCondition> sheetNameBetween(
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

  QueryBuilder<StarredVal, StarredVal, QAfterFilterCondition>
      sheetNameStartsWith(
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

  QueryBuilder<StarredVal, StarredVal, QAfterFilterCondition> sheetNameEndsWith(
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

  QueryBuilder<StarredVal, StarredVal, QAfterFilterCondition> sheetNameContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'sheetName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<StarredVal, StarredVal, QAfterFilterCondition> sheetNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'sheetName',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<StarredVal, StarredVal, QAfterFilterCondition> starsEqualTo(
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

  QueryBuilder<StarredVal, StarredVal, QAfterFilterCondition> starsGreaterThan(
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

  QueryBuilder<StarredVal, StarredVal, QAfterFilterCondition> starsLessThan(
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

  QueryBuilder<StarredVal, StarredVal, QAfterFilterCondition> starsBetween(
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

  QueryBuilder<StarredVal, StarredVal, QAfterFilterCondition> starsStartsWith(
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

  QueryBuilder<StarredVal, StarredVal, QAfterFilterCondition> starsEndsWith(
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

  QueryBuilder<StarredVal, StarredVal, QAfterFilterCondition> starsContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'stars',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<StarredVal, StarredVal, QAfterFilterCondition> starsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'stars',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension StarredValQueryLinks
    on QueryBuilder<StarredVal, StarredVal, QFilterCondition> {}

extension StarredValQueryWhereSortBy
    on QueryBuilder<StarredVal, StarredVal, QSortBy> {
  QueryBuilder<StarredVal, StarredVal, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<StarredVal, StarredVal, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<StarredVal, StarredVal, QAfterSortBy> sortBySheetID() {
    return addSortByInternal('sheetID', Sort.asc);
  }

  QueryBuilder<StarredVal, StarredVal, QAfterSortBy> sortBySheetIDDesc() {
    return addSortByInternal('sheetID', Sort.desc);
  }

  QueryBuilder<StarredVal, StarredVal, QAfterSortBy> sortBySheetName() {
    return addSortByInternal('sheetName', Sort.asc);
  }

  QueryBuilder<StarredVal, StarredVal, QAfterSortBy> sortBySheetNameDesc() {
    return addSortByInternal('sheetName', Sort.desc);
  }

  QueryBuilder<StarredVal, StarredVal, QAfterSortBy> sortByStars() {
    return addSortByInternal('stars', Sort.asc);
  }

  QueryBuilder<StarredVal, StarredVal, QAfterSortBy> sortByStarsDesc() {
    return addSortByInternal('stars', Sort.desc);
  }
}

extension StarredValQueryWhereSortThenBy
    on QueryBuilder<StarredVal, StarredVal, QSortThenBy> {
  QueryBuilder<StarredVal, StarredVal, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<StarredVal, StarredVal, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<StarredVal, StarredVal, QAfterSortBy> thenBySheetID() {
    return addSortByInternal('sheetID', Sort.asc);
  }

  QueryBuilder<StarredVal, StarredVal, QAfterSortBy> thenBySheetIDDesc() {
    return addSortByInternal('sheetID', Sort.desc);
  }

  QueryBuilder<StarredVal, StarredVal, QAfterSortBy> thenBySheetName() {
    return addSortByInternal('sheetName', Sort.asc);
  }

  QueryBuilder<StarredVal, StarredVal, QAfterSortBy> thenBySheetNameDesc() {
    return addSortByInternal('sheetName', Sort.desc);
  }

  QueryBuilder<StarredVal, StarredVal, QAfterSortBy> thenByStars() {
    return addSortByInternal('stars', Sort.asc);
  }

  QueryBuilder<StarredVal, StarredVal, QAfterSortBy> thenByStarsDesc() {
    return addSortByInternal('stars', Sort.desc);
  }
}

extension StarredValQueryWhereDistinct
    on QueryBuilder<StarredVal, StarredVal, QDistinct> {
  QueryBuilder<StarredVal, StarredVal, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<StarredVal, StarredVal, QDistinct> distinctBySheetID() {
    return addDistinctByInternal('sheetID');
  }

  QueryBuilder<StarredVal, StarredVal, QDistinct> distinctBySheetName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('sheetName', caseSensitive: caseSensitive);
  }

  QueryBuilder<StarredVal, StarredVal, QDistinct> distinctByStars(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('stars', caseSensitive: caseSensitive);
  }
}

extension StarredValQueryProperty
    on QueryBuilder<StarredVal, StarredVal, QQueryProperty> {
  QueryBuilder<StarredVal, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<StarredVal, int, QQueryOperations> sheetIDProperty() {
    return addPropertyNameInternal('sheetID');
  }

  QueryBuilder<StarredVal, String, QQueryOperations> sheetNameProperty() {
    return addPropertyNameInternal('sheetName');
  }

  QueryBuilder<StarredVal, String, QQueryOperations> starsProperty() {
    return addPropertyNameInternal('stars');
  }
}
