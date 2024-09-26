module API
  module V1
    class DefaultUser < Grape::API
      prefix :api
      version :v1
      format :json

      resources :defaultUser do
        #Rails.logger.info"API Params:#{params.inspect}"
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
              @default_user.update(wallet_balance: "5")
              @default_user.transaction_histories.create(
                title:"Signup Bonus",
                subtitle:DateTime.now.strftime("%d/%m/%Y"),
                coins:"5"
            )
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
