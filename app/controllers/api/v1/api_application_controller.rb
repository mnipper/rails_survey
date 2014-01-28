module Api
  module V1
    class ApiApplicationController < ApplicationController
      before_filter :restrict_access
      before_filter :check_version_code
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

      private
        def restrict_access
          unless current_user
            api_key = ApiKey.find_by_access_token(params[:access_token])
            head :unauthorized unless api_key
          end
        end

        def check_version_code
          if params[:version_code]
            head :upgrade_required unless params[:version_code].to_i >= Settings.minimum_android_version_code
          end
        end
    end
  end
end
