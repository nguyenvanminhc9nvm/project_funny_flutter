import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project_funny_flutter/ui/base/base_bloc.dart';
import 'package:project_funny_flutter/ui/base/base_state.dart';
import 'package:project_funny_flutter/ui/home/home.dart';
import 'package:project_funny_flutter/ui/home/picture/picture_bloc.dart';
import 'package:project_funny_flutter/utils/admob/admob_service.dart';
import 'package:project_funny_flutter/utils/constant/constant.dart';
import 'dart:math' as math;

class Picture extends StatefulWidget {
  const Picture({Key? key}) : super(key: key);

  @override
  _PictureState createState() => _PictureState();
}

class _PictureState extends BaseState<Picture, PictureBloc> {
  late BannerAd _ad;

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> pictures =
        FirebaseFirestore.instance.collection(tbPicture).snapshots();
    PageController controller = HomeProviderController.of(context).controller1;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45.h,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset(icMenu),
          onPressed: () {
            Navigator.pushNamed(context, menu);
          },
        ),
        title: Text(
          getString("key_title"),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocProvider(
        bloc: bloc,
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: AdWidget(
                      ad: _ad,
                    ),
                    width: _ad.size.width.toDouble(),
                    height: 72.0,
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: pictures,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading");
                        }
                        return PageView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: controller,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var result = snapshot.data!.docs[index];
                            return ItemPicture(result);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ad.dispose();
    super.dispose();
  }

  @override
  void onListenerStream() {
    _initGoogleMobileAds();
    _ad = BannerAd(
      adUnitId: AdmobService.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          print('Ad load loaded success');
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    _ad.load();
  }
}

class ItemPicture extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> snapshot;

  ItemPicture(this.snapshot);

  @override
  _ItemPictureState createState() => _ItemPictureState();
}

class _ItemPictureState extends State<ItemPicture> {
  bool _visibleIcSmile = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20.h, 10.h, 50.h),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: color_border_gray),
        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(1, 10),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          doVotes();
        },
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                alignment: Alignment.centerLeft,
                child: Text(widget.snapshot['caption']),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                child: CachedNetworkImage(
                  imageUrl: widget.snapshot['image'],
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Icon(!_visibleIcSmile ? Icons.favorite_border : Icons.favorite),
                    SizedBox(width: 10,),
                    Text(widget.snapshot['votes'].toString()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void doVotes() {
    _visibleIcSmile = !_visibleIcSmile;
    if (_visibleIcSmile) {
      FirebaseFirestore.instance
          .collection(tbPicture)
          .doc(widget.snapshot.id)
          .update({"votes": widget.snapshot['votes'] + 1});
    } else {
      FirebaseFirestore.instance
          .collection(tbPicture)
          .doc(widget.snapshot.id)
          .update({"votes": widget.snapshot['votes'] - 1});
    }
  }
}
