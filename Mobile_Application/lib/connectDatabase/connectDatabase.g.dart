// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectDatabase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      json['id'] as int?,
      json['title'] as String,
      json['description'] as String,
      json['contributors'] as String,
      json['startDate'] as String,
      json['endDate'] as String,
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'contributors': instance.contributors,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };

Feedback _$FeedbackFromJson(Map<String, dynamic> json) => Feedback(
      json['id'] as int?,
      json['projectId'] as int,
      json['visitorName'] as String,
      json['speech'] as String,
      json['date'] as String,
    );

Map<String, dynamic> _$FeedbackToJson(Feedback instance) => <String, dynamic>{
      'id': instance.id,
      'projectId': instance.projectId,
      'visitorName': instance.visitorName,
      'speech': instance.speech,
      'date': instance.date,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      json['id'] as int?,
      json['feedbackId'] as int,
      json['feedback'] as String,
      json['score'] as double,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'id': instance.id,
      'feedbackId': instance.feedbackId,
      'feedback': instance.feedback,
      'score': instance.score,
    };
