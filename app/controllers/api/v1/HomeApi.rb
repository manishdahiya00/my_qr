module API
  module V1
    class HomeApi < Grape::API
      prefix :api
      version :v1
      format :json

      resources :home do
        desc "Api for Home Screen"
        params do
          requires :deviceId, type: String, allow_blank: false
          requires :securityToken, type: String, allow_blank: false
          requires :versionName, type: String, allow_blank: false
          requires :versionCode, type: String, allow_blank: false
          requires :userId, type: String, allow_blank: true
        end

        post do
          puts params
          begin
            @appBanners = AppBanner.all.select(:id, :imgUrl, :actionUrl).where(:status => true)
            if params[:userId] == "2"
              @deviceDetail = DeviceDetail.find_by(deviceId: "12345678",security_token: params[:securityToken])
              @recentlyAdded = RecentlyAdded.where(device_detail_id: @deviceDetail.id).select(:id, :title, :subtitle).order(created_at: :desc).limit(10)
            else
              @deviceDetail = DeviceDetail.find_by(deviceId: params[:deviceId], security_token: params[:securityToken])
              puts @deviceDetail
              @recentlyAdded = RecentlyAdded.where(device_detail_id: @deviceDetail.id).select(:id, :title, :subtitle).order(created_at: :desc).limit(10)
            end
            @user = UserDetail.find_by(id:params[:userId])
            if @user.present?
              @userCoins = @user.wallet_balance.to_s
            else
              @userCoins = "0"
            end
            { status: 200, message: "Success", appBanners: @appBanners.any? ? @appBanners : [], recentlyAdded: @recentlyAdded.any? ? @recentlyAdded : [],userCoins: @userCoins }
          rescue Exception => e
            {status:500,message:"Internal Server Error",error:e}
          end
        end
      end
    end
  end
end
