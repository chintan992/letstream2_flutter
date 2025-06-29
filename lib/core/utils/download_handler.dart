import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
/// A utility class for handling downloads
class DownloadHandler {
  /// Opens a URL in an external browser with fallback options
  static Future<void> openDownloadUrl(BuildContext context, String url) async {
    try {
      final Uri uri = Uri.parse(url);
      
      // Try to launch with external application mode first
      if (await canLaunchUrl(uri)) {
        final bool launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
        
        if (!launched) {
          // If external launch fails, try with in-app browser
          await _showFallbackOptions(context, uri);
        }
      } else {
        // Show options if we can't launch directly
        await _showFallbackOptions(context, Uri.parse(url));
      }
    } catch (e) {
      // Handle any exceptions during URL parsing or launching
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error opening download: $e'),
          backgroundColor: Colors.red,
          action: SnackBarAction(
            label: 'Copy URL',
            onPressed: () {
              // Copy URL to clipboard
              _copyToClipboard(context, url);
            },
          ),
        ),
      );
    }
  }
  
  /// Shows a dialog with fallback options for handling the URL
  static Future<void> _showFallbackOptions(BuildContext context, Uri uri) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Download Options'),
          content: const Text(
            'The download link couldn\'t be opened automatically. What would you like to do?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _copyToClipboard(context, uri.toString());
              },
              child: const Text('Copy URL'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Try to open in the platform's default browser
                launchUrl(uri, mode: LaunchMode.platformDefault);
              },
              child: const Text('Try Different Browser'),
            ),
          ],
        );
      },
    );
  }
  
  /// Helper to copy text to clipboard and show confirmation
  static void _copyToClipboard(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('URL copied to clipboard'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
