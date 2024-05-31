module API
  module V1
    class GeneratedQrApi < Grape::API
      format :json
      version :v1
      prefix :api

      resources :qrCodeData do
        desc "Save Qr Code Data and Create History"
        params do
          requires :deviceId,type: String, allow_blank: false
          requires :securityToken,type: String, allow_blank: false
          requires :versionName,type: String, allow_blank: false
          requires :versionCode,type: String, allow_blank: false
          requires :codeImage,type: File,allow_blank: false
          requires :codeData,type: String, allow_blank: false
          requires :qrType,type:String,allow_blank: false
          requires :userId, type: String, allow_blank: true
          requires :qrName, type: String, allow_blank: false

        end

        post do
          begin
            if params[:userId] == "2"
              @device_details = DeviceDetail.find_by(deviceId:"12345678",security_token: params[:securityToken])
            else
              @device_details = DeviceDetail.find_by(deviceId:params[:deviceId],security_token: params[:securityToken])
            end
            @recently_added = @device_details.recently_added.create(
                title:params[:qrType],
                subtitle:params[:codeData],
                qrType: params[:qrType],
                qr_name:params[:qrName]
                )
            codeImage = ActionDispatch::Http::UploadedFile.new(params[:codeImage])
            @generated_qr = @device_details.generated_qrs.create(
                id: @recently_added.id,
                deviceId: params[:deviceId],
                securityToken: params[:securityToken],
                versionName: params[:versionName],
                versionCode: params[:versionCode],
                codeData: params[:codeData],
                device_detail_id: @device_details.id,
                codeImage: codeImage,
                qr_name:params[:qrName]
              )
            {status:200,message:"Success",qrId: @generated_qr.id}
            rescue Exception => e
            {status:500,message:"Internal Server Error",error:e}
          end
        end
      end

    end
  end
end
