module API
  module V1
    class UserDetails < Grape::API
      version :v1
      prefix :api
      format :json

      helpers do
        def google_validator(token, socialemail)
          validator = GoogleIDToken::Validator.new(expiry: 300)
          begin
            token_segments = token.split(".")
            if token_segments.count == 3
              # optional_client_id = "511334437597-29pnd8hkorkh186vftvu1dpka58qkq2v.apps.googleusercontent.com"
              required_audience = JWT.decode(token, nil, false)[0]["aud"]
              payload = validator.check(token, required_audience)
              # payload = validator.check(token, required_audience, optional_client_id)
              if (payload["email"] == socialemail) #&& (payload['azp'].include? "511334437597")
                return true
              else
                return false
              end
            else
              return false
            end
          rescue GoogleIDToken::ValidationError => e
            return false
          end
        end
      end

      resources :googleSignUp do
        Rails.logger.info "API Params:#{params.inspect}"
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
          requires :oauthResponse, type: String, allow_blank: true
        end
        post do
          begin
            source_ip = request.ip
            # if params[:userId] == "2"
            # @deviceDetails = DeviceDetail.find_by(deviceId: "12345678")
            # puts @deviceDetails
            # else
            @deviceDetails = DeviceDetail.find_by(deviceId: params[:deviceId])
            # puts @deviceDetails
            # end
            @user_detail = UserDetail.find_by(socialEmail: params[:socialEmail], socialId: params[:socialId])
            genuine_user = google_validator(params[:socialToken], params[:socialEmail])
            if genuine_user
              if @user_detail.present?
                { status: 200, message: "Success", userId: @user_detail.id, securityToken: @deviceDetails.security_token }
              else
                @user_details = UserDetail.create(
                  deviceType: params[:deviceType],
                  deviceId: params[:deviceId],
                  deviceName: params[:deviceName],
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
                  utmContent: params[:utmContent],
                  utmCampaign: params[:utmCampaign],
                  referrerUrl: params[:referrerUrl],
                  device_detail_id: @deviceDetails.id,
                  securityToken: @deviceDetails.security_token,                  
                  refCode: SecureRandom.hex(4).upcase,
                  source_ip: source_ip,
                )
                if @deviceDetails.user_detail_id.presence == nil
                  new_user_id = "#{@user_details.id}"
                else
                  new_user_id = "#{@deviceDetails.user_detail_id}, #{@user_details.id}"
                end
                @deviceDetails.update(user_detail_id: new_user_id)
                @redeem = @user_details.transaction_histories.create(
                  title: "Signup Bonus",
                  subtitle: DateTime.now.strftime("%d/%m/%Y"),
                  coins: "500",
                )
                @user_details.update(wallet_balance: "500")
                { status: 200, message: "Success", userId: @user_details.id, securityToken: @deviceDetails.security_token }
              end
            else
              { status: 500, message: "Sorry, Tricks are not allowed" }
            end
          rescue Exception => e
            { status: 500, message: "Internal Server Error", error: e }
          end
        end
      end
    end
  end
end
