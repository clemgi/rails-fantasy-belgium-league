class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @background = ['old_trafford.jpg', 'stadium.jpg', 'stadium2.jpg'].sample
  end
end
