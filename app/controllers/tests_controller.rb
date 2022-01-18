class TestsController < ApplicationController
  def index
    params.permit!
  end
end
