import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final ScrollController? scrollController;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onMenuPressed;

  const CustomAppBar({
    super.key,
    this.scrollController,
    this.onSearchPressed,
    this.onMenuPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> with SingleTickerProviderStateMixin {
  late AnimationController _menuController;
  double _scrollOffset = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    widget.scrollController?.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_onScroll);
    _menuController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!mounted) return;
    setState(() {
      _scrollOffset = widget.scrollController?.offset ?? 0;
    });
  }


  void _showMenu(BuildContext context) {
    _menuController.forward();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black87.withValues(alpha: 0.7),
      transitionAnimationController: _menuController,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              _buildMenuItem(Icons.home, 'Home', () {
                context.go('/');
                Navigator.pop(context);
              }),
              _buildMenuItem(Icons.movie, 'Movies', () {
                context.go('/movies');
                Navigator.pop(context);
              }),
              _buildMenuItem(Icons.tv, 'TV Shows', () {
                context.go('/tv');
                Navigator.pop(context);
              }),
              _buildMenuItem(Icons.favorite, 'Favorites', () {
                context.go('/favorites');
                Navigator.pop(context);
              }),
              _buildMenuItem(Icons.history, 'Watch History', () {
                context.go('/history');
                Navigator.pop(context);
              }),
              _buildMenuItem(Icons.account_circle, 'Profile', () {
                context.go('/profile');
                Navigator.pop(context);
              }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ).then((_) => _menuController.reverse());
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 26),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scrollProgress = (_scrollOffset / 100).clamp(0.0, 1.0);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withValues(alpha: 0.7 * scrollProgress),
            Colors.transparent,
          ],
        ),
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10 * scrollProgress,
            sigmaY: 10 * scrollProgress,
          ),
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 32,
                  errorBuilder: (context, error, stackTrace) => const Text(
                    'LS',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              // Search
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => context.push('/search'),
              ),
// Profile
              IconButton(
                icon: const Icon(Icons.account_circle),
                onPressed: () => context.push('/profile'),
              ),
              // Menu
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => _showMenu(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
