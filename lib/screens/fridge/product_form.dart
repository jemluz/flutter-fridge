import 'package:flutter/material.dart';
import 'package:fridge/components/error_dialog.dart';
import 'package:fridge/components/image_preview.dart';
import 'package:fridge/components/text_input.dart';
import 'package:fridge/models/product.dart';
import 'package:fridge/models/products.dart';
import 'package:fridge/themes.dart';
import 'package:provider/provider.dart';

import '../../enums.dart';
import '../../validations.dart';

class ProductForm extends StatefulWidget {
  SubmitType submitType;
  Product receivedProduct;
  String dialogTitle;

  ProductForm(
    this.submitType,
    this.receivedProduct,
    this.dialogTitle,
  );

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  TextEditingController _nameCtrl;
  TextEditingController _amountCtrl;
  TextEditingController _imgSrcController;

  final _imgSrcFocusNode = FocusNode();

  final _productForm = GlobalKey<FormState>();
  final __productFormData = Map<String, Object>();

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };

    if (states.any(interactiveStates.contains)) {
      return Theme.of(context).errorColor.withOpacity(.1);
    }

    return Colors.transparent;
  }

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imgSrcFocusNode.addListener(upgradeImageUrl);

    _imgSrcController = TextEditingController(text: '');

    final product = widget.receivedProduct;
    if (__productFormData.isEmpty && product != null) {
      __productFormData['id'] = product.id;
      __productFormData['name'] = product.name;
      __productFormData['amount'] = product.amount;
      __productFormData['imgSrc'] = product.imgSrc;

      _nameCtrl = TextEditingController(text: '${product.name}');
      _amountCtrl = TextEditingController(text: '${product.amount}');
      _imgSrcController = TextEditingController(text: '${product.imgSrc}');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _imgSrcFocusNode.removeListener(upgradeImageUrl);
    _imgSrcFocusNode.dispose();
  }

  void upgradeImageUrl() {
    if (Validation.isValidImageUrl(_imgSrcController.text)) {
      setState(() {});
    }
  }

  Future<void> _submitForm() async {
    final products = Provider.of<Products>(context, listen: false);

    Validation.validateForm(_productForm);
    _productForm.currentState.save();

    final newProduct = Product(
      id: __productFormData['id'],
      name: __productFormData['name'],
      amount: __productFormData['amount'],
      imgSrc: __productFormData['imgSrc'],
    );

    setState(() => _isLoading = true);

    try {
      if (widget.submitType == SubmitType.save) {
        await products.saveProduct(newProduct);
      } else {
        await products.updateProduct(__productFormData['id'], newProduct);
      }

      Navigator.of(context).pop();
    } catch (error) {
      await showDialog<Null>(
        context: context,
        builder: (ctx) => ErrorDialog(
          context: context,
          message: error,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context, listen: false);

    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: AlertDialog(
              title: Text(widget.dialogTitle),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.resolveWith(getColor),
                  ),
                  child: Text(
                    'Cancelar',
                    style: TextStyle(color: Theme.of(context).errorColor),
                  ),
                ),
                TextButton(
                  onPressed: () => _submitForm(),
                  child: Text('Confirmar'),
                ),
              ],
              content: SingleChildScrollView(
                child: Form(
                  key: _productForm,
                  child: Column(
                    children: <Widget>[
                      ImagePreview(imgSrcController: _imgSrcController),
                      SizedBox(height: 16),
                      TextInput(
                        label: "Nome do Item",
                        ctrl: _nameCtrl,
                        onSaved: (value) => __productFormData['name'] = value,
                        onValidation: (value) =>
                            Validation.nameValidation(value),
                      ),
                      SizedBox(height: 16),
                      TextInput(
                        label: "Quantidade (Und)",
                        ctrl: _amountCtrl,
                        onSaved: (value) =>
                            __productFormData['amount'] = int.parse(value),
                        onValidation: (value) =>
                            Validation.amountValidation(value),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 16),
                      TextInput(
                        label: "Url da imagem",
                        ctrl: _imgSrcController,
                        focusNode: _imgSrcFocusNode,
                        onSaved: (value) => __productFormData['imgSrc'] = value,
                        onValidation: (value) =>
                            Validation.imgSrcValidation(value),
                      ),
                      SizedBox(height: 16),
                      widget.submitType == SubmitType.save ? SizedBox() : Material(
                        color: AppColors.RED_n230.withOpacity(.1),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text('Excluir produto'),
                                content: Text(
                                    'Tem certeza que quer excluir este produto?'),
                                actions: [
                                  TextButton(
                                    child: Text('Não'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                  TextButton(
                                    child: Text('Sim'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                  )
                                ],
                              ),
                            ).then((value) {
                              if (value) {
                                try {
                                  products
                                      .deleteProduct(widget.receivedProduct.id);
                                  Navigator.of(context).pop();
                                } catch (error) {
                                  print(error.toString());
                                }
                              }
                            });
                          },
                          highlightColor: AppColors.RED_n230.withOpacity(.1),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.delete, color: AppColors.RED_n230),
                                SizedBox(width: 12),
                                Text(
                                  'Excluir produto',
                                  style: TextStyle(
                                      fontSize: 18, color: AppColors.RED_n230),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
