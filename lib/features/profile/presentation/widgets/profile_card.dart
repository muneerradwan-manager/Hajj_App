import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:hajj_app/core/constants/app_colors.dart';
import 'package:hajj_app/shared/widgets/custom_text.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  // Track which sections are expanded (using a map for scalability)
  final Map<String, bool> _expandedSections = {
    'basic': true,
    'rezident': false,
    'flight': false,
  };

  void _toggleSection(String key) {
    setState(() {
      _expandedSections[key] = !(_expandedSections[key] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: cs.primaryContainer),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withValues(alpha: 0.18),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _GradientStripe(cs: cs),

          // --- Header Profile Info ---
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: cs.primary,
                    border: Border.all(color: cs.brandGold, width: 3),
                  ),
                  child: Icon(LucideIcons.user, size: 48, color: cs.onPrimary),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        'home.pilgrim_name',
                        type: CustomTextType.bodyLarge,
                        color: CustomTextColor.green,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: cs.primary.withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: cs.primary.withValues(alpha: .3),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: const CustomText(
                          'home.pilgrim_id',
                          type: CustomTextType.bodyMedium,
                          color: CustomTextColor.lightGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // --- Divider ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Divider(color: cs.outline, thickness: 1, height: 30),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cs.primary,
                  ),
                ),
              ],
            ),
          ),

          // --- Expandable Sections ---
          _ProfileInfoSection(
            title: 'المعلومات الأساسية',
            icon: LucideIcons.user,
            isExpanded: _expandedSections['basic'] ?? false,
            onToggle: () => _toggleSection('basic'),
            iconColor: cs.primary,
            children: [
              _buildInfoRow(cs, 'الاسم الكامل', 'محمد أحمد الشامي'),
              const SizedBox(height: 10),
              _buildInfoRow(cs, 'اسم المجموعة', 'التوفيق'),
              const SizedBox(height: 10),
              _buildInfoRow(cs, 'اسم التكتل', 'ارتقاء'),
              const SizedBox(height: 10),
              _buildInfoRow(cs, 'اسم المكتب', 'دمشق'),
              const SizedBox(height: 10),
              _buildInfoRow(cs, 'رقم المكتب', '+963 11 234 5678'),
              const SizedBox(height: 10),
              _buildInfoRow(cs, 'اسم المطوف', 'عبدالرحمن بن خالد المطوف'),
              const SizedBox(height: 10),
              _buildInfoRow(cs, 'رقم الطوارئ', '+963 944 123 456'),
            ],
          ),

          _ProfileInfoSection(
            title: 'معلومات الإقامة',
            icon: LucideIcons.hotel,
            isExpanded: _expandedSections['rezident'] ?? false,
            onToggle: () => _toggleSection('rezident'),
            iconColor: cs.brandRed,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: cs.brandRed),
                  color: cs.brandRed.withValues(alpha: .1),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 10,
                  children: [
                    CustomText(
                      'مكة المكرمة',
                      color: CustomTextColor.red,
                      type: CustomTextType.bodyLarge,
                    ),
                    _buildInfoRow(
                      cs,
                      'اسم الفندق',
                      'فندق مكة هيلتون',
                      containerColor: Colors.white,
                      borderColor: cs.outline,
                    ),
                    _buildInfoRow(
                      cs,
                      'الموقع',
                      'شارع إبراهيم الخليل',
                      containerColor: Colors.white,
                      borderColor: cs.outline,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cs.brandRed,
                      ),
                      label: CustomText(
                        'فتح الموقع في خرائط جوجل',
                        color: CustomTextColor.white,
                      ),
                      icon: Icon(LucideIcons.arrowUpRight),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: cs.primary),
                  color: cs.primary.withValues(alpha: .1),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 10,
                  children: [
                    CustomText(
                      'المدينة المنورة',
                      color: CustomTextColor.red,
                      type: CustomTextType.bodyLarge,
                    ),
                    _buildInfoRow(
                      cs,
                      'اسم الفندق',
                      'فندق المدينة موفنبيك',
                      containerColor: Colors.white,
                      borderColor: cs.outline,
                    ),
                    _buildInfoRow(
                      cs,
                      'الموقع',
                      'طريق الملك فهد',
                      containerColor: Colors.white,
                      borderColor: cs.outline,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      label: CustomText(
                        'فتح الموقع في خرائط جوجل',
                        color: CustomTextColor.white,
                      ),
                      icon: Icon(LucideIcons.arrowUpRight),
                    ),
                  ],
                ),
              ),
            ],
          ),
          _ProfileInfoSection(
            title: 'معلومات الرحلات',
            icon: LucideIcons.plane,
            isExpanded: _expandedSections['flight'] ?? false,
            onToggle: () => _toggleSection('flight'),
            iconColor: cs.brandGold,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: cs.primary),
                  color: cs.primary.withValues(alpha: .1),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 10,
                  children: [
                    CustomText(
                      'رحلة الذهاب',
                      color: CustomTextColor.green,
                      type: CustomTextType.bodyLarge,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: cs.primary,
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 10,
                        children: [
                          CustomText(
                            'رقم الرحلة',
                            color: CustomTextColor.white,
                            type: CustomTextType.labelMedium,
                          ),
                          CustomText(
                            'SYR-1234',
                            color: CustomTextColor.white,
                            type: CustomTextType.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                    _buildInfoRow(
                      cs,
                      'شركة الطيران',
                      'الخطوط الجوية السورية',
                      containerColor: Colors.white,
                      borderColor: cs.outline,
                    ),
                    _buildInfoRow(
                      cs,
                      'وقت الإقلاع',
                      '10 يونيو 2026 - 14:30',
                      containerColor: Colors.white,
                      borderColor: cs.outline,
                    ),
                    _buildInfoRow(
                      cs,
                      'وقت الهبوط',
                      '10 يونيو 2026 - 18:45',
                      containerColor: Colors.white,
                      borderColor: cs.outline,
                    ),
                    _buildInfoRow(
                      cs,
                      'مطار المغادرة',
                      'مطار دمشق الدولي',
                      containerColor: Colors.white,
                      borderColor: cs.outline,
                    ),
                    _buildInfoRow(
                      cs,
                      'مطار الوصول',
                      'مطار الملك عبدالعزيز - جدة',
                      containerColor: Colors.white,
                      borderColor: cs.outline,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: cs.primary),
                  color: cs.primary.withValues(alpha: .1),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 10,
                  children: [
                    CustomText(
                      'رحلة العودة',
                      color: CustomTextColor.gold,
                      type: CustomTextType.bodyLarge,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: cs.brandGold,
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 10,
                        children: [
                          CustomText(
                            'رقم الرحلة',
                            color: CustomTextColor.white,
                            type: CustomTextType.labelMedium,
                          ),
                          CustomText(
                            'SYR-5678',
                            color: CustomTextColor.white,
                            type: CustomTextType.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                    _buildInfoRow(
                      cs,
                      'شركة الطيران',
                      'الخطوط الجوية السورية',
                      containerColor: Colors.white,
                      borderColor: cs.outline,
                    ),
                    _buildInfoRow(
                      cs,
                      'وقت الإقلاع',
                      '10 يونيو 2026 - 14:30',
                      containerColor: Colors.white,
                      borderColor: cs.outline,
                    ),
                    _buildInfoRow(
                      cs,
                      'وقت الهبوط',
                      '10 يونيو 2026 - 18:45',
                      containerColor: Colors.white,
                      borderColor: cs.outline,
                    ),
                    _buildInfoRow(
                      cs,
                      'مطار المغادرة',
                      'مطار الملك عبدالعزيز - جدة',
                      containerColor: Colors.white,
                      borderColor: cs.outline,
                    ),
                    _buildInfoRow(
                      cs,
                      'مطار الوصول',
                      'مطار دمشق الدولي',
                      containerColor: Colors.white,
                      borderColor: cs.outline,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _GradientStripe(cs: cs),
        ],
      ),
    );
  }

  // Helper to build the data rows inside the expanded area
  Widget _buildInfoRow(
    ColorScheme cs,
    String label,
    String value, {
    Color? containerColor,
    Color? borderColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor ?? cs.brandGold.withValues(alpha: 0.5),
        ),
        color: containerColor,
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Expanded(child: CustomText(label, color: CustomTextColor.gold)),
          Expanded(child: CustomText(value, color: CustomTextColor.green)),
        ],
      ),
    );
  }
}

class _ProfileInfoSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isExpanded;
  final VoidCallback onToggle;
  final List<Widget> children;
  final Color iconColor;

  const _ProfileInfoSection({
    required this.title,
    required this.icon,
    required this.isExpanded,
    required this.onToggle,
    required this.children,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: iconColor.withValues(alpha: 0.1),
                    ),
                    child: Icon(icon, color: iconColor, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomText(title, color: CustomTextColor.green),
                  ),
                  Icon(
                    isExpanded
                        ? LucideIcons.chevronUp
                        : LucideIcons.chevronDown,
                    color: cs.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
          // Using AnimatedCrossFade for a smooth "auto-calculating" height transition
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Column(children: children),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
          Divider(color: cs.outline.withValues(alpha: 0.5)),
        ],
      ),
    );
  }
}

class _GradientStripe extends StatelessWidget {
  const _GradientStripe({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.brandRed, cs.primary, cs.brandGold],
        ),
      ),
    );
  }
}
