import 'package:business_logic/blocs/cart.dart';
import 'package:business_logic/business_logic.dart';
import 'package:catalog/catalog.dart';
import 'package:catalog/pages/catalog.dart';
import 'package:checkout/checkout.dart';
import 'package:coordinator_layout/coordinator_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uikit/components/textfield.dart';
import 'package:uikit/uikit.dart';
import 'package:user_info/user_info.dart';
import 'package:utils/utils.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<UserLocationBloc>().setAddress(UserAddress(
        name: "Home", address: "935-9940 Tortor. Street Santa Rosa MN 98804"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CoordinatorLayout(
        headerMaxHeight: 150,
        headerMinHeight: kToolbarHeight + MediaQuery.of(context).padding.top,
        headers: [
          Builder(builder: (context) {
            return SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverSafeArea(
                top: false,
                sliver: SliverCollapsingHeader(
                  builder: (context, offset, diff) {
                    return HomeHeader(
                      offset: offset,
                    );
                  },
                ),
              ),
            );
          }),
        ],
        body: IndexedStack(
          index: 0,
          children: [
            CatalogPage(),
          ],
        ),
      ),
      floatingActionButton: CartSummary(),
      bottomNavigationBar: OrderStatusView(),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
    required this.offset,
  }) : super(key: key);

  final double offset;
  final Curve collapseCurves = Curves.easeInOut;

  @override
  Widget build(BuildContext context) {
    final invertOffset = collapseCurves.transform(1 - offset);

    return Card(
      margin: EdgeInsets.zero,
      color: Theme.of(context).canvasColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      elevation: 1 * invertOffset,
      child: Stack(
        children: [
          TransparentAppBar(
            leading: Icon(Icons.menu),
            actions: [buildCartCounter()],
          ),
          Positioned(
            bottom: 2 + 8 * offset,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Opacity(
                  opacity: offset,
                  child: Container(
                    height: kToolbarHeight,
                    margin: EdgeInsets.only(
                      left: 32,
                      right: 32,
                    ),
                    child: DeliveryLocation(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 32 * invertOffset,
                    right: 28 * invertOffset,
                  ),
                  child: InkWell(
                    onTap: () => Navigator.of(context)
                        .pushNamed(RoutesPath.product, arguments: "search"),
                    child: AbsorbPointer(
                      absorbing: true,
                      child: SearchBar(),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  BlocBuilder<CartBloc, CartState> buildCartCounter() {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      bool hasItem = state.carts.isNotEmpty == true;
      int count = state.totalItem;
      return Stack(
        children: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(RoutesPath.checkout),
            icon: Container(
              child: hasItem
                  ? Icon(
                      Icons.shopping_bag,
                      color: Theme.of(context).primaryColor,
                    )
                  : Icon(Icons.shopping_bag_outlined),
            ),
          ),
          Positioned(
            right: 8,
            bottom: 16,
            child: Visibility(
              visible: hasItem,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: 16, minHeight: 16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).errorColor,
                  ),
                  height: 16,
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  alignment: Alignment.center,
                  child: Text(
                    count > 99 ? "99+" : "$count",
                    textAlign: TextAlign.center,
                    style: AppTextSyle.semiBold()
                        .size12()
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
