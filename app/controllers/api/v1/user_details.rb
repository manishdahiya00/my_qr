module API
  module V1
    class UserDetails < Grape::API
      version :v1
      prefix :api
      format :json

      resources :googleSignUp do
        desc "Google Sign Up Api"
        params do
          requires :deviceType, type: String, allow_blank: true
          requires :deviceId, type: String, allow_blank: false
          requires :deviceName, type: String, allow_blank: true
          requires :socialType, type: String, allow_blank: false
          requires :socialId, type: String, allow_blank: false
          requires :socialToken, type: String, allow_blank: false
          requires :socialEmail, type: String, allow_blank: false
          requires :socialName, type: String, allow_blank: false
          requires :socialImgUrl, type: String, allow_blank: false
          requires :advertisingId, type: String, allow_blank: false
          requires :versionName, type: String, allow_blank: false
          requires :versionCode, type: String, allow_blank: false
          requires :utmSource, type: String, allow_blank: true
          requires :utmMedium, type: String, allow_blank: true
          requires :utmTerm, type: String, allow_blank: true
          requires :utmContent, type: String, allow_blank: true
          requires :utmCampaign, type: String, allow_blank: true
          requires :referrerUrl, type: String, allow_blank: true
          requires :oauthResponse, type: String, allow_blank: true

          end
          post do
            begin
              @device_details = DeviceDetail.find_by(deviceId: params[:deviceId],advertisingId: params[:advertisingId])
              @user_detail = UserDetail.find_by(deviceId:params[:deviceId])
              if @user_detail.present?
                {status:200,message:"Success",userId:@user_detail.id,securityToken: @device_details.security_token}
              else
                @user_details = UserDetail.create(
                    deviceType: params[:deviceType],
                    deviceId: params[:deviceId],
                    deviceName:params[:deviceName],
                    socialType: params[:socialType],
                    socialId: params[:socialId],
                    socialToken: params[:socialToken],
                    socialEmail: params[:socialEmail],
                    socialName: params[:socialName],
                    socialImgUrl: params[:socialImgUrl],
                    advertisingId: params[:advertisingId],
                    versionName: params[:versionName],
                    versionCode: params[:versionCode],
                    utmSource: params[:utmSource],
                    utmMedium: params[:utmMedium],
                    utmTerm: params[:utmTerm],
                    utmContent:params[:utmContent],
                    utmCampaign: params[:utmCampaign],
                    referrerUrl: params[:referrerUrl],
                    device_detail_id: @device_details.id,
                    oauth_response: params[:oauthResponse],
                    securityToken: @device_details.security_token,
                    refCode: SecureRandom.hex(6)
                  )


                if @device_details.user_detail_id.presence == nil
                  new_user_id = "#{@user_details.id}"
                else
                  new_user_id = "#{@device_details.user_detail_id}, #{@user_details.id}"
                end
                    @device_details.update(user_detail_id: new_user_id)
                  @redeem = @user_details.redeem_histories.create(
                    title:"Signup Bonus",
                    subtitle:DateTime.now.strftime("%d/%m/%Y"),
                    coins:"5"
                )
                @user_details.update(wallet_balance: "5")
                    {status:200,message:"Success",userId:@user_details.id,securityToken: @device_details.security_token}
              end
            rescue Exception => e
              {status:500,message: "Internal Server Error",error:e}
            end
        end
      end
    end
  end
end