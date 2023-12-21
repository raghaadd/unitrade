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

  /// `Account`
  String get Account {
    return Intl.message(
      'Account',
      name: 'Account',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get Settings {
    return Intl.message(
      'Settings',
      name: 'Settings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get Language {
    return Intl.message(
      'Language',
      name: 'Language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get Lang_type {
    return Intl.message(
      'English',
      name: 'Lang_type',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get Chnage_pass {
    return Intl.message(
      'Change Password',
      name: 'Chnage_pass',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get Notifications {
    return Intl.message(
      'Notifications',
      name: 'Notifications',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get Dark_mode {
    return Intl.message(
      'Dark Mode',
      name: 'Dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Send Feedback`
  String get Send_feedback {
    return Intl.message(
      'Send Feedback',
      name: 'Send_feedback',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get Categories {
    return Intl.message(
      'Categories',
      name: 'Categories',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get view_all {
    return Intl.message(
      'View All',
      name: 'view_all',
      desc: '',
      args: [],
    );
  }

  /// `Search Items`
  String get Search {
    return Intl.message(
      'Search Items',
      name: 'Search',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message(
      'Cancel',
      name: 'Cancel',
      desc: '',
      args: [],
    );
  }

  /// `Resturants`
  String get Resturants {
    return Intl.message(
      'Resturants',
      name: 'Resturants',
      desc: '',
      args: [],
    );
  }

  /// `Recently added`
  String get Recently_added {
    return Intl.message(
      'Recently added',
      name: 'Recently_added',
      desc: '',
      args: [],
    );
  }

  /// ` Details`
  String get Details {
    return Intl.message(
      ' Details',
      name: 'Details',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get Status {
    return Intl.message(
      'Status',
      name: 'Status',
      desc: '',
      args: [],
    );
  }

  /// ` Description`
  String get Description {
    return Intl.message(
      ' Description',
      name: 'Description',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get Name {
    return Intl.message(
      'Name',
      name: 'Name',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get Category {
    return Intl.message(
      'Category',
      name: 'Category',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get Date {
    return Intl.message(
      'Date',
      name: 'Date',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get Phone {
    return Intl.message(
      'Phone',
      name: 'Phone',
      desc: '',
      args: [],
    );
  }

  /// `No items to display.`
  String get Message_No_item {
    return Intl.message(
      'No items to display.',
      name: 'Message_No_item',
      desc: '',
      args: [],
    );
  }

  /// `Click to add item`
  String get click_to_add_item {
    return Intl.message(
      'Click to add item',
      name: 'click_to_add_item',
      desc: '',
      args: [],
    );
  }

  /// `Add image here`
  String get add_image {
    return Intl.message(
      'Add image here',
      name: 'add_image',
      desc: '',
      args: [],
    );
  }

  /// `You can remove an image by tapping on it.`
  String get remove_image {
    return Intl.message(
      'You can remove an image by tapping on it.',
      name: 'remove_image',
      desc: '',
      args: [],
    );
  }

  /// `Item name`
  String get item_name {
    return Intl.message(
      'Item name',
      name: 'item_name',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get Next {
    return Intl.message(
      'Next',
      name: 'Next',
      desc: '',
      args: [],
    );
  }

  /// `Pick from Gallery`
  String get pick_from_gallery {
    return Intl.message(
      'Pick from Gallery',
      name: 'pick_from_gallery',
      desc: '',
      args: [],
    );
  }

  /// `Take a Photo`
  String get take_photo {
    return Intl.message(
      'Take a Photo',
      name: 'take_photo',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get Back {
    return Intl.message(
      'Back',
      name: 'Back',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get Upload {
    return Intl.message(
      'Upload',
      name: 'Upload',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get Select {
    return Intl.message(
      'Select',
      name: 'Select',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get Complete {
    return Intl.message(
      'Complete',
      name: 'Complete',
      desc: '',
      args: [],
    );
  }

  /// `Recent Chats`
  String get Recent_chats {
    return Intl.message(
      'Recent Chats',
      name: 'Recent_chats',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get see_all {
    return Intl.message(
      'See All',
      name: 'see_all',
      desc: '',
      args: [],
    );
  }

  /// `My Items`
  String get My_Items {
    return Intl.message(
      'My Items',
      name: 'My_Items',
      desc: '',
      args: [],
    );
  }

  /// `SoftCopy Slides`
  String get softcopy_slides {
    return Intl.message(
      'SoftCopy Slides',
      name: 'softcopy_slides',
      desc: '',
      args: [],
    );
  }

  /// `Requests`
  String get Requests {
    return Intl.message(
      'Requests',
      name: 'Requests',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get Delete {
    return Intl.message(
      'Delete',
      name: 'Delete',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get Edit {
    return Intl.message(
      'Edit',
      name: 'Edit',
      desc: '',
      args: [],
    );
  }

  /// `Hardware`
  String get Hardware {
    return Intl.message(
      'Hardware',
      name: 'Hardware',
      desc: '',
      args: [],
    );
  }

  /// `Software`
  String get Software {
    return Intl.message(
      'Software',
      name: 'Software',
      desc: '',
      args: [],
    );
  }

  /// `Please Select the type of item you want to upload`
  String get select_type_of_item {
    return Intl.message(
      'Please Select the type of item you want to upload',
      name: 'select_type_of_item',
      desc: '',
      args: [],
    );
  }

  /// `Item Type`
  String get Item_type {
    return Intl.message(
      'Item Type',
      name: 'Item_type',
      desc: '',
      args: [],
    );
  }

  /// `Type your message here...`
  String get Type_msg {
    return Intl.message(
      'Type your message here...',
      name: 'Type_msg',
      desc: '',
      args: [],
    );
  }

  /// `Items`
  String get Items {
    return Intl.message(
      'Items',
      name: 'Items',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get Download {
    return Intl.message(
      'Download',
      name: 'Download',
      desc: '',
      args: [],
    );
  }

  /// `Preview`
  String get Preview {
    return Intl.message(
      'Preview',
      name: 'Preview',
      desc: '',
      args: [],
    );
  }

  /// `No slides to display`
  String get no_slides_to_display {
    return Intl.message(
      'No slides to display',
      name: 'no_slides_to_display',
      desc: '',
      args: [],
    );
  }

  /// `Paid Books and Slides`
  String get paid_books_slides {
    return Intl.message(
      'Paid Books and Slides',
      name: 'paid_books_slides',
      desc: '',
      args: [],
    );
  }

  /// `Free Books and Slides`
  String get free_books_slides {
    return Intl.message(
      'Free Books and Slides',
      name: 'free_books_slides',
      desc: '',
      args: [],
    );
  }

  /// `Copy Type`
  String get Copy_type {
    return Intl.message(
      'Copy Type',
      name: 'Copy_type',
      desc: '',
      args: [],
    );
  }

  /// `Please Select the type of copy you want`
  String get select_the_copy_type {
    return Intl.message(
      'Please Select the type of copy you want',
      name: 'select_the_copy_type',
      desc: '',
      args: [],
    );
  }

  /// `Pick PDF File`
  String get pick_pdf {
    return Intl.message(
      'Pick PDF File',
      name: 'pick_pdf',
      desc: '',
      args: [],
    );
  }

  /// `Add file here`
  String get add_file {
    return Intl.message(
      'Add file here',
      name: 'add_file',
      desc: '',
      args: [],
    );
  }

  /// `File Name`
  String get file_name {
    return Intl.message(
      'File Name',
      name: 'file_name',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get Accept {
    return Intl.message(
      'Accept',
      name: 'Accept',
      desc: '',
      args: [],
    );
  }

  /// `Decline`
  String get Decline {
    return Intl.message(
      'Decline',
      name: 'Decline',
      desc: '',
      args: [],
    );
  }

  /// ` has requested to reserved your `
  String get request_your_item {
    return Intl.message(
      ' has requested to reserved your ',
      name: 'request_your_item',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get first_name {
    return Intl.message(
      'First Name',
      name: 'first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get last_name {
    return Intl.message(
      'Last Name',
      name: 'last_name',
      desc: '',
      args: [],
    );
  }

  /// `Major`
  String get Major {
    return Intl.message(
      'Major',
      name: 'Major',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get About {
    return Intl.message(
      'About',
      name: 'About',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get Save {
    return Intl.message(
      'Save',
      name: 'Save',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Payment method`
  String get payment {
    return Intl.message(
      'Payment method',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Credit Card`
  String get Credit_card {
    return Intl.message(
      'Credit Card',
      name: 'Credit_card',
      desc: '',
      args: [],
    );
  }

  /// `Validate`
  String get validate {
    return Intl.message(
      'Validate',
      name: 'validate',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get Pay {
    return Intl.message(
      'Pay',
      name: 'Pay',
      desc: '',
      args: [],
    );
  }

  /// `PayPal Checkout`
  String get PayPal_check {
    return Intl.message(
      'PayPal Checkout',
      name: 'PayPal_check',
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
      Locale.fromSubtags(languageCode: 'ar'),
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
