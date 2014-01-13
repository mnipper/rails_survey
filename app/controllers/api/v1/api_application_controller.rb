module Api
  module V1
    class ApiApplicationController < ApplicationController
      skip_before_filter :authenticate_user!
      skip_before_filter :authenticate_user_from_token!
      after_filter :set_csrf_cookie_for_ng

      def set_csrf_cookie_for_ng
        cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
      end

      protected
        def verified_request?
          super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
        end
    end
  end
end
