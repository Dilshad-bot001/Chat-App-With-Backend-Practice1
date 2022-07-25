import 'package:chat_application_with_backend_practice1/Screens/screens.dart';
import 'package:chat_application_with_backend_practice1/app.dart';
// import 'package:chat_application_with_backend_practice1/theme.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

void main() {
  final client = StreamChatClient(streamKey);
  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {

  final StreamChatClient client;

  const MyApp({Key? key, required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      // theme: AppTheme.light(),
      // darkTheme: AppTheme.dark(),
      // themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: 'Chat Application Practice',
      builder: (context, child){
        return StreamChatCore(
          client: client,
          child: ChannelsBloc(child: child!)
        );
      },      
      home: const SelectUserScreen(),
    );
  }
}