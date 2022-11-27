import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/chats/chats_dashboard/widgets/chats_list_tiles.dart';
import 'package:ubs/pages/chats/chats_dashboard/widgets/empty_screen.dart';
import 'package:ubs/pages/chats/controller/chats_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatsRoomAll extends StatefulWidget {
  final UserLogin userLogin;
  const ChatsRoomAll({super.key, required this.userLogin});

  @override
  State<ChatsRoomAll> createState() => _ChatsRoomAllState();
}

class _ChatsRoomAllState extends State<ChatsRoomAll> {
  final ChatsController chatsController = Get.find<ChatsController>();

  @override
  void initState() {
    super.initState();
    chatsController.getChatsRoomsList(widget.userLogin.userId);
  }

  @override
  Widget build(BuildContext context) {
    // final TextTheme textTheme = Theme.of(context).textTheme;

    return StreamBuilder<QuerySnapshot>(
        stream: chatsController.chatsRoomStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data != null) {
            if (snapshot.data!.docs.isNotEmpty) {
              return Padding(
                padding: EdgeInsets.only(top: 20.sp),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];
                    return ChatsListTitle(
                        doc: data, userId: widget.userLogin.userId);
                  },
                ),
              );
            }
          }

          return const EmptyScreen(
              title_1: "You've got no message so far!",
              btnTitle: "Start To Explore");
        });

    // return Obx(() => chatsController.isLoading.value == true
    //     ? const Center(child: CircularProgressIndicator())
    //     : chatsController.chatsRooms.isEmpty
    //         ? const EmptyScreen(
    //             title_1: "You've got no message so far!",
    //             btnTitle: "Start To Explore")
    //         : Padding(
    //             padding: EdgeInsets.only(top: 20.sp),
    //             child: ListView.builder(
    //               shrinkWrap: true,
    //               itemCount: chatsController.chatsRooms.length,
    //               itemBuilder: (BuildContext context, int index) {
    //                 var val = chatsController.chatsRooms[index];
    //                 return ChatsListTitle(
    //                     chatRoom: val, userId: widget.userLogin.userId);
    //               },
    //             ),
    //           ));
  }
}


  // StreamBuilder<QuerySnapshot>(
  //   stream: chatsController.chatsRoom.value,
  //   builder: (context, snapshot) {
  //     if (snapshot.hasError) {
  //       return const Text('Something went wrong');
  //     }
  //     if (snapshot.connectionState == ConnectionState.waiting) {
  //       return const Text("Loading");
  //     }
  //     if (snapshot.data!.docs.isNotEmpty) {
        
  //       return ListView.builder(
  //         shrinkWrap: true,
  //         itemCount: snapshot.data!.docs.length,
  //         itemBuilder: (BuildContext context, int index) {
  //           DocumentSnapshot data = snapshot.data!.docs[index];
  //           String userName = getAdsUser( data['chatsUser']);
  //           // return ChatsListTitle(chatData: ,);
  //           return ListTile(title: Text(data['adsPostUsers']));
  //         },
  //       );
  //     }
  //     return const Center(child: Text("Data not"));

  //     // return ListView(
  //     //   shrinkWrap: true,
  //     //   children:
  //     //       snapshot.data!.docs.map((DocumentSnapshot document) {
  //     //     Map<String, dynamic> data =
  //     //         document.data()! as Map<String, dynamic>;
  //     //     return ListTile(
  //     //       title: Text(data['name']),
  //     //     );
  //     //   }).toList(),
  //     // );
  //   }),
            