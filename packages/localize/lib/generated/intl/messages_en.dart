// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(howMany) =>
      "${Intl.plural(howMany, one: '1 item', other: '${howMany} items')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add": MessageLookupByLibrary.simpleMessage("Add"),
        "additem": MessageLookupByLibrary.simpleMessage("Add item"),
        "back": MessageLookupByLibrary.simpleMessage("Back"),
        "buyagain": MessageLookupByLibrary.simpleMessage("Buy again"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "cancelorder": MessageLookupByLibrary.simpleMessage("Cancel order"),
        "categories": MessageLookupByLibrary.simpleMessage("Categories"),
        "checkout": MessageLookupByLibrary.simpleMessage("Checkout"),
        "close": MessageLookupByLibrary.simpleMessage("Close"),
        "contactsupport":
            MessageLookupByLibrary.simpleMessage("Contact support"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "emptycart_msg":
            MessageLookupByLibrary.simpleMessage("No item added on cart."),
        "home": MessageLookupByLibrary.simpleMessage("home"),
        "more": MessageLookupByLibrary.simpleMessage("More"),
        "morechoice": MessageLookupByLibrary.simpleMessage("More choice"),
        "n_item": m0,
        "optional": MessageLookupByLibrary.simpleMessage("Optional"),
        "ordercollected":
            MessageLookupByLibrary.simpleMessage("Order collected"),
        "ordercollected_msg": MessageLookupByLibrary.simpleMessage(
            "Get ready to receive your order"),
        "orderdelivered":
            MessageLookupByLibrary.simpleMessage("Order delivered"),
        "orderdelivered_msg":
            MessageLookupByLibrary.simpleMessage("Thank you for your order"),
        "orderplaced": MessageLookupByLibrary.simpleMessage("Order placed"),
        "orderplaced_msg": MessageLookupByLibrary.simpleMessage(
            "Your order is being processed"),
        "paymentdetails":
            MessageLookupByLibrary.simpleMessage("Payment details"),
        "peoplealsobought":
            MessageLookupByLibrary.simpleMessage("People also bought"),
        "profile": MessageLookupByLibrary.simpleMessage("profile"),
        "recommendforyou":
            MessageLookupByLibrary.simpleMessage("Recommend for you"),
        "remove": MessageLookupByLibrary.simpleMessage("Remove"),
        "requesteditems":
            MessageLookupByLibrary.simpleMessage("Requested items"),
        "requesting": MessageLookupByLibrary.simpleMessage("Requesting"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "seeall": MessageLookupByLibrary.simpleMessage("See all"),
        "specialinstruction":
            MessageLookupByLibrary.simpleMessage("Special instructions"),
        "totalamount": MessageLookupByLibrary.simpleMessage("Total amount"),
        "update": MessageLookupByLibrary.simpleMessage("Update"),
        "updatebasket": MessageLookupByLibrary.simpleMessage("Update basket"),
        "voucher": MessageLookupByLibrary.simpleMessage("Voucher")
      };
}
