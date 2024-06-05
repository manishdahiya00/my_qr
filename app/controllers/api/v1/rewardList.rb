module API
  module V1
    class RewardList < Grape::API
      prefix :api
      version :v1
      format :json

      resources :rewardList do
        params do
          requires :deviceId,type:String,allow_blank: false
          requires :securityToken,type:String,allow_blank: false
          requires :versionName,type:String,allow_blank: false
          requires :versionCode,type:String,allow_blank: false
          requires :userId, type: String, allow_blank: false
        end
        post do
          begin
            if params[:userId] == "2"
              @deviceDetail = DeviceDetail.find_by(deviceId: "12345678",security_token: params[:securityToken])
              @user = UserDetail.find_by(id:"3")
            else
              @deviceDetail = DeviceDetail.find_by(deviceId: params[:deviceId],security_token: params[:securityToken])
              @user = UserDetail.find_by(id:params[:userId])
            end
            @payment_methods = [
              {
                id:"1",
                name:"Paytm",
                category:"Cashback",
                icon: "https://img.icons8.com/?size=256&id=68067&format=png",
                payoutValues: ["500","1000","2000"],
                payoutRewards: ["5000","10000","20000"],
              },
              {
                id:"2",
                name:"PayPal",
                category:"Cashback",
                icon: "https://img.icons8.com/?size=256&id=13611&format=png",
                payoutValues: ["200","800","900"],
                payoutRewards: ["2000","8000","9000"],
              },
              {
                id:"3",
                name:"PUBG",
                category:"Game",
                icon: "https://img.icons8.com/?size=256&id=73814&format=png",
                payoutValues: ["400","1500","3000"],
                payoutRewards: ["4000","15000","30000"],
              }
            ]
            {status:200,message:"Success",coins: @user.wallet_balance.to_s,conversion:(@user.wallet_balance / 10.to_f).to_s,conversionAmt:(@user.wallet_balance/10.to_f).to_f,withdrawlLimit:"500",paytmMethods: @payment_methods}
          rescue Exception => e
            {status:500,message:"Internal Server Error",error:e}
          end
        end
      end

    end
  end
end
