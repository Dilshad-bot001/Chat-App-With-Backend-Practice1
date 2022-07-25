import 'dart:js';

import 'package:chat_application_with_backend_practice1/Models/models.dart';
import 'package:chat_application_with_backend_practice1/Widgets/widget.dart';
import 'package:chat_application_with_backend_practice1/app.dart';
import 'package:chat_application_with_backend_practice1/helpers.dart';
import 'package:chat_application_with_backend_practice1/theme.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({ Key? key }) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {

  final channelListController = ChannelListController();

  @override
  Widget build(BuildContext context) {

    return ChannelListCore(
      channelListController: channelListController,
      filter: Filter.and(
        [
          Filter.equal('type', 'messaging'),
          Filter.in_('members', [
            StreamChatCore.of(context).currentUser!.id,
          ])
        ]
      ),
      emptyBuilder: (context) => const Center(
        child: Text(
          'So empty.\nGo and message someone.',
          textAlign: TextAlign.center,
        ),
      ),
      errorBuilder: (context, error) => DisplayErrorMessage(
        error: error,
      ),
      loadingBuilder: (context) => const Center(
        child: SizedBox(
          height: 100.0,
          width: 100.0,
          child: CircularProgressIndicator(),
        ),
      ),
      listBuilder: (context, channels){
        return CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(


              //stories section
              child: _Stories(),
            ),


            //sliver list creation section, In this section sliver list builder is created
            SliverList(
              delegate: SliverChildBuilderDelegate( (context, index){
                return _MessageTile(channel: channels[index],);
              },
              childCount: channels.length
              )
            )
      ],
    );
      },
    );

  //   //customscrollview is for both side scrolling
  //   return CustomScrollView(
  //     slivers: [
  //       const SliverToBoxAdapter(


  //         //stories section
  //         child: _Stories(),
  //       ),


  //       //sliver list creation section, In this section sliver list builder is created
  //       SliverList(
  //         delegate: SliverChildBuilderDelegate(_delegate)
  //       )
  //     ],
  //   );
  // }


  // //in this section messagetile section is called and messagedata is passed with faker details
  // Widget _delegate(BuildContext context, int index){
  //   final faker = Faker();
  //   final date = Helpers.randomDate();
  //   return _MessageTile(messageData: MessageData(
  //     senderName: faker.person.name(),
  //     message: faker.lorem.sentence(),
  //     dateMessage: Jiffy(date).fromNow(),
  //     profilePicture: Helpers.randomPictureUrl(),
  //     messageDate: date)
  //   );
  }
}


//messages tile list view section
class _MessageTile extends StatelessWidget {

  final Channel channel;

  const _MessageTile({ Key? key, required this.channel }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(


      //in this section on tapping the messagetile navigator will push us to the chatscreen
      onTap: (){
        // Navigator.of(context).push(ChatScreen.route(messageData));
      },


      //messagetile designing section
      child: Container(
        height: 100.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.2,
            )
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [


              //messagetile avatar section
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Avatar.medium(url: Helpers.getChannelImage(channel, context.currentUser!)),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    //message sender name/title of messagetile
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        Helpers.getChannelName(channel, context.currentUser!),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          letterSpacing: 0.2,
                          wordSpacing: 1.5,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),


                    //last message section on messagetile/subtitle of messagetile
                    SizedBox(
                      height: 20.0,
                      child: _buildLastMessage(),
                    ),
                  ],
                )
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 4.0,),


                    //sended message date section
                    _buildLastMessageAt(),                    


                    //munber of unseen messages
                    const SizedBox(height: 8.0,),
                    Container(
                      height: 18.0,
                      width: 18.0,
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle
                      ),
                      child: const Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: AppColors.textLight,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLastMessage(){
    return BetterStreamBuilder<Message>(
      stream: channel.state!.lastMessageStream,
      initialData: channel.state!.lastMessage,
      builder: (context, lastMessage){
        return Text(
          lastMessage.text ?? '',
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12.0,
            color: AppColors.textFaded,
          ),
        );
      }
    );
  }

  Widget _buildLastMessageAt(){
    return BetterStreamBuilder<DateTime>(
      stream: channel.lastMessageAtStream,
      initialData: channel.lastMessageAt,
      builder: (context, data){
        final lastMessageAt = data.toLocal();
        String stringDate;
        final now = DateTime.now();

        final startOfDay = DateTime(now.year, now.month, now.day);

        if(lastMessageAt.millisecondsSinceEpoch >= startOfDay.millisecondsSinceEpoch){
          stringDate = Jiffy(lastMessageAt.toLocal()).jm;
        }
        else if(lastMessageAt.millisecondsSinceEpoch >= startOfDay.subtract(const Duration(days: 1)).millisecondsSinceEpoch){
          stringDate = 'YESTERDAY';
        }
        else if(startOfDay.difference(lastMessageAt).inDays < 7){
          stringDate = Jiffy(lastMessageAt.toLocal()).EEEE;
        }
        else{
          stringDate = Jiffy(lastMessageAt.toLocal()).yMd;
        }
        return Text(
          stringDate,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.2,
            color: AppColors.textFaded,
          ),
        );
      }
    );
  }
}


// stories section
class _Stories extends StatelessWidget {
  const _Stories({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: SizedBox(
        height: 134.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 16.0),


              //stories text/title section
              child: Text(
                'Stories',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15.0,
                  color: AppColors.textFaded
                ),
              ),
            ),


            // story card builder section
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index){
                  final faker = Faker();
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 60.0,
                      child: _StoryCard(
                        storyData: StoryData(
                          name: faker.person.name(),
                          url: Helpers.randomPictureUrl()
                        )
                      )
                    ),
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}


//story card designing section
class _StoryCard extends StatelessWidget {

  final StoryData storyData;

  const _StoryCard({ Key? key, required this.storyData }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Avatar.medium(url: storyData.url),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              storyData.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11.0,
                letterSpacing: 0.3,
                fontWeight: FontWeight.bold
              )
            ),
          )
        )
      ],
    );
  }
}