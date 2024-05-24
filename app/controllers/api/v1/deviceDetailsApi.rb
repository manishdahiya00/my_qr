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
         requires :userId, type: String, allow_blank: true

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
     resources :appInvite do
       desc "App Invite API"
       params do
         requires :deviceId, type: String, allow_blank: false
         requires :userId, type: String, allow_blank: false
         requires :securityToken, type: String, allow_blank: false
         requires :versionName, type: String, allow_blank: false
         requires :versionCode, type: String, allow_blank: false

       end
       post do
         begin
           user = UserDetail.find_by(id:params[:userId],securityToken: params[:securityToken])
           if user
             inviteFbUrl = "http://localhost:8000/invite/#{user.refCode}/?by=facebook"
             inviteWhatsappUrl = "http://localhost:8000/invite/#{user.refCode}/?by=whatsapp"
             inviteTelegramUrl = "http://localhost:8000/invite/#{user.refCode}/?by=telegram"
             inviteOtherUrl = "http://localhost:8000/invite/#{user.refCode}/?by=other"
             inviteText = "Share, Invite Friends and Get Free Cash and Diamonds.\n ► Get 5 MyQr amount instant as your Friend Register on MyQr App."
             {message: "Success", status: 200, inviteFbUrl: inviteFbUrl,inviteWhatsappUrl: inviteWhatsappUrl,inviteTelegramUrl: inviteTelegramUrl,inviteOtherUrl: inviteOtherUrl,inviteText: inviteText,refCode:user.refCode}
           else
             {message: "Invalid User", status: 500}
           end
         rescue Exception => e
           {message: "Internal Server Error", status: 500,error:e}
         end
     end
    end
    end
  end
end
