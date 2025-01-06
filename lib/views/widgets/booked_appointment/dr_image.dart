import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget buildDoctorImage(String imageUrl) {
  const double _kPadding = 20.0;
  const double _kImageSize = 80.0;
  return Container(
    width: _kImageSize,
    height: _kImageSize,
    decoration: BoxDecoration( 
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(_kPadding),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(_kPadding),
      child:CachedNetworkImage(imageUrl: imageUrl,
      fit: BoxFit.cover,
       placeholder: (context, url) =>Icon(Icons.person), 
                    errorWidget: (context, url, error) => Icon(Icons.error),
      )
    ),
  );
}
