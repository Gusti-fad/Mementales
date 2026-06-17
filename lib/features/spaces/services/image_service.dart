import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImageService {
  static Future<String?> uploadSpaceCover(
    File file,
  ) async {
    try {
      final supabase =
          Supabase.instance.client;

      final fileName =
          "${DateTime.now().millisecondsSinceEpoch}.jpg";

      print("UPLOAD START");
      print("FILE: ${file.path}");

      await supabase.storage
          .from("space-covers")
          .upload(
            fileName,
            file,
          );

      print("UPLOAD SUCCESS");

      final url = supabase.storage
          .from("space-covers")
          .getPublicUrl(
            fileName,
          );

      print("PUBLIC URL: $url");

      return url;
    } catch (e) {
      print(
        "SUPABASE UPLOAD ERROR: $e",
      );

      return null;
    }
  }
}