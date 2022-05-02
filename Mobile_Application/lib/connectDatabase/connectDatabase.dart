import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'connectDatabase.g.dart';

Future<Project> fetchProject(int pk) async {
  final response = await http
      .get(Uri.parse('http://octopus:8000/api/project/' + pk.toString()));

  if (response.statusCode < 300) {
    return Project.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load project.');
  }
}

Future<List<Project>> fetchAllProject() async {
  final response = await http.get(Uri.parse('http://octopus:8000/api/project'));

  if (response.statusCode < 300) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Project>((json) => Project.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load projects.');
  }
}

Future<Feedback> fetchFeedback(int pk) async {
  final response = await http
      .get(Uri.parse('http://octopus:8000/api/feedback/' + pk.toString()));

  if (response.statusCode < 300) {
    return Feedback.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load feedback.');
  }
}

Future<List<Feedback>> fetchAllFeedback() async {
  final response =
      await http.get(Uri.parse('http://octopus:8000/api/feedback'));

  if (response.statusCode < 300) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Feedback>((json) => Feedback.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load feedbacks.');
  }
}

Future<Result> fetchResult(int pk) async {
  final response = await http
      .get(Uri.parse('http://octopus:8000/api/result/' + pk.toString()));

  if (response.statusCode < 300) {
    return Result.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load result.');
  }
}

Future<List<Result>> fetchAllResult() async {
  final response = await http.get(Uri.parse('http://octopus:8000/api/result'));

  if (response.statusCode < 300) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Result>((json) => Result.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load result.');
  }
}

Future<Project> createProject(Project project) async {
  final response = await http.post(Uri.parse('http://octopus:8000/api/project'),
      headers: {"Content-Type": "application/json"}, body: jsonEncode(project));

  if (response.statusCode < 300) {
    //print("................createProject done...............");
    return Project.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to save in database.');
  }
}

Future<Feedback> createFeedback(Feedback feedback) async {
  final response = await http.post(
      Uri.parse('http://octopus:8000/api/feedback'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(feedback));

  if (response.statusCode < 300) {
    //print("................createFeedback done...............");
    return Feedback.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to save in database.');
  }
}

Future<Result> createResult(Result result) async {
  final response = await http.post(Uri.parse('http://octopus:8000/api/result'),
      headers: {"Content-Type": "application/json"}, body: jsonEncode(result));

  if (response.statusCode < 300) {
    //print("................createResult done...............");
    return Result.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to save in database.');
  }
}

// Run "flutter pub run build_runner build" in the project root,
// to generate JSON serialization code for models whenever they are needed

@JsonSerializable()
class Project {
  final int? id;
  final String title;
  final String description;
  final String contributors;
  final String startDate;
  final String endDate;

  Project(this.id, this.title, this.description, this.contributors,
      this.startDate, this.endDate);

  factory Project.fromJson(final Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}

@JsonSerializable()
class Feedback {
  int? id;
  int projectId;
  String visitorName;
  String speech;
  String? date;

  Feedback(this.id, this.projectId, this.visitorName, this.speech, this.date);

  factory Feedback.fromJson(Map<String, dynamic> json) =>
      _$FeedbackFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackToJson(this);
}

@JsonSerializable()
class Result {
  int? id;
  int feedbackId;
  String feedback;
  num score;

  Result(this.id, this.feedbackId, this.feedback, this.score);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
