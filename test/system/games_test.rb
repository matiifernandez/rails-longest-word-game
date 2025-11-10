require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "The user writes a word that is NOT in the English dictionary (GATO)" do
    visit '/new'
    fill_in 'answer', with: 'gato'
    click_button 'Play'
    assert_text "Sorry but GATO does not seem to be a valid English word."
  end
end
