#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'json'
require 'fireeagle'

post '/' do
  req = JSON.parse(request.body.string)
  puts req.inspect

  config = {
    :consumer_key => "<consumer key>",
    :consumer_secret => "<consumer secret>",
    :access_token => "<access token>",
    :access_token_secret => "<access token secret>"
  }
  client = FireEagle::Client.new(config)
  loc = client.user.best_guess
  postal_code = client.user.locations.select {|l| l.level_name == "postal"}.first.name
  city = client.user.locations.select {|l| l.level_name == "city"}.first.name
  county = client.user.locations.select {|l| l.level_name == "region"}.first.name
  region = client.user.locations.select {|l| l.level_name == "state"}.first.name
  country = client.user.locations.select {|l| l.level_name == "country"}.first.name

  location = {
    :location => {
      :latitude => loc.geom.y,
      :longitude => loc.geom.x,
      :horizontal_accuracy => 0,
      :address => {
        :postal_code => postal_code,
        :city => city,
        :county => county,
        :region => region,
        :country => country
      }
    }
  }
  puts "Location: #{location.to_json}"

  content_type 'application/json'
  status 200
  body location.to_json
end

