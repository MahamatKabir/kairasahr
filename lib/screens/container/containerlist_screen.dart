import 'package:flutter/material.dart';
import 'package:kairasahrl/models/container_model.dart';
import 'package:kairasahrl/screens/container/containerupdate.dart';
import 'package:kairasahrl/widget/sizedtext.dart';

class ContainerListScreen extends StatefulWidget {
  const ContainerListScreen({super.key});

  @override
  State<ContainerListScreen> createState() => _ContainerListScreenState();
}

class _ContainerListScreenState extends State<ContainerListScreen> {
  final List<Containere> _containers = [
    Containere(
      id: 1,
      name: 'Container 1',
      slug: 'container_1',
      customer: 'Customer 1',
      customerTel: '1234567890',
      cityID: 1,
      contTypeID: 1,
      status: 1,
      createdAt: '2024-02-06',
    ),
    Containere(
      id: 1,
      name: 'Container 1',
      slug: 'container_1',
      customer: 'Customer 1',
      customerTel: '1234567890',
      cityID: 1,
      contTypeID: 1,
      status: 1,
      createdAt: '2024-02-06',
    ),
    Containere(
      id: 1,
      name: 'Container 1',
      slug: 'container_1',
      customer: 'Customer 1',
      customerTel: '1234567890',
      cityID: 1,
      contTypeID: 1,
      status: 1,
      createdAt: '2024-02-06',
    ),
    Containere(
      id: 1,
      name: 'Container 1',
      slug: 'container_1',
      customer: 'Customer 1',
      customerTel: '1234567890',
      cityID: 1,
      contTypeID: 1,
      status: 1,
      createdAt: '2024-02-06',
    ),
    Containere(
      id: 1,
      name: 'Container 1',
      slug: 'container_1',
      customer: 'Customer 1',
      customerTel: '1234567890',
      cityID: 1,
      contTypeID: 1,
      status: 1,
      createdAt: '2024-02-06',
    ),
    Containere(
      id: 1,
      name: 'Container 1',
      slug: 'container_1',
      customer: 'Customer 1',
      customerTel: '1234567890',
      cityID: 1,
      contTypeID: 1,
      status: 1,
      createdAt: '2024-02-06',
    ),
    Containere(
      id: 1,
      name: 'Container 1',
      slug: 'container_1',
      customer: 'Customer 1',
      customerTel: '1234567890',
      cityID: 1,
      contTypeID: 1,
      status: 1,
      createdAt: '2024-02-06',
    ),
    Containere(
      id: 1,
      name: 'Container 1',
      slug: 'container_1',
      customer: 'Customer 1',
      customerTel: '1234567890',
      cityID: 1,
      contTypeID: 1,
      status: 1,
      createdAt: '2024-02-06',
    ),
    Containere(
      id: 2,
      name: 'Container 2',
      slug: 'container_2',
      customer: 'Customer 2',
      customerTel: '9876543210',
      cityID: 2,
      contTypeID: 2,
      status: 1,
      createdAt: '2024-02-07',
    ),
    // Add more Container objects if needed
  ];

  void deleteContainer(int id) {
    setState(() {
      _containers.removeWhere((container) => container.id == id);
    });
  }

  void updateContainer(
    int id,
    String newName,
    String newSlug,
    String newCustomer,
    String newCustomerTel,
    int cityID,
    int contTypeID,
    int status,
    String newCreatedAt,
  ) {
    setState(() {
      for (int i = 0; i < _containers.length; i++) {
        if (_containers[i].id == id) {
          _containers[i] = Containere(
            id: id,
            name: newName,
            slug: newSlug,
            customer: newCustomer,
            customerTel: newCustomerTel,
            cityID: cityID,
            contTypeID: contTypeID,
            status: status,
            createdAt: newCreatedAt,
            createdBy: _containers[i].createdBy,
            updatedAt: _containers[i].updatedAt,
            updatedBy: _containers[i].updatedBy,
          );
          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade50,
        title: const Text(
          'Liste des Containers',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                itemCount: _containers.length,
                itemBuilder: (context, index) {
                  final containerdepense = _containers[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to container details screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContainerUpScreen(
                            container: containerdepense,
                            onDelete: deleteContainer,
                            onUpdate: updateContainer,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 120,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade50,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFFd8dbe0),
                            offset: Offset(1, 1),
                            spreadRadius: 5.0,
                            blurRadius: 10.0,
                          )
                        ],
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, left: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            width: 3,
                                            color: Colors.grey,
                                          ),
                                          image: const DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/images/cont.png"))),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          containerdepense.name,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'ID: ${containerdepense.id}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 85, 84, 84),
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                SizedText(
                                    text:
                                        'creer le ${containerdepense.createdAt}',
                                    color: Colors.green)
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 27,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.indigo),
                                      child: const Center(
                                        child: Text(
                                          'select',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      // child: Padding(
                      //   padding: const EdgeInsets.all(16.0),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         container.name,
                      //         style: const TextStyle(
                      //           fontFamily: 'Varela',
                      //           fontSize: 20,
                      //           color: Color.fromARGB(255, 10, 2, 52),
                      //         ),
                      //       ),
                      //       Text(container.slug),
                      //       const Icon(Icons.arrow_forward_ios),
                      //     ],
                      //   ),
                      // ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

//   _listcontainer() {
//     return Positioned(
//       top: 320,
//       child: Container(
//         height: 130,
//         width: MediaQuery.of(context).size.width - 20,
//         decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(30),
//                 bottomRight: Radius.circular(30)),
//             boxShadow: [
//               BoxShadow(
//                   color: Color(0xFFd8dbe0),
//                   offset: Offset(1, 1),
//                   blurRadius: 20.0,
//                   spreadRadius: 10),
//             ]),
//         child: Container(
//           margin: const EdgeInsets.only(top: 10, left: 18),
//           child: Row(children: [
//             Column(
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       height: 60,
//                       width: 60,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(
//                             width: 3,
//                             color: Colors.grey,
//                           ),
//                           image: const DecorationImage(
//                               fit: BoxFit.cover,
//                               image: AssetImage("images/background.png"))),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     const Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "kengne",
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: AppColor.mainColor),
//                         ),
//                         Text(
//                           "id: 123457",
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: AppColor.mainColor),
//                         )
//                       ],
//                     )
//                   ],
//                 )
//               ],
//             )
//           ]),
//         ),
//       ),
//     );
//   }
//
}