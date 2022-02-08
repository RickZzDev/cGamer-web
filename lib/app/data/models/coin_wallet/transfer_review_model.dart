class TransferReviewModel {
  String userDestination;
  String quantityString;
  double quantity;
  String availableAmmount;
  double taxAmount;

  TransferReviewModel(this.userDestination, this.quantityString, this.quantity,
      this.availableAmmount, this.taxAmount);
}
