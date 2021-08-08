import 'package:flutter/material.dart';
//import 'package:flutter_travel_concept/screens/search.dart';
import 'package:flutter_travel_concept/util/places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  CameraPosition vegasPosition = CameraPosition(target: LatLng(34.024317, -6.822659), zoom: 17);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: ()=>Navigator.pop(context),
        ),

        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: (){},
          ),
        ],
      ),

      body:  ListView(
        children: <Widget>[
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(left: 20),
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              primary: false,
              itemCount: places == null ? 0 : places.length,
              itemBuilder: (BuildContext context, int index) {
                Map place = places[index];

                return Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "${place["img"]}",
                      height: 250,
                      width: MediaQuery.of(context).size.width-40,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),


          SizedBox(height: 20),

          ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${places[0]["name"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                  ),

                  IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                    ),
                    iconSize: 23.0,
                    onPressed: (){},
                  ),


                ],
              ),

              Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    size: 14,
                    color: Colors.blueGrey[300],
                  ),

                  SizedBox(width: 3),

                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${places[0]["location"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.blueGrey[300],
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40),

              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Description",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              ),

              SizedBox(height: 10),

              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${places[0]["details"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.all(0.0),
                child: InkWell(
                  child: Container(
                    height: 400.0,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: vegasPosition,
                    ),
                  ),
                  onTap: (){
                    return Map();
                  },
                ),
              ),

              SizedBox(height: 20),

            ],
          ),
        ],
      ),

/*       floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.location_on,
        ),
        onPressed: (){},
      ), */

    );
  }
}
