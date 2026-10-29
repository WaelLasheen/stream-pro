import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/generated/l10n.dart';

import '../../domain/entities/session_entity.dart';
import '../extension/session_display.dart';

class SessionCard extends StatelessWidget {
  final SessionEntity session;
  final VoidCallback onRevoke;

  const SessionCard({super.key, required this.session, required this.onRevoke});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final textTheme = context.textTheme;
    final location = session.locationLabel;
    final lastActive = session.lastActiveLabel;
    final country = session.country;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: appTheme.surfaceColor,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: appTheme.boarderPrimary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44.r,
                height: 44.r,
                decoration: BoxDecoration(
                  color: appTheme.primaryTint,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(
                  session.deviceIcon,
                  color: appTheme.primaryColor,
                  size: 22.r,
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session.deviceLabel(context),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyLarge?.copyWith(
                        color: appTheme.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    5.verticalSpace,
                    Text(
                      session.loginMethodLabel(context),
                      style: textTheme.bodySmall?.copyWith(
                        color: appTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          14.verticalSpace,
          Row(
            children: [
              if (country != null && _isCountryCode(country))
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3.r),
                    child: CountryFlag.fromCountryCode(
                      country,
                      theme: const ImageTheme(width: 22, height: 16),
                    ),
                  ),
                )
              else
                Padding(
                  padding: EdgeInsets.only(right: 6.w),
                  child: Icon(
                    Icons.location_on_outlined,
                    size: 16.r,
                    color: appTheme.secondaryColor,
                  ),
                ),
              if (country != null && _isCountryCode(country))
                Padding(
                  padding: EdgeInsets.only(right: 6.w),
                  child: Icon(
                    Icons.location_on_outlined,
                    size: 14.r,
                    color: appTheme.secondaryColor,
                  ),
                ),
              Expanded(
                child: Text(
                  location ?? S.current.unknownLocation,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(
                    color: appTheme.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          if (lastActive != null) ...[
            12.verticalSpace,
            _SessionInfoRow(
              icon: Icons.schedule_rounded,
              label: S.current.lastActive,
              value: lastActive,
            ),
          ],
          if (session.createdAt != null) ...[
            8.verticalSpace,
            _SessionInfoRow(
              icon: Icons.login_rounded,
              label: S.current.signedInAt,
              value: _formatDate(context, session.createdAt!),
            ),
          ],
          if (session.expiresAt != null) ...[
            8.verticalSpace,
            _SessionInfoRow(
              icon: Icons.event_available_rounded,
              label: S.current.expiresAtLabel,
              value: _formatDate(context, session.expiresAt!),
            ),
          ],
          if (session.ipAddress != null) ...[
            8.verticalSpace,
            _SessionInfoRow(
              icon: Icons.language_rounded,
              label: S.current.ipAddressLabel,
              value: session.ipAddress!,
            ),
          ],
          if (session.appVersion != null) ...[
            8.verticalSpace,
            _SessionInfoRow(
              icon: Icons.info_outline_rounded,
              label: S.current.appVersionLabel,
              value: session.appVersion!,
            ),
          ],
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton.icon(
              onPressed: onRevoke,
              style: TextButton.styleFrom(
                foregroundColor: appTheme.redNormalColor,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              ),
              icon: Icon(Icons.logout_rounded, size: 17.r),
              label: Text(
                S.current.logoutSession,
                style: textTheme.labelLarge?.copyWith(
                  color: appTheme.redNormalColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isCountryCode(String value) {
    return RegExp(r'^[A-Za-z]{2}$').hasMatch(value);
  }

  String _formatDate(BuildContext context, DateTime date) {
    return MaterialLocalizations.of(context).formatMediumDate(date.toLocal());
  }
}

class _SessionInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _SessionInfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final textTheme = context.textTheme;

    return Row(
      children: [
        Icon(icon, size: 15.r, color: appTheme.grey700),
        7.horizontalSpace,
        Text(
          '$label: ',
          style: textTheme.bodySmall?.copyWith(color: appTheme.grey700),
        ),
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodySmall?.copyWith(
              color: appTheme.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
