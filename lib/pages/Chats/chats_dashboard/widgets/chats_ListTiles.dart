import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ubs/model/chats_room.dart';
import 'package:ubs/model/users_data.dart';
import 'package:ubs/services/remote_services.dart';
import 'package:ubs/sharing_widget/show_image.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/utils/custom_fun.dart';
import 'package:ubs/utils/text_style.dart';

class ChatsListTitle extends StatefulWidget {
  final ChatsRoomModel chatRoom;
  final String userId;
  const ChatsListTitle({super.key, required this.chatRoom , required this.userId});
  // const ChatsListTitle({required this.userId});

  @override
  State<ChatsListTitle> createState() => _ChatsListTitleState();
}

class _ChatsListTitleState extends State<ChatsListTitle> {
  UsersData? userData;
  final DateFormat formatter = DateFormat('yyyy-MMM-dd');

  @override
  void initState() {
    super.initState();
  }

  getUserData() async {
    userData = await RemoteServices.getUserData(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    
    return userData == null
        ? const SizedBox()
        : GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/chatDetails");
              // Navigator.pushNamed(context, "/demo");
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                color: COLOR_WHITE,
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.blueGrey.shade100,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.all(6),
                      width: 100,
                      height: 110,
                      child: Badge(
                        // badgeColor: Colors.white,
                        padding: EdgeInsets.zero,
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2),
                        badgeContent: SizedBox(
                            height: 45,
                            width: 45,
                            child: ClipOval(
                              // borderRadius: BorderRadius.circular(50),
                              child: ShowImage(
                                  imageUrl: getLink(userData!.uPhone))
                              // Image.asset(
                              //   userData!.uPhoto!,
                              //   fit: BoxFit.fitWidth,
                              // ),
                            )),
                        position: BadgePosition.bottomEnd(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.asset(
                            widget.chatRoom.pImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                  addHorizontalSpace(15),
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.chatRoom.userName, style: heading6),
                            // Text(
                            //     formatter.format(widget.chatRoom.userLastSeen) +
                            //         "   ",
                            //     style: trailingTestStyle)
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.chatRoom.pTitle,
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      subtitleLabel.copyWith(fontSize: 26.sp),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      // widget.chatRoom.messageStatus == "read"
                                      "read" == "read"
                                          ? Icons.done_all_outlined
                                          : Icons.done,
                                      color: Colors.blueGrey.shade200,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      widget.chatRoom.pTitle,
                                      maxLines: 1,
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      style: subTitle2,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const Icon(Icons.more_vert_outlined,
                                size: 28, color: COLOR_BLACK)
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
