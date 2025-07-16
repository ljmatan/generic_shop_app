import 'dart:async';

import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_api/api.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_data/data.dart';
import 'package:generic_shop_app_services/services.dart';

part 'widgets/widget_banner.dart';
part 'widgets/widget_bookmarks.dart';
part 'widgets/widget_categories.dart';
part 'widgets/widget_client_preview.dart';
part 'widgets/widget_customer_notice.dart';
part 'widgets/widget_drawer.dart';
part 'widgets/widget_header.dart';
part 'widgets/widget_profile.dart';
part 'widgets/widget_promo_carousel.dart';
part 'widgets/widget_search_results.dart';
part 'widgets/widget_search_suggestions.dart';

/// Shop route, displaying product info, alongisde of the search services.
///
class GsaRouteShop extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteShop({super.key});

  @override
  State<GsaRouteShop> createState() => _GsaRouteShopState();
}

class _GsaRouteShopState extends GsaRouteState<GsaRouteShop> {
  final _filters = GsaModelShopSearch(
    id: null,
    originId: null,
    searchTerm: '',
    categoryId: null,
    sortCategoryId: null,
  );

  Future<List<GsaModelSaleItem>>? _searchFuture;

  Future<void> _updateSearchTermHistory(
    String searchTerm,
  ) async {
    final previousTerms = GsaServiceCacheEntry.shopSearchHistory.value;
    await GsaServiceCacheEntry.shopSearchHistory.setValue(
      <String>{
        if (previousTerms is Iterable) ...previousTerms,
        searchTerm,
      }.toList().reversed.take(5).toList(),
    );
  }

  void _onFiltersUpdated() {
    _searchFuture = Future(
      () async {
        final categoryResults = _filters.categoryId == null
            ? null
            : GsaDataSaleItems.instance.collection.where(
                (product) {
                  return product.categoryId == _filters.categoryId;
                },
              ).toList();
        final searchTermResults = _filters.searchTerm?.trim().isNotEmpty == true
            ? await GsaServiceSearch.instance.findByCharacters(
                searchTerm: _filters.searchTerm!,
                comparisonValues: categoryResults ?? GsaDataSaleItems.instance.collection,
                comparator: (value) {
                  final saleItem = value as GsaModelSaleItem;
                  return [
                    if (saleItem.name?.isNotEmpty == true) saleItem.name!,
                    if (saleItem.productCode?.isNotEmpty == true) saleItem.productCode!,
                    if (saleItem.id?.isNotEmpty == true) saleItem.id!,
                  ];
                },
              )
            : null;
        if (_filters.searchTerm?.isNotEmpty == true) {
          try {
            await _updateSearchTermHistory(_filters.searchTerm!);
          } catch (e) {
            GsaServiceLogging.instance.logError('Couldn\'t update search term history:\n$e');
          }
        }
        return List<GsaModelSaleItem>.from(searchTermResults ?? categoryResults ?? []);
      },
    );
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
      _searchFutureUpdateTimer = Timer(
        const Duration(milliseconds: 600),
        () {
          return _onFiltersUpdated();
        },
      );
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
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
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
      if (presentingRoute != this) _clearSearchFilters();
    });
  }

  bool get _searchActive {
    return _searchTermFocusNode.hasFocus || _filters.active == true;
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          _WidgetHeader(
            searchTermController: _searchTermController,
            searchTermFocusNode: _searchTermFocusNode,
            clearSearchFilters: () => _clearSearchFilters(),
          ),
          Expanded(
            child: _searchActive
                ? FutureBuilder<List<GsaModelSaleItem>>(
                    future: _searchFuture,
                    builder: (context, searchResponse) {
                      if (!_filters.active) {
                        return _WidgetSearchSuggestions(
                          updateSearchTerm: (value) {
                            _searchTermController.text = value;
                          },
                        );
                      } else {
                        if (_searchFuture == null || searchResponse.connectionState != ConnectionState.done) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (searchResponse.hasError || searchResponse.data?.isNotEmpty != true) {
                          return GsaWidgetError(
                            searchResponse.hasError ? searchResponse.error.toString() : 'No results found.',
                          );
                        }
                        return _WidgetSearchResults(searchResponse.data!);
                      }
                    },
                  )
                : Column(
                    children: [
                      if (GsaConfig.authenticationEnabled && !GsaDataUser.instance.authenticated) const _WidgetBanner(),
                      Expanded(
                        child: ListView(
                          controller: _scrollController,
                          padding: EdgeInsets.symmetric(
                            vertical: Theme.of(context).listViewPadding.vertical / 2,
                          ),
                          children: [
                            if (<GsaClient>{
                                  GsaClient.froddoB2b,
                                }.contains(GsaConfig.plugin.client) &&
                                GsaDataCheckout.instance.orderDraft.client != null) ...[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Theme.of(context).listViewPadding.horizontal / 2,
                                ),
                                child: _WidgetClientPreview(),
                              ),
                              const SizedBox(height: 16),
                            ],
                            if (GsaDataUser.instance.authenticated &&
                                !<GsaClient>{
                                  GsaClient.froddoB2b,
                                }.contains(
                                  GsaConfig.plugin.client,
                                )) ...[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Theme.of(context).listViewPadding.horizontal / 2,
                                ),
                                child: const _WidgetProfile(),
                              ),
                              const SizedBox(height: 16),
                            ],
                            if (GsaConfig.bookmarksEnabled) ...[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Theme.of(context).listViewPadding.horizontal / 2,
                                ),
                                child: const _WidgetBookmarks(),
                              ),
                              const SizedBox(height: 16),
                            ],
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Theme.of(context).listViewPadding.horizontal / 2,
                              ),
                              child: const _WidgetPromoCarousel(),
                            ),
                            GsaWidgetSaleItemCarousel(
                              GsaDataSaleItems.instance.collection,
                              label: 'Featured',
                              horizontalPadding: Theme.of(context).listViewPadding.horizontal / 2,
                            ),
                            const SizedBox(height: 16),
                            if (GsaDataSaleItems.instance.categories.isNotEmpty) ...[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Theme.of(context).listViewPadding.horizontal / 2,
                                ),
                                child: _WidgetCategories(
                                  GsaDataSaleItems.instance.categories,
                                  setCategory: (category) {
                                    _filters.categoryId = category.id;
                                    _onFiltersUpdated();
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Theme.of(context).listViewPadding.horizontal / 2,
                              ),
                              child: const _WidgetCustomerNotice(),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).padding.bottom + 100,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
      floatingActionButton: _searchActive
          ? null
          : Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                GsaWidgetButton.filled(
                  icon: Icons.chat,
                  onTap: () {
                    const GsaRouteMerchantContact().push();
                  },
                ),
                if (Theme.of(context).dimensions.smallScreen && Navigator.of(context).canPop()) ...[
                  const SizedBox(height: 10),
                  GsaWidgetButton.filled(
                    icon: Icons.apps,
                    onTap: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                ],
              ],
            ),
      drawerEnableOpenDragGesture: false,
      endDrawerEnableOpenDragGesture: false,
      drawer: const _WidgetDrawer(),
      endDrawer: const _WidgetDrawer(),
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
