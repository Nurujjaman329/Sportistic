import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class BannerWidget extends StatefulWidget {
  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List _bannersImages = [];

  getBanners() {
    return _firestore
        .collection('banners')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _bannersImages.add(doc['images']);
        });
      });
    });
  }

  @override
  void initState() {
    getBanners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.yellow.shade900,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: PageView.builder(
            itemCount: _bannersImages.length,
            itemBuilder: ((context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: _bannersImages[index],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer(
                    duration: Duration(seconds: 3), //Default value
                    interval: Duration(
                        seconds: 5), //Default value: Duration(seconds: 0)
                    color: Colors.white, //Default value
                    colorOpacity: 0, //Default value
                    enabled: true, //Default value
                    direction: ShimmerDirection.fromLTRB(), //Default Value
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              );
            }),
          )),
    );
  }
}
