# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
  # fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  # Movie.count.should be n_seeds.to_i
  expect(Movie.count).to eq n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  # fail "Unimplemented"
  e1_str = page.body.index(e1)
  e2_str = page.body.index(e2)
  expect(e1_str).to be < e2_str
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  split_rating_list = rating_list.split(', ');
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  split_rating_list.each do |check_each_rating|
    if uncheck
      uncheck("ratings["+check_each_rating+"]")
    else 
      check("ratings["+check_each_rating+"]")
    end
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  # step "10 seed movies should exist" #as we impelemented before
  # or to use expect(rows).to eq value
  expect(Movie.count).to eq page.all('table#movies tbody tr').length
  # fail "Unimplemented"
end
