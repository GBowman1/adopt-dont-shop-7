class AdminSheltersController < ApplicationsController
  def index
    @shelters = Shelter.order_by_reverse_alpha_sql
    @shelters_pending_app = Shelter.with_pending_app
  end
end