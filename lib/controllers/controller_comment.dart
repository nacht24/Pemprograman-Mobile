import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/model_comment.dart';

Future<List<Comment>> fetchComments(int postId) async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/comments?postId=$postId'),
  );

  if (response.statusCode == 200) {
    final List jsonData = jsonDecode(response.body);
    return jsonData.map((json) => Comment.fromJson(json)).toList();
  } else {
    throw Exception('Gagal mengambil komentar');
  }
}
