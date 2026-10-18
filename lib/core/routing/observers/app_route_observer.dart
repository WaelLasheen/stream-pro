import 'package:flutter/material.dart';
import 'package:stream_pro/core/routing/observers/route_history_observer.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final routeHistoryObserver = RouteHistoryObserver();
