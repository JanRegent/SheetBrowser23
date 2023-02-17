// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'sheet.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetSheetCollection on Isar {
  IsarCollection<Sheet> get sheets => getCollection();
}

const SheetSchema = CollectionSchema(
  name: 'Sheet',
  schema:
      '{"name":"Sheet","idName":"id","properties":[{"name":"aKey","type":"String"},{"name":"aSheetName","type":"String"},{"name":"rowArr","type":"StringList"},{"name":"selections","type":"StringList"},{"name":"sheetId","type":"Long"},{"name":"tags","type":"StringList"},{"name":"zfileId","type":"String"}],"indexes":[{"name":"aKey","unique":false,"properties":[{"name":"aKey","type":"Value","caseSensitive":true}]},{"name":"aSheetName","unique":false,"properties":[{"name":"aSheetName","type":"Value","caseSensitive":true}]},{"name":"selections","unique":false,"properties":[{"name":"selections","type":"Value","caseSensitive":true}]},{"name":"tags","unique":false,"properties":[{"name":"tags","type":"Value","caseSensitive":true}]}],"links":[]}',
  idName: 'id',
  propertyIds: {
    'aKey': 0,
    'aSheetName': 1,
    'rowArr': 2,
    'selections': 3,
    'sheetId': 4,
    'tags': 5,
    'zfileId': 6
  },
  listProperties: {'rowArr', 'selections', 'tags'},
  indexIds: {'aKey': 0, 'aSheetName': 1, 'selections': 2, 'tags': 3},
  indexValueTypes: {
    'aKey': [
      IndexValueType.string,
    ],
    'aSheetName': [
      IndexValueType.string,
    ],
    'selections': [
      IndexValueType.string,
    ],
    'tags': [
      IndexValueType.string,
    ]
  },
  linkIds: {},
  backlinkLinkNames: {},
  getId: _sheetGetId,
  setId: _sheetSetId,
  getLinks: _sheetGetLinks,
  attachLinks: _sheetAttachLinks,
  serializeNative: _sheetSerializeNative,
  deserializeNative: _sheetDeserializeNative,
  deserializePropNative: _sheetDeserializePropNative,
  serializeWeb: _sheetSerializeWeb,
  deserializeWeb: _sheetDeserializeWeb,
  deserializePropWeb: _sheetDeserializePropWeb,
  version: 3,
);

int? _sheetGetId(Sheet object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _sheetSetId(Sheet object, int id) {
  object.id = id;
}

List<IsarLinkBase> _sheetGetLinks(Sheet object) {
  return [];
}

void _sheetSerializeNative(
    IsarCollection<Sheet> collection,
    IsarRawObject rawObj,
    Sheet object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.aKey;
  final _aKey = IsarBinaryWriter.utf8Encoder.convert(value0);
  dynamicSize += (_aKey.length) as int;
  final value1 = object.aSheetName;
  final _aSheetName = IsarBinaryWriter.utf8Encoder.convert(value1);
  dynamicSize += (_aSheetName.length) as int;
  final value2 = object.rowArr;
  dynamicSize += (value2.length) * 8;
  final bytesList2 = <IsarUint8List>[];
  for (var str in value2) {
    final bytes = IsarBinaryWriter.utf8Encoder.convert(str);
    bytesList2.add(bytes);
    dynamicSize += bytes.length as int;
  }
  final _rowArr = bytesList2;
  final value3 = object.selections;
  dynamicSize += (value3.length) * 8;
  final bytesList3 = <IsarUint8List>[];
  for (var str in value3) {
    final bytes = IsarBinaryWriter.utf8Encoder.convert(str);
    bytesList3.add(bytes);
    dynamicSize += bytes.length as int;
  }
  final _selections = bytesList3;
  final value4 = object.sheetId;
  final _sheetId = value4;
  final value5 = object.tags;
  dynamicSize += (value5.length) * 8;
  final bytesList5 = <IsarUint8List>[];
  for (var str in value5) {
    final bytes = IsarBinaryWriter.utf8Encoder.convert(str);
    bytesList5.add(bytes);
    dynamicSize += bytes.length as int;
  }
  final _tags = bytesList5;
  final value6 = object.zfileId;
  final _zfileId = IsarBinaryWriter.utf8Encoder.convert(value6);
  dynamicSize += (_zfileId.length) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _aKey);
  writer.writeBytes(offsets[1], _aSheetName);
  writer.writeStringList(offsets[2], _rowArr);
  writer.writeStringList(offsets[3], _selections);
  writer.writeLong(offsets[4], _sheetId);
  writer.writeStringList(offsets[5], _tags);
  writer.writeBytes(offsets[6], _zfileId);
}

Sheet _sheetDeserializeNative(IsarCollection<Sheet> collection, int id,
    IsarBinaryReader reader, List<int> offsets) {
  final object = Sheet();
  object.aKey = reader.readString(offsets[0]);
  object.aSheetName = reader.readString(offsets[1]);
  object.id = id;
  object.rowArr = reader.readStringList(offsets[2]) ?? [];
  object.selections = reader.readStringList(offsets[3]) ?? [];
  object.sheetId = reader.readLong(offsets[4]);
  object.tags = reader.readStringList(offsets[5]) ?? [];
  object.zfileId = reader.readString(offsets[6]);
  return object;
}

P _sheetDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringList(offset) ?? []) as P;
    case 3:
      return (reader.readStringList(offset) ?? []) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readStringList(offset) ?? []) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _sheetSerializeWeb(IsarCollection<Sheet> collection, Sheet object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'aKey', object.aKey);
  IsarNative.jsObjectSet(jsObj, 'aSheetName', object.aSheetName);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'rowArr', object.rowArr);
  IsarNative.jsObjectSet(jsObj, 'selections', object.selections);
  IsarNative.jsObjectSet(jsObj, 'sheetId', object.sheetId);
  IsarNative.jsObjectSet(jsObj, 'tags', object.tags);
  IsarNative.jsObjectSet(jsObj, 'zfileId', object.zfileId);
  return jsObj;
}

Sheet _sheetDeserializeWeb(IsarCollection<Sheet> collection, dynamic jsObj) {
  final object = Sheet();
  object.aKey = IsarNative.jsObjectGet(jsObj, 'aKey') ?? '';
  object.aSheetName = IsarNative.jsObjectGet(jsObj, 'aSheetName') ?? '';
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.rowArr = (IsarNative.jsObjectGet(jsObj, 'rowArr') as List?)
          ?.map((e) => e ?? '')
          .toList()
          .cast<String>() ??
      [];
  object.selections = (IsarNative.jsObjectGet(jsObj, 'selections') as List?)
          ?.map((e) => e ?? '')
          .toList()
          .cast<String>() ??
      [];
  object.sheetId =
      IsarNative.jsObjectGet(jsObj, 'sheetId') ?? double.negativeInfinity;
  object.tags = (IsarNative.jsObjectGet(jsObj, 'tags') as List?)
          ?.map((e) => e ?? '')
          .toList()
          .cast<String>() ??
      [];
  object.zfileId = IsarNative.jsObjectGet(jsObj, 'zfileId') ?? '';
  return object;
}

P _sheetDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'aKey':
      return (IsarNative.jsObjectGet(jsObj, 'aKey') ?? '') as P;
    case 'aSheetName':
      return (IsarNative.jsObjectGet(jsObj, 'aSheetName') ?? '') as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'rowArr':
      return ((IsarNative.jsObjectGet(jsObj, 'rowArr') as List?)
              ?.map((e) => e ?? '')
              .toList()
              .cast<String>() ??
          []) as P;
    case 'selections':
      return ((IsarNative.jsObjectGet(jsObj, 'selections') as List?)
              ?.map((e) => e ?? '')
              .toList()
              .cast<String>() ??
          []) as P;
    case 'sheetId':
      return (IsarNative.jsObjectGet(jsObj, 'sheetId') ??
          double.negativeInfinity) as P;
    case 'tags':
      return ((IsarNative.jsObjectGet(jsObj, 'tags') as List?)
              ?.map((e) => e ?? '')
              .toList()
              .cast<String>() ??
          []) as P;
    case 'zfileId':
      return (IsarNative.jsObjectGet(jsObj, 'zfileId') ?? '') as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _sheetAttachLinks(IsarCollection col, int id, Sheet object) {}

extension SheetQueryWhereSort on QueryBuilder<Sheet, Sheet, QWhere> {
  QueryBuilder<Sheet, Sheet, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }

  QueryBuilder<Sheet, Sheet, QAfterWhere> anyAKey() {
    return addWhereClauseInternal(
        const IndexWhereClause.any(indexName: 'aKey'));
  }

  QueryBuilder<Sheet, Sheet, QAfterWhere> anyASheetName() {
    return addWhereClauseInternal(
        const IndexWhereClause.any(indexName: 'aSheetName'));
  }

  QueryBuilder<Sheet, Sheet, QAfterWhere> anySelectionsAny() {
    return addWhereClauseInternal(
        const IndexWhereClause.any(indexName: 'selections'));
  }

  QueryBuilder<Sheet, Sheet, QAfterWhere> anyTagsAny() {
    return addWhereClauseInternal(
        const IndexWhereClause.any(indexName: 'tags'));
  }
}

extension SheetQueryWhere on QueryBuilder<Sheet, Sheet, QWhereClause> {
  QueryBuilder<Sheet, Sheet, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> idBetween(
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

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> aKeyEqualTo(String aKey) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'aKey',
      value: [aKey],
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> aKeyNotEqualTo(String aKey) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'aKey',
        upper: [aKey],
        includeUpper: false,
      )).addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'aKey',
        lower: [aKey],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'aKey',
        lower: [aKey],
        includeLower: false,
      )).addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'aKey',
        upper: [aKey],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> aKeyGreaterThan(
    String aKey, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.greaterThan(
      indexName: 'aKey',
      lower: [aKey],
      includeLower: include,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> aKeyLessThan(
    String aKey, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.lessThan(
      indexName: 'aKey',
      upper: [aKey],
      includeUpper: include,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> aKeyBetween(
    String lowerAKey,
    String upperAKey, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IndexWhereClause.between(
      indexName: 'aKey',
      lower: [lowerAKey],
      includeLower: includeLower,
      upper: [upperAKey],
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> aKeyStartsWith(
      String AKeyPrefix) {
    return addWhereClauseInternal(IndexWhereClause.between(
      indexName: 'aKey',
      lower: [AKeyPrefix],
      includeLower: true,
      upper: ['$AKeyPrefix\u{FFFFF}'],
      includeUpper: true,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> aSheetNameEqualTo(
      String aSheetName) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'aSheetName',
      value: [aSheetName],
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> aSheetNameNotEqualTo(
      String aSheetName) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'aSheetName',
        upper: [aSheetName],
        includeUpper: false,
      )).addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'aSheetName',
        lower: [aSheetName],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'aSheetName',
        lower: [aSheetName],
        includeLower: false,
      )).addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'aSheetName',
        upper: [aSheetName],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> aSheetNameGreaterThan(
    String aSheetName, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.greaterThan(
      indexName: 'aSheetName',
      lower: [aSheetName],
      includeLower: include,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> aSheetNameLessThan(
    String aSheetName, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.lessThan(
      indexName: 'aSheetName',
      upper: [aSheetName],
      includeUpper: include,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> aSheetNameBetween(
    String lowerASheetName,
    String upperASheetName, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IndexWhereClause.between(
      indexName: 'aSheetName',
      lower: [lowerASheetName],
      includeLower: includeLower,
      upper: [upperASheetName],
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> aSheetNameStartsWith(
      String ASheetNamePrefix) {
    return addWhereClauseInternal(IndexWhereClause.between(
      indexName: 'aSheetName',
      lower: [ASheetNamePrefix],
      includeLower: true,
      upper: ['$ASheetNamePrefix\u{FFFFF}'],
      includeUpper: true,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> selectionsAnyEqualTo(
      String selectionsElement) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'selections',
      value: [selectionsElement],
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> selectionsAnyNotEqualTo(
      String selectionsElement) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'selections',
        upper: [selectionsElement],
        includeUpper: false,
      )).addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'selections',
        lower: [selectionsElement],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'selections',
        lower: [selectionsElement],
        includeLower: false,
      )).addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'selections',
        upper: [selectionsElement],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> selectionsAnyGreaterThan(
    String selectionsElement, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.greaterThan(
      indexName: 'selections',
      lower: [selectionsElement],
      includeLower: include,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> selectionsAnyLessThan(
    String selectionsElement, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.lessThan(
      indexName: 'selections',
      upper: [selectionsElement],
      includeUpper: include,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> selectionsAnyBetween(
    String lowerSelectionsElement,
    String upperSelectionsElement, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IndexWhereClause.between(
      indexName: 'selections',
      lower: [lowerSelectionsElement],
      includeLower: includeLower,
      upper: [upperSelectionsElement],
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> selectionsAnyStartsWith(
      String SelectionsElementPrefix) {
    return addWhereClauseInternal(IndexWhereClause.between(
      indexName: 'selections',
      lower: [SelectionsElementPrefix],
      includeLower: true,
      upper: ['$SelectionsElementPrefix\u{FFFFF}'],
      includeUpper: true,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> tagsAnyEqualTo(
      String tagsElement) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'tags',
      value: [tagsElement],
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> tagsAnyNotEqualTo(
      String tagsElement) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'tags',
        upper: [tagsElement],
        includeUpper: false,
      )).addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'tags',
        lower: [tagsElement],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'tags',
        lower: [tagsElement],
        includeLower: false,
      )).addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'tags',
        upper: [tagsElement],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> tagsAnyGreaterThan(
    String tagsElement, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.greaterThan(
      indexName: 'tags',
      lower: [tagsElement],
      includeLower: include,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> tagsAnyLessThan(
    String tagsElement, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.lessThan(
      indexName: 'tags',
      upper: [tagsElement],
      includeUpper: include,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> tagsAnyBetween(
    String lowerTagsElement,
    String upperTagsElement, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IndexWhereClause.between(
      indexName: 'tags',
      lower: [lowerTagsElement],
      includeLower: includeLower,
      upper: [upperTagsElement],
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterWhereClause> tagsAnyStartsWith(
      String TagsElementPrefix) {
    return addWhereClauseInternal(IndexWhereClause.between(
      indexName: 'tags',
      lower: [TagsElementPrefix],
      includeLower: true,
      upper: ['$TagsElementPrefix\u{FFFFF}'],
      includeUpper: true,
    ));
  }
}

extension SheetQueryFilter on QueryBuilder<Sheet, Sheet, QFilterCondition> {
  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> aKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'aKey',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> aKeyGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'aKey',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> aKeyLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'aKey',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> aKeyBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'aKey',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> aKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'aKey',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> aKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'aKey',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> aKeyContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'aKey',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> aKeyMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'aKey',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> aSheetNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'aSheetName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> aSheetNameGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'aSheetName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> aSheetNameLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'aSheetName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> aSheetNameBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'aSheetName',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> aSheetNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'aSheetName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> aSheetNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'aSheetName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> aSheetNameContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'aSheetName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> aSheetNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'aSheetName',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> rowArrAnyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'rowArr',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> rowArrAnyGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'rowArr',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> rowArrAnyLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'rowArr',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> rowArrAnyBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'rowArr',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> rowArrAnyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'rowArr',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> rowArrAnyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'rowArr',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> rowArrAnyContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'rowArr',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> rowArrAnyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'rowArr',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> selectionsAnyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'selections',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> selectionsAnyGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'selections',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> selectionsAnyLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'selections',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> selectionsAnyBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'selections',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> selectionsAnyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'selections',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> selectionsAnyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'selections',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> selectionsAnyContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'selections',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> selectionsAnyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'selections',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> sheetIdEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'sheetId',
      value: value,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> sheetIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'sheetId',
      value: value,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> sheetIdLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'sheetId',
      value: value,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> sheetIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'sheetId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> tagsAnyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'tags',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> tagsAnyGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'tags',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> tagsAnyLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'tags',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> tagsAnyBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'tags',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> tagsAnyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'tags',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> tagsAnyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'tags',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> tagsAnyContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'tags',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> tagsAnyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'tags',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> zfileIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'zfileId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> zfileIdGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'zfileId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> zfileIdLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'zfileId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> zfileIdBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'zfileId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> zfileIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'zfileId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> zfileIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'zfileId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> zfileIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'zfileId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Sheet, Sheet, QAfterFilterCondition> zfileIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'zfileId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension SheetQueryLinks on QueryBuilder<Sheet, Sheet, QFilterCondition> {}

extension SheetQueryWhereSortBy on QueryBuilder<Sheet, Sheet, QSortBy> {
  QueryBuilder<Sheet, Sheet, QAfterSortBy> sortByAKey() {
    return addSortByInternal('aKey', Sort.asc);
  }

  QueryBuilder<Sheet, Sheet, QAfterSortBy> sortByAKeyDesc() {
    return addSortByInternal('aKey', Sort.desc);
  }

  QueryBuilder<Sheet, Sheet, QAfterSortBy> sortByASheetName() {
    return addSortByInternal('aSheetName', Sort.asc);
  }

  QueryBuilder<Sheet, Sheet, QAfterSortBy> sortByASheetNameDesc() {
    return addSortByInternal('aSheetName', Sort.desc);
  }

  QueryBuilder<Sheet, Sheet, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Sheet, Sheet, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Sheet, Sheet, QAfterSortBy> sortBySheetId() {
    return addSortByInternal('sheetId', Sort.asc);
  }

  QueryBuilder<Sheet, Sheet, QAfterSortBy> sortBySheetIdDesc() {
    return addSortByInternal('sheetId', Sort.desc);
  }

  QueryBuilder<Sheet, Sheet, QAfterSortBy> sortByZfileId() {
    return addSortByInternal('zfileId', Sort.asc);
  }

  QueryBuilder<Sheet, Sheet, QAfterSortBy> sortByZfileIdDesc() {
    return addSortByInternal('zfileId', Sort.desc);
  }
}

extension SheetQueryWhereSortThenBy on QueryBuilder<Sheet, Sheet, QSortThenBy> {
  QueryBuilder<Sheet, Sheet, QAfterSortBy> thenByAKey() {
    return addSortByInternal('aKey', Sort.asc);
  }

  QueryBuilder<Sheet, Sheet, QAfterSortBy> thenByAKeyDesc() {
    return addSortByInternal('aKey', Sort.desc);
  }

  QueryBuilder<Sheet, Sheet, QAfterSortBy> thenByASheetName() {
    return addSortByInternal('aSheetName', Sort.asc);
  }

  QueryBuilder<Sheet, Sheet, QAfterSortBy> thenByASheetNameDesc() {
    return addSortByInternal('aSheetName', Sort.desc);
  }

  QueryBuilder<Sheet, Sheet, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Sheet, Sheet, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Sheet, Sheet, QAfterSortBy> thenBySheetId() {
    return addSortByInternal('sheetId', Sort.asc);
  }

  QueryBuilder<Sheet, Sheet, QAfterSortBy> thenBySheetIdDesc() {
    return addSortByInternal('sheetId', Sort.desc);
  }

  QueryBuilder<Sheet, Sheet, QAfterSortBy> thenByZfileId() {
    return addSortByInternal('zfileId', Sort.asc);
  }

  QueryBuilder<Sheet, Sheet, QAfterSortBy> thenByZfileIdDesc() {
    return addSortByInternal('zfileId', Sort.desc);
  }
}

extension SheetQueryWhereDistinct on QueryBuilder<Sheet, Sheet, QDistinct> {
  QueryBuilder<Sheet, Sheet, QDistinct> distinctByAKey(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('aKey', caseSensitive: caseSensitive);
  }

  QueryBuilder<Sheet, Sheet, QDistinct> distinctByASheetName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('aSheetName', caseSensitive: caseSensitive);
  }

  QueryBuilder<Sheet, Sheet, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Sheet, Sheet, QDistinct> distinctBySheetId() {
    return addDistinctByInternal('sheetId');
  }

  QueryBuilder<Sheet, Sheet, QDistinct> distinctByZfileId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('zfileId', caseSensitive: caseSensitive);
  }
}

extension SheetQueryProperty on QueryBuilder<Sheet, Sheet, QQueryProperty> {
  QueryBuilder<Sheet, String, QQueryOperations> aKeyProperty() {
    return addPropertyNameInternal('aKey');
  }

  QueryBuilder<Sheet, String, QQueryOperations> aSheetNameProperty() {
    return addPropertyNameInternal('aSheetName');
  }

  QueryBuilder<Sheet, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Sheet, List<String>, QQueryOperations> rowArrProperty() {
    return addPropertyNameInternal('rowArr');
  }

  QueryBuilder<Sheet, List<String>, QQueryOperations> selectionsProperty() {
    return addPropertyNameInternal('selections');
  }

  QueryBuilder<Sheet, int, QQueryOperations> sheetIdProperty() {
    return addPropertyNameInternal('sheetId');
  }

  QueryBuilder<Sheet, List<String>, QQueryOperations> tagsProperty() {
    return addPropertyNameInternal('tags');
  }

  QueryBuilder<Sheet, String, QQueryOperations> zfileIdProperty() {
    return addPropertyNameInternal('zfileId');
  }
}
