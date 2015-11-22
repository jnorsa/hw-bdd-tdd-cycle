class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.similar_Director(movieID)
    return (Movie.find(movieID).director == nil || Movie.find(movieID).director == "")? Array.new() : Movie.where(director: Movie.find(movieID).director)
  end
end
