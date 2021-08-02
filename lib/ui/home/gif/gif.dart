import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project_funny_flutter/ui/base/base_state.dart';
import 'package:project_funny_flutter/ui/home/gif/gif_bloc.dart';
import 'package:project_funny_flutter/ui/home/home.dart';
import 'package:project_funny_flutter/utils/admob/admob_service.dart';
import 'package:project_funny_flutter/utils/constant/constant.dart';
import 'dart:math' as math;

class Gif extends StatefulWidget {
  const Gif({Key? key}) : super(key: key);

  @override
  _GifState createState() => _GifState();
}

class _GifState extends BaseState<Gif, GifBloc> {
  late BannerAd _ad;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> gifs =
    FirebaseFirestore.instance.collection(tbGif).snapshots();
    PageController controller = HomeProviderController
        .of(context)
        .controller2;
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
          getString("key_title_global"),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
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
                    stream: gifs,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }

                      return PageView.builder(
                        controller: controller,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var result = snapshot.data!.docs[index];
                          return ItemGif(result);
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
    );
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
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

    // TODO: Load an ad
    _ad.load();
  }

  @override
  void dispose() {
    _ad.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}

class ItemGif extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> snapshot;

  ItemGif(this.snapshot);

  @override
  _ItemPictureState createState() => _ItemPictureState();
}

class _ItemPictureState extends State<ItemGif> {
  bool _visibleIcSmile = false;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0.h, 20.h, 10.h, 50.h),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: color_border_gray),
        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(0.05),
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
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(widget.snapshot['caption']),
                ),
              ),
              Expanded(
                  flex: 6,
                  child: CachedNetworkImage(
                    imageUrl: widget.snapshot['gif'],
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Icon(!_visibleIcSmile ? Icons.favorite_border : Icons
                        .favorite),
                    SizedBox(width: 10,),
                    Text(widget.snapshot['votes'].toString()),
                  ],
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }

  void doVotes() {
    _visibleIcSmile = !_visibleIcSmile;
    if (_visibleIcSmile) {
      FirebaseFirestore.instance
          .collection(tbGif)
          .doc(widget.snapshot.id)
          .update({"votes": widget.snapshot['votes'] + 1});
    } else {
      FirebaseFirestore.instance
          .collection(tbGif)
          .doc(widget.snapshot.id)
          .update({"votes": widget.snapshot['votes'] - 1});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
