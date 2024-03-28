import 'dart:math';

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kairasahrl/models/container_model.dart';
import 'package:kairasahrl/models/depense_model.dart';
import 'package:kairasahrl/screens/depenses/expensedetail.dart';
import 'package:kairasahrl/screens/editpage.dart';
import 'package:kairasahrl/screens/utils/color.dart';
import 'package:kairasahrl/widget/sizedtext.dart';

class ContainerUpScreen extends StatefulWidget {
  static const routeName = "/ContainerUpScreen";
  Conteneure container;
  final List<Expense> containerExpenses;
  final String name;
  final String customer;
  final String? customerPhone;
  final Function(int) onDelete;
  final Function(
    int,
    String,
    String,
    String,
    String,
    String,
    String,
    String,
    double,
    String,
    // int,
    int,
    String,
    String,
    String,
  ) onUpdate;
  final String createdAt;

  ContainerUpScreen({
    Key? key,
    required this.container,
    required this.name,
    required this.customer,
    this.customerPhone,
    required this.onDelete,
    required this.onUpdate,
    required this.createdAt,
    required this.containerExpenses,
  }) : super(key: key);

  @override
  _ContainerUpScreenState createState() => _ContainerUpScreenState();
}

class _ContainerUpScreenState extends State<ContainerUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          '',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPage(
                    container: widget.container,
                    onDelete: widget.onDelete,
                    isEditing: true,
                    updateContainer: widget.onUpdate,
                    initialStatusValue:
                        int.tryParse(widget.container.status.toString()) ?? 0,
                    initialContainerTypeValue: int.tryParse(
                            widget.container.containerType.toString()) ??
                        0,
                  ),
                ),
              );
            },
            child: const Text(
              'Éditer',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textFieldBackground
                  // Vous pouvez ajuster d'autres styles ici selon vos préférences
                  ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: 280, child: _head()),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                  child: list(widget
                      .containerExpenses)), // Utilisez la liste des dépenses associées
            ),
          ],
        ),
      ),
    );
  }

  Widget list(List<Expense> expenses) {
    if (expenses.isEmpty) {
      return const Center(
        child: Text(
          'Aucune dépense disponible',
          style: TextStyle(fontSize: 16.0, color: Colors.black),
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          final expense = expenses[index];

          return ListTile(
            subtitle: Container(
              height: 75,
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.indigo,
                    offset: Offset(1, 1),
                    spreadRadius: 1.0,
                    blurRadius: 1.0,
                  )
                ],
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      expense.article,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 15,
                                        width: 15,
                                        child: const HeroIcon(
                                          HeroIcons.user,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        ' ${expense.createdBy}',
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.w400),
                                        maxLines: 1,
                                        softWrap: false,
                                        overflow: TextOverflow.clip,
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 27,
                              child: Center(
                                child: Container(
                                  child: Text(
                                    "${expense.paid.toString()}FCFA",
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedText(
                                text: ' ${expense.createdAt}',
                                color: const Color.fromARGB(255, 0, 0, 0))
                            // Container(
                            //   margin:
                            //       const EdgeInsets.only(bottom: 20, left: 50),
                            //   width: 40,
                            //   height: 18,
                            //   child: const Center(
                            //     child: HeroIcon(
                            //       HeroIcons.chevronRight,
                            //       size: 18,
                            //       color: Colors.black,
                            //     ),
                            //   ),
                            // ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            // onTap: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => ExpenseDetailPage(expense:expense)),
            //   );
            // },
          );
        },
      );
    }
  }

  Widget _head() {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.indigo,
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.all(20),
          height: 200,
          decoration: BoxDecoration(
            color: Colors.indigo.shade100,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withOpacity(0.4),
                spreadRadius: 4,
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Center(
                      child: Text(
                        '', // Utilisez le nom du widget
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_right,
                      color: Colors.black,
                      size: 33,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPage(
                            container: widget.container,
                            onDelete: widget.onDelete,
                            //onUpdate: widget.onUpdate,
                            isEditing: false,
                            updateContainer: widget.onUpdate,
                            initialStatusValue: int.tryParse(
                                    widget.container.status.toString()) ??
                                0,
                            initialContainerTypeValue: int.tryParse(widget
                                    .container.containerType
                                    .toString()) ??
                                0,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Center(
                child: Text(
                  widget.name, // Utilisez le nom du widget
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  widget.customer, // Utilisez total
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 13,
                          backgroundColor: AppColors.appbar,
                          child: HeroIcon(
                            HeroIcons.phone,
                            color: Colors.white,
                            size: 13,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          widget.customerPhone!.toString(),
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 13,
                          backgroundColor: AppColors.appbar,
                          child: HeroIcon(
                            HeroIcons.calendar,
                            color: Colors.white,
                            size: 13,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          widget
                              .createdAt, // Utilisez le numéro de téléphone du client du widget
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
            ],
          ),
        ),
      ],
    );
  }
}
