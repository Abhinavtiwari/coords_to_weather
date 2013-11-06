require 'open-uri'
require 'json'

class CoordsController < ApplicationController
  def fetch_weather
    @address = params[:address]
    @url_safe_address = URI.encode(@address)
    @url = "http://maps.googleapis.com/maps/api/geocode/json?address="+@url_safe_address+"&sensor=false"
    @raw_data = open(@url).read
    @parsed_data = JSON.parse(@raw_data)
    @latitude = @parsed_data["results"][0]["geometry"]["location"]["lat"].to_s
    @longitude = @parsed_data["results"][0]["geometry"]["location"]["lng"].to_s


    #@latitude = params[:latitude]
    #@longitude = params[:longitude]
    @your_api_key = "https://api.forecast.io/forecast/eea15b14f8340b68a97254a40fcbe6c2/"

    # Your code goes here.
    @url_weather = "https://api.forecast.io/forecast/eea15b14f8340b68a97254a40fcbe6c2/"+@latitude+","+@longitude
    @raw_data_weather = open(@url_weather).read
    @parsed_data_weather = JSON.parse(@raw_data_weather)
    @temperature = @parsed_data_weather["currently"]["temperature"]
    @minutely_summary = @parsed_data_weather["minutely"]["summary"]
    @hourly_summary = @parsed_data_weather["hourly"]["summary"]
    @daily_summary = @parsed_data_weather["daily"]["summary"]
  end
end
