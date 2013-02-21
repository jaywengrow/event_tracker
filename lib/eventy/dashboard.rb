require 'sinatra/base'
require 'eventy'
require 'eventy/dashboard/helpers'

module Eventy
  class Dashboard < Sinatra::Base
    dir = File.dirname(File.expand_path(__FILE__))

    set :views,  "#{dir}/dashboard/views"
    set :public_folder, "#{dir}/dashboard/public"
    set :static, true
    set :method_override, true

    helpers Eventy::DashboardHelpers

    get '/' do
      @events = Eventy::Event.all
      erb :index
    end

    # post '/:experiment' do
    #   @experiment = Split::Experiment.find(params[:experiment])
    #   @alternative = Split::Alternative.new(params[:alternative], params[:experiment])
    #   @experiment.winner = @alternative.name
    #   redirect url('/')
    # end

    # post '/reset/:experiment' do
    #   @experiment = Split::Experiment.find(params[:experiment])
    #   @experiment.reset
    #   redirect url('/')
    # end

    delete '/:event' do
      @event = Eventy::Event.find(params[:event])
      @event.delete
      redirect url('/')
    end
  end
end