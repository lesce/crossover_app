class HomeController < ApplicationController
  def index
  end

  def test
    render :test, layout: 'test'
  end
end
