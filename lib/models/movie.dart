class Movie{
  final String title;
  final String trailerUrl;
  final String posterUrl;

  Movie({
    this.title,
    this.trailerUrl,
    this.posterUrl,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'],
      trailerUrl: map['trailerUrl'],
      posterUrl: map['posterUrl'],
    );
  }

}