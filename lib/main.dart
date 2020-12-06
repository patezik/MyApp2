import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

//получаем альбом
Future<http.Response> fetchAlbum() {
  return http.get('https://jsonplaceholder.typicode.com/albums/1');
}

//создаем класс
class Album {
  final int userId;
  final int id;
  final String title;

  Album({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

//ожидаемый итог
Future<Album> fetchAlbum() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/albums/1');

//проверка результата
  if (response.statusCode == 200) {

    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

//
class _MyAppState extends State<MyApp> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

//отображение приложения
  FutureBuilder<Album>(
  future: futureAlbum,
  builder: (context, snapshot) {
  if (snapshot.hasData) {
  return Text(snapshot.data.title);
  } else if (snapshot.hasError) {
  return Text("${snapshot.error}");
  }

  return CircularProgressIndicator();
  },
  );