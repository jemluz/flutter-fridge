import 'package:flutter/material.dart';
import 'package:fridge/components/error_dialog.dart';
import 'package:fridge/components/image_preview.dart';
import 'package:fridge/components/text_input.dart';
import 'package:fridge/models/product.dart';
import 'package:fridge/models/products.dart';
import 'package:provider/provider.dart';

import '../../validations.dart';

class ProductForm extends StatefulWidget {
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  // DateTime _selectedDate = DateTime.now();

  final _nameCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _imgSrcController = TextEditingController();

  final _imgSrcFocusNode = FocusNode();

  final _addProductForm = GlobalKey<FormState>();
  final __addProductFormData = Map<String, Object>();

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
  }

  @override
  void dispose() {
    super.dispose();
    _imgSrcFocusNode.removeListener(upgradeImageUrl);
    _imgSrcFocusNode.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (__addProductFormData.isEmpty) {
      final product = ModalRoute.of(context).settings.arguments as Product;

      // navegando com argumentos
      // Navigator.of(context)
      //     .pushNamed(AppRoutes.PRODUCT_FORM, arguments: product);

      if (product != null) {
        __addProductFormData['id'] = product.id;
        __addProductFormData['name'] = product.name;
        __addProductFormData['amount'] = product.amount;
        __addProductFormData['imgSrc'] = product.imgSrc;

        _imgSrcController.text = __addProductFormData['imageUrl'];
      } else {
        __addProductFormData['amount'] = '';
      }
    }
  }

  void upgradeImageUrl() {
    if (Validation.isValidImageUrl(_imgSrcController.text)) {
      setState(() {});
    }
  }

  Future<void> _submitForm() async{
    final products = Provider.of<Products>(context, listen: false);

    Validation.validateForm(_addProductForm);
    _addProductForm.currentState.save();

    final newProduct = Product(
      id: __addProductFormData['id'],
      name: __addProductFormData['name'],
      amount: __addProductFormData['amount'],
      imgSrc: __addProductFormData['imgSrc'],
    );

    setState(() => _isLoading = true);

    try {
      await products.saveProduct(newProduct);
      Navigator.of(context).pop();
    } catch(error) {
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
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
          child: AlertDialog(
              title: Text('Adicionar item'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith(getColor),
                  ),
                  child: Text(
                    'Cancelar',
                    style: TextStyle(color: Theme.of(context).errorColor),
                  ),
                ),
                TextButton(
                    onPressed: () => _submitForm(), child: Text('Confirmar')),
              ],
              content: SingleChildScrollView(
                child: Form(
                  key: _addProductForm,
                  child: Column(
                    children: <Widget>[
                      ImagePreview(imgSrcController: _imgSrcController),
                      SizedBox(height: 16),
                      TextInput(
                        label: "Nome do Item",
                        ctrl: _nameCtrl,
                        onSaved: (value) => __addProductFormData['name'] = value,
                        onValidation: (value) => Validation.nameValidation(value),
                      ),
                      SizedBox(height: 16),
                      TextInput(
                        label: "Quantidade (Und)",
                        ctrl: _amountCtrl,
                        onSaved: (value) =>
                            __addProductFormData['amount'] = int.parse(value),
                        onValidation: (value) =>
                            Validation.amountValidation(value),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 16),
                      TextInput(
                          label: "Url da imagem",
                          ctrl: _imgSrcController,
                          focusNode: _imgSrcFocusNode,
                          onSaved: (value) =>
                              __addProductFormData['imgSrc'] = value,
                          onValidation: (value) =>
                              Validation.imgSrcValidation(value)),
                    ],
                  ),
                ),
              ),
            ),
        );
  }
}
