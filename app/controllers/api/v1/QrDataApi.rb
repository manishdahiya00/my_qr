module API
  module V1
    class QrDataApi < Grape::API
      prefix :api
      version :v1
      format :json

      resources :qrHistory do
        desc "Single Qr History Api"
        params do
          requires :deviceId, type: String, allow_blank: false
          requires :securityToken, type: String, allow_blank: false
          requires :versionName, type: String, allow_blank: false
          requires :versionCode, type: String, allow_blank: false
          requires :qrId, type: String, allow_blank: false
          requires :qrType, type: String, allow_blank: false
          requires :userId, type: String, allow_blank: true

        end
        post do
          begin
            if params[:userId] == "2"
              @device_details = DeviceDetail.find_by(deviceId:"12345678",security_token: params[:securityToken])
            else
              @device_details = DeviceDetail.find_by(deviceId:params[:deviceId],security_token: params[:securityToken])
            end
            case params[:qrType]
            when "Scanned"
              @history = QrDatum.where(id: params[:qrId]).select(:id,:codeData).first
              @isFavourite = Favourite.find_by(qr_code_id: params[:qrId]).present?
              @image = ""
            when "Generated"
              @history = GeneratedQr.where(id: params[:qrId]).select(:id,:codeData).first
                @image = @history.codeImage.url
              @isFavourite = Favourite.find_by(qr_code_id: params[:qrId]).present?
            else
              { status: 500, message: "Invalid qrType" }
            end
            { status: 200, message: "Success", history: @history || {}, image_url: @image , isFavourite: @isFavourite }
          rescue Exception => e
            {status:500,message:"Internal Server Error",error:e}
          end
        end
      end
    end
  end
end
