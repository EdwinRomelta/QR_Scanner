import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/ui/screen/qr_scanner/qr_scanner.dart';

enum _CameraState { initial, deny, allow }

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({Key? key}) : super(key: key);

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CameraState _cameraState = CameraState(_CameraState.initial);
  late CameraDescription _cameraDescription;
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
    _openCamera();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: _firebaseAuth.signOut,
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        body: ChangeNotifierProvider<CameraState>.value(
          value: _cameraState,
          child: Consumer<CameraState>(
            builder: (context, cameraState, _) {
              switch (cameraState._cameraState) {
                case _CameraState.initial:
                  return const SizedBox.shrink();
                case _CameraState.allow:
                  return QrScanner(
                    cameraDescription: _cameraDescription,
                    controller: _controller,
                  );
                case _CameraState.deny:
                default:
                  return _DenyContainer(isGranted: _openCamera);
              }
            },
          ),
        ),
      );

  Future<void> _openCamera() async {
    try {
      final cameras = await availableCameras();
      _cameraDescription = cameras[0];
      _controller = CameraController(_cameraDescription, ResolutionPreset.max);
      await _controller.initialize();
      if (!mounted) {
        return;
      }
      _cameraState.allow();
    } catch (e) {
      _cameraState.deny();
    }
  }
}

class _DenyContainer extends StatelessWidget {
  final VoidCallback isGranted;

  const _DenyContainer({required this.isGranted, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Please allow camera permission to use the app',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            TextButton(
              onPressed: () async {
                final statusList =
                    await [Permission.camera, Permission.microphone].request();
                if (statusList.values.every((status) => status.isGranted)) {
                  isGranted.call();
                }
              },
              child: const Text('Request'),
            )
          ],
        ),
      );
}

class CameraState with ChangeNotifier {
  _CameraState _cameraState;

  CameraState(this._cameraState);

  void allow() {
    _cameraState = _CameraState.allow;
    notifyListeners();
  }

  void reset() {
    _cameraState = _CameraState.initial;
    notifyListeners();
  }

  void deny() {
    _cameraState = _CameraState.deny;
    notifyListeners();
  }
}
