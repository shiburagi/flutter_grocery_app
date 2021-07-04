// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Add item`
  String get additem {
    return Intl.message(
      'Add item',
      name: 'additem',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `No item added on cart.`
  String get emptycart_msg {
    return Intl.message(
      'No item added on cart.',
      name: 'emptycart_msg',
      desc: '',
      args: [],
    );
  }

  /// `Buy again`
  String get buyagain {
    return Intl.message(
      'Buy again',
      name: 'buyagain',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Cancel order`
  String get cancelorder {
    return Intl.message(
      'Cancel order',
      name: 'cancelorder',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Contact support`
  String get contactsupport {
    return Intl.message(
      'Contact support',
      name: 'contactsupport',
      desc: '',
      args: [],
    );
  }

  /// `home`
  String get home {
    return Intl.message(
      'home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `{howMany, plural, one{1 item} other{{howMany} items}}`
  String n_item(num howMany) {
    return Intl.plural(
      howMany,
      one: '1 item',
      other: '$howMany items',
      name: 'n_item',
      desc: '',
      args: [howMany],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `More choice`
  String get morechoice {
    return Intl.message(
      'More choice',
      name: 'morechoice',
      desc: '',
      args: [],
    );
  }

  /// `Order delivered`
  String get orderdelivered {
    return Intl.message(
      'Order delivered',
      name: 'orderdelivered',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for your order`
  String get orderdelivered_msg {
    return Intl.message(
      'Thank you for your order',
      name: 'orderdelivered_msg',
      desc: '',
      args: [],
    );
  }

  /// `Order placed`
  String get orderplaced {
    return Intl.message(
      'Order placed',
      name: 'orderplaced',
      desc: '',
      args: [],
    );
  }

  /// `Your order is being processed`
  String get orderplaced_msg {
    return Intl.message(
      'Your order is being processed',
      name: 'orderplaced_msg',
      desc: '',
      args: [],
    );
  }

  /// `Order collected`
  String get ordercollected {
    return Intl.message(
      'Order collected',
      name: 'ordercollected',
      desc: '',
      args: [],
    );
  }

  /// `Get ready to receive your order`
  String get ordercollected_msg {
    return Intl.message(
      'Get ready to receive your order',
      name: 'ordercollected_msg',
      desc: '',
      args: [],
    );
  }

  /// `Optional`
  String get optional {
    return Intl.message(
      'Optional',
      name: 'optional',
      desc: '',
      args: [],
    );
  }

  /// `Payment details`
  String get paymentdetails {
    return Intl.message(
      'Payment details',
      name: 'paymentdetails',
      desc: '',
      args: [],
    );
  }

  /// `People also bought`
  String get peoplealsobought {
    return Intl.message(
      'People also bought',
      name: 'peoplealsobought',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pay {
    return Intl.message(
      'Pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `profile`
  String get profile {
    return Intl.message(
      'profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Requesting`
  String get requesting {
    return Intl.message(
      'Requesting',
      name: 'requesting',
      desc: '',
      args: [],
    );
  }

  /// `Recommend for you`
  String get recommendforyou {
    return Intl.message(
      'Recommend for you',
      name: 'recommendforyou',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Requested items`
  String get requesteditems {
    return Intl.message(
      'Requested items',
      name: 'requesteditems',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get seeall {
    return Intl.message(
      'See all',
      name: 'seeall',
      desc: '',
      args: [],
    );
  }

  /// `Special instructions`
  String get specialinstruction {
    return Intl.message(
      'Special instructions',
      name: 'specialinstruction',
      desc: '',
      args: [],
    );
  }

  /// `Total amount`
  String get totalamount {
    return Intl.message(
      'Total amount',
      name: 'totalamount',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Update basket`
  String get updatebasket {
    return Intl.message(
      'Update basket',
      name: 'updatebasket',
      desc: '',
      args: [],
    );
  }

  /// `Voucher`
  String get voucher {
    return Intl.message(
      'Voucher',
      name: 'voucher',
      desc: '',
      args: [],
    );
  }

  /// `Your basket`
  String get yourbasket {
    return Intl.message(
      'Your basket',
      name: 'yourbasket',
      desc: '',
      args: [],
    );
  }

  /// `Your basket is empty`
  String get yourbasketisempty {
    return Intl.message(
      'Your basket is empty',
      name: 'yourbasketisempty',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
