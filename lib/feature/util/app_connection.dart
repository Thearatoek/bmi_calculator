import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

BuildContext? appContext;

class AppNetworkHandler {
  static const String logName = 'App Network Handler';

  static dynamic listen;

  /// for check device connection
  static Future<ConnectivityResult> checkConnection() async {
    final connection = await (Connectivity().checkConnectivity());

    logInfo('Connection Status $connection', name: logName);

    if (connection == ConnectivityResult.none) {
      appContext?.read<AppNetworkBloc>().add(NetworkEventDisconnected());
    }
    return connection;
  }

  /// use for listen the connection [use only one time in main]
  static void listener() {
    listen = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      logInfo('Connection Listen Status $result', name: logName);

      switch (result) {
        case ConnectivityResult.none:
          appContext?.read<AppNetworkBloc>().add(NetworkEventDisconnected());
          break;

        case ConnectivityResult.wifi:
          appContext?.read<AppNetworkBloc>().add(NetworkEventConnected());
          break;

        case ConnectivityResult.mobile:
          appContext?.read<AppNetworkBloc>().add(NetworkEventConnected());
          break;

        default:
          break;
      }
    });
  }

  /// use for cancel the connection listener
  static void cancel() async {
    await Future.delayed(const Duration(seconds: 30));
    await listen?.cancel();
  }

  /// use for waiting animation after user connected to the internet
  // void startAnimatedConnected(bool value) async {
  //   logInfo('Connected Animated Status $value', name: 'Connection Handler');

  //   if (!value) {
  //     connectedStatus = true;

  //     await Future.delayed(const Duration(seconds: 2));

  //     connectedStatus = false;
  //     notifyListeners();
  //   }
  // }
}

class AppNetworkBloc extends Bloc<NetworkEvent, NetworkState?> {
  AppNetworkBloc() : super(NetworkStateInit()) {
    try {
      on<NetworkEventDisconnected>((event, emit) {
        status = ConnectivityResult.none;
        emit(NetworkStateNoInternet());
      });

      on<NetworkEventConnected>(_onConnected);
    } catch (error) {
      // do sth
    }
  }

  ConnectivityResult status = ConnectivityResult.wifi;

  Future _onConnected(event, emit) async {
    try {
      if (status == ConnectivityResult.none) {
        emit(NetworkStateConnected());

        await Future.delayed(const Duration(seconds: 1));

        status = ConnectivityResult.none;
      }

      emit(NetworkStateInit());
    } catch (error) {
      // _baseErrorHandler<>(error);
    }
  }
}

/// Event
abstract class NetworkEvent {}

class NetworkEventDisconnected extends NetworkEvent {}

class NetworkEventConnected extends NetworkEvent {}

/// State
abstract class NetworkState {}

class NetworkStateNoInternet extends NetworkState {}

class NetworkStateInit extends NetworkState {}

class NetworkStateConnected extends NetworkState {}

void logInfo(String message, {String name = 'Log Info', bool force = false}) {
  if (!force) {
    developer.log(message, name: name);
  } else {
    // ignore: avoid_print
    print('[ $name ] $message');
  }
}
