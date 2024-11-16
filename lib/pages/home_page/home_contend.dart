import 'package:carousel_slider/carousel_slider.dart';
import 'package:cure_connect_service/pages/category.dart';
import 'package:cure_connect_service/pages/home_page/home_page.dart';
import 'package:cure_connect_service/pages/top_rated_doctors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeContent extends StatelessWidget{
  HomeContent({super.key});

  final List<String> categoryTitles = [
    'Physiotherapist',
    'Dentist',
    'Ophthalmologist',
    'Neurologist',
    'Pediatrician',
    'Nephrologist',
  ];

  final List<String> categorysImages = [
    'assets/physiotherapist.png',
    'assets/teeth (2).png',
    'assets/advertising.png',
    'assets/brainstorm.png',
    'assets/baby-boy.png',
    'assets/kidneys.png',
  ];

  final List<Color> categoryTextColors = [
    const Color.fromARGB(255, 20, 116, 24),
    const Color.fromARGB(255, 192, 47, 37),
    const Color(0xFF6082CC),
    const Color(0xFFA820AB),
    const Color(0xFFDEA200),
    Colors.black.withOpacity(0.8),
  ];

  final List<Color> categoryColors = [
    Colors.green.withOpacity(0.15),
    Colors.red.withOpacity(0.15),
    Colors.blue.withOpacity(0.12),
    Colors.purple.withOpacity(0.12),
    Colors.orange.withOpacity(0.12),
    Colors.black.withOpacity(0.12),
  ];

  final List<Map<String, dynamic>> doctors = [
    {
      'name': 'Dr. Alex',
      'specialty': 'Physiotherapist',
      'imageUrl':
          'https://t4.ftcdn.net/jpg/02/60/04/09/360_F_260040900_oO6YW1sHTnKxby4GcjCvtypUCWjnQRg5.jpg',
      'rating': 4.0,
    },
    {
      'name': 'Dr. Sarah',
      'specialty': 'Cardiologist',
      'imageUrl':
          'https://img.freepik.com/free-photo/beautiful-young-female-doctor-looking-camera-office_1301-7807.jpg',
      'rating': 5.0,
    },
    {
      'name': 'Dr. John',
      'specialty': 'Neurologist',
      'imageUrl':
          'https://media.istockphoto.com/id/1390000431/photo/shot-of-a-mature-doctor-using-a-digital-tablet-in-a-modern-hospital.jpg?s=612x612&w=0&k=20&c=ofnikeDwvLhhEvLpSuQME5kWclGchqUKSHQFdQ4mcWo=',
      'rating': 4.5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A78FF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 40, 24, 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Hi Faris!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          'Find your Doctor',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 33,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/Donex Fiance.webp',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: 'Search....',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 8),
                          child: Icon(Icons.search,
                              color: Colors.grey.withOpacity(0.7), size: 22),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 55, left: 34, right: 34),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text(
                          'Top rated Doctors',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(TopRatedDoctors());
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'See All>',
                            style: TextStyle(
                              color: Color(0xFF4A78FF),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                     ),
                     SizedBox(height: 30),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 160,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.85,
                      ),
                      items: doctors.map((doctor) {
                        return DoctorCard(
                          name: doctor['name'],
                          specialty: doctor['specialty'],
                          imageUrl: doctor['imageUrl'],
                          rating: doctor['rating'],
                          backgroundImageUrl:
                              'https://media.istockphoto.com/id/1387688781/vector/modern-layer-blue-colorful-abstract-design-background.jpg?s=612x612&w=0&k=20&c=wAKGTuxGlV3ZUAMVKXUpA_Lai89TZkYa059ubw5s-8U=',
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Category's",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),

                              TextButton(
                                onPressed: () async {
                                  Get.to(()=>CategoryPage());
                                
                                }, 
                                style: TextButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text(
                                  'See All>',
                                  style: TextStyle(
                                    color: Color(0xFF4A78FF),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                           SizedBox(height: 30),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: categoryTitles.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                            ),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: categoryColors[
                                      index % categoryColors.length],
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      categorysImages[index],
                                      height: 40,
                                      width: 40,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      categoryTitles[index],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                        color: categoryTextColors[
                                            index % categoryTextColors.length],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
