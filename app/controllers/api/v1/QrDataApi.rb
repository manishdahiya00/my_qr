module API
  module V1
    class QrDataApi < Grape::API
      prefix :api
      version :v1
      format :json

      resources :qrHistory do
        params do
          requires :deviceId, type: String, allow_blank: false
          requires :securityToken, type: String, allow_blank: false
          requires :versionName, type: String, allow_blank: false
          requires :versionCode, type: String, allow_blank: false
          requires :qrId, type: String, allow_blank: false
          requires :qrType, type: String, allow_blank: false
        end
        post do
          begin
            @device_detail = DeviceDetail.find_by(deviceId: params[:deviceId], security_token: params[:securityToken])
            case params[:qrType]
            when "Scanned"
              @history = QrDatum.where(id: params[:qrId]).select(:id,:data).first
              @isFavourite = Favourite.find_by(qr_code_id: params[:qrId]).present?
              @images = ""
            when "Generated"
              @history = GeneratedQr.where(id: params[:qrId]).select(:id,:codeData).first
                @images = @history.codeImage.url
              @isFavourite = Favourite.find_by(qr_code_id: params[:qrId]).present?
            else
              { status: 500, message: "Invalid qrType" }
            end
            { status: 200, message: "Success", history: @history || [], image_url: @images , isFavourite: @isFavourite }
          rescue Exception => e
            { status: 500, message: e.message }
          end
        end
      end
    end
  end
end
