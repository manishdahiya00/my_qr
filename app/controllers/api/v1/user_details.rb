module API
  module V1
    class UserDetails < Grape::API
      version :v1
      prefix :api
      format :json

      resources :googleSignUp do
        params do
          optional :deviceType, type: String, allow_blank: false
          requires :deviceId, type: String, allow_blank: false
          optional :deviceName, type: String, allow_blank: false
          requires :socialType, type: String, allow_blank: false
          requires :socialId, type: String, allow_blank: false
          requires :socialToken, type: String, allow_blank: false
          requires :socialEmail, type: String, allow_blank: false
          requires :socialName, type: String, allow_blank: false
          requires :socialImgUrl, type: String, allow_blank: false
          requires :advertisingId, type: String, allow_blank: false
          requires :versionName, type: String, allow_blank: false
          requires :versionCode, type: String, allow_blank: false
          optional :utmSource, type: String, allow_blank: false
          optional :utmMedium, type: String, allow_blank: false
          optional :utmTerm, type: String, allow_blank: false
          optional :utmContent, type: String, allow_blank: false
          optional :utmCampaign, type: String, allow_blank: false
          optional :referrerUrl, type: String, allow_blank: false

          end
          post do
            begin
              @device_details = DeviceDetail.find_by(deviceId: params[:deviceId],advertisingId: params[:advertisingId])
              @user_detail = UserDetail.find_by(advertising_id:params[:advertisingId])
              until @user_detail.present?
                @user_details = UserDetail.create(
                deviceId: params[:deviceId],
                deviceName:params[:deviceName],
                socialType: params[:socialType],
                socialId: params[:socialId],
                socialToken: params[:socialToken],
                socialEmail: params[:socialEmail],
                socialName: params[:socialName],
                socialImgUrl: params[:socialImgUrl],
                advertising_id: params[:advertisingId],
                versionName: params[:versionName],
                versionCode: params[:versionCode],
                utmSource: params[:utmSource],
                utmMedium: params[:utmMedium],
                utmTerm: params[:utmTerm],
                utmContent:params[:utmContent],
                utmCampaign: params[:utmCampaign],
                referrerUrl: params[:referrerUrl],
                device_detail_id: @device_details.id
              )
              end
              new_user_id = @device_details.user_detail_id.presence + ",#{@user_details.id}"
              @device_details.update(user_detail_id: new_user_id)
              {status:200,message:"Success",userId: @user_details.id,securityToken:@device_details.security_token}
            rescue Exception => e
              {status:500,message: e}
            end
        end
      end
    end
  end
end