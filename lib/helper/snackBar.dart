import 'package:flutter/material.dart';

void ShowSnackBar(
    {required BuildContext context,
    required String message,
    required bool isSucces}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 6,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Row(
        children: [
          isSucces
              ? Icon(Icons.gpp_good, color: Colors.green, size: 26)
              : Icon(Icons.error, color: Colors.red, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      duration: Duration(seconds: 2),
    ),
  );
}
