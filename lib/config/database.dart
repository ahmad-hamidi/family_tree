class Database {

  static String familyTable = "family";

  static Map<String, dynamic> paramMinus1 = {
    "id": -1,
    "name": "John Doe",
    "gender": "Male",
    "place_birth": "-",
    "date_birth": "-",
    "phone_number": "-",
    "blood_group": "-",
    "last_education": "-",
    "status_life": "Life",
    "avatar": null,
    "parent_id": null,
    "child_id": null,
  };

  static Map<String, dynamic> paramMinus2 = {
    "id": -2,
    "name": "Valentine",
    "gender": "Female",
    "place_birth": "-",
    "date_birth": "-",
    "phone_number": "-",
    "blood_group": "-",
    "last_education": "-",
    "status_life": "Life",
    "avatar": null,
    "parent_id": null,
    "child_id": null,
  };

  static Map<String, dynamic> param1 = {
    "id": 1,
    "name": "Jonas",
    "gender": "Female",
    "place_birth": "-",
    "date_birth": "-",
    "phone_number": "-",
    "blood_group": "-",
    "last_education": "-",
    "status_life": "Life",
    "avatar": null,
    "parent_id": null,
    "child_id": null,
  };

  static Map<String, dynamic> param2 = {
    "id": 2,
    "name": "Joni",
    "gender": "Male",
    "place_birth": "-",
    "date_birth": "-",
    "phone_number": "-",
    "blood_group": "-",
    "last_education": "-",
    "status_life": "Life",
    "avatar": null,
    "parent_id": null,
    "child_id": null,
  };


  static List<Map<String, dynamic>> families = [paramMinus1, paramMinus2, param1, param2];
}