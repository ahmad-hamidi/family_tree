class FamilyModel {
  String? name,
      gender,
      placeBirth,
      dateBirth,
      phoneNumber,
      bloodGroup,
      lastEducation,
      statusLife,
      avatar;

  int? id, parentId, childId;

  FamilyModel(
      {this.id,
      this.parentId,
      this.childId,
      this.name,
      this.gender,
      this.placeBirth,
      this.dateBirth,
      this.phoneNumber,
      this.bloodGroup,
      this.lastEducation,
      this.statusLife,
      this.avatar});

  factory FamilyModel.mapping(Map<String, dynamic> data) {
    return FamilyModel(
      id: data['id'],
      parentId: data['parent_id'],
      childId: data['child_id'],
      name: data['name'],
      gender: data['gender'],
      placeBirth: data['place_birth'],
      dateBirth: data['date_birth'],
      phoneNumber: data['phone_number'],
      bloodGroup: data['blood_group'],
      lastEducation: data['last_education'],
      statusLife: data['status_life'],
      avatar: data['avatar'],
    );
  }
}
