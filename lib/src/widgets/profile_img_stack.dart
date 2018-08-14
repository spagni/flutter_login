import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ProfileImgStack extends AnimatedWidget {
  //Uso un ImageProvider para que la imagen pueda venir de muchas fuentes(Memory, Network, Assets)
  final ImageProvider<dynamic> image;
  final String title;
  final String subtitle;
  final Animation<double> animation;

  ProfileImgStack({Key key, @required this.image, @required this.animation, this.subtitle, @required this.title})
    : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: _stackHeight,
      width: double.infinity, 
      child: Stack(
        children: <Widget>[
          //Pongo la img de fondo en el decoration de un container para poder aplicarle el blur
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: image,
                fit: BoxFit.cover
              )
            ),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              //Para que se vea la imagen de atras con opacity
              child: new Container(
                decoration: new BoxDecoration(color: Colors.black.withOpacity(0.4))
              ),
            )
          ),
          Positioned(
            //Width de la pantalla sobre dos, menos el radio del avatar para que quede en el centro
            left: MediaQuery.of(context).size.width / 2 - 70.0,
            top: 30.0,
            child: ScaleTransition(
              scale: animation,
              child: CircleAvatar(
                backgroundImage: image,
                radius: 70.0,
                //Child para agregar el borde de color
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70.0),
                    border: Border.all(
                      color: Theme.of(context).accentColor,
                      width: 3.0
                    )
                  ),
                ),
              ),
            )
          ),
          Positioned(
            bottom: 50.0,
            left: 0.0,
            right: 0.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).canvasColor,
                    fontSize: 23.0
                  ),
                ),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).canvasColor,
                    fontSize: 15.0
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}