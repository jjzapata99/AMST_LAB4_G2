import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../constants/colors.dart';
import '../../../models/cart.dart';
import '../../../models/product.dart';

class ProductView extends StatefulWidget {
  final Product product;

  ProductView(this.product);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.product.video)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.product.color,
      appBar: AppBar(
        backgroundColor: widget.product.color,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: AppColors.text_light,
            ),
            onPressed: () => Navigator.of(context).pushNamed("/cart-view"),
          ),
        ],
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        Expanded(
            flex: 2,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      widget.product.title,
                      style:
                          TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child:
                            Stack(alignment: Alignment.bottomRight, children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 80.0),
                        child: Hero(
                            tag: "${widget.product.id}",
                            child: Image.asset(widget.product.image)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Precio",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "\$" + widget.product.price.toString(),
                                style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.normal),
                              ),
                            ]),
                      ),
                    ]))
                  ],
                ))),
        Expanded(
          flex: 2,
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(5),
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: Text(widget.product.description),
                  ),
                  Material(
                    type: MaterialType.transparency,
                    child: Ink(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 3.0),
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(1000),
                        onTap: () => {demoCarts.addItem(widget.product)},
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Icon(Icons.shopping_cart),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25),

                  ),
                  _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                      : Container(),
                ]),
              )),
        )
      ],
    );
  }
}
