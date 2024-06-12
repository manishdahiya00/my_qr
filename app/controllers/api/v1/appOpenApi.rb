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
          requires :userId, type: String, allow_blank: true

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
            @user = UserDetail.find_by(securityToken:params[:securityToken])
            if @user
              @app = AppOpen.find_by(securityToken: params[:securityToken])
              @new_app_open = @app.update(
                socialName: @user.socialName || "USER",
                socialEmail: @user.socialEmail,
                socialImgUrl:@user.socialImgUrl
              )
              { status: 200, message: "Success", socialName: @app.socialName, socialEmail: @app.socialEmail,socialImgUrl: @app.socialImgUrl,appUrl:@app.app_url || "https://play.google.com/store/apps/details?id=com.apps.scanbuddy",forceUpdate:@app.forceUpdate}
            else
            { status: 200, message: "No User Found", socialName: "" ,socialEmail: "",socialImgUrl: "",appUrl: "",forceUpdate:@app_open.forceUpdate}
            end
          rescue => e
            { message: "Error", status: 500, error: e }
          end
        end
      end
    end
  end
end
