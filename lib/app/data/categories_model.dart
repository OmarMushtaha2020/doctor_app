class CategoriesModel{
  dynamic nameCategories;
  dynamic detailsCategories;
  String? imageCategories;

  String ?id;
  bool ?like;
  String? idOfPatients;
  String? idOfMyCategories;
  dynamic tokenOfDoctor;

  CategoriesModel(this.nameCategories,this.detailsCategories,this.imageCategories,this.like,this.tokenOfDoctor,{this.id,this.idOfPatients,this.idOfMyCategories});
  CategoriesModel.fromJson(Map<String,dynamic>json){
    nameCategories=json['nameCategories'];
    detailsCategories=json['detailsCategories'];
    imageCategories=json['imageCategories'];
    like=json['like'];
    id=json['id'];
    idOfPatients=json['idOfPatients'];
    idOfMyCategories=json['idOfMyCategories'];
    tokenOfDoctor=json['tokenOfDoctor'];
  }
  Map<String, dynamic> toMap() {
    return {
      'nameCategories': nameCategories,
      'detailsCategories': detailsCategories,
      'imageCategories': imageCategories,
      'like':like,
      'id':id,
'idOfPatients':idOfPatients,
      'idOfMyCategories':idOfMyCategories,
      'tokenOfDoctor':tokenOfDoctor,
    };
  }

}