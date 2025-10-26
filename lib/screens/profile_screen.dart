import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/colors.dart';
import '../providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: authState.isAuthenticated
              ? _buildSignedInView(context, ref)
              : _buildGuestView(context),
        ),
      ),
    );
  }

  /// Guest view (not logged in)
  Widget _buildGuestView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sign up or log in to start booking your plans!',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Login/Sign up',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        _buildListTile(
          icon: Icons.system_update,
          title: 'App update available',
          onTap: () {},
        ),
        const SizedBox(height: 24),
        const Text(
          'Support',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        _buildListTile(
          icon: Icons.help_outline,
          title: 'Frequently asked questions',
          onTap: () {},
        ),
        const SizedBox(height: 24),
        const Text(
          'More',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        _buildListTile(
          icon: Icons.info_outline,
          title: 'About us',
          onTap: () {},
        ),
        const SizedBox(height: 40),
        Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/district_logo.png',
                width: 80,
                color: Colors.grey.shade700,
              ),
              const SizedBox(height: 8),
              const Text(
                'v2.20.0',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Signed-in view (placeholder)
  Widget _buildSignedInView(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hello, John Doe!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        _buildListTile(
          icon: Icons.person,
          title: 'My Profile',
          onTap: () {},
        ),
        const SizedBox(height: 12),
        _buildListTile(
          icon: Icons.history,
          title: 'My Bookings',
          onTap: () {},
        ),
        const SizedBox(height: 12),
        _buildListTile(
          icon: Icons.payment,
          title: 'Payment Methods',
          onTap: () {},
        ),
        const SizedBox(height: 12),
        _buildListTile(
          icon: Icons.logout,
          title: 'Logout',
          onTap: () {
            // Temporary placeholder logout
            ref.read(authProvider.notifier).logout();
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ],
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.grey.shade400,
                  size: 22,
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade600,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
