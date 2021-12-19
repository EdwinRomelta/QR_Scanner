import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/ui/model/sku.dart';
import 'package:qr_scanner/ui/screen/detail/sku_detail_screen.dart';
import 'package:qr_scanner/ui/screen/qr_scanner/qr_scanner_screen.dart';
import 'package:qr_scanner/ui/widget/loading_dialog.dart';

class QrScanner extends StatefulWidget {
  final CameraDescription cameraDescription;
  final CameraController controller;

  const QrScanner({
    required this.cameraDescription,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  final _skus = FirebaseFirestore.instance.collection('sku');
  final BarcodeScanner _barcodeScanner = GoogleMlKit.vision.barcodeScanner();
  bool isProcess = false;

  @override
  void initState() {
    super.initState();
    widget.controller.startImageStream(_processCameraImage);
  }

  @override
  Widget build(BuildContext context) => Stack(
        fit: StackFit.expand,
        children: [
          CameraPreview(widget.controller),
        ],
      );

  @override
  void dispose() {
    _barcodeScanner.close();
    super.dispose();
  }

  Future _processCameraImage(CameraImage image) async {
    if (isProcess) return;
    isProcess = true;
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final imageRotation = InputImageRotationMethods.fromRawValue(
            widget.cameraDescription.sensorOrientation) ??
        InputImageRotation.Rotation_0deg;

    final inputImageFormat =
        InputImageFormatMethods.fromRawValue(image.format.raw) ??
            InputImageFormat.NV21;

    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
    final barcodes = await _barcodeScanner.processImage(inputImage);
    await _fetchBarcode(barcodes);
    isProcess = false;
  }

  Future<void> _fetchBarcode(List<Barcode> barcodeList) async {
    if (barcodeList.isEmpty) return;
    LoadingDialog.show(context);
    final List<Sku> skuList =
        await Future.wait(barcodeList.toSet().map((barcode) async {
      try {
        final snapshot = await _skus.doc(barcode.value.rawValue).get();
        final data = snapshot.data();
        if (data != null) {
          return Sku.fromJson(data);
        }
        return null;
      } catch (e) {
        return null;
      }
    })).then((skuList) => skuList.whereNotNull().toList());
    LoadingDialog.hide(context);
    if (skuList.isNotEmpty) {
      widget.controller.stopImageStream();
      final cameraState = context.read<CameraState>();
      cameraState.reset();
      await SkuDetailScreen.push(context, skuList);
      cameraState.allow();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Invalid Format')));
    }
  }
}
