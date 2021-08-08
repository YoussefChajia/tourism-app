import 'package:flutter/material.dart';
import 'package:flutter_travel_concept/screens/details.dart';
import 'package:flutter_travel_concept/util/places.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<UserDetails> _searchResult = [];
  List<UserDetails> _userDetails = [];
  TextEditingController controller = new TextEditingController();
  final TextEditingController _searchControl = new TextEditingController();

  Widget _buildUsersList() {
    return new ListView.builder(
      itemCount: _userDetails.length,
      itemBuilder: (context, index) {
        return new Card(
          child: new ListTile(
            leading: new CircleAvatar(
              backgroundImage: new NetworkImage(
                _userDetails[index].image,
              ),
            ),
            title: new Text(_userDetails[index].name + ' ' + _userDetails[index].city),
          ),
          margin: const EdgeInsets.all(0.0),
        );
      },
    );
  }

  Widget _buildSearchResults() {
    return new ListView.builder(
      itemCount: _searchResult.length,
      itemBuilder: (context, i) {
        return new Card(
          child: new ListTile(
            leading: new CircleAvatar(
              backgroundImage: new NetworkImage(
                _searchResult[i].image,
              ),
            ),
            title: new Text(_searchResult[i].name + ' ' + _searchResult[i].city),
          ),
          margin: const EdgeInsets.all(0.0),
        );
      },
    );
  }

  Widget _buildSearchBox() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            child: TextField(
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.blueGrey[300],
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: "Rechercher",
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.blueGrey[300],
                ),
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  color: Colors.blueGrey[300],
                ),
              ),
              maxLines: 1,
              controller: _searchControl,
              onChanged: onSearchTextChanged,
            ),
          ),
        ),
        SizedBox(height: 7),
        Padding(
          padding: EdgeInsets.all(20),
          child: ListView.builder(
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: places == null ? 0 : places.length,
            itemBuilder: (BuildContext context, int index) {
              Map place = places[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: InkWell(
                  child: Container(
                    height: 70,
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            "${place["img"]}",
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 15),
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width - 130,
                          child: ListView(
                            primary: false,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${place["name"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                  maxLines: 2,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(height: 3),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.location_on,
                                    size: 13,
                                    color: Colors.blueGrey[300],
                                  ),
                                  SizedBox(width: 3),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${place["location"]}",
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return Details();
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return new Column(
      children: <Widget>[
        new Container(color: Theme.of(context).primaryColor, child: _buildSearchBox()),
        new Expanded(
            child: _searchResult.length != 0 || controller.text.isNotEmpty
                ? _buildSearchResults()
                : _buildUsersList()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Accueil'),
        elevation: 0.0,
      ),
      body: _buildBody(),
      resizeToAvoidBottomInset: true,
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((userDetail) {
      if (userDetail.name.contains(text) || userDetail.city.contains(text))
        _searchResult.add(userDetail);
    });

    setState(() {});
  }
}

class UserDetails {
  final String name, image, city;

  UserDetails({this.name, this.image, this.city});
}
