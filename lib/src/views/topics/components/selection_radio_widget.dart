import 'package:flutter/material.dart';
import 'package:vquiz_app/src/models/data_model.dart';
import 'package:vquiz_app/src/res/colors.dart';
import 'package:vquiz_app/src/services/utils/print_log.dart';

class SelectionRadioWidget extends StatelessWidget {
  const SelectionRadioWidget(
      {Key? key,
      required this.idx,
      required this.itemLength,
      required this.ratingData,
      required this.onUpdate,
      required this.selectedRadio,
      this.enable = true})
      : super(key: key);
  final int idx;
  final int itemLength;
  final Data ratingData;
  final ValueChanged<Data> onUpdate;
  final String selectedRadio;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    // printWarning('enable => $enable');
    return GestureDetector(
      onTap: enable
          ? () {
              PrintLog().printWarning("${ratingData.label} tapped!");
              onUpdate(ratingData);
            }
          : null,
      child: Container(
        margin: EdgeInsets.only(
            top: idx == 0 ? 0 : 3, bottom: idx == itemLength - 1 ? 3 : 0),
        // height: 30,
        width: double.infinity,
        decoration: BoxDecoration(
            color: selectedRadio == ratingData.value
                ? primaryColor.withOpacity(enable ? 0.25 : 0.15)
                : enable
                    ? Colors.grey.shade200
                    : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(3)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          // color:
          //     Colors.green,
          child: Row(
            children: [
              Radio(
                  value: ratingData.value.toString(),
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    return selectedRadio == ratingData.value
                        ? primaryColor.withOpacity(enable ? 1 : 0.5)
                        : Colors.black.withOpacity(enable ? 0.5 : 0.2);
                  }),
                  groupValue: selectedRadio,
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: 0),
                  onChanged: enable
                      ? (String? value) {
                          // setState(() {
                          //   _selectedCicoType = value;
                          //   _absType = "DAILY";
                          //   printSuccess("Clocktype (CICO): $_absType");
                          // });
                          PrintLog()
                              .printWarning("${ratingData.label} tapped!");
                          onUpdate(ratingData);
                        }
                      : null),
              Expanded(
                child: GestureDetector(
                  onTap: enable
                      ? () {
                          // setState(() {
                          //   _selectedCicoType = 'OOR';
                          //   _absType = "DAILY";
                          //   printSuccess("Clocktype (CICO): $_absType");
                          // });
                          PrintLog()
                              .printWarning("${ratingData.label} tapped!");
                          onUpdate(ratingData);
                        }
                      : null,
                  child: Text(
                    ratingData.label.toString(),
                    style: TextStyle(
                        height: 1.1,
                        fontSize: 13,
                        color: Colors.black.withOpacity(
                            selectedRadio == ratingData.value ? 1 : 0.5)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
