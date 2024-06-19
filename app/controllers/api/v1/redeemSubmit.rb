module API
  module V1
    class RedeemSubmit < Grape::API
      prefix :api
      version :v1
      format :json

      resources :redeemSubmit do
        Rails.logger.info"API Params:#{params.inspect}"
        params do
          requires :userId, type: String, allow_blank: false
          requires :securityToken, type: String, allow_blank: false
          requires :versionName, type: String, allow_blank: false
          requires :versionCode, type: String, allow_blank: false
          requires :payId, type: String, allow_blank: false
          requires :mobileNumber, type: String, allow_blank: false
          requires :payCoins, type: String, allow_blank: false
          requires :payAmt, type: String, allow_blank: false
          requires :payType, type: String, allow_blank: false
        end
        post do
          begin
            # if params[:userId] == "2"
              # @user = UserDetail.find_by(id:"2",securityToken: params[:securityToken])
            # else
              @user = UserDetail.find_by(id:params[:userId])
            # end
            if @user
              @coins = params[:payCoins].to_i
              if @coins > @user.wallet_balance
                {status:500,message:"Insufficient Balance"}
              else
                @remaining_balance = @user.wallet_balance.to_i - @coins
                @user.update(wallet_balance: @remaining_balance)
                @user.redeems.create(
                  payCoins: params[:payCoins],
                  payAmount: params[:payAmt],
                  payType: params[:payType],
                  mobileNumber: params[:mobileNumber],
                  versionName: params[:versionName],
                  versionCode: params[:versionCode],
                  payId: params[:payId]
                )
                @user.transaction_histories.create(
                  title: "Withdrawal",
                  subtitle: DateTime.now.strftime("%d/%m/%y %I:%M %p"),
                  coins: @user.wallet_balance
                )
                {status:200,message:"Success",coins: @user.wallet_balance}
              end
            else
              {status:500,message:"User Not Found"}
            end
          rescue Exception => e
            {status:500,message:"Internal Server Error",error:e}
          end
        end

      end

    end
  end
end
