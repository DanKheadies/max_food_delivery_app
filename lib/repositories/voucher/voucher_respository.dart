import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:max_food_delivery_app/models/models.dart';
// import 'package:max_food_delivery_app/repositories/voucher/base_voucher_repository.dart';

class VoucherRepository extends Equatable {
  final FirebaseFirestore _firebaseFirestore;

  VoucherRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<Voucher>> getVouchers() {
    return _firebaseFirestore
        .collection('vouchers')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Voucher.fromSnapshot(doc)).toList();
    });
  }

  Future<bool> searchVoucher(String code) async {
    final voucher = await _firebaseFirestore
        .collection('vouchers')
        .where('code', isEqualTo: code)
        .get();

    return voucher.docs.isNotEmpty;
  }

  @override
  List<Object?> get props => [];
}
