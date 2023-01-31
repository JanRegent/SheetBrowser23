// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'log.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetLogCollection on Isar {
  IsarCollection<Log> get logs => getCollection();
}

const LogSchema = CollectionSchema(
  name: 'Log',
  schema:
      '{"name":"Log","idName":"id","properties":[{"name":"aDateTime","type":"String"},{"name":"aStep","type":"String"},{"name":"clasFunc","type":"String"},{"name":"descr","type":"String"},{"name":"error","type":"String"},{"name":"mess","type":"String"},{"name":"stackTrace","type":"String"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {
    'aDateTime': 0,
    'aStep': 1,
    'clasFunc': 2,
    'descr': 3,
    'error': 4,
    'mess': 5,
    'stackTrace': 6
  },
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _logGetId,
  setId: _logSetId,
  getLinks: _logGetLinks,
  attachLinks: _logAttachLinks,
  serializeNative: _logSerializeNative,
  deserializeNative: _logDeserializeNative,
  deserializePropNative: _logDeserializePropNative,
  serializeWeb: _logSerializeWeb,
  deserializeWeb: _logDeserializeWeb,
  deserializePropWeb: _logDeserializePropWeb,
  version: 3,
);

int? _logGetId(Log object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _logSetId(Log object, int id) {
  object.id = id;
}

List<IsarLinkBase> _logGetLinks(Log object) {
  return [];
}

void _logSerializeNative(IsarCollection<Log> collection, IsarRawObject rawObj,
    Log object, int staticSize, List<int> offsets, AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.aDateTime;
  final _aDateTime = IsarBinaryWriter.utf8Encoder.convert(value0);
  dynamicSize += (_aDateTime.length) as int;
  final value1 = object.aStep;
  final _aStep = IsarBinaryWriter.utf8Encoder.convert(value1);
  dynamicSize += (_aStep.length) as int;
  final value2 = object.clasFunc;
  final _clasFunc = IsarBinaryWriter.utf8Encoder.convert(value2);
  dynamicSize += (_clasFunc.length) as int;
  final value3 = object.descr;
  final _descr = IsarBinaryWriter.utf8Encoder.convert(value3);
  dynamicSize += (_descr.length) as int;
  final value4 = object.error;
  final _error = IsarBinaryWriter.utf8Encoder.convert(value4);
  dynamicSize += (_error.length) as int;
  final value5 = object.mess;
  final _mess = IsarBinaryWriter.utf8Encoder.convert(value5);
  dynamicSize += (_mess.length) as int;
  final value6 = object.stackTrace;
  final _stackTrace = IsarBinaryWriter.utf8Encoder.convert(value6);
  dynamicSize += (_stackTrace.length) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _aDateTime);
  writer.writeBytes(offsets[1], _aStep);
  writer.writeBytes(offsets[2], _clasFunc);
  writer.writeBytes(offsets[3], _descr);
  writer.writeBytes(offsets[4], _error);
  writer.writeBytes(offsets[5], _mess);
  writer.writeBytes(offsets[6], _stackTrace);
}

Log _logDeserializeNative(IsarCollection<Log> collection, int id,
    IsarBinaryReader reader, List<int> offsets) {
  final object = Log();
  object.aDateTime = reader.readString(offsets[0]);
  object.aStep = reader.readString(offsets[1]);
  object.clasFunc = reader.readString(offsets[2]);
  object.descr = reader.readString(offsets[3]);
  object.error = reader.readString(offsets[4]);
  object.id = id;
  object.mess = reader.readString(offsets[5]);
  object.stackTrace = reader.readString(offsets[6]);
  return object;
}

P _logDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _logSerializeWeb(IsarCollection<Log> collection, Log object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'aDateTime', object.aDateTime);
  IsarNative.jsObjectSet(jsObj, 'aStep', object.aStep);
  IsarNative.jsObjectSet(jsObj, 'clasFunc', object.clasFunc);
  IsarNative.jsObjectSet(jsObj, 'descr', object.descr);
  IsarNative.jsObjectSet(jsObj, 'error', object.error);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'mess', object.mess);
  IsarNative.jsObjectSet(jsObj, 'stackTrace', object.stackTrace);
  return jsObj;
}

Log _logDeserializeWeb(IsarCollection<Log> collection, dynamic jsObj) {
  final object = Log();
  object.aDateTime = IsarNative.jsObjectGet(jsObj, 'aDateTime') ?? '';
  object.aStep = IsarNative.jsObjectGet(jsObj, 'aStep') ?? '';
  object.clasFunc = IsarNative.jsObjectGet(jsObj, 'clasFunc') ?? '';
  object.descr = IsarNative.jsObjectGet(jsObj, 'descr') ?? '';
  object.error = IsarNative.jsObjectGet(jsObj, 'error') ?? '';
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.mess = IsarNative.jsObjectGet(jsObj, 'mess') ?? '';
  object.stackTrace = IsarNative.jsObjectGet(jsObj, 'stackTrace') ?? '';
  return object;
}

P _logDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'aDateTime':
      return (IsarNative.jsObjectGet(jsObj, 'aDateTime') ?? '') as P;
    case 'aStep':
      return (IsarNative.jsObjectGet(jsObj, 'aStep') ?? '') as P;
    case 'clasFunc':
      return (IsarNative.jsObjectGet(jsObj, 'clasFunc') ?? '') as P;
    case 'descr':
      return (IsarNative.jsObjectGet(jsObj, 'descr') ?? '') as P;
    case 'error':
      return (IsarNative.jsObjectGet(jsObj, 'error') ?? '') as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'mess':
      return (IsarNative.jsObjectGet(jsObj, 'mess') ?? '') as P;
    case 'stackTrace':
      return (IsarNative.jsObjectGet(jsObj, 'stackTrace') ?? '') as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _logAttachLinks(IsarCollection col, int id, Log object) {}

extension LogQueryWhereSort on QueryBuilder<Log, Log, QWhere> {
  QueryBuilder<Log, Log, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension LogQueryWhere on QueryBuilder<Log, Log, QWhereClause> {
  QueryBuilder<Log, Log, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<Log, Log, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<Log, Log, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<Log, Log, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<Log, Log, QAfterWhereClause> idBetween(
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

extension LogQueryFilter on QueryBuilder<Log, Log, QFilterCondition> {
  QueryBuilder<Log, Log, QAfterFilterCondition> aDateTimeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'aDateTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> aDateTimeGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'aDateTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> aDateTimeLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'aDateTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> aDateTimeBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'aDateTime',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> aDateTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'aDateTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> aDateTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'aDateTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> aDateTimeContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'aDateTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> aDateTimeMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'aDateTime',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> aStepEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'aStep',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> aStepGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'aStep',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> aStepLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'aStep',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> aStepBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'aStep',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> aStepStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'aStep',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> aStepEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'aStep',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> aStepContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'aStep',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> aStepMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'aStep',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> clasFuncEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'clasFunc',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> clasFuncGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'clasFunc',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> clasFuncLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'clasFunc',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> clasFuncBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'clasFunc',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> clasFuncStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'clasFunc',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> clasFuncEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'clasFunc',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> clasFuncContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'clasFunc',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> clasFuncMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'clasFunc',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> descrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'descr',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> descrGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'descr',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> descrLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'descr',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> descrBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'descr',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> descrStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'descr',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> descrEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'descr',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> descrContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'descr',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> descrMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'descr',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> errorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'error',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> errorGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'error',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> errorLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'error',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> errorBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'error',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> errorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'error',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> errorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'error',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> errorContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'error',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> errorMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'error',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Log, Log, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Log, Log, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Log, Log, QAfterFilterCondition> messEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'mess',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> messGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'mess',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> messLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'mess',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> messBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'mess',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> messStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'mess',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> messEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'mess',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> messContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'mess',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> messMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'mess',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> stackTraceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'stackTrace',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> stackTraceGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'stackTrace',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> stackTraceLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'stackTrace',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> stackTraceBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'stackTrace',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> stackTraceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'stackTrace',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> stackTraceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'stackTrace',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> stackTraceContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'stackTrace',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Log, Log, QAfterFilterCondition> stackTraceMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'stackTrace',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension LogQueryLinks on QueryBuilder<Log, Log, QFilterCondition> {}

extension LogQueryWhereSortBy on QueryBuilder<Log, Log, QSortBy> {
  QueryBuilder<Log, Log, QAfterSortBy> sortByADateTime() {
    return addSortByInternal('aDateTime', Sort.asc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> sortByADateTimeDesc() {
    return addSortByInternal('aDateTime', Sort.desc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> sortByAStep() {
    return addSortByInternal('aStep', Sort.asc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> sortByAStepDesc() {
    return addSortByInternal('aStep', Sort.desc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> sortByClasFunc() {
    return addSortByInternal('clasFunc', Sort.asc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> sortByClasFuncDesc() {
    return addSortByInternal('clasFunc', Sort.desc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> sortByDescr() {
    return addSortByInternal('descr', Sort.asc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> sortByDescrDesc() {
    return addSortByInternal('descr', Sort.desc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> sortByError() {
    return addSortByInternal('error', Sort.asc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> sortByErrorDesc() {
    return addSortByInternal('error', Sort.desc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> sortByMess() {
    return addSortByInternal('mess', Sort.asc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> sortByMessDesc() {
    return addSortByInternal('mess', Sort.desc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> sortByStackTrace() {
    return addSortByInternal('stackTrace', Sort.asc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> sortByStackTraceDesc() {
    return addSortByInternal('stackTrace', Sort.desc);
  }
}

extension LogQueryWhereSortThenBy on QueryBuilder<Log, Log, QSortThenBy> {
  QueryBuilder<Log, Log, QAfterSortBy> thenByADateTime() {
    return addSortByInternal('aDateTime', Sort.asc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> thenByADateTimeDesc() {
    return addSortByInternal('aDateTime', Sort.desc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> thenByAStep() {
    return addSortByInternal('aStep', Sort.asc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> thenByAStepDesc() {
    return addSortByInternal('aStep', Sort.desc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> thenByClasFunc() {
    return addSortByInternal('clasFunc', Sort.asc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> thenByClasFuncDesc() {
    return addSortByInternal('clasFunc', Sort.desc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> thenByDescr() {
    return addSortByInternal('descr', Sort.asc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> thenByDescrDesc() {
    return addSortByInternal('descr', Sort.desc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> thenByError() {
    return addSortByInternal('error', Sort.asc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> thenByErrorDesc() {
    return addSortByInternal('error', Sort.desc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> thenByMess() {
    return addSortByInternal('mess', Sort.asc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> thenByMessDesc() {
    return addSortByInternal('mess', Sort.desc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> thenByStackTrace() {
    return addSortByInternal('stackTrace', Sort.asc);
  }

  QueryBuilder<Log, Log, QAfterSortBy> thenByStackTraceDesc() {
    return addSortByInternal('stackTrace', Sort.desc);
  }
}

extension LogQueryWhereDistinct on QueryBuilder<Log, Log, QDistinct> {
  QueryBuilder<Log, Log, QDistinct> distinctByADateTime(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('aDateTime', caseSensitive: caseSensitive);
  }

  QueryBuilder<Log, Log, QDistinct> distinctByAStep(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('aStep', caseSensitive: caseSensitive);
  }

  QueryBuilder<Log, Log, QDistinct> distinctByClasFunc(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clasFunc', caseSensitive: caseSensitive);
  }

  QueryBuilder<Log, Log, QDistinct> distinctByDescr(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('descr', caseSensitive: caseSensitive);
  }

  QueryBuilder<Log, Log, QDistinct> distinctByError(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('error', caseSensitive: caseSensitive);
  }

  QueryBuilder<Log, Log, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Log, Log, QDistinct> distinctByMess(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('mess', caseSensitive: caseSensitive);
  }

  QueryBuilder<Log, Log, QDistinct> distinctByStackTrace(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('stackTrace', caseSensitive: caseSensitive);
  }
}

extension LogQueryProperty on QueryBuilder<Log, Log, QQueryProperty> {
  QueryBuilder<Log, String, QQueryOperations> aDateTimeProperty() {
    return addPropertyNameInternal('aDateTime');
  }

  QueryBuilder<Log, String, QQueryOperations> aStepProperty() {
    return addPropertyNameInternal('aStep');
  }

  QueryBuilder<Log, String, QQueryOperations> clasFuncProperty() {
    return addPropertyNameInternal('clasFunc');
  }

  QueryBuilder<Log, String, QQueryOperations> descrProperty() {
    return addPropertyNameInternal('descr');
  }

  QueryBuilder<Log, String, QQueryOperations> errorProperty() {
    return addPropertyNameInternal('error');
  }

  QueryBuilder<Log, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Log, String, QQueryOperations> messProperty() {
    return addPropertyNameInternal('mess');
  }

  QueryBuilder<Log, String, QQueryOperations> stackTraceProperty() {
    return addPropertyNameInternal('stackTrace');
  }
}
