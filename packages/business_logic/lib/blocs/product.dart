import 'package:bloc/bloc.dart';
import 'package:business_logic/business_logic.dart';
import 'package:utils/utils.dart';

class ProductBloc extends Cubit<ProductState> {
  ProductBloc() : super(ProductState());

  Product? getProduct(int? productId) => state.getProduct(productId);

  Future<List<Product>> retrieveProduct() async {
    final data = await ProductRepo.instance.getProducts();

    emit(state.copyWith(products: data));
    return data;
  }

  Future<List<Product>> retrieveSuggestions(String type) async {
    final data = await ProductRepo.instance.getSuggestion(type);
    emit(state.copyWith(suggestions: {...state.suggestions, type: data}));
    return data;
  }

  Future<List<Category>> retrieveCategories() async {
    final data = await ProductRepo.instance.getCategories();
    emit(state.copyWith(categories: data));
    return data;
  }

  filter(String value) {
    emit(state.copyWith(filter: value.toLowerCase()));
  }
}

class ProductState {
  final List<Product>? products;
  final List<Category>? categories;
  final Map<String, List<Product>> suggestions;
  final String filter;

  ProductState(
      {this.products,
      this.filter = "",
      this.categories,
      this.suggestions = const {}});

  Product? getProduct(int? productId) {
    try {
      return products?.firstWhere(
        (element) => element.productId == productId,
      );
    } catch (e) {
      return null;
    }
  }

  List<Product>? getProducts(String? type) {
    if (type == null) return products;
    if (ProductFilter.isBasicFilter(type)) return suggestions[type];

    return products?.where((element) => element.type == type).toList();
  }

  List<Product>? getFilterProducts(String? type) {
    return getProducts(type)
        ?.where((element) =>
            element.title?.toLowerCase().contains(filter) == true ||
            element.type?.toLowerCase().contains(filter) == true)
        .toList();
  }

  ProductState copyWith({
    List<Product>? products,
    List<Category>? categories,
    String? filter,
    Map<String, List<Product>>? suggestions,
  }) =>
      ProductState(
          products: products ?? this.products,
          filter: filter ?? this.filter,
          categories: categories ?? this.categories,
          suggestions: suggestions ?? this.suggestions);
}
