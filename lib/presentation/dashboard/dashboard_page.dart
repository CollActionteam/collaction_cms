import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late ScrollController _statsScrollController;

  @override
  void initState() {
    super.initState();
    _statsScrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        const Text(
          'CrowdAction Statistics',
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 85,
                child: Scrollbar(
                  controller: _statsScrollController,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: ListView(
                      controller: _statsScrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: const [
                        StatsBox(
                          amount: 34,
                          label: 'Draft',
                        ),
                        SizedBox(width: 15),
                        StatsBox(
                          amount: 9,
                          label: 'Upcoming',
                        ),
                        SizedBox(width: 15),
                        StatsBox(
                          amount: 17,
                          label: 'On-going',
                        ),
                        SizedBox(width: 15),
                        StatsBox(
                          amount: 197,
                          label: 'Ended',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class StatsBox extends StatelessWidget {
  final int amount;
  final String label;

  const StatsBox({
    Key? key,
    required this.amount,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 70,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kBorderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            amount.toString(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              color: kSecondaryTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
