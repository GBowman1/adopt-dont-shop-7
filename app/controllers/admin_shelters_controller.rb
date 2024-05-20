class AdminSheltersController < ApplicationsController
  def index
# pry
    @shelters = Shelter.order_by_reverse_alpha_sql
    @shelters_pending_app = Shelter.with_pending_app
    # pry
  end
end