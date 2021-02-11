require "csv"

Page.delete_all
Movie.delete_all
ProductionCompany.delete_all

Page.create(
  title:     "About Us",
  content:   "This is all about the creators!  ME specifically.. im cool.. please think im cool.",
  permalink: "about_us"
)

Page.create(
  title:     "Information about our data",
  content:   "We stole... umm.. borrowed the data from Kaggle.. which sounds like KRAGGLE!!",
  permalink: "data_info"
)

# Rails.root...  ./db/top_movies.csv
filename = Rails.root.join("db/top_movies.csv")

puts "Importing CSV data from: #{filename}"

csv_data = File.read(filename)
movies = CSV.parse(csv_data, headers: true, encoding: "utf-8")

movies.each do |m|
  production_company = ProductionCompany.find_or_create_by(name: m["production_company"])

  if production_company && production_company.valid?
    # puts "Movie Title: #{m['original_title']}"
    # create a movie based on the production company!
    movie = production_company.movies.create(
      title:        m["original_title"],
      year:         m["year"],
      duration:     m["duration"],
      description:  m["description"],
      average_vote: m["avg_vote"]
    )

    puts "Invalid movie #{m['original_title']}" unless movie&.valid?
  else
    puts "Invalid Production Company: #{m['production_company']} for movie #{m['original_title']}"
  end
end

puts "Created #{ProductionCompany.count} Production Companies."
puts "Created #{Movie.count} Movies."
puts "Created #{Page.count} Pages."
