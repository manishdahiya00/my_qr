module API
  module V1
    class ContactQrCodeApi < Grape::API
      prefix :api
      version :v1
      format :json

      resources :contactQrCode do

        params do
          requires :deviceId, type: String,allow_blank: false
          requires :securityToken, type: String,allow_blank: false
          requires :versionName, type: String,allow_blank: false
          requires :versionCode,type: String,allow_blank: false
          requires :name, type: String,allow_blank: false
          requires :phone,type: String,allow_blank: false
          optional :email,type: String,allow_blank: true,default:""
          optional :address,type: String,allow_blank: true,default:""
          optional :organization,type: String,allow_blank: true,default:""
          optional :url,type: String,allow_blank: true,default:""
          optional :note,type: String,allow_blank: true,default:""
        end

        post do
          begin
            @device_details = DeviceDetail.find_by(deviceId:params[:deviceId],security_token:params[:securityToken])
            puts @device_details
            @contactQrCode = @device_details.contact_qr_codes.create(
              name: params[:name],
              phone: params[:phone],
              email: params[:email],
              address: params[:address],
              organization: params[:organization],
              url: params[:url],
              note: params[:note],
              device_detail_id: @device_details.id
            )
            {status:200,message:"Success"}
          rescue Exception => e
            {status:500,message:e }
          end

        end

      end

    end
  end
end