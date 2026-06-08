sealed class SavedAddressesIntent {
  const SavedAddressesIntent();
}

class LoadAddressesIntent extends SavedAddressesIntent {
  const LoadAddressesIntent();
}

class DeleteAddressIntent extends SavedAddressesIntent {
  final String id;
  const DeleteAddressIntent(this.id);
}

class SelectAddressIntent extends SavedAddressesIntent {
  final String id;
  const SelectAddressIntent(this.id);
}
