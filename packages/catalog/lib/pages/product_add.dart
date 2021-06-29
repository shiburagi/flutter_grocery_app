import 'package:business_logic/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize/generated/l10n.dart';
import 'package:uikit/uikit.dart';

class ProductAddPage extends StatefulWidget {
  ProductAddPage({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  _ProductAddPageState createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  final TextEditingController _quatityController =
      TextEditingController(text: "1");
  final TextEditingController _instructionController = TextEditingController();
  late Cart cart;

  bool isUpdate = false;
  bool isRemove = false;
  @override
  void initState() {
    cart = context.read<CartBloc>().getCart(widget.product);
    _quatityController.addListener(() {
      setState(() {
        isRemove = int.tryParse(_quatityController.text) == 0;
      });
    });
    _quatityController.text = (cart.quantity ?? 1).toString();
    _instructionController.text = cart.instructions ?? "";
    isUpdate = cart.quantity != null;
    super.initState();
  }

  onSubmit() {
    if (isRemove) {
      context.read<CartBloc>().removeItem(cart);
    } else {
      int quantity = int.tryParse(_quatityController.text) ?? 1;
      cart.quantity = quantity;
      cart.instructions = _instructionController.text;
      context.read<CartBloc>().addItem(cart);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(24, 12, 24, 8),
          child: buildTitle(context),
        ),
        Divider(height: 1),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                children: [
                  Text(S.of(context).specialinstruction,
                      style: AppTextSyle.semiBold().size14()),
                  Text(" | ${S.of(context).optional}",
                      style: AppTextSyle.regular()
                          .size14()
                          .colorDisabled(context)),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _instructionController,
                maxLines: 6,
                minLines: 2,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "E.g: no plastic",
                  hintStyle: AppTextSyle.light().size14(),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              buildQuantityControl(),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  style: isRemove
                      ? ElevatedButton.styleFrom(
                          primary: Theme.of(context).errorColor)
                      : null,
                  onPressed: onSubmit,
                  child: Text((isRemove
                          ? S.of(context).remove
                          : isUpdate
                              ? S.of(context).updatebasket
                              : S.of(context).additem)
                      .toUpperCase()))
            ],
          ),
        ),
      ],
    );
  }

  addQuatitty(int value) {
    int nextValue = (int.tryParse(_quatityController.text) ?? 0) + value;
    if (nextValue >= 0) _quatityController.text = "$nextValue";
  }

  Row buildQuantityControl() {
    return Row(
      children: [
        FloatingActionButton(
          onPressed: () {
            addQuatitty(-1);
          },
          mini: true,
          child: Icon(Icons.remove),
        ),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(border: InputBorder.none),
            controller: _quatityController,
            textAlign: TextAlign.center,
          ),
        ),
        FloatingActionButton(
          onPressed: () {
            addQuatitty(1);
          },
          mini: true,
          child: Icon(Icons.add),
        ),
      ],
    );
  }

  Container buildTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8),
      alignment: Alignment.centerRight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.product.title ?? "-",
                  style: AppTextSyle.semiBold().size18(),
                ),
                Text(
                  widget.product.description ?? "-",
                  style: AppTextSyle.regular(height: 1)
                      .size14()
                      .colorHint(context),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Theme.of(context).primaryColor),
              color: Theme.of(context).primaryColor.withOpacity(0.1),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              "\$ ${widget.product.price}",
              style: AppTextSyle.regular().size18(),
            ),
          ),
        ],
      ),
    );
  }
}
