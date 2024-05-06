module API
  module V1
    class DeviceDetailsApi < Grape::API
      format :json
      prefix :api
      version :v1

     resources :deviceDetails do
       desc "Device details API"
       params do
         requires :deviceId, type: String, allow_blank: false
         requires :deviceType, type: String, allow_blank: true
         requires :deviceName, type: String, allow_blank: true

         requires :advertisingId, type: String, allow_blank: false
         requires :versionName, type: String, allow_blank: false
         requires :versionCode, type: String, allow_blank: false

         requires :utmSource, type: String, allow_blank: true
         requires :utmMedium, type: String, allow_blank: true
         requires :utmCampaign, type: String, allow_blank: true
         requires :utmContent, type: String, allow_blank: true
         requires :utmTerm, type: String, allow_blank: true
         requires :referrerUrl, type: String, allow_blank: true
       end

       post do
         begin
          @device_detail = DeviceDetail.find_by(advertisingId: params[:advertisingId])
          unless @device_detail.present?
            @security_token = SecureRandom.uuid
            @device_detail = DeviceDetail.create(
              deviceId: params[:deviceId],
              deviceType: params[:deviceType],
              deviceName: params[:deviceName],
              advertisingId: params[:advertisingId],
              versionName: params[:versionName],
              versionCode: params[:versionCode],
              utmSource: params[:utmSource],
              utmMedium: params[:utmMedium],
              utmCampaign: params[:utmCampaign],
              utmContent: params[:utmContent],
              utmTerm:params[:utmTerm],
              referrerUrl: params[:ReferrerUrl],
              security_token: @security_token)
          {status:200,message:"Success",security_token:@security_token}
          end
          {status:200,message:"Success",security_token:@device_detail.security_token,deviceId:@device_detail.deviceId}
         rescue Exception=>e
              {message: "Error", status: 500,error:e}
         end

       end
     end

    end
  end
end
