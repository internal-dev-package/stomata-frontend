import 'package:flutter/material.dart';
import 'package:flutter_package/flutter_package.dart';
import 'package:get/get.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:stomata_app/core/global_widget/loading/skeleton_loading.dart';
import 'package:stomata_app/core/global_widget/total_cash_widget.dart';
import 'package:stomata_app/core/utils/colors_utils.dart';
import 'package:stomata_app/core/utils/helpers.dart';
import 'package:stomata_app/features/investment/controller/investment_controller.dart';
import 'package:stomata_app/features/investment/model/investment_model.dart';

class InvestmentScreen extends StatefulWidget {
  final InvestmentModel detailData;
  const InvestmentScreen({super.key, required this.detailData});

  @override
  State<InvestmentScreen> createState() => _InvestmentScreenState();
}

class _InvestmentScreenState extends State<InvestmentScreen> {
  late final InvestmentController controller;

  @override
  void initState() {
    controller = Get.put(InvestmentController(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidgetContainer(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Invest Project', style: TextStyle(fontSize: 18)),
      ),
      body: SizedBox(
        height: Helpers.getFullHeight(context),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Source of Fund",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      margin: const EdgeInsets.all(0),
                      color: ColorUtils.fourGreenColors.withValues(alpha: 0.3),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(
                          () => SkeletonLoading(
                            loading: controller.loadingCash.value,
                            child: TotalCashWidget(
                              amount: controller.totalCash.value,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Input Amount",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    CTextInput(
                      textController: controller.textEditingController,
                      inputBackgroundColors: ColorUtils.secondaryBgColors,
                      keyboardType: TextInputType.number,
                      borderWidth: 1,
                      enableBorderColors: ColorUtils.secondaryColors,
                      focusBorderColors: ColorUtils.secondaryColors,
                      preffixIcon: Image.network(
                        "https://s3.ap-southeast-1.amazonaws.com/static.pintu.co.id/assets/images/logo/IDRX+-+IDRX.png",
                        scale: 30,
                      ),
                      hintText: "Input Amount...",
                      labelInput: "Input Amount...",
                      labelInputColors: ColorUtils.white,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      cursorColors: ColorUtils.secondaryColors,
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
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Quantity of Items",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                Text(
                                  "${widget.detailData.volume ?? "-"} Pieces",
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
                                    "Item Type",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                Text(
                                  widget.detailData.commodity ?? "-",
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
                                    "Submission Date",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                Text(
                                  Helpers.formatDate(
                                    widget.detailData.submissionDate ??
                                        DateTime.now(),
                                  ),
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
                                    "Delivery Date",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                Text(
                                  Helpers.formatDate(
                                    widget.detailData.deliveryDate ??
                                        DateTime.now(),
                                  ),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: ColorUtils.primaryColors,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
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
                                      "Rp ${widget.detailData.currentFundingPrice} / Rp ${widget.detailData.fundingPrice}",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                LinearProgressBar(
                                  minHeight: 5,
                                  maxSteps: int.parse(
                                    (widget.detailData.fundingPrice ?? "0")
                                        .replaceAll('.', ''),
                                  ),
                                  progressType: ProgressType.linear,
                                  currentStep: (() {
                                    int max = int.parse((widget.detailData.fundingPrice ?? "0").replaceAll('.', ''));
                                    int current = int.parse((widget.detailData.currentFundingPrice ?? "0").replaceAll('.', ''));
                                    return current > max ? max : current;
                                  })(),
                                  progressColor: ColorUtils.primaryColors,
                                  backgroundColor: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${widget.detailData.investors} Investor",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text("Margin"),
                                        const SizedBox(width: 8),
                                        Card(
                                          margin: const EdgeInsets.all(0),
                                          color: ColorUtils.primaryColors,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                              top: 2,
                                              bottom: 2,
                                            ),
                                            child: Text(
                                              "${widget.detailData.returnInvestmentRate}%",
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
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Project Price",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                Text(
                                  "Rp ${widget.detailData.projectPrice}",
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
                                    "Funding Price",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                Text(
                                  "Rp ${widget.detailData.fundingPrice}",
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
                                    "Current Funding Price",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                Text(
                                  "Rp ${widget.detailData.currentFundingPrice}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: ColorUtils.primaryColors,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
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
                  () => CustomButton(
                    onPressed: () => controller.confirmTransaction(
                      context,
                      widget.detailData,
                    ),
                    titleButton: "Payment",
                    borderRadius: 30,
                    enableButton: controller.enableButton.value,
                    backgroundDisableColors: ColorUtils.primaryColors.withAlpha(
                      60,
                    ),
                    backgroundColors: ColorUtils.primaryColors,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
