import 'package:chat_application_with_backend_practice1/Models/models.dart';
import 'package:chat_application_with_backend_practice1/Widgets/widget.dart';
import 'package:collection/collection.dart' as IterableExtension;
import 'package:chat_application_with_backend_practice1/app.dart';
import 'package:chat_application_with_backend_practice1/helpers.dart';
import 'package:chat_application_with_backend_practice1/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class ChatScreen extends StatelessWidget {


  //here we are getting messageData from the messagepage section for showing same name
  static Route routeWithChannel(Channel channel) => MaterialPageRoute(
    builder: (context) => StreamChannel(
      channel: channel,
      child: const ChatScreen()
    )
  );

  const ChatScreen({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(


        //appbar designing section
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leadingWidth: 54.0,


        //back icon section
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(icon: CupertinoIcons.back, onTap: (){Navigator.of(context).pop();}),
        ),


        //here we are using messagedata which we get from the messagePage for showing same name and calling the appBarTitle where there is two thing senders avatar and name
        title: const _AppBarTitle(),
        actions: [


          //camera section on appbar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: IconBorder(
                icon: CupertinoIcons.video_camera_solid,
                onTap: (){},
              ),
            ),
          ),


          //phone section on appbar
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Center(
              child: IconBorder(
                icon: CupertinoIcons.phone_solid,
                onTap: (){},
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: const [


          //demomessagelist calling section/ in this section we will show the chats
          Expanded(
            child: _DemoMessageList(),
          ),

          //and this is bottom bar section
          _ActionBar(),
        ],
      ),
    );
  }
}

class _DemoMessageList extends StatelessWidget {
  const _DemoMessageList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),


      //list view of chat section
      child: ListView(


        //list of hard coded chats
        children: const [
          _DateLable(label: 'Yesterday'),
          _MessageTile(
            message: 'Hi, Lucy! How\'s your day going?',
            messageDate: '12:01 PM'
          ),
          _MessageOwnTile(
            message: 'You know how it goes...',
            messageDate: '12:02 PM'
          ),
          _MessageTile(
            message: 'Do you want Starbucks?',
            messageDate: '12:02 PM'
          ),
          _MessageOwnTile(
            message: 'Would be awesome!',
            messageDate: '12:03 PM'
          ),
          _MessageTile(
            message: 'Coming up!',
            messageDate: '12:03 PM'
          ),
          _MessageOwnTile(
            message: 'YAY!!!!',
            messageDate: '12:03 PM'
          ),
        ],
      ),
    );
  }
}



//sender message chat section
class _MessageTile extends StatelessWidget {

  final String message;
  final String messageDate;

  const _MessageTile({ Key? key, required this.message, required this.messageDate }) : super(key: key);

  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {


    //sender message designing section
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  topRight: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                )
              ),


              //sender's chat section
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
                child: Text(message),
              ),
            ),


            //time of sender's message
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                messageDate,
                style: const TextStyle(
                  color: AppColors.textFaded,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


//message section of mobile user/mine
class _MessageOwnTile extends StatelessWidget {

  final String message;
  final String messageDate;

  const _MessageOwnTile({ Key? key, required this.message, required this.messageDate }) : super(key: key);

  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {


    //message designing section
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  bottomLeft: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                )
              ),


              //mobile user's chat section
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
                child: Text(
                  message,
                  style: const TextStyle(
                    color: AppColors.textLight,
                  ),
                ),
              )
            ),


            //time of mobile user's/mine sending the message
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                messageDate,
                style: const TextStyle(
                  color: AppColors.textFaded,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ]
        )
      )
    );
  }
}



//the day at which the chat happened
class _DateLable extends StatelessWidget {
  
  final String label;
  const _DateLable({ Key? key, required this.label }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: AppColors.textFaded
              ),
            ),
          ),
        ),
      ),
    );
  }
}



//top bar sender name's and avatar section
class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final channel = StreamChannel.of(context).channel;
    return Row(
      children: [


        //senders avatar section on top bar
        Avatar.small(url: Helpers.getChannelImage(channel, context.currentUser!)),
        const SizedBox(width: 16.0,),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //senders name section on top bar
              Text(
                Helpers.getChannelName(channel, context.currentUser!),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14.0),
              ),
              const SizedBox(height: 2.0,),


              //status of sender
              BetterStreamBuilder<List<Member>>(
                stream: channel.state!.membersStream,
                initialData: channel.state!.members,
                builder: (context, data) => ConnectionStatusBuilder(
                  statusBuilder: (context, status){
                    switch (status){
                      case ConnectionStatus.connected:
                        return _buildConnectedTitleState(context, data);
                      case ConnectionStatus.connecting:
                        return const Text(
                          'Connecting',
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        );
                      case ConnectionStatus.disconnected:
                        return const Text(
                          'Offline',
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        );
                      default:
                      return const SizedBox.shrink();
                    }
                  }
                )
              )
            ],
          )
        )
      ],
    );
  }

  Widget _buildConnectedTitleState(BuildContext context, List<Member>? members){
    Widget? alternativeWidget;
    final channel = StreamChannel.of(context).channel;
    final memberCount = channel.memberCount;
    if(memberCount != null && memberCount > 2){
      var text = 'Members: $memberCount';
      final watcherCount = channel.state?.watcherCount ?? 0;
      if(watcherCount > 0){
        text = 'watchers $watcherCount';
      }
      alternativeWidget = Text(text);
    }
    else{
      final userId = StreamChatCore.of(context).currentUser?.id;
      final otherMember = members?.firstWhereOrNull(
        (element) => element.userId != userId,
      );

      if(otherMember != null){
        if(otherMember.user?.online == true){
          alternativeWidget = const Text(
            'Online',
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          );
        }
        else{
          alternativeWidget = Text(
            'Last online: '
            '${Jiffy(otherMember.user?.lastActive).fromNow()}',
            style: const TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          );
        }
      }
    }

    // return TypingIndicator(alternativeWidget: alternativeWidget,);
    return Text('null');
  }
}

// Widget that builds itself based on the latest snapshot of interaction with a [Stream] of type [ConnectionStatus].

// The widget will use the closest [StreamChatClient.wsConnectionStatusStream] in case no stream is provided.

class ConnectionStatusBuilder extends StatelessWidget {
  // creates a new ConnectionStatusBuilder
  const ConnectionStatusBuilder({ Key? key, this.connectionStatusStream, this.errorBuilder, this.loadingBuilder, required this.statusBuilder }) : super(key: key);

  // The asynchronous computation to which this builder is currently connected.
  final Stream<ConnectionStatus>? connectionStatusStream;

  // The builder that will be used in case of error
  final Widget Function(BuildContext context, Object? error)? errorBuilder;

  //The builder that will be used in case of loading
  final WidgetBuilder? loadingBuilder;

  // The builder that will be used in case of data
  final Widget Function(BuildContext context, ConnectionStatus status) statusBuilder;

  @override
  Widget build(BuildContext context) {
    final stream = connectionStatusStream ?? StreamChatCore.of(context).client.wsConnectionStatusStream;
    final client = StreamChatCore.of(context).client;
    return BetterStreamBuilder<ConnectionStatus>(
      initialData: client.wsConnectionStatus,
      stream: stream,
      noDataBuilder: loadingBuilder,
      errorBuilder: (context, error){
        if(errorBuilder != null){
          return errorBuilder!(context, error);
        }
        return const Offstage();
      },
      builder: statusBuilder,
    );
  }
}

//bottom bar designing section
class _ActionBar extends StatelessWidget {
  const _ActionBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 2.0,
                  color: Theme.of(context).dividerColor,
                )
              )
            ),


            //camera icon section
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                CupertinoIcons.camera_fill,
              )),
            ),


            //text field section / type something section
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: TextField(
                  style: TextStyle(fontSize: 14.0),
                  decoration: InputDecoration(
                    hintText: 'Type something',
                    border: InputBorder.none,
                  ),
                ),
              )
            ),


            //send message button section
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 24.0),
              child: GlowingActionButton(
                color: AppColors.accent,
                icon: Icons.send_rounded,
                onPressed: (){'send message';},
              ),
            )
        ],
      ),
    );
  }
}