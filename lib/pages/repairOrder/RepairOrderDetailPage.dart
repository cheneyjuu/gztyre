import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/api/HttpRequestRest.dart';
import 'package:gztyre/api/model/ReportOrder.dart';
import 'package:gztyre/components/ProgressDialog.dart';
import 'package:gztyre/components/ViewDialog.dart';
import 'package:gztyre/utils/screen_utils.dart';
import 'package:video_player/video_player.dart';

class RepairOrderDetailPage extends StatefulWidget {
  RepairOrderDetailPage({Key key, this.reportOrder}) : super(key: key);
  final ReportOrder reportOrder;

  @override
  State createState() => _RepairOrderDetailPageState();
}

class _RepairOrderDetailPageState extends State<RepairOrderDetailPage> {
  var _getPicFuture;
  bool _loading = false;
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  List _imgList = [];
  String _video;

  _getPic() {
    setState(() {
      this._loading = true;
    });
    HttpRequestRest.getMalfunction(widget.reportOrder.QMNUM, (res) {
      if (res != null && res["pictures"] != null && res["pictures"].length > 0) {
        this._imgList = res["pictures"];
      }
      if (res != null && res["video"] != null && res["video"].length > 0) {
        this._video = res["video"];
        this._imgList.add(this._video);
        this._controller = VideoPlayerController.network(this._video);
        this._initializeVideoPlayerFuture = this._controller.initialize();
      }
      setState(() {
        this._loading = false;
      });
    }, (err) {
      setState(() {
        this._loading = false;
      });
    });
  }

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
                              return {'key': index, 'videoFile': list[index]};
                            } else {
                              return {'key': index, 'url': list[index]};
                            }
                          });
                          Navigator.of(context)
                              .push(new CupertinoPageRoute(
                                  builder: (context) => new ViewDialog(
                                        img: {'key': i, 'videoFile': list[i]},
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
            child: Image.network(
              list[i],
              fit: BoxFit.cover,
            ),
          ),
          onTap: () {
            var imgs = list.asMap().keys.toList().map((index) {
              if (list[index].endsWith("mp4")) {
                return {'key': index, 'videoFile': list[index]};
              } else {
                return {'key': index, 'url': list[index]};
              }
            });
            Navigator.of(context)
                .push(new CupertinoPageRoute(
                    builder: (context) => new ViewDialog(
                          img: {'key': i, 'url': list[i]},
                          imgs: imgs,
                          width: MediaQuery.of(context).size.width,
                          controller: this._controller,
                          initializeVideoPlayerFuture:
                              this._initializeVideoPlayerFuture,
                          onlyView: true,
                        )))
                .then((index) {
              if (this._controller != null) {
                this._controller.pause();
              }
              if (index != null) {
                if (list[index - 1].endsWith("mp4")) {
                  this._controller = null;
                }
              }
            });
          },
        ));
      }
    }
    return imgList;
  }

  @override
  void initState() {
    this._getPicFuture = this._getPic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: this._getPicFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ProgressDialog(
              loading: this._loading,
              child: CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  leading: CupertinoNavigationBarBackButton(
                    onPressed: () => Navigator.pop(context),
                    color: Color.fromRGBO(94, 102, 111, 1),
                  ),
                  middle: Text(
                    /// todo
                    "工单详情",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                backgroundColor: Colors.white,
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 30, bottom: 20, left: 10, right: 10),
                        child: Text(
                          widget.reportOrder.FETXT,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            children: <Widget>[
                              ..._buildPic(this._imgList),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}
