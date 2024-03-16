import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Город Краснодар'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

 /*String phoneNumba = 'tel:+79281337228';*/
  /*String location = 'https://yandex.ru/maps/-/CDFo48pC';*/

  class _MyHomePageState extends State<MyHomePage> {
  int _likeCount = 1;
  bool _isLiked = false;

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      if (_isLiked) {
        _likeCount++;
      } else {
        _likeCount--;
      }
    });
  }

  void _sharePressed() { // share function using share_plus
    Share.share('https://yandex.ru/maps/-/CDFo48pC');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView( // listview so it scrolls
        children: [
          Image.asset('assets/22.jpg'), 
          Expanded(
            child:
            Padding( // padding so it looks better
              padding: const EdgeInsets.only(top: 10.0),
              child:
              Row( // row with basic info
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: const [
                      Text(
                        'Краснодар, Россия',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(
                        'Население: 1,020,567',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  Row( // the like button and a counter for it
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: _toggleLike,
                        color: Colors.red,
                        icon: Icon(_isLiked ? Icons.favorite : Icons.favorite_border),
                        ),
                    
                      Text(
                      '$_likeCount'
                    )]
                  )
                ],
              )
            )
          ),
          Expanded( // three buttons with some functionality
              child:
              Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.phone),
                              onPressed: () => launchUrl(
                                Uri.parse('tel:+7928133728'), // launches the dial app 
                              ),
                              color: Colors.green,
                              ),
                            const Text(
                                'Позвонить',
                                style: TextStyle(color:Colors.green)
                            )
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.navigation),
                              onPressed: () => launchUrl(
                                Uri.parse('https://yandex.ru/maps/-/CDFo48pC'), // launches the link which might be attached to an app able to parse it
                              ),
                              color: Colors.green,
                            ),
                            const Text(
                                'Маршрут',
                                style: TextStyle(color:Colors.green)
                            )
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.share),
                              onPressed: _sharePressed,
                              color: Colors.green,
                            ),
                            const Text(
                                'Поделиться',
                                style: TextStyle(color:Colors.green)
                            )
                          ],
                        )
                      ],
                    )
              )
          ),
          const Expanded( // the long text to show scrolling possibilities 
              child:
              Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text('Краснодар в прошлом – Екатеринодар) – один из крупнейших городов'
                      ' российского Юга, расположившийся на берегу реки Кубани. Город с '
                      'неповторимыми достопримечательностями. В Краснодаре живёт более '
                      '1.000.000 человек что сравнимо, например, с населением Дании. '
                      'Город поделён на четыре округа – Центральный, Западный, Прикубанский и Карасунский. '
                      'С самого основания города главная улица называлась Красной, это название не'
                      'было изменено и в годы советской власти. История Краснодара насчитывает'
                      ' более двух сотен лет.')
              )
          )
        ]
      )
    );
  }
}