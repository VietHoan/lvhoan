import 'package:flutter/material.dart';
import 'package:free_music/app/utils/app_color.dart';
import 'package:free_music/app/utils/app_text_style.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // below is app bar
              Container(
                decoration: const BoxDecoration(
                  gradient: gradientPrimaryOrange,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.arrow_back_ios_new,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: controller.searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search..',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          border: InputBorder.none,
                        ),
                        onFieldSubmitted: (value) {
                          controller.onSearchSubmit(search: value);
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.searchController.clear();
                        FocusScope.of(context).unfocus();
                      },
                      child: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              // list clip
              const SizedBox(
                height: 16,
              ),
              Obx(
                () => controller.listClip.length != 0
                    ? ListView.builder(
                        itemCount: controller.listClip.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (controller.listClip[index].id!.kind != 'youtube#channel') {
                            return _itemYoutube(
                              clipId: controller.listClip[index].id!.videoId!,
                              urlThumbnail: controller.listClip[index].snippet!.thumbnails!.thumbnailsDefault!.url,
                              title: controller.listClip[index].snippet!.title,
                              time: controller.listClip[index].snippet!.publishTime,
                              channelTitle: controller.listClip[index].snippet!.channelTitle,
                            );
                          } else {
                            return Container();
                          }
                        },
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemYoutube({
    required String clipId,
    String? title,
    String? urlThumbnail,
    String? channelTitle,
    DateTime? time,
  }) {
    return GestureDetector(
      onTap: () {
        print(clipId);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(urlThumbnail!),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title!.replaceAll('&quot;', '\''),
                    style: styleRoboto14,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                        size: 12,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        '${timeago.format(time!)}',
                        style: styleRoboto12.copyWith(
                          color: colorText80,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    channelTitle ?? '',
                    style: styleRoboto12,
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
