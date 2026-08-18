import 'package:flutter/material.dart';
import 'package:flutter_package/source/base_widget_container.dart';
import 'package:flutter_package/source/custom_button.dart';
import 'package:get/get.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:stomata_app/core/global_widget/loading/skeleton_loading.dart';
import 'package:stomata_app/core/global_widget/loading/skeleton_loading_v2.dart';
import 'package:stomata_app/core/utils/colors_utils.dart';
import 'package:stomata_app/core/utils/helpers.dart';
import 'package:stomata_app/features/project/controller/project_detail_controller.dart';
import 'package:stomata_app/repository/project/view/list/project_item_view_model.dart';

class ProjectDetailScreen extends StatefulWidget {
  final ProjectItemViewModel projectData;
  const ProjectDetailScreen({super.key, required this.projectData});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  late final ProjectDetailController controller;

  @override
  void initState() {
    controller = Get.put(
      ProjectDetailController(
        context: context,
        projectData: widget.projectData,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidgetContainer(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Project Detail', style: TextStyle(fontSize: 18)),
        actions: [
          IconButton(
            icon: Icon(Icons.message_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  child: Hero(
                    tag: widget.projectData.projectId ?? "",
                    child: Image.network(
                      widget.projectData.image ??
                          "https://www.sadakoffie.com/wp-content/uploads/2018/05/Carrboro-Coffee-Roasters.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),

                      // COMMODITY CATEGORY
                      Row(
                        children: [
                          Obx(
                            () => controller.loadingDetail.value
                                ? SkeletonLoadingV2(width: 50, height: 20)
                                : Card(
                                    margin: const EdgeInsets.all(0),
                                    color: ColorUtils.primaryColors,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 5,
                                        bottom: 5,
                                      ),
                                      child: Text(
                                        "${controller.projectDetail.value.commodity}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                          const SizedBox(width: 8),
                          // Card(
                          //   margin: const EdgeInsets.all(0),
                          //   color: ColorUtils.thirdBgColors,
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(30),
                          //   ),
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(
                          //       left: 15,
                          //       right: 15,
                          //       top: 5,
                          //       bottom: 5,
                          //     ),
                          //     child: Text(
                          //       "On Your Portofolio",
                          //       style: TextStyle(
                          //         fontSize: 12,
                          //         color: ColorUtils.white,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // PROJECT NAME
                      Obx(
                        () => controller.loadingDetail.value
                            ? SkeletonLoadingV2(height: 25)
                            : Text(
                                "${controller.projectDetail.value.projectName}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      const SizedBox(height: 16),

                      // COLLECTOR NAME
                      InkWell(
                        onTap: () => controller.showCompanyDetail(
                          context,
                          controller.projectDetail.value,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => SkeletonLoading(
                                loading: controller.loadingDetail.value,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    "https://bcassetcdn.com/public/blog/wp-content/uploads/2023/06/21145200/Costa-Coffee-1024x640.png",
                                    fit: BoxFit.cover,
                                    scale: 15,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => controller.loadingDetail.value
                                        ? SkeletonLoadingV2()
                                        : Text(
                                            "${controller.projectDetail.value.collectorName}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                  const SizedBox(height: 2),
                                  Obx(
                                    () => controller.loadingDetail.value
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                            ),
                                            child: SkeletonLoadingV2(),
                                          )
                                        : Text(
                                            "${controller.projectDetail.value.landAddress}",
                                            softWrap: true,
                                            maxLines: null,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: ColorUtils.primaryColors,
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => controller.loadingDetail.value
                                ? SkeletonLoadingV2()
                                : Card(
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
                                        "Rp ${controller.projectDetail.value.currentFundingPrice} / Rp ${controller.projectDetail.value.fundingPrice}",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 12),
                          Obx(
                            () => controller.loadingDetail.value
                                ? SkeletonLoadingV2()
                                : LinearProgressBar(
                                    minHeight: 5,
                                    maxSteps: int.parse(
                                      (controller
                                                  .projectDetail
                                                  .value
                                                  .fundingPrice ??
                                              "0")
                                          .replaceAll('.', ''),
                                    ),
                                    progressType: ProgressType.linear,
                                    currentStep: (() {
                                      int max = int.parse((controller.projectDetail.value.fundingPrice ?? "0").replaceAll('.', ''));
                                      int current = int.parse((controller.projectDetail.value.currentFundingPrice ?? "0").replaceAll('.', ''));
                                      return current > max ? max : current;
                                    })(),
                                    progressColor: ColorUtils.primaryColors,
                                    backgroundColor: Colors.grey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Obx(
                                  () => controller.loadingDetail.value
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                            right: 8,
                                          ),
                                          child: SkeletonLoadingV2(),
                                        )
                                      : Text(
                                          "${controller.projectDetail.value.investors} Investor",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              ),
                              Obx(
                                () => controller.loadingDetail.value
                                    ? SkeletonLoadingV2(width: 50)
                                    : Row(
                                        children: [
                                          Text("Margin"),
                                          const SizedBox(width: 8),
                                          Card(
                                            margin: const EdgeInsets.all(0),
                                            color: ColorUtils.primaryColors,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8,
                                                right: 8,
                                                top: 2,
                                                bottom: 2,
                                              ),
                                              child: Text(
                                                "${controller.projectDetail.value.returnInvestmentRate}%",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
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

                      const SizedBox(height: 20),
                      Text(
                        "Project Detail",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        margin: const EdgeInsets.all(0),
                        color: ColorUtils.secondaryBgColors,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => controller.loadingDetail.value
                                    ? SkeletonLoadingV2()
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Quantity of Items",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                          Text(
                                            "${controller.projectDetail.value.volume} Pieces",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: ColorUtils.primaryColors,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                              const SizedBox(height: 8),
                              Obx(
                                () => controller.loadingDetail.value
                                    ? SkeletonLoadingV2()
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Item Type",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                          Text(
                                            "${controller.projectDetail.value.commodity}",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: ColorUtils.primaryColors,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                              const SizedBox(height: 8),
                              Obx(
                                () => controller.loadingDetail.value
                                    ? SkeletonLoadingV2()
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Submission Date",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                          Text(
                                            Helpers.formatDate(
                                              controller
                                                      .projectDetail
                                                      .value
                                                      .submissionDate ??
                                                  DateTime.now(),
                                            ),
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: ColorUtils.primaryColors,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                              const SizedBox(height: 8),
                              Obx(
                                () => controller.loadingDetail.value
                                    ? SkeletonLoadingV2()
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Delivery Date",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                          Text(
                                            Helpers.formatDate(
                                              controller
                                                      .projectDetail
                                                      .value
                                                      .deliveryDate ??
                                                  DateTime.now(),
                                            ),
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: ColorUtils.primaryColors,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Pricing",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        margin: const EdgeInsets.all(0),
                        color: ColorUtils.secondaryBgColors,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => controller.loadingDetail.value
                                    ? SkeletonLoadingV2()
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Project Price",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                          Text(
                                            "Rp ${controller.projectDetail.value.projectPrice}",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: ColorUtils.primaryColors,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                              const SizedBox(height: 8),
                              Obx(
                                () => controller.loadingDetail.value
                                    ? SkeletonLoadingV2()
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Funding Price",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                          Text(
                                            "Rp ${controller.projectDetail.value.fundingPrice}",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: ColorUtils.primaryColors,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                              const SizedBox(height: 8),
                              Obx(
                                () => controller.loadingDetail.value
                                    ? SkeletonLoadingV2()
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Current Funding Price",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                          Text(
                                            "Rp ${controller.projectDetail.value.currentFundingPrice}",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: ColorUtils.primaryColors,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Investment",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        margin: const EdgeInsets.all(0),
                        color: ColorUtils.secondaryBgColors,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => controller.loadingDetail.value
                                    ? SkeletonLoadingV2()
                                    : Row(
                                        children: [
                                          Text(
                                            "Return Investment Rate",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Expanded(child: const SizedBox()),
                                          Text(
                                            "${controller.projectDetail.value.returnInvestmentRate}%",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: ColorUtils.primaryColors,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: ColorUtils.secondaryBgColors,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 30,
                top: 30,
              ),
              child: Obx(
                () => controller.loadingDetail.value
                    ? SkeletonLoadingV2(height: 35, borderRadius: 30)
                    : CustomButton(
                        onPressed: controller.startInvest,
                        titleButton: "Start to Invest",
                        borderRadius: 30,
                        backgroundColors: ColorUtils.primaryColors,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
