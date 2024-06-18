module API
  module V1
    class RewardList < Grape::API
      prefix :api
      version :v1
      format :json

      resources :rewardList do
        Rails.logger.info"API Params:#{params.inspect}"
        params do
          requires :deviceId,type:String,allow_blank: false
          requires :securityToken,type:String,allow_blank: false
          requires :versionName,type:String,allow_blank: false
          requires :versionCode,type:String,allow_blank: false
          requires :userId, type: String, allow_blank: false
        end
        post do
          begin
            # if params[:userId] == "2"
              # @user = UserDetail.find(params[:userId])
            # else
              @user = UserDetail.find(params[:userId])
            # end
            @payment_methods = [
              {
                id:"1",
                name:"Paytm",
                category:"Cashback",
                icon: "https://img.icons8.com/?size=256&id=68067&format=png",
                payoutValues: ["500","1000","2000"],
                payoutRewards: ["50000","100000","200000"],
              },
              {
                id:"2",
                name:"PayPal",
                category:"Cashback",
                icon: "https://img.icons8.com/?size=256&id=13611&format=png",
                payoutValues: ["200","800","900"],
                payoutRewards: ["20000","80000","90000"],
              },
              {
                id:"3",
                name:"PUBG",
                category:"Game",
                icon: "https://img.icons8.com/?size=256&id=73814&format=png",
                payoutValues: ["400","1500","3000"],
                payoutRewards: ["40000","150000","300000"],
              }
            ]
            {status:200,message:"Success",coins: @user.wallet_balance.to_s,conversion:(@user.wallet_balance / 100.to_f).to_s,conversionAmt:(@user.wallet_balance/100.to_f).to_f,withdrawlLimit:"500",paytmMethods: @payment_methods}
          rescue Exception => e
            {status:500,message:"Internal Server Error",error:e}
          end
        end
      end

    end
  end
end
