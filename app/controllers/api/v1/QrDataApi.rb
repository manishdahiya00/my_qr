module API
  module V1
    class QrDataApi < Grape::API
      prefix :api
      version :v1
      format :json


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
        PLAY_STORE_URL = IconType.new("https://scansbuddy.app/images/url.png")
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
      "DRIVER LICENSE" => IconType::DRIVER_LICENSE,
      "PLAY STORE URL" => IconType::PLAY_STORE_URL
    }

      resources :qrHistory do
        Rails.logger.info"API Params:#{params.inspect}"
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
              @qr = RecentlyAdded.where(id: params[:qrId]).first
              if @qr.qr_name == nil
                icon = ICON_TYPE_MAP["UNKNOWN"].url
                title = "UNKNOWN"
              else
                icon = ICON_TYPE_MAP[@qr.qr_name].url
                title = @qr.qr_name
              end
              @history = {
                id: @qr.id,
                title: title,
                subtitle: @qr.subtitle,
                createdAt: @qr.created_at.strftime("%d/%m/%y"),
                icon: icon
              }
              @isFavourite = Favourite.find_by(qr_code_id: params[:qrId]).present?
              @image = ""
            when "Generated"
              @qr = GeneratedQr.where(id: params[:qrId]).select(:id,:codeData,:created_at,:qr_name).first
              if @qr.qr_name == nil
                icon = ICON_TYPE_MAP["UNKNOWN"].url
                title = "UNKNOWN"
              else
                icon = ICON_TYPE_MAP[@qr.qr_name].url
                title = @qr.qr_name
              end
              @history = {
                id: @qr.id,
                title: title,
                subtitle: @qr.codeData,
                createdAt: @qr.created_at.strftime("%d/%m/%y"),
                icon: icon
              }
                @image = @qr.codeImage.url
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
