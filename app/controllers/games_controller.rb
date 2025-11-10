require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    alphabet = ("A".."Z").to_a
    10.times do
      @letters << alphabet.sample
    end
    session[:total_score] ||= 0
  end

  def score
    @letters = params[:letters].split
    answer = params[:answer]
    url = "https://dictionary.lewagon.com/#{answer}"
    response_serialized = URI.parse(url).read
    response_json = JSON.parse(response_serialized)
    english_word = response_json["found"] # true or false
    checking_letters = @letters.dup
    can_be_build = answer.upcase.chars.all? do |letter|
      i = checking_letters.index(letter)
      if i
        checking_letters.delete_at(i)
      else
        false
      end
    end
    if english_word && can_be_build
      @current_game_score = answer.length * 100
      session[:total_score] ||= 0
      session[:total_score] += @current_game_score
      @message = "CONGRATULATIONS! 🎉 #{answer.upcase} is a valid English word!"
    elsif english_word == false
      @message = "Sorry but #{answer.upcase} does not seem to be a valid English word."
    else
      @message = "Sorry but #{answer.upcase} can't be built out of the given letters: #{@letters.join(' - ')}."
    end
    @total_score = session[:total_score]
  end
end
