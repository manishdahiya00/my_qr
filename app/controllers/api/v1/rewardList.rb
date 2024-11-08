module API
  module V1
    class RewardList < Grape::API
      prefix :api
      version :v1
      format :json

      resources :rewardList do
        #Rails.logger.info"API Params:#{params.inspect}"
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
                name:"UPIPay",
                category:"Cashback",
                #icon: "https://img.icons8.com/?size=256&id=68067&format=png",
                icon: "https://play-lh.googleusercontent.com/kvMSUs3kp3QX265zCfYBR6n5oPyTeoJtPY9aPLyJmzltDPmVVS7GViuqYct63fbPVPB1=w256-h256-rw",
                payoutValues: ['50','100','250','500','750','1000'],
                payoutRewards: ["5000","10000","25000","50000","75000","100000"],
              },
              {
                id:"2",
                name:"PUBG",
                category:"Game",
                icon: "https://img.icons8.com/?size=256&id=73814&format=png",
                payoutValues: ['60','325','660','1800','3850','8100'],
                payoutRewards: ['7500','3800','7500','19000','380000','750000'],
              },
              {
                id:"3",
                name:"PayPal",
                category:"Cashback",
                icon: "https://img.icons8.com/?size=256&id=13611&format=png",
                payoutValues: ["200","400","600","800","1000"],
                payoutRewards: ["20000","40000","60000","80000","100000"],
              },
              {
                id:"3",
                name:"Freefire",
                category:"Cashback",
                icon: "https://img.icons8.com/color/256/free-fire.png",
                payoutValues: ['90','175','438','580','874'],
                payoutRewards: ['10000',"21000",'51000','64500','108000'],
              }
            ]
            {status:200,message:"Success",coins: @user.wallet_balance.to_s, conversion:(@user.wallet_balance / 100.to_f).to_s,
              conversionAmt:(@user.wallet_balance/100.to_f).to_f, withdrawlLimit:"500", paytmMethods: @payment_methods}
          rescue Exception => e
            {status:500,message:"Internal Server Error",error:e}
          end
        end
      end

    end
  end
end
