part of '../route_checkout.dart';

enum _WidgetCheckoutOptionType {
  delivery,
  payment,
}

class _WidgetCheckoutOption extends StatefulWidget {
  const _WidgetCheckoutOption({
    required this.type,
    required this.options,
    required this.onCartSettingsUpdate,
    required this.goToNextStep,
    required this.title,
    required this.subtitle,
    required this.inputFieldsTitle,
    required this.inputFieldsNotice,
    this.additionalTextInputFields,
  });

  final _WidgetCheckoutOptionType type;

  final List<GsaModelSaleItem> options;

  final String title, subtitle;

  final String inputFieldsTitle, inputFieldsNotice;

  final Function onCartSettingsUpdate;

  final Function goToNextStep;

  final List? additionalTextInputFields;

  @override
  State<_WidgetCheckoutOption> createState() => _WidgetCheckoutOptionState();
}

class _WidgetCheckoutOptionState extends State<_WidgetCheckoutOption> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late GsaModelSaleItem? _selectedOption;

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameTextController,
      _lastNameTextController,
      _phonePrefixTextController,
      _phoneNumberTextController,
      _emailTextController,
      _streetNameTextController,
      _houseNumberTextController,
      _postcodeTextController,
      _cityTextController,
      _stateTextController,
      _countryTextController;

  final _existingPersonalDetails = GsaDataCheckout.instance.orderDraft.deliveryAddress?.personalDetails ??
      GsaDataCheckout.instance.orderDraft.client?.personalDetails ??
      GsaDataCheckout.instance.orderDraft.invoiceAddress?.personalDetails ??
      GsaDataUser.instance.user?.personalDetails;

  final _existingContactDetails = GsaDataCheckout.instance.orderDraft.deliveryAddress?.contactDetails ??
      GsaDataCheckout.instance.orderDraft.client?.contactDetails ??
      GsaDataCheckout.instance.orderDraft.invoiceAddress?.contactDetails ??
      GsaDataUser.instance.user?.contact;

  final _existingAddressDetails = GsaDataCheckout.instance.orderDraft.deliveryAddress ??
      GsaDataCheckout.instance.orderDraft.invoiceAddress ??
      GsaDataUser.instance.user?.address;

  @override
  void initState() {
    super.initState();
    if (widget.type == _WidgetCheckoutOptionType.delivery) {
      _selectedOption = GsaDataCheckout.instance.orderDraft.deliveryType;
    } else {
      _selectedOption = GsaDataCheckout.instance.orderDraft.paymentType;
    }
    if (widget.options.isNotEmpty && _selectedOption == null) {
      _selectedOption = widget.options[0];
      if (widget.type == _WidgetCheckoutOptionType.delivery) {
        GsaDataCheckout.instance.orderDraft.deliveryType = _selectedOption;
      } else {
        GsaDataCheckout.instance.orderDraft.paymentType = _selectedOption;
      }
    }
    _firstNameTextController = TextEditingController(
      text: _existingPersonalDetails?.firstName,
    );
    _lastNameTextController = TextEditingController(
      text: _existingPersonalDetails?.lastName,
    );
    _phonePrefixTextController = TextEditingController(
      text: _existingContactDetails?.phoneCountryCode ?? '1',
    );
    _phoneNumberTextController = TextEditingController(
      text: _existingContactDetails?.phoneNumber,
    );
    _emailTextController = TextEditingController(
      text: _existingContactDetails?.email,
    );
    _streetNameTextController = TextEditingController(
      text: _existingAddressDetails?.streetName,
    );
    _houseNumberTextController = TextEditingController(
      text: _existingAddressDetails?.houseNumber,
    );
    _postcodeTextController = TextEditingController(
      text: _existingAddressDetails?.zipCode,
    );
    _cityTextController = TextEditingController(
      text: _existingAddressDetails?.city,
    );
    _stateTextController = TextEditingController(
      text: _existingAddressDetails?.state,
    );
    _countryTextController = TextEditingController(
      text: _existingAddressDetails?.country,
    );
  }

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        ListView(
          controller: _scrollController,
          padding: const EdgeInsets.all(20),
          children: [
            GsaWidgetText(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 9),
            GsaWidgetText(
              widget.subtitle,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 20),
            for (final option in widget.options.indexed)
              Padding(
                padding: option.$1 == 0 ? EdgeInsets.zero : const EdgeInsets.only(top: 12),
                child: InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: _selectedOption == option.$2 ? Theme.of(context).primaryColor : Colors.grey.withOpacity(.2),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 14),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    color: _selectedOption == option.$2 ? Theme.of(context).primaryColor : null,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const SizedBox(
                                    width: 10,
                                    height: 10,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GsaWidgetText(
                                  option.$2.name ?? 'N/A',
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              GsaWidgetText(
                                ' ${option.$2.price?.formatted}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          if (option.$2.description != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: GsaWidgetText(
                                option.$2.description!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    if (widget.type == _WidgetCheckoutOptionType.delivery) {
                      GsaDataCheckout.instance.orderDraft.deliveryType = option.$2;
                    } else {
                      GsaDataCheckout.instance.orderDraft.paymentType = option.$2;
                    }
                    setState(() => _selectedOption = option.$2);
                  },
                ),
              ),
            const SizedBox(height: 20),
            AnimatedSize(
              duration: const Duration(milliseconds: 400),
              alignment: Alignment.center,
              curve: Curves.ease,
              child: _selectedOption?.delivered == true
                  ? Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GsaWidgetHeadline(widget.inputFieldsTitle),
                          GsaWidgetText(
                            widget.inputFieldsNotice,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: GsaWidgetText(
                              'Contact',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          GsaWidgetText(
                            'Your name, email, and contact number entered during checkout will be shared '
                            'with the vendor and courier for order processing purposes',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 20),
                          GsaWidgetTextField(
                            labelText: 'First Name',
                            controller: _firstNameTextController,
                            validator: GsaServiceInputValidation.instance.firstName,
                          ),
                          const SizedBox(height: 16),
                          GsaWidgetTextField(
                            labelText: 'Last Name',
                            controller: _lastNameTextController,
                            validator: GsaServiceInputValidation.instance.lastName,
                          ),
                          const SizedBox(height: 16),
                          GsaWidgetTextField(
                            labelText: 'Email',
                            controller: _emailTextController,
                            validator: GsaServiceInputValidation.instance.lastName,
                          ),
                          const SizedBox(height: 16),
                          GsaWidgetPhoneNumberInput(
                            prefix: () => _phonePrefixTextController.text,
                            setPrefix: (value) => _phonePrefixTextController.text = value,
                            phoneNumberController: _phoneNumberTextController,
                          ),
                          const SizedBox(height: 20),
                          GsaWidgetText(
                            'Address',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          GsaWidgetText(
                            'Your delivery data is essential for completing the checkout process and will be shared '
                            'with the vendor and the courier for the purposes of order fulfillment.',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: GsaWidgetTextField(
                                  labelText: 'Street Name',
                                  controller: _streetNameTextController,
                                  validator: GsaServiceInputValidation.instance.street,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: GsaWidgetTextField(
                                  labelText: 'Number',
                                  controller: _houseNumberTextController,
                                  validator: GsaServiceInputValidation.instance.houseNumber,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          GsaWidgetTextField(
                            labelText: 'Postcode',
                            controller: _postcodeTextController,
                            validator: GsaServiceInputValidation.instance.postCode,
                          ),
                          const SizedBox(height: 16),
                          GsaWidgetTextField(
                            labelText: 'City',
                            controller: _cityTextController,
                            validator: GsaServiceInputValidation.instance.city,
                          ),
                          const SizedBox(height: 16),
                          GsaWidgetTextField(
                            labelText: 'State',
                            controller: _stateTextController,
                            validator: GsaServiceInputValidation.instance.state,
                          ),
                          const SizedBox(height: 16),
                          GsaWidgetTextField(
                            labelText: 'Country',
                            controller: _countryTextController,
                            validator: GsaServiceInputValidation.instance.country,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ),
            const GsaWidgetTotalCartPrice(),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 60),
          ],
        ),
        Positioned(
          right: 12,
          bottom: MediaQuery.of(context).padding.bottom + 12,
          child: FloatingActionButton.extended(
            heroTag: null,
            icon: const Icon(Icons.arrow_forward),
            label: GsaWidgetText(
              'NEXT',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              FocusScope.of(context).unfocus();
              if (_selectedOption?.delivered == true && _formKey.currentState?.validate() != true) {
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent + 20,
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.fastOutSlowIn,
                );
              } else {
                switch (widget.type) {
                  case _WidgetCheckoutOptionType.delivery:
                    GsaDataCheckout.instance.orderDraft.deliveryType = _selectedOption;
                    GsaDataCheckout.instance.orderDraft.deliveryAddress ??= GsaModelAddress(
                      personalDetails: GsaModelPerson(),
                      contactDetails: GsaModelContact(),
                    );
                    GsaDataCheckout.instance.orderDraft.deliveryAddress!.personalDetails!.firstName = _firstNameTextController.text.trim();
                    GsaDataCheckout.instance.orderDraft.deliveryAddress!.personalDetails!.lastName = _lastNameTextController.text.trim();
                    GsaDataCheckout.instance.orderDraft.deliveryAddress!.contactDetails!.phoneCountryCode =
                        _phonePrefixTextController.text.trim();
                    GsaDataCheckout.instance.orderDraft.deliveryAddress!.contactDetails!.phoneNumber =
                        _phoneNumberTextController.text.trim();
                    GsaDataCheckout.instance.orderDraft.deliveryAddress!.contactDetails!.email = _emailTextController.text.trim();
                    GsaDataCheckout.instance.orderDraft.deliveryAddress!.streetName = _streetNameTextController.text.trim();
                    GsaDataCheckout.instance.orderDraft.deliveryAddress!.houseNumber = _houseNumberTextController.text.trim();
                    GsaDataCheckout.instance.orderDraft.deliveryAddress!.zipCode = _postcodeTextController.text.trim();
                    GsaDataCheckout.instance.orderDraft.deliveryAddress!.city = _cityTextController.text.trim();
                    GsaDataCheckout.instance.orderDraft.deliveryAddress!.state = _stateTextController.text.trim();
                    GsaDataCheckout.instance.orderDraft.deliveryAddress!.country = _countryTextController.text.trim();
                    break;
                  case _WidgetCheckoutOptionType.payment:
                    GsaDataCheckout.instance.orderDraft.paymentType = _selectedOption;
                    GsaDataCheckout.instance.orderDraft.invoiceAddress ??= GsaModelAddress(
                      personalDetails: GsaModelPerson(),
                      contactDetails: GsaModelContact(),
                    );
                    GsaDataCheckout.instance.orderDraft.invoiceAddress!.personalDetails!.firstName = _firstNameTextController.text.trim();
                    GsaDataCheckout.instance.orderDraft.invoiceAddress!.personalDetails!.lastName = _lastNameTextController.text.trim();
                    GsaDataCheckout.instance.orderDraft.invoiceAddress!.contactDetails!.phoneCountryCode =
                        _phonePrefixTextController.text.trim();
                    GsaDataCheckout.instance.orderDraft.invoiceAddress!.contactDetails!.phoneNumber =
                        _phoneNumberTextController.text.trim();
                    GsaDataCheckout.instance.orderDraft.invoiceAddress!.contactDetails!.email = _emailTextController.text.trim();
                    GsaDataCheckout.instance.orderDraft.invoiceAddress!.streetName = _streetNameTextController.text.trim();
                    GsaDataCheckout.instance.orderDraft.invoiceAddress!.houseNumber = _houseNumberTextController.text.trim();
                    GsaDataCheckout.instance.orderDraft.invoiceAddress!.zipCode = _postcodeTextController.text.trim();
                    GsaDataCheckout.instance.orderDraft.invoiceAddress!.city = _cityTextController.text.trim();
                    GsaDataCheckout.instance.orderDraft.invoiceAddress!.state = _stateTextController.text.trim();
                    GsaDataCheckout.instance.orderDraft.invoiceAddress!.country = _countryTextController.text.trim();
                    break;
                }
                widget.onCartSettingsUpdate();
                widget.goToNextStep();
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _firstNameTextController.dispose();
    _lastNameTextController.dispose();
    _phonePrefixTextController.dispose();
    _phoneNumberTextController.dispose();
    _emailTextController.dispose();
    _streetNameTextController.dispose();
    _houseNumberTextController.dispose();
    _postcodeTextController.dispose();
    _cityTextController.dispose();
    _stateTextController.dispose();
    _countryTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
