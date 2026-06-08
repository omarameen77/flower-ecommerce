import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension AddressConstants on BuildContext {
  String get addressTitle => 'address.title'.tr();
  String get addressLabel => 'address.address_label'.tr();
  String get enterAddress => 'address.enter_address'.tr();
  String get phoneNumber => 'address.phone_number'.tr();
  String get enterPhoneNumber => 'address.enter_phone_number'.tr();
  String get recipientName => 'address.recipient_name'.tr();
  String get enterRecipientName => 'address.enter_recipient_name'.tr();
  String get cityLabel => 'address.city'.tr();
  String get areaLabel => 'address.area'.tr();
  String get selectCity => 'address.select_city'.tr();
  String get selectArea => 'address.select_area'.tr();
  String get saveAddress => 'address.save_address'.tr();
  String get addressSaved => 'address.address_saved'.tr();
  String get locationPermissionDenied =>
      'address.location_permission_denied'.tr();

  String get savedAddressTitle => 'address.saved_address_title'.tr();
  String get addNewAddress => 'address.add_new_address'.tr();
  String get noSavedAddresses => 'address.no_saved_addresses'.tr();
  String get deleteAddressTitle => 'address.delete_address_title'.tr();
  String get deleteAddressMessage => 'address.delete_address_message'.tr();
  String get cancel => 'address.cancel'.tr();
  String get delete => 'address.delete'.tr();
  String get deliverTo => 'address.deliver_to'.tr();
}
