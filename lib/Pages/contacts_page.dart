import 'package:chat_application_with_backend_practice1/Screens/screens.dart';
import 'package:chat_application_with_backend_practice1/Widgets/display_error_message.dart';
import 'package:chat_application_with_backend_practice1/Widgets/widget.dart';
import 'package:chat_application_with_backend_practice1/app.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({ Key? key }) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return UserListCore(
      pagination: const PaginationParams(
        limit: 20,
      ),
      filter: Filter.notEqual('id', context.currentUser!.id),
      emptyBuilder: (context){
        return const Center(child: Text('There are no more users.'),);
      },
      loadingBuilder: (context){
        return const Center(child: CircularProgressIndicator(),);
      },
      errorBuilder: (context, error){
        return DisplayErrorMessage(error: error,);
      },
      listBuilder: (context, items){
        return Scrollbar(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index){
              return items[index].when(
                headerItem: (_) => const SizedBox.shrink(),
                userItem: (user) => _ContactTile(user: user),
              );
            }
          )
        );
      },
    );
  }
}

class _ContactTile extends StatelessWidget {

  final User user;

  const _ContactTile({ Key? key, required this.user }) : super(key: key);

  Future<void> createChannel(BuildContext context) async{
    final core = StreamChatCore.of(context);
    final channel = core.client.channel('messaging', extraData: {
      'members': [
        core.currentUser!.id,
        user.id,
      ]
    });
    await channel.watch();
    Navigator.of(context).push(ChatScreen.routeWithChannel(channel));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        createChannel(context);
      },
      child: ListTile(
        leading: Avatar.small(url: user.image,),
        title: Text(user.name),
      ),
    );
  }
}