import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_shop_app/config.dart';
import 'package:generic_shop_app/data/data.dart';
import 'package:generic_shop_app/services/src/i18n/service_i18n.dart';
import 'package:generic_shop_app/view/src/common/widgets/actions/widget_dropdown.dart';
import 'package:generic_shop_app/view/src/common/widgets/actions/widget_text_field.dart';
import 'package:generic_shop_app/view/src/common/widgets/overlays/widget_overlay_consent.dart';
import 'package:generic_shop_app/view/src/common/widgets/overlays/widget_overlay_sale_item.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_error.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_headline.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_image.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_merchant_preview.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_sale_item_carousel.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_text.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

part 'widgets/widget_banner.dart';
part 'widgets/widget_header.dart';
part 'widgets/widget_categories.dart';
part 'widgets/widget_customer_notice.dart';
part 'widgets/widget_drawer.dart';
part 'widgets/widget_promo_carousel.dart';
part 'widgets/widget_search_results.dart';
part 'widgets/widget_search_suggestions.dart';

/// Shop route, displaying product info, alongisde of the search services.
///
class GsaRouteShop extends GsarRoute {
  // ignore: public_member_api_docs
  const GsaRouteShop({super.key});

  @override
  State<GsaRouteShop> createState() => _GsaRouteShopState();

  @override
  String get routeId => 'shop';

  @override
  String get displayName => 'Shop';
}

class _GsaRouteShopState extends GsarRouteState<GsaRouteShop> {
  final _filters = GsaaModelShopSearch(
    id: null,
    originId: null,
    searchTerm: '',
    categoryId: null,
    sortCategoryId: null,
  );

  Future<List<GsaaModelSaleItem>>? _searchFuture;

  void _onFiltersUpdated() {
    _searchFuture = Future(() async {
      final categoryResults = _filters.categoryId == null
          ? null
          : GsaDataSaleItems.instance.products.where((product) => product.categoryId == _filters.categoryId).toList();
      final searchTermResults = _filters.searchTerm?.trim().isNotEmpty == true
          ? await GsaaServiceSearch.instance.findByCharacters(
              searchTerm: _filters.searchTerm!,
              comparisonValues: categoryResults ?? GsaDataSaleItems.instance.products,
              comparator: (value) => (value as GsaaModelSaleItem).name ?? '',
            )
          : null;
      return List<GsaaModelSaleItem>.from(searchTermResults ?? categoryResults ?? []);
    });
    setState(() {});
  }

  Timer? _searchFutureUpdateTimer;

  final _searchTermFocusNode = FocusNode();

  final _searchTermController = TextEditingController();

  final _searchTermNotifier = ValueNotifier<String>('');

  void _onSearchStatusUpdate() {
    setState(() {});
  }

  void _onSearchTermControllerUpdate() {
    // Process and filter user input.
    final currentSearchTerm = _searchTermController.text.trim().replaceAll('  ', ' ').toLowerCase();
    // Check if any changes have been made after processing the input value.
    if (currentSearchTerm != _searchTermNotifier.value) {
      _searchTermNotifier.value = currentSearchTerm;
      _filters.searchTerm = currentSearchTerm;
    }
  }

  void _onSearchTermNotifierUpdate() {
    setState(() {});
    // Check if min. 3 characters are present in search term.
    if (_searchTermNotifier.value.length >= 3) {
      // Cancel any currently active timer.
      _searchFutureUpdateTimer?.cancel();
      // Clear current state.
      setState(() => _searchFuture = null);
      // Set timer to run in 600ms.
      _searchFutureUpdateTimer = Timer(const Duration(milliseconds: 600), () => _onFiltersUpdated());
    }
  }

  final _scrollController = ScrollController();

  void _clearSearchFilters() {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).unfocus();
    _filters.clear();
    _searchTermController.clear();
    setState(() {});
    if (_scrollController.hasClients) {
      _scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.ease);
    }
  }

  @override
  void initState() {
    super.initState();
    _searchTermFocusNode.addListener(_onSearchStatusUpdate);
    _searchTermController.addListener(_onSearchTermControllerUpdate);
    _searchTermNotifier.addListener(_onSearchTermNotifierUpdate);
  }

  @override
  void didPushNext() {
    super.didPushNext();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (presentingRoute != runtimeType) _clearSearchFilters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _WidgetHeader(
            searchTermController: _searchTermController,
            searchTermFocusNode: _searchTermFocusNode,
            clearSearchFilters: () => _clearSearchFilters(),
          ),
          Expanded(
            child: _searchTermFocusNode.hasFocus || _filters.active == true
                ? FutureBuilder<List<GsaaModelSaleItem>>(
                    future: _searchFuture,
                    builder: (context, searchResponse) {
                      if (!_filters.active) {
                        return const _WidgetSearchSuggestions();
                      } else {
                        if (_searchFuture == null || searchResponse.connectionState != ConnectionState.done) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (searchResponse.hasError || searchResponse.data?.isNotEmpty != true) {
                          return GsaWidgetError(
                            searchResponse.hasError ? searchResponse.error.toString() : 'No results found.'.translated(context),
                          );
                        }
                        return _WidgetSearchResults(searchResponse.data!);
                      }
                    },
                  )
                : Column(
                    children: [
                      if (!GsaDataUser.instance.authenticated) const _WidgetBanner(),
                      Expanded(
                        child: Stack(
                          children: [
                            ListView(
                              controller: _scrollController,
                              padding: const EdgeInsets.symmetric(vertical: 26),
                              children: [
                                const _WidgetPromoCarousel(),
                                if (1 == 2 && GsaDataMerchant.instance.merchant != null)
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                    child: GsaWidgetMerchantPreview(GsaDataMerchant.instance.merchant!),
                                  )
                                else
                                  const SizedBox(),
                                GsaWidgetSaleItemCarousel(GsaDataSaleItems.instance.products, label: 'Featured', horizontalPadding: 20),
                                if (GsaDataSaleItems.instance.categories.isNotEmpty)
                                  _WidgetCategories(
                                    GsaDataSaleItems.instance.categories,
                                    setCategory: (category) {
                                      _filters.categoryId = category.id;
                                      _onFiltersUpdated();
                                    },
                                  ),
                                const _WidgetCustomerNotice(),
                                SizedBox(height: MediaQuery.of(context).padding.bottom + 60),
                              ],
                            ),
                            Positioned(
                              right: 12,
                              bottom: MediaQuery.of(context).padding.bottom + 12,
                              child: FloatingActionButton(
                                heroTag: null,
                                child: const Icon(Icons.chat, color: Colors.white),
                                onPressed: () {
                                  Navigator.of(context).pushNamed('contact');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
      drawer: MediaQuery.of(context).size.width < 1000 ? const _WidgetDrawer() : null,
    );
  }

  @override
  void dispose() {
    _searchTermFocusNode.removeListener(_onSearchStatusUpdate);
    _searchTermController.removeListener(_onSearchTermControllerUpdate);
    _searchTermNotifier.removeListener(_onSearchTermNotifierUpdate);
    _searchTermFocusNode.dispose();
    _searchTermController.dispose();
    _searchTermNotifier.dispose();
    _searchFutureUpdateTimer?.cancel();
    super.dispose();
  }
}
