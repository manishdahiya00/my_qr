module API
  module V1
    class HistoryApi < Grape::API
      prefix :api
      version :v1
      format :json

      resources :history do
        desc "Full History Api"
        params do

          requires :deviceId,type: String, allow_blank: false
          requires :securityToken,type: String, allow_blank: false
          requires :versionName,type: String, allow_blank: false
          requires :versionCode,type: String, allow_blank: false
          requires :userId, type: String, allow_blank: true

        end
        post do
          begin
            if params[:userId] == "2"
              @deviceDetail = DeviceDetail.find_by(deviceId: "12345678",security_token: params[:securityToken])
              @generated = RecentlyAdded.where(device_detail_id: @deviceDetail.id.to_s,qrType: "Generated").select(:id,:title,:subtitle)
              @scanned = RecentlyAdded.where(device_detail_id: @deviceDetail.id.to_s,qrType: "Scanned").select(:id,:title,:subtitle)
              @favourite = Favourite.where(device_detail_id: @deviceDetail.id.to_s)
              @favourites = RecentlyAdded.where(id: @favourite.ids).select(:id,:title,:subtitle)
            else
              @device_details = DeviceDetail.find_by(deviceId: params[:deviceId],security_token: params[:securityToken])
              @generated = RecentlyAdded.where(device_detail_id: @device_details.id,qrType: "Generated").select(:id,:title,:subtitle)
              @scanned = RecentlyAdded.where(device_detail_id: @device_details.id,qrType: "Scanned").select(:id,:title,:subtitle)
              @favourite = Favourite.where(device_detail_id: @device_details.id)
              @favourites = RecentlyAdded.where(id: @favourite.ids).select(:id,:title,:subtitle)
            end

            @user = UserDetail.find_by(id:params[:userId])
            if @user.present?
              @userCoins = @user.wallet_balance.to_s
            else
              @userCoins = "0"
            end
            {status: 200,message:"Success",generated: @generated,scanned: @scanned,favourite: @favourites,userCoins: @userCoins }
          end
          rescue Exception => e
            {status:500,message:"Internal Server Error",error:e}
        end
      end

    end
  end
end
