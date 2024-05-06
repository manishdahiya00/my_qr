module API
  module V1
    class ScannerApi < Grape::API
      prefix :api
      version :v1
      format :json

      resources :home do
        params do
          requires :deviceId, type: String, allow_blank: false
          requires :securityToken, type: String, allow_blank: false
          requires :versionName, type: String, allow_blank: false
          requires :versionCode, type: String, allow_blank: false
        end

        post do
          begin
            @appBanners = AppBanner.all.select(:id, :imgUrl, :actionUrl)
            @deviceDetail = DeviceDetail.find_by(deviceId: params[:deviceId], security_token: params[:securityToken])
            @recentlyAdded = RecentlyAdded.where(device_detail_id: @deviceDetail.id).select(:id, :title, :subtitle).order(created_at: :desc)
            { status: 200, message: "Success", appBanners: @appBanners.any? ? @appBanners : [], recentlyAdded: @recentlyAdded.any? ? @recentlyAdded : [] }
          rescue => e
            error!({ status: 500, message: e.message }, 500)
          end
        end
      end
    end
  end
end
