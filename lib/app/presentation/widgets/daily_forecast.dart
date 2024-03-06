import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_theme.dart';

class DailyForecast extends StatefulWidget {
  const DailyForecast({super.key});

  @override
  State<DailyForecast> createState() => _DailyForecastState();
}

class _DailyForecastState extends State<DailyForecast> {
  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextTheme.textTheme;

    return Container(
      height: 430,
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 6),
      margin: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "5-DAYS FORECAST",
            style: textTheme.labelMedium?.copyWith(
              color: Colors.grey,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 14),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        // DateFormat('MMMM d,EEEE').format(
                        //             DateTime.fromMillisecondsSinceEpoch(
                        //                 day.dailyTime.toInt() * 1000,
                        //                 isUtc: false)) ==
                        //         DateFormat('MMMM d,EEEE').format(DateTime.now())
                        //     ? "Today"
                        //     : DateFormat.EEEE().format(
                        //         DateTime.fromMillisecondsSinceEpoch(
                        //             day.dailyTime.toInt() * 1000,
                        //             isUtc: false
                        //             ),
                        "---",
                        style: textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 6,
                        ),
                        // child: Image.asset(
                        //   getCustomIcon(day.dailyIcon),
                        //   filterQuality: FilterQuality.high,
                        //   fit: BoxFit.cover,
                        //   width: 36,
                        // ),
                        child: Text("Icon"),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        // "${day.dailyMinTemp.round().toString()}\u{00B0}c to ${day.dailyMaxTemp.round().toString()}\u{00B0}c",
                        "---",
                        textAlign: TextAlign.end,
                        style: textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
