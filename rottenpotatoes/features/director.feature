Feature: search for movies by director

  As a movie buff
  So that I can find movies with my favorite director
  I want to include and serach on director information in movies I enter

Background: movies in database

  Given the following movies exist:
  | title                   | rating | director     | release_date |
  | Star Wars               | PG     | George Lucas |   1977-05-25 |
  | Blade Runner            | PG     | Ridley Scott |   1982-06-25 |
  | Alien                   | R      |              |   1979-05-25 |
  | THX-1138                | R      | George Lucas |   1971-03-11 |
  | Aladdin                 | G      |              | 25-Nov-1992  |
  | The Terminator          | R      |              | 26-Oct-1984  |
  | When Harry Met Sally    | R      |              | 21-Jul-1989  |
  | The Help                | PG-13  |              | 10-Aug-2011  |
  | Chocolat                | PG-13  |              | 5-Jan-2001   |
  | Amelie                  | R      |              | 25-Apr-2001  |
  | 2001: A Space Odyssey   | G      |              | 6-Apr-1968   |
  | The Incredibles         | PG     |              | 5-Nov-2004   |
  | Raiders of the Lost Ark | PG     |              | 12-Jun-1981  |
  | Chicken Run             | G      |              | 21-Jun-2000  |

Scenario: add director to existing movie
  When I go to the edit page for "Alien"
  And  I fill in "Director" with "Ridley Scott"
  And  I press "Update Movie Info"
  Then the director of "Alien" should be "Ridley Scott"

Scenario: find movie with same director
  Given I am on the details page for "Star Wars"
  When  I follow "Find Movies With Same Director"
  Then  I should be on the Similar Movies page for "Star Wars"
  And   I should see "THX-1138"
  But   I should not see "Blade Runner"

Scenario: can't find similar movies if we don't know director (sad path)
  Given I am on the details page for "Alien"
  Then  I should not see "Ridley Scott"
  When  I follow "Find Movies With Same Director"
  Then  I should be on the home page
  And   I should see "'Alien' has no director info"

Scenario: delete a movie
  Given I am on the details page for "Alien"
  Then  I press "Delete"
  Then  I should see "Movie 'Alien' deleted."
  
Scenario: add a movie
  Given I am on the homepage
  Then  I follow "Add new movie"
  And   I fill in "Rambo" for "movie_title"  
  And   I press "Save Changes" 
  Then  I should see "Rambo was successfully created."
  
Scenario: sort movies alphabetically
  Given I am on the homepage
  When I follow "Movie Title"
 Then I should see "Aladdin" before "Amelie"
 And I should see "Chicken Run" before "Raiders of the Lost Ark"

Scenario: sort movies in increasing order of release date
  Given I am on the homepage
  When I follow "Release Date"
  # your steps here
 Then I should see "Aladdin" before "Amelie"
 And I should see "2001: A Space Odyssey" before "Aladdin"
