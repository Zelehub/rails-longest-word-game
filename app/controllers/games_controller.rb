require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
    @array = ("A".."Z").to_a
    @letters = []
    10.times do
      @letters << @array.sample
    end
  end

  def score
    @parame = params[:userInput]
    @url = "https://dictionary.lewagon.com/#{@parame}"
    @uri_parse = URI.parse(@url).read
    @json_parse = JSON.parse(@uri_parse)
    @grid = params[:grid]
    @tally_letters = @grid.chars.tally
    @parame_tally = @parame.upcase.chars.tally
    @tally_result = @parame_tally.all? { |word, tally| @tally_letters[word].to_i >= tally }
    if @json_parse["found"]
      if @tally_result
        @response = "Congratulations! #{@parame} is a valid English word!"
      else
        @response = "Sorry but #{@parame} can't be build out of #{@grid}"
      end
    else
      @response = "Sorry but #{@parame} does not seem to be a valid English word..."
    end
  end
end
