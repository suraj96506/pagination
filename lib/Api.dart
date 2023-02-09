import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api extends ChangeNotifier {
  int page = 1;
  void incrementPage() {
    page++;
    notifyListeners();
  }

  List category = [];
  var token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNGI1OThkZWVmMTQ5M2QyZjMxMmU4NDU4M2NmNTY4NzA3YjVmODY1YzJhNDM4ODIzNjM3NjM0Zjg2MDExNWIyMGIzODUyNzUyNTdjOTVjMDIiLCJpYXQiOjE2NzU4NjkzMTcuMTU2NDAzLCJuYmYiOjE2NzU4NjkzMTcuMTU2NDA1LCJleHAiOjE3MDc0MDUzMTcuMTUxMzcyLCJzdWIiOiI5NDA2MSIsInNjb3BlcyI6W119.U8h-71Xdt7TngYO6iE3jzcXbYexxxZhjR4Po2KpO_Yf4oCb7Nj6GFLPIoy8NXwK8kuq6pPF7C6yLW8ppU5oKbyVtKO5GAq7pf0w2p9DbIrqg1Ur6Kvb9Q1KyNlyjx0fHzLwhzw2PbXUpgiFfnAu_ho-xQ1Imn3NsC4I01OrXbh3F8KeWfaHiphKlKGr4f23z1pAnMNovIdVtFZqTcH-rj-sTnfkZPYr6SGj3tDGxFgzSikP-_m8q9eP4jIvBYPPPKtO-uV1KxP0ijdZJ7-1VHBbIPv9UzGWpgqz8P5PYfojloiH9RXXTpGiGYTavP5eKrgSMedYLPnyD6B6733zg4pjkP0f7i_HV0LTi3gZKy3p-1_fqjoXpTTYC-b0oXat1S750LsrfTvlMJDKT2RT0fihtqSwEIDXZpY2Me2XWTTr-OGkSS6iqP2Kze8t-Etxk2h3pXBtYSTSmyutoAAexHJ3g8pCY-7KgHY20XKH7FbPElkhgc9SO1BJI1ekN_bN7Dvedcr9pZ8qN7XjNFGJcpXL1Mc3755ADekyWq7m_BFr3ExnwObVVMbpuEeBwmq408k0_1_R8w8bDC3IaM-ef4Xz-bX-JxEd2WYbaAwehplPICdZrR1MHP1AthLLnNbHvJayk1GvrkoXx-bDSm1daE9yYBs-wKnGg7HW4-qvLaHs";
  Future<List<dynamic>> getCategory(int pages) async {
    var url = "https://dev3.talentedge.com/api/v2/categories?page=$pages";
    try {
      var response = await http
          .get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});

      if (response.statusCode == 200) {
        /// API call for user login
        print(jsonDecode(response.body));
        if (page == 1) {
          category.clear();
          category.addAll(jsonDecode(response.body)["data"]["data"]);
          notifyListeners();
          return category;
        } else {
          category.addAll(jsonDecode(response.body)["data"]["data"]);

          notifyListeners();
          return category;
        }
      } else {
        print("else");
        return Future.error('Server Error!');
      }
    } catch (e) {
      // ignore: avoid_log
      log(e.toString());
      print("catch");
      return Future.error(e);
    }
  }
}
