module API
  module V1
    class AppOpenApi < Grape::API
      format :json
      prefix :api
      version :v1

      resources :appOpen do
        #Rails.logger.info"API Params:#{params.inspect}"
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
            social_links = [{id: 1, title: 'Telegram', actionUrl: 'https://t.me/mobcandyapp'},{id: 2, title: 'Whatsapp', actionUrl: 'https://whatsapp.com/channel/0029Vb3vPT60AgW39nxpC624'},
              {id: 3, title: 'Facebook', actionUrl: 'https://www.facebook.com/gamersanjuyt/'},{id: 4, title: 'YouTube', actionUrl: 'https://www.youtube.com/channel/UCLV_ZFqTH9l4zx8VFZ-Xjqw'},
              {id: 5, title: 'TwitterX', actionUrl: 'https://x.com/mobcandyapp'},{id: 6, title: 'Instagram', actionUrl: 'https://www.instagram.com/cashleyapp/'}]
            @app_open = AppOpen.find_by(securityToken: params[:securityToken])
            unless @app_open.present?
              @app_open = AppOpen.create(
                deviceId: params[:deviceId],
                versionName: params[:versionName],
                versionCode: params[:versionCode],
                securityToken: params[:securityToken]
              )
              {status: 200, message: "Success",socialName: @app_open.socialName, socialEmail: @app_open.socialEmail,socialImgUrl: @app_open.socialImgUrl,
                appUrl:@app_open.app_url,forceUpdate:@app_open.forceUpdate,socialLinks: social_links}
            end            
            if params[:userId] == ""
               {status: 200, message: "No User Found", socialName: "" ,socialEmail: "",socialImgUrl: "",appUrl: "",
                forceUpdate:@app_open.forceUpdate,socialLinks: social_links}
            else
              @user = UserDetail.find_by(securityToken:params[:securityToken])
              if @user
                @app = AppOpen.find_by(securityToken: params[:securityToken])
                @new_app_open = @app.update(
                  socialName: @user.socialName || "USER",
                  socialEmail: @user.socialEmail,
                  socialImgUrl:@user.socialImgUrl
                )              
                {status: 200, message: "Success",socialName: @app.socialName, socialEmail: @app.socialEmail,socialImgUrl: @app.socialImgUrl, socialLinks: social_links,
                 appUrl:@app.app_url || "https://play.google.com/store/apps/details?id=com.apps.scanbuddy", forceUpdate:@app.forceUpdate}
              else
                {status: 200, message: "No User Found", socialName: "" ,socialEmail: "",socialImgUrl: "", appUrl: "",forceUpdate:@app_open.forceUpdate,socialLinks: social_links}
              end
            end
          rescue => e
            { message: "Error", status: 500, error: e }
          end
        end
      end
    end
  end
end
