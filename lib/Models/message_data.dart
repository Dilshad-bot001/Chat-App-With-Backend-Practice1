import 'package:meta/meta.dart';

@immutable
class MessageData{
  final String senderName;
  final String message;
  final String dateMessage;
  final String profilePicture;
  final DateTime messageDate;

  const MessageData({required this.senderName, required this.message, required this.dateMessage, required this.profilePicture, required this.messageDate,});
}