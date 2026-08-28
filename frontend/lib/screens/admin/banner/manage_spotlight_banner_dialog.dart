import 'package:flutter/material.dart';
import 'active_banners_screen.dart';

class ManageSpotlightBannerDialog extends StatefulWidget {
  const ManageSpotlightBannerDialog({super.key});

  @override
  State<ManageSpotlightBannerDialog> createState() =>
      _ManageSpotlightBannerDialogState();
}

class _ManageSpotlightBannerDialogState
    extends State<ManageSpotlightBannerDialog> {
  final TextEditingController _buttonTextController =
      TextEditingController(text: "Register Now!");

  final TextEditingController _buttonLinkController =
      TextEditingController(
    text: "http://koode.dev/fest-register",
  );

  @override
  void dispose() {
    _buttonTextController.dispose();
    _buttonLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 600,
          maxHeight: 700,
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFD4E7ED),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF004D61),
              width: 1.5,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // ---------------------------------------------------------
                // TITLE
                // ---------------------------------------------------------
                const Text(
                  "Add Spotlight Banner",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003344),
                  ),
                ),

                const SizedBox(height: 16),

                // ---------------------------------------------------------
                // UPLOAD BANNER
                // ---------------------------------------------------------
                const Text(
                  "Upload Banner Image (Required)",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 6),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 36,
                        color: Colors.black87,
                      ),

                      SizedBox(height: 6),

                      Text(
                        "Tap to upload or drag & drop",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(
                        "Recommended dimensions: 1000 x 400 px.\n"
                        "Max size: 5MB. Format: JPG or PNG.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // ---------------------------------------------------------
                // BUTTON TEXT
                // ---------------------------------------------------------
                const Text(
                  "Button Text (e.g., Learn More, Register Now)",
                  style: TextStyle(fontSize: 12),
                ),

                const SizedBox(height: 4),

                TextField(
                  controller: _buttonTextController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    fillColor: Colors.white.withValues(alpha: 0.6),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // ---------------------------------------------------------
                // BUTTON LINK
                // ---------------------------------------------------------
                const Text(
                  "Button Link (URL)",
                  style: TextStyle(fontSize: 12),
                ),

                const SizedBox(height: 4),

                TextField(
                  controller: _buttonLinkController,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    fillColor: Colors.white.withValues(alpha: 0.6),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ---------------------------------------------------------
                // CANCEL + ADD BANNER
                // ---------------------------------------------------------
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(44),
                          foregroundColor: const Color(0xFF004D61),
                          side: const BorderSide(
                            color: Color(0xFF004D61),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF009688),
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(44),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // Backend save logic will be connected later.
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Add Banner",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // ---------------------------------------------------------
                // MANAGE EXISTING BANNERS
                // ---------------------------------------------------------
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ActiveBannersScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: Color(0xFF004D61),
                    ),
                    label: const Text(
                      "Manage Existing Banners",
                      style: TextStyle(
                        color: Color(0xFF004D61),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}