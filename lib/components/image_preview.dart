import 'package:flutter/material.dart';

import '../themes.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    Key key,
    @required TextEditingController imgSrcController,
  }) : _imgSrcController = imgSrcController, super(key: key);

  final TextEditingController _imgSrcController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.GRAY_n236, width: 1),
      ),
      child: _imgSrcController.text.isEmpty
          ? Center(
              child: Text(
                "Prévia da imagem",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            )
          : FittedBox(
              child: Image.network(
                _imgSrcController.text,
                fit: BoxFit.fill,
              ),
            ),
    );
  }
}