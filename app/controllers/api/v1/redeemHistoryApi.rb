module API
  module V1
    class RedeemHistoryApi < Grape::API
      prefix :api
      version :v1
      format :json

      resources :redeemHistory do
        params do
          requires :deviceId,type: String, allow_blank: false
          requires :securityToken,type: String, allow_blank: false
          requires :versionName,type: String, allow_blank: false
          requires :versionCode,type: String, allow_blank: false
          requires :userId, type: String, allow_blank: false
        end

        post do
          begin
            @user = UserDetail.find_by(id:params[:userId],securityToken:params[:securityToken])
            if @user.present?
              @redeems = @user.redeem_histories.select(:id,:title,:subtitle,:coins)
              {status:200,message:"Success",coins: @user.wallet_balance.to_s,conversion:"100 Coins = ₹ 10",withdrawlLimit:"100",redeemHistory: @redeems || []}
            else
            {status:500,message:"No User Found"}
            end
          rescue Exception => e
            {status:500,message:"Internal Server Error",error:e}
          end

        end

      end

    end
  end
end