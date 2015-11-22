# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    movieTest = Movie.find_or_initialize_by(title: movie[title])
    movieTest.update_attributes!(movie)
    result = movieTest.save!
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  table = page.all("table tr")
  e1_presence = false
  e2_presence = false
  table.each do |line|
    #debugger
    if (line.text.include? e1) then e1_presence = true end
    if (line.text.include? e2) && !e1_presence then fail "#{e2} appears first" else e2_presence = true end
  end
  if !e1_presence then fail "#{e1} not present" end
  if !e2_presence then fail "#{e2} not present" end
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  #fail "Unimplemented"
  ratings = rating_list.split(",")
  ratings.each do |rating|
    if uncheck == nil then step "I check \"ratings_#{rating.strip()}\"" else step "I uncheck \"ratings_#{rating.strip()}\"" end
  end
end

Then /I should see all the movies/ do
  movies_db = Movie.count()
  movies_page = page.all("table tr").count - 1
  # Make sure that all the movies in the app are visible in the table
  if (movies_db != movies_page) then fail "error nb movies displayed" end
end

Then /^the (.*) of "(.*)" should be "(.*)"/ do |e1, e2, e3|
  case e1 
  when "director"
    if !(page.body.include? e3) then fail "Director #{e3} not found" end
  else
    raise "Field #{e1} do not exist in movie"
  end
end
