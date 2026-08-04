import 'package:flutter/material.dart'; // FIXED: Lowercase 'i'
// import 'active_banners_screen.dart'; // TEMPORARILY HIDDEN: Until you create this file!

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
      TextEditingController(text: "http://koode.dev/fest-register");

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
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFD4E7ED),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF004D61), width: 1.5),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Add Spotlight Banner",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF003344),
                ),
              ),
              const SizedBox(height: 16),

              // Upload Box
              const Text("Upload Banner Image (Required)",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade600),
                ),
                child: Column(
                  children: const [
                    Icon(Icons.camera_alt, size: 36, color: Colors.black87),
                    SizedBox(height: 6),
                    Text("Tap to upload or drag & drop",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13)),
                    SizedBox(height: 4),
                    Text(
                      "Recommended dimensions: 1000 x 400 px.\nMax size: 5MB. Format: JPG or PNG.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Button Text Input
              const Text("Button Text (e.g., Learn More, Register Now)",
                  style: TextStyle(fontSize: 12)),
              const SizedBox(height: 4),
              TextField(
                controller: _buttonTextController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  fillColor: Colors.white.withValues(alpha: 0.6),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 12),

              // Button Link Input
              const Text("Button Link (URL)", style: TextStyle(fontSize: 12)),
              const SizedBox(height: 4),
              TextField(
                controller: _buttonLinkController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  fillColor: Colors.white.withValues(alpha: 0.6),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 24),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF009688)),
                    onPressed: () {
                      // TODO: Save Banner logic
                      Navigator.pop(context);
                    },
                    child: const Text("Add Banner",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Manage Existing Banners Button
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: () {
                    // Temporarily just closes the dialog until the screen is built
                    Navigator.pop(context);
                    
                    /* UNCOMMENT THIS LATER ONCE THE SCREEN IS BUILT
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ActiveBannersScreen(),
                      ),
                    );
                    */
                  },
                  icon: const Icon(Icons.settings, color: Color(0xFF004D61)),
                  label: const Text(
                    "Manage Existing Banners",
                    style: TextStyle(color: Color(0xFF004D61)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}