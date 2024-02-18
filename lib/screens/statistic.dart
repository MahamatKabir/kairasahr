import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class StatisticPage extends StatefulWidget {
  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  late int selectedYear;
  late List<Expense> expenses;
  late Map<String, int> monthlyExpenses;

  @override
  void initState() {
    super.initState();
    selectedYear = DateTime.now().year;
    expenses = _generateExpenses(selectedYear);
    monthlyExpenses = _calculateMonthlyExpenses(expenses);
  }

  List<Expense> _generateExpenses(int year) {
    return [
      Expense(createdAt: '2024-01-01', total: 500),
      Expense(createdAt: '2024-02-01', total: 700),
      Expense(createdAt: '2022-03-01', total: 900),
      Expense(createdAt: '2024-04-01', total: 600),
      Expense(createdAt: '2021-05-01', total: 800),
      Expense(createdAt: '2024-06-01', total: 400),
      Expense(createdAt: '2024-07-01', total: 300),
      Expense(createdAt: '2023-08-01', total: 1000),
      Expense(createdAt: '2024-09-01', total: 1200),
      Expense(createdAt: '2023-10-01', total: 1500),
      Expense(createdAt: '2024-11-01', total: 1100),
      Expense(createdAt: '2024-12-01', total: 800),
    ].where((expense) => expense.createdAt.startsWith('$year')).toList();
  }

  Map<String, int> _calculateMonthlyExpenses(List<Expense> expenses) {
    Map<String, int> monthlyExpenses = {};
    for (var expense in expenses) {
      final month = expense.createdAt.substring(5, 7);
      monthlyExpenses.update(month, (value) => value + expense.total,
          ifAbsent: () => expense.total);
    }
    return monthlyExpenses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: Center(
        child: Container(
          height: 400,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              DropdownButton<int>(
                value: selectedYear,
                onChanged: (int? year) {
                  if (year != null) {
                    setState(() {
                      selectedYear = year;
                      expenses = _generateExpenses(selectedYear);
                      monthlyExpenses = _calculateMonthlyExpenses(expenses);
                    });
                  }
                },
                items: List.generate(
                  10,
                  (index) => DropdownMenuItem<int>(
                    value: DateTime.now().year - index,
                    child: Text('${DateTime.now().year - index}'),
                  ),
                ),
              ),
              Expanded(
                child: Echarts(
                  option: '''
                  {
                    xAxis: {
                      type: 'category',
                      data: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    },
                    yAxis: {
                      type: 'value'
                    },
                    series: [{
                      data: [
                        ${_generateData()},
                      ],
                      type: 'bar'
                    }]
                  }
                  ''',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _generateData() {
    String data = '';
    monthlyExpenses.forEach((month, total) {
      data += '$total,';
    });
    return data;
  }
}

class Expense {
  final String createdAt;
  final int total;

  Expense({required this.createdAt, required this.total});
}
