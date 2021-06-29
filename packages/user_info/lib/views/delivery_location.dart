import 'package:business_logic/blocs/user_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uikit/uikit.dart';

class DeliveryLocation extends StatelessWidget {
  const DeliveryLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserLocationBloc, UserLocationState>(
        builder: (context, state) {
      return Hero(
        tag: "delivery-location-detail",
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          margin: EdgeInsets.zero,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: Row(
                children: [
                  Icon(
                    Icons.place,
                    color: Colors.red,
                    size: 24,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        state.address?.name ?? "-",
                        style: AppTextSyle.bold().size14(),
                      ),
                      Text(
                        state.address?.address ?? "-",
                        maxLines: 2,
                        style: AppTextSyle.semiBold(height: 1)
                            .size12()
                            .colorDisabled(context),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
