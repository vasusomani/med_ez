import 'package:flutter/material.dart';
import 'package:med_ez/data/services/api_service.dart';

import '../../Constants/colors.dart';

class InfoContainer extends StatelessWidget {
  const InfoContainer(
    this.label,
    this.value, {
    this.date = "",
    this.id = "",
    this.lastAssessmentDate = "",
    this.isPdf = false,
    Key? key,
  }) : super(key: key);
  final String label;
  final String value;
  final String date;
  final String id;
  final String lastAssessmentDate;
  final bool isPdf;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: containerColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xff00425A),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xff00425A),
                ),
              ),
              if (date != "")
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff00425A),
                  ),
                ),
              if (isPdf)
                IconButton(
                    onPressed: () async {
                      debugPrint(id);
                      debugPrint(lastAssessmentDate);
                      final pdfContent = await ApiService()
                          .getDischargeReport(id, lastAssessmentDate);
                      ApiService().savePDF(context, pdfContent);
                    },
                    icon: const Icon(
                      Icons.download,
                      color: appBarColor,
                    ))
            ],
          ),
        ],
      ),
    );
  }
}
