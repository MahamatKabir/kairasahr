import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kairasahrl/models/container_model.dart';
import 'package:kairasahrl/models/depense_model.dart';
import 'package:kairasahrl/screens/editpage.dart';
import 'package:kairasahrl/screens/utils/color.dart';
import 'package:kairasahrl/widget/sizedtext.dart';

class ContainerUpScreen extends StatefulWidget {
  static const routeName = "/ContainerUpScreen";
  Conteneure container;
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
    int,
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
  }) : super(key: key);

  @override
  _ContainerUpScreenState createState() => _ContainerUpScreenState();
}

class _ContainerUpScreenState extends State<ContainerUpScreen> {
  final List<Expense> _depenses = [
    Expense(
      id: 1,
      article: 'Achat de fournitures',
      slug: 'achat_fournitures_bureau',
      total: 2000,
      paid: 150,
      containerID: 2,
      createdBy: 1,
      createdAt: '2024-02-17',
      updatedBy: 1,
      updatedAt: '2024-02-17',
    ),
    Expense(
      id: 1,
      article: 'Achat de fournitures',
      slug: 'achat_fournitures_bureau',
      total: 2000,
      paid: 150,
      containerID: 2,
      createdBy: 1,
      createdAt: '2024-02-17',
      updatedBy: 1,
      updatedAt: '2024-02-17',
    ),
    Expense(
      id: 1,
      article: 'Achat de fournitures',
      slug: 'achat_fournitures_bureau',
      total: 2000,
      paid: 150,
      containerID: 2,
      createdBy: 1,
      createdAt: '2024-02-17',
      updatedBy: 1,
      updatedAt: '2024-02-17',
    ),
    Expense(
      id: 2,
      article: 'Achat de fournitures',
      slug: 'achat_fournitures_bureau',
      total: 90000,
      paid: 150,
      containerID: 3,
      createdBy: 1,
      createdAt: '2024-02-17',
      updatedBy: 1,
      updatedAt: '2024-02-17',
    ),
    Expense(
      id: 3,
      article: 'Achat de fournitures de l ambasssade de france',
      slug: 'achat_fournitures_bureau',
      total: 700000,
      paid: 150,
      containerID: 2,
      createdBy: 1,
      createdAt: '2024-02-17',
      updatedBy: 1,
      updatedAt: '2024-02-17',
    ),
    Expense(
      id: 3,
      article: 'Achat de fournitures de l ambasssade de france',
      slug: 'achat_fournitures_bureau',
      total: 3000000,
      paid: 150,
      containerID: 4,
      createdBy: 1,
      createdAt: '2024-02-17',
      updatedBy: 1,
      updatedAt: '2024-02-17',
    ),
  ];

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
                    onUpdate: widget.onUpdate,
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
              child: SizedBox(child: list()),
            )
          ],
        ),
      ),
    );
  }

  Widget list() {
    // Check if _depenses is empty or if there are no expenses for the current container
    if (_depenses.isEmpty ||
        _depenses
            .where((depense) => depense.containerID == widget.container.id)
            .isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 50.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: 0.2, // Opacité de l'image
                    child: Image(
                      image: AssetImage(
                        "assets/images/expense.png", // Chemin de l'image
                      ),
                      width: 100, // Largeur de l'image
                      height: 100, // Hauteur de l'image
                    ),
                  ),
                  Text(
                    'Aucune dépense disponible', // Texte indiquant l'absence de dépenses
                    style: TextStyle(
                      fontSize: 16.0, // Taille de la police du texte
                      color: Colors.black, // Couleur du texte
                    ),
                    textAlign: TextAlign.center, // Alignement du texte
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              'Depense lieé au conteneur',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.indigo,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: _depenses
                .where((depense) => depense.containerID == widget.container.id)
                .map((depense) {
              return GestureDetector(
                onTap: () {
                  // Navigate to container details screen
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(5, 5),
                        spreadRadius: 5.0,
                        blurRadius: 10.0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                depense.article,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              SizedText(
                                text: 'creer le ${depense.createdAt}',
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 25),
                          child: Text(
                            "${depense.total.toString()} FCFA",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
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
        Positioned(
          top: MediaQuery.of(context).size.height *
              0.03, // 10% de la hauteur de l'écran à partir du haut
          left: MediaQuery.of(context).size.width *
              0.056, // 5.6% de la largeur de l'écran à partir de la gauche
          child: Container(
            height: MediaQuery.of(context).size.height *
                0.30, // 23% de la hauteur de l'écran
            width: MediaQuery.of(context).size.width * 0.89,

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
                        color: Colors.white,
                        size: 33,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPage(
                              container: widget.container,
                              onDelete: widget.onDelete,
                              onUpdate: widget.onUpdate,
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.indigo.shade900,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    widget.customer, // Utilisez total
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.indigo.shade900,
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
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.indigo.shade900,
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
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Colors.green,
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
        )
      ],
    );
  }
}
