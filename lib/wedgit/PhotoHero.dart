import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoHero extends StatelessWidget {
  const PhotoHero({ Key key, this.photo, this.onTap, this.width }) : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;

  Widget build(BuildContext context) {
    return new SizedBox(
      width: width,
      child: new Hero(
        tag: photo,
        child: new Material(
          color: Colors.transparent,
          child: new InkWell(
            onTap: onTap,
            child:  CachedNetworkImage(
              imageUrl:
              photo,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}