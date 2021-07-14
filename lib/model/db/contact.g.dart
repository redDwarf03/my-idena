// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) {
  return Contact(
    name: json['name'] as String?,
    address: json['address'] as String?,
  )
    ..status = json['status'] as String?
    ..online = json['online'] as bool?;
}

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'status': instance.status,
      'online': instance.online,
    };
