class Admin::SheltersController < ApplicationController
  def index
    @sorted_shelters = Shelter.reverse_alpha
    @pending_shelters = Shelter.filter_status('Pending')
  end
end