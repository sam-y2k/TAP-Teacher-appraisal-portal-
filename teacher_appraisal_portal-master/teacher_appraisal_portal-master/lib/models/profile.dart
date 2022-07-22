class Profile {
  String? name,
      additionalQualif,
      department,
      email,
      firstDesig,
      higherStudies,
      joiningDate,
      presentDesig,
      presentPay,
      qualif,
      specialization;
  Profile(
      this.email,
      this.name,
      this.additionalQualif,
      this.department,
      this.firstDesig,
      this.higherStudies,
      this.joiningDate,
      this.presentDesig,
      this.presentPay,
      this.qualif,
      this.specialization);

  Profile.fromMap(Map<String, dynamic>? map) {
    additionalQualif = map?['additionalQualif'];
    name = map?['name'];
    department = map?['department'];
    email = map?['email'];
    firstDesig = map?['firstDesig'];
    higherStudies = map?['higherStudies'];
    joiningDate = map?['joiningDate'];
    presentDesig = map?['presentDesig'];
    presentPay = map?['presentPay'];
    qualif = map?['qualif'];
    specialization = map?['specialization'];
  }

  Map<String, dynamic>? toMap() {
    return {
      'additionalQualif': additionalQualif,
      'name': name,
      'department': department,
      'email': email,
      'firstDesig': firstDesig,
      'higherStudies': higherStudies,
      'joiningDate': joiningDate,
      'presentDesig': presentDesig,
      'presentPay': presentPay,
      'qualif': qualif,
      'specialization': specialization,
    };
  }
}
