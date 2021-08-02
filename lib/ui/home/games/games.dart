import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project_funny_flutter/ui/base/base_state.dart';
import 'package:project_funny_flutter/ui/home/games/games_bloc.dart';
import 'package:project_funny_flutter/utils/admob/admob_service.dart';
import 'package:project_funny_flutter/utils/constant/constant.dart';
import 'dart:math' as math;

import '../home.dart';

class Games extends StatefulWidget {
  const Games({Key? key}) : super(key: key);

  @override
  _GamesState createState() => _GamesState();
}

class _GamesState extends BaseState<Games, GamesBloc> {
  late BannerAd _ad;

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> gifs =
        FirebaseFirestore.instance.collection(tbGames).snapshots();
    PageController controller = HomeProviderController.of(context).controller4;
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
          getString("key_title_game"),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
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
                        return ItemGames(result);
                    },
                  );
                },
              ),
            ),
          ],
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

class ItemGames extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> snapshot;

  ItemGames(this.snapshot);

  @override
  _ItemGamesState createState() => _ItemGamesState();
}

class _ItemGamesState extends State<ItemGames> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420.h,
      margin: EdgeInsets.fromLTRB(0, 20.h, 20.h, 50.h),
      decoration: BoxDecoration(
        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.05),
        border: Border.all(width: 0.15),
        borderRadius: BorderRadius.circular(30),
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

              ),
            ),
            Expanded(
              flex: 15,
              child: CachedNetworkImage(
                imageUrl: widget.snapshot['games'],
                errorWidget: (context, url, error) => Icon(Icons.error),
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

  bool _visibleIcSmile = false;

  void doVotes() {
    _visibleIcSmile = !_visibleIcSmile;
    if (_visibleIcSmile) {
      FirebaseFirestore.instance
          .collection(tbGames)
          .doc(widget.snapshot.id)
          .update({"votes": widget.snapshot['votes'] + 1});
    } else {
      FirebaseFirestore.instance
          .collection(tbGames)
          .doc(widget.snapshot.id)
          .update({"votes": widget.snapshot['votes'] - 1});
    }
  }
}
