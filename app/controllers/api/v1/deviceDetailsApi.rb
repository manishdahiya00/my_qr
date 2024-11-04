module API
  module V1
    class DeviceDetailsApi < Grape::API
      format :json
      prefix :api
      version :v1

     resources :deviceDetails do
      #Rails.logger.info"API Params:#{params.inspect}"
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
          @device_detail = DeviceDetail.find_by(deviceId: params[:deviceId])
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
            #{status:200,message:"Success",security_token:@security_token}
            require "uri"
            require "net/http"                    
            uri = URI("https://performxcel.com/record?vendor=MGApps&app=ScanBuddy&clickid=#{params[:utmMedium]}&adv_sub=#{params[:ReferrerUrl]}")
            x = Net::HTTP.get(uri)
          end
          {status:200, message:"Success", security_token: @device_detail.security_token, deviceId: @device_detail.deviceId}
         rescue Exception=>e
           {message: "Error", status: 500, error:e}
         end
         end
     end
     resources :appInvite do
       #Rails.logger.info"API Params:#{params.inspect}"
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
           user = UserDetail.find_by(id:params[:userId])
           if user
             inviteFbUrl = "https://scansbuddy.app/invite/#{user.refCode}/?by=facebook"
             inviteWhatsappUrl = "https://scansbuddy.app/invite/#{user.refCode}/?by=whatsapp"
             inviteTelegramUrl = "https://scansbuddy.app/invite/#{user.refCode}/?by=telegram"
             inviteOtherUrl = "https://scansbuddy.app/invite/#{user.refCode}/?by=other"
             inviteText = "Share, Invite Friends and Get Free Cash and Diamonds.\n ► Get 500 ScanBuddy Coins instant as your Friend Register on ScanBuddy App.\n ► Get a Chance to Earn upto 10,000 ScanBuddy Coins for Top Inviters.\n ► Sponsorship for YouTube, WhatsApp, Telegram and Facebook Content Creator Available!"             
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
