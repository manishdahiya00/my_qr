module API
  module V1
    class AppOpenApi < Grape::API
      format :json
      prefix :api
      version :v1

      resources :appOpen do
        desc "App Open API"
        params do
          requires :deviceId, type: String, allow_blank: false
          requires :versionName, type: String, allow_blank: false
          requires :versionCode, type: String, allow_blank: false
          requires :securityToken, type: String, allow_blank: false
          optional :appUrl, type: String, allow_blank: false, default: ""
          optional :socialName, type: String, allow_blank: false, default: ""
          optional :socialEmail, type: String, allow_blank: false, default: ""
          optional :socialImgUrl, type: String, allow_blank: false, default: ""
          optional :forceUpdate, type: String, allow_blank: false, default: ""
        end

        post do
          begin
            @app_open = AppOpen.find_by(securityToken: params[:securityToken])
            unless @app_open.present?
              @app_open = AppOpen.create(
                deviceId: params[:deviceId],
                versionName: params[:versionName],
                versionCode: params[:versionCode],
                securityToken: params[:securityToken]
              )
              { status: 200, message: "Success",socialName: @app_open.socialName, socialEmail: @app_open.socialEmail,socialImgUrl: @app_open.socialImgUrl,appUrl:@app_open.app_url,forceUpdate:@app_open.forceUpdate }
            end
            { status: 200, message: "Success", socialName: @app_open.socialName, socialEmail: @app_open.socialEmail,socialImgUrl: @app_open.socialImgUrl,appUrl:@app_open.app_url,forceUpdate:@app_open.forceUpdate}
          rescue => e
            { message: "Error", status: 500, error: e }
          end
        end
      end
    end
  end
end
