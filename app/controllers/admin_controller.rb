class AdminController < ApplicationController
    def index
        @applications = Application.all
    end
end