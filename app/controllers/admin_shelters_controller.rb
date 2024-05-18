class AdminSheltersController < ApplicationsController
  def index
# pry
    @shelters = Shelter.order_by_reverse_alpha_sql
  end
end