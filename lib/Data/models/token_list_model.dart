class TokenModel {
  final String name;
  final String symbol;
  final String address;
  final String logoURI;

  TokenModel( this.name, this.symbol, this.address, this.logoURI);

  TokenModel.fromJson(Map<String, dynamic> json) :
        name = json['name'],
        symbol = json['symbol'],
        address = json['address'],
        logoURI = json['logoURI'];

  Map<String, dynamic> toJson() => {
    'name' : name,
    'Symbol' : symbol,
    'address' : address,
    'logoURI' : logoURI,
  };
}