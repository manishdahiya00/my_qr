module API
  module V1
    class ScannerDataApi < Grape::API
      format :json
      prefix :api
      version :v1


      class IconType
        attr_reader :url

        def initialize(url)
          @url = url
        end

        UNKNOWN = IconType.new("https://scansbuddy.app/images/help.png")
        ALL_FORMATS = IconType.new("https://scansbuddy.app/images/all-format.png")
        CODE_128 = IconType.new("https://scansbuddy.app/images/bar-code.png")
        CODE_39 = IconType.new("https://scansbuddy.app/images/bar-code.png")
        CODE_93 = IconType.new("https://scansbuddy.app/images/bar-code.png")
        CODABAR = IconType.new("https://scansbuddy.app/images/bar-code.png")
        DATA_MATRIX = IconType.new("https://scansbuddy.app/images/bar-code.png")
        EAN_13 = IconType.new("https://scansbuddy.app/images/bar-code.png")
        EAN_8 = IconType.new("https://scansbuddy.app/images/bar-code.png")
        ITF = IconType.new("https://scansbuddy.app/images/bar-code.png")
        QR_CODE = IconType.new("https://scansbuddy.app/images/qr-code.png")
        UPC_A = IconType.new("https://scansbuddy.app/images/bar-code.png")
        UPC_E = IconType.new("https://scansbuddy.app/images/bar-code.png")
        PDF417 = IconType.new("https://scansbuddy.app/images/bar-code.png")
        AZTEC = IconType.new("https://scansbuddy.app/images/bar-code.png")
        CONTACT_INFO = IconType.new("https://scansbuddy.app/images/contact.png")
        EMAIL = IconType.new("https://scansbuddy.app/images/email.png")
        ISBN = IconType.new("https://scansbuddy.app/images/bar-code.png")
        PHONE = IconType.new("https://scansbuddy.app/images/phone.png")
        PRODUCT = IconType.new("https://scansbuddy.app/images/product.png")
        SMS = IconType.new("https://scansbuddy.app/images/sms.png")
        TEXT = IconType.new("https://scansbuddy.app/images/text.png")
        URL = IconType.new("https://scansbuddy.app/images/url.png")
        WIFI = IconType.new("https://scansbuddy.app/images/wifi.png")
        GEO = IconType.new("https://scansbuddy.app/images/location.png")
        CALENDAR_EVENT = IconType.new("https://scansbuddy.app/images/calender.png")
        DRIVER_LICENSE = IconType.new("https://scansbuddy.app/images/driver-license.png")
      end

      ICON_TYPE_MAP = {
      "UNKNOWN" => IconType::UNKNOWN,
      "ALL FORMATS" => IconType::ALL_FORMATS,
      "CODE 128" => IconType::CODE_128,
      "CODE 39" => IconType::CODE_39,
      "CODE 93" => IconType::CODE_93,
      "CODABAR" => IconType::CODABAR,
      "DATA MATRIX" => IconType::DATA_MATRIX,
      "EAN 13" => IconType::EAN_13,
      "EAN 8" => IconType::EAN_8,
      "ITF" => IconType::ITF,
      "QR CODE" => IconType::QR_CODE,
      "UPC A" => IconType::UPC_A,
      "UPC E" => IconType::UPC_E,
      "PDF417" => IconType::PDF417,
      "AZTEC" => IconType::AZTEC,
      "CONTACT INFO" => IconType::CONTACT_INFO,
      "EMAIL" => IconType::EMAIL,
      "ISBN" => IconType::ISBN,
      "PHONE" => IconType::PHONE,
      "PRODUCT" => IconType::PRODUCT,
      "SMS" => IconType::SMS,
      "TEXT" => IconType::TEXT,
      "URL" => IconType::URL,
      "WIFI" => IconType::WIFI,
      "GEO" => IconType::GEO,
      "CALENDAR EVENT" => IconType::CALENDAR_EVENT,
      "DRIVER LICENSE" => IconType::DRIVER_LICENSE
    }




      resources :scannerData do
        desc "Create Qr Code History"
        params do
          requires :deviceId,type:String,allow_blank: false
          requires :securityToken,type:String,allow_blank: false
          requires :versionName,type:String,allow_blank: false
          requires :versionCode,type:String,allow_blank: false
          requires :data,type:String,allow_blank: false
          requires :qrType,type:String,allow_blank: false
          requires :userId, type: String, allow_blank: true
          requires :qrName, type: String, allow_blank: false

        end

        post do
          begin
            if params[:userId] == "2"
              @device_detail = DeviceDetail.find_by(deviceId:"12345678",security_token: params[:securityToken])
            else
              @device_detail = DeviceDetail.find_by(deviceId:params[:deviceId],security_token: params[:securityToken])
            end
            @recently_added =  @device_detail.recently_added.create(
              title:params[:qrType],
              subtitle:params[:data],
              qrType: params[:qrType],
              qr_name: params[:qrName],)
            @qrData = @device_detail.qr_data.create(
              id: @recently_added.id,
              device_detail_id: params[:deviceId],
              securityToken: params[:securityToken],
              versionName: params[:versionName],
              versionCode: params[:versionCode],
              codeData: params[:data],
              qr_name: params[:qrName],)

            {status:200,message:"Success",createdAt:@qrData.created_at.strftime("%d/%m/%y"),id:@recently_added.id,icon: ICON_TYPE_MAP[@recently_added.qr_name].url}
          rescue Exception => e
            {status:500,message:"Internal Server Error",error:e}
          end
        end

      end

    end
  end
end
