import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/components/TakePhotoAndVideoWidget.dart';
import 'package:gztyre/components/ViewDialog.dart';
import 'package:gztyre/utils/ListController.dart';
import 'package:gztyre/utils/screen_utils.dart';
import 'package:video_player/video_player.dart';

typedef VideoAndPicCallback(List<String> list);

class TextareaWithPicAndVideoWidget extends StatefulWidget {
  TextareaWithPicAndVideoWidget(
      {Key key,
      @required this.textEditingController,
      this.placeholder,
      this.lines,
      this.callback,
      @required this.listController,
      @required this.rootContext})
      : super(key: key);

  final TextEditingController textEditingController;
  final String placeholder;
  final int lines;
  final BuildContext rootContext;
  final VideoAndPicCallback callback;
  final ListController listController;

  @override
  State createState() {
    return _TextareaWithPicAndVideoWidgetState();
  }
}

class _TextareaWithPicAndVideoWidgetState
    extends State<TextareaWithPicAndVideoWidget> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

//  List<String> list = [];

  List<Widget> _buildPic(List list) {
    List<Widget> imgList = [];
    print(list);
    for (int i = 0; i < list.length; i++) {
      if (list[i].endsWith('mp4')) {
        imgList.add(Padding(
          padding: EdgeInsets.all(2),
          child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the VideoPlayerController has finished initialization, use
                // the data it provides to limit the aspect ratio of the video.
                return Stack(
                  children: <Widget>[
                    FittedBox(
                      fit: BoxFit.cover,
                      child: Container(
                        height: ScreenUtils.screenW(context) - 20 - 4,
                        width: ScreenUtils.screenW(context) - 20 - 4,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: FloatingActionButton(
                        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
                        onPressed: () {
                          var imgs = list.asMap().keys.toList().map((index) {
                            if (list[index].endsWith("mp4")) {
                              return {
                                'key': index,
                                'videoFile': File(list[index])
                              };
                            } else {
                              return {'key': index, 'file': File(list[index])};
                            }
                          });
                          Navigator.of(widget.rootContext)
                              .push(new CupertinoPageRoute(
                                  builder: (context) => new ViewDialog(
                                        img: {
                                          'key': i,
                                          'videoFile': File(list[i])
                                        },
                                        imgs: imgs,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        controller: this._controller,
                                        initializeVideoPlayerFuture:
                                            this._initializeVideoPlayerFuture,
                                        onlyView: false,
                                      )))
                              .then((index) {
                            if (this._controller != null) {
                              this._controller.pause();
                            }
                            if (index != null) {
                              if (list[index - 1].endsWith("mp4")) {
                                this._controller = null;
                              }
                              widget.listController.value.removeAt(index - 1);
//                              widget.callback(this.list);
                            }
                          });
                        },
                        // Display the correct icon depending on the state of the player.
                        child: Icon(
                          Icons.play_arrow,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                // If the VideoPlayerController is still initializing, show a
                // loading spinner.
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
      } else {
        imgList.add(GestureDetector(
          child: Padding(
            padding: EdgeInsets.all(2),
            child: Image.file(
              File(list[i]),
              fit: BoxFit.cover,
            ),
          ),
          onTap: () {
            var imgs = list.asMap().keys.toList().map((index) {
              if (list[index].endsWith("mp4")) {
                return {'key': index, 'videoFile': File(list[index])};
              } else {
                return {'key': index, 'file': File(list[index])};
              }
            });
            Navigator.of(widget.rootContext)
                .push(new CupertinoPageRoute(
                    builder: (context) => new ViewDialog(
                          img: {'key': i, 'file': File(list[i])},
                          imgs: imgs,
                          width: MediaQuery.of(context).size.width,
                          controller: this._controller,
                          initializeVideoPlayerFuture:
                              this._initializeVideoPlayerFuture,
                          onlyView: false,
                        )))
                .then((index) {
              if (this._controller != null) {
                this._controller.pause();
              }
              if (index != null) {
                if (list[index - 1].endsWith("mp4")) {
                  this._controller = null;
                }
                widget.listController.value.removeAt(index - 1);
//                widget.callback(this.list);
              }
            });
          },
        ));
      }
    }
    return imgList;
  }

  void appendList(List list, String path) {
    list.add(path);
  }

  @override
  void dispose() {
    super.dispose();
    this._controller.dispose();
  }


  @override
  void initState() {
//    this.list = widget.list;
//    print({'childinit.list': this.list.length});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            CupertinoTextField(
              maxLines: widget.lines,
              autofocus: false,
              controller: widget.textEditingController,
              keyboardType: TextInputType.text,
              obscureText: false,
              showCursor: true,
              cursorColor: Color.fromRGBO(51, 115, 178, 1),
              placeholder: widget.placeholder,
              placeholderStyle:
                  TextStyle(fontSize: 14, color: Color.fromRGBO(0, 0, 0, 0.25)),
              decoration: BoxDecoration(border: Border()),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                children: <Widget>[
                  ..._buildPic(widget.listController.value),
                  widget.listController.value.length < 6
                      ? TakePhotoAndVideoWidget(
                          canShoot: this._controller == null,
                          takePhotoCallback: (path) {
//                    print(path);
                            if (path.endsWith('mp4')) {
                              print(path);
                              this._controller =
                                  VideoPlayerController.file(File(path));
                              this._initializeVideoPlayerFuture =
                                  this._controller.initialize();
                              this._controller.setLooping(true);
                              this.appendList(widget.listController.value, path);
                            } else {
                              this.appendList(widget.listController.value, path);
                            }
//                            print({'childcallback.list': this.list.length});
//                            widget.callback(this.list);
                            setState(() {});
                          },
                        )
                      : Container()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
