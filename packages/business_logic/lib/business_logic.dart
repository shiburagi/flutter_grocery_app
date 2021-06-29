import 'package:business_logic/blocs/cart.dart';
import 'package:business_logic/blocs/payment.dart';
import 'package:business_logic/blocs/product.dart';
import 'package:business_logic/blocs/user_location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';

export 'package:repositories/repositories.dart';

export 'blocs/cart.dart';
export 'blocs/payment.dart';
export 'blocs/product.dart';
export 'blocs/user_location.dart';

List<BlocProvider> get blocs => [
      BlocProvider<CartBloc>(
        create: (context) {
          return CartBloc();
        },
      ),
      BlocProvider<PaymentBloc>(
        create: (context) {
          return PaymentBloc();
        },
      ),
      BlocProvider<ProductBloc>(
        create: (context) {
          return ProductBloc();
        },
      ),
      BlocProvider<UserLocationBloc>(
        create: (context) {
          return UserLocationBloc();
        },
      ),
    ];
