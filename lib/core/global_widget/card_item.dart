import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:stomata_app/core/global_widget/loading/skeleton_loading_v2.dart';
import 'package:stomata_app/core/utils/colors_utils.dart';
import 'package:stomata_app/core/utils/helpers.dart';

class CardItem extends StatelessWidget {
  final String imageUrl;
  final String projectName;
  final String projectId;
  final String releaserName;
  final double totalFunding;
  final double fundingGoal;
  final int investor;
  final int margin;
  final int percentageFunded;
  final VoidCallback onTap;

  const CardItem({
    super.key,
    required this.projectName,
    required this.releaserName,
    required this.projectId,
    required this.imageUrl,
    required this.onTap,
    required this.totalFunding,
    required this.fundingGoal,
    required this.investor,
    required this.margin,
    required this.percentageFunded,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: ColorUtils.secondaryBgColors,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Hero(
                  tag: projectId,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SkeletonLoadingV2(height: 200);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      projectName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Image.network(
                            "https://bcassetcdn.com/public/blog/wp-content/uploads/2023/06/21145200/Costa-Coffee-1024x640.png",
                            fit: BoxFit.cover,
                            scale: 30,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          releaserName,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // const Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          margin: const EdgeInsets.all(0),
                          color: ColorUtils.thirdBgColors,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                              top: 2,
                              bottom: 2,
                            ),
                            child: Text(
                              "Rp ${Helpers.formatAmount((totalFunding).toInt())} / Rp ${Helpers.formatAmount((fundingGoal).toInt())}",
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        LinearProgressBar(
                          minHeight: 5,
                          maxSteps: fundingGoal.toInt(),
                          progressType: ProgressType.linear,
                          currentStep: totalFunding.toInt() > fundingGoal.toInt() ? fundingGoal.toInt() : totalFunding.toInt(),
                          progressColor: ColorUtils.primaryColors,
                          backgroundColor: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Text("Price", style: TextStyle(fontSize: 15)),
                        ),
                        Text(
                          "Rp. ${Helpers.formatAmount((fundingGoal).toInt())}",
                          style: TextStyle(
                            fontSize: 15,
                            color: ColorUtils.primaryColors,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Total Investor",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Text(
                          "$investor",
                          style: TextStyle(
                            fontSize: 15,
                            color: ColorUtils.primaryColors,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text("Margin", style: TextStyle(fontSize: 15)),
                        ),
                        Card(
                          margin: const EdgeInsets.all(0),
                          color: ColorUtils.primaryColors,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                              top: 2,
                              bottom: 2,
                            ),
                            child: Text(
                              "$margin%",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
