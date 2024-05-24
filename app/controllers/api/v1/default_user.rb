module API
  module V1
    class DefaultUser < Grape::API
      prefix :api
      version :v1
      format :json

      resources :defaultUser do
        params do
          requires :versionName,type: String, allow_blank: false
          requires :versionCode,type: String, allow_blank: false
          requires :userEmail,type: String, allow_blank: false
          requires :password,type: String, allow_blank: false
        end
        post do
          begin
            if params[:userEmail] == "techmindgeeks@gmail.com" && params[:password] == "Slacker@123"
              @default_user = UserDetail.find_by(socialEmail: params[:userEmail])
              {status:200,message:"Success",userId:@default_user.id.to_s,securityToken:@default_user.securityToken}
            else
              {status:500,message:"Invalid User"}
            end
            rescue Exception => e
              {status:500,message: "Internal Server Error",error:e}
          end
        end
      end
    end
  end
end
