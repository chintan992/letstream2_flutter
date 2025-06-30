import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/services/auth_service.dart';
import '../../auth/application/auth_provider.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_menu_item.dart';
import 'widgets/profile_section.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _authService = AuthService();
  bool _isLoading = false;

  Future<void> _handleSignOut() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _authService.signOut();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Signed out successfully'),
            backgroundColor: Colors.green,
          ),
        );
        context.go('/login');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error signing out: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _navigateToLogin() {
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final userAsyncValue = ref.watch(authUserProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
      ),
      body: userAsyncValue.when(
        data: (user) {
          if (user == null) {
            // User is not logged in, show login/signup prompt
            return _buildNotLoggedInView();
          } else {
            // User is logged in, show profile
            return _buildLoggedInProfile(user);
          }
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            'Error loading profile: ${error.toString()}',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }

  Widget _buildNotLoggedInView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.account_circle,
              size: 100,
              color: Colors.grey,
            ),
            const SizedBox(height: 24),
            const Text(
              'Sign in to access your profile',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Create an account or sign in to track your watchlist, favorites, and settings',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _navigateToLogin,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Sign In / Create Account'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoggedInProfile(user) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileHeader(
            email: user.email ?? 'No email',
            displayName: user.displayName ?? user.email?.split('@').first ?? 'User',
            photoUrl: user.photoURL,
          ),
          const SizedBox(height: 16),
          ProfileSection(
            title: 'Account',
            children: [
              ProfileMenuItem(
                icon: Icons.favorite,
                title: 'My Favorites',
                onTap: () {
                  // Navigate to favorites
                  context.push('/favorites');
                },
              ),
              ProfileMenuItem(
                icon: Icons.playlist_play,
                title: 'Watchlist',
                onTap: () {
                  // Navigate to watchlist
                  context.push('/watchlist');
                },
              ),
              ProfileMenuItem(
                icon: Icons.history,
                title: 'Watch History',
                onTap: () {
                  // Navigate to watch history
                  context.push('/history');
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          ProfileSection(
            title: 'Preferences',
            children: [
              ProfileMenuItem(
                icon: Icons.settings,
                title: 'App Settings',
                onTap: () {
                  // Navigate to settings
                  context.push('/settings');
                },
              ),
              ProfileMenuItem(
                icon: Icons.notifications,
                title: 'Notifications',
                onTap: () {
                  // Navigate to notifications settings
                  context.push('/notifications');
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          ProfileSection(
            title: 'Support',
            children: [
              ProfileMenuItem(
                icon: Icons.help,
                title: 'Help & FAQ',
                onTap: () {
                  // Navigate to help
                  context.push('/help');
                },
              ),
              ProfileMenuItem(
                icon: Icons.info,
                title: 'About',
                onTap: () {
                  // Navigate to about
                  context.push('/about');
                },
              ),
            ],
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleSignOut,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.red,
              ),
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Sign Out'),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
