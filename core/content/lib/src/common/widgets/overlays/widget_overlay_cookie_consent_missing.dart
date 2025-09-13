import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/arch.dart';

class GsaWidgetOverlayCookieConsentMissing extends GsaWidgetOverlay {
  const GsaWidgetOverlayCookieConsentMissing({
    super.key,
    required this.message,
    this.functional = false,
    this.marketing = false,
    this.statistical = false,
  });

  final String message;

  final bool functional, marketing, statistical;

  @override
  State<GsaWidgetOverlayCookieConsentMissing> createState() {
    return _GsaWidgetOverlayCookieConsentMissingState();
  }
}

class _GsaWidgetOverlayCookieConsentMissingState extends State<GsaWidgetOverlayCookieConsentMissing> {
  late Iterable<
      ({
        String label,
        bool value,
      })> _consentStatuses, _missingConsentStatuses;

  @override
  void initState() {
    super.initState();
    _consentStatuses = [
      (
        label: 'Functional',
        value: widget.functional,
      ),
      (
        label: 'Marketing',
        value: widget.marketing,
      ),
      (
        label: 'Statistical',
        value: widget.statistical,
      ),
    ];
    _missingConsentStatuses = _consentStatuses.where((status) {
      return status.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: GsaTheme.of(context).paddings.content.mediumLarge,
        ),
        Semantics(
          label: 'Cookie Illustration.',
          image: true,
          child: Center(
            child: Icon(
              Icons.cookie,
              size: 72,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        SizedBox(
          height: GsaTheme.of(context).paddings.content.mediumLarge,
        ),
        GsaWidgetText(
          (_missingConsentStatuses.length == 1 ? '${_missingConsentStatuses.first.label} ' : '') + 'Cookies Disabled',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: GsaTheme.of(context).paddings.content.mediumLarge,
        ),
        GsaWidgetText(
          widget.message,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: GsaTheme.of(context).paddings.content.medium,
        ),
        GsaWidgetButton.outlined(
          label: 'Open Cookie Settings',
          onTap: () {
            Navigator.pop(context);
            const GsaWidgetOverlayCookieConsent().openDialog();
          },
        ),
      ],
    );
  }
}
