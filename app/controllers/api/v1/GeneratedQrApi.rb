module API
  module V1
    class GeneratedQrApi < Grape::API
      format :json
      version :v1
      prefix :api

      resources :qrCodeData do

        params do
          requires :deviceId,type: String, allow_blank: false
          requires :securityToken,type: String, allow_blank: false
          requires :versionName,type: String, allow_blank: false
          requires :versionCode,type: String, allow_blank: false
          requires :codeImage,type: File,allow_blank: false
          requires :codeData,type: String, allow_blank: false
          requires :qrType,type:String,allow_blank: false
        end

        post do
          begin
            @device_details = DeviceDetail.find_by(deviceId:params[:deviceId],security_token: params[:securityToken])
            @recently_added = @device_details.recently_added.create(
                title:params[:codeType],
                subtitle:params[:codeData],
                qrType: params[:qrType])
            codeImage = ActionDispatch::Http::UploadedFile.new(params[:codeImage])
            @generated_qr = @device_details.generated_qrs.create(
                id: @recently_added.id,
                deviceId: params[:deviceId],
                securityToken: params[:securityToken],
                versionName: params[:versionName],
                versionCode: params[:versionCode],
                codeData: params[:codeData],
                device_detail_id: @device_details.id,
                codeImage: codeImage
              )
            {status:200,message:"Success"}
            rescue Exception => e
            {status:500,message:e.message}
          end
        end
      end

    end
  end
end