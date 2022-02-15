class Token {
  Token({
    required this.access_token,
    required this.token_type,
    required this.refresh_token,
    required this.expires_in,
  });

  String access_token;
  String token_type;
  String refresh_token;
  num expires_in;

  factory Token.fromJson(dynamic json) => Token(
        access_token: json.access_token,
        token_type: json.token_type,
        refresh_token: json.refresh_tokens,
        expires_in: json.expires_in,
      );
}
