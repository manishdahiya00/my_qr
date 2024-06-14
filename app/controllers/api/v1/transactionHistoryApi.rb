module API
  module V1
    class TransactionHistoryApi < Grape::API
      prefix :api
      version :v1
      format :json

      resources :transactionHistory do
        Rails.logger.info"API Params:#{params.inspect}"
        params do
          requires :deviceId,type: String, allow_blank: false
          requires :securityToken,type: String, allow_blank: false
          requires :versionName,type: String, allow_blank: false
          requires :versionCode,type: String, allow_blank: false
          requires :userId, type: String, allow_blank: false
        end

        post do
          begin
            @user = UserDetail.find_by(id:params[:userId])
            if @user.present?
              @transactios = @user.transaction_histories.select(:id,:title,:subtitle,:coins).order("created_at DESC")
              {status:200,message:"Success",coins: @user.wallet_balance.to_s,conversion: (@user.wallet_balance / 10.to_f).to_s,withdrawlLimit:"500",transactionHistory: @transactios || []}
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
