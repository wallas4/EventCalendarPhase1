class HomePageController < ApplicationController
  def index
     @events = Event.all
     @date = params[:month] ? Date.parse(params[:month]) : Date.today

  end
end
