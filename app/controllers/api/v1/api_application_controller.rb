module Api
  module V1
    class ApiApplicationController < ApplicationController
      skip_before_filter :authenticate_user!
      skip_before_filter :authenticate_user_from_token!
    end
  end
end
