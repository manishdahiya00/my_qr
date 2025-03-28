module API
  class Base < Grape::API
    mount API::V1::DeviceDetailsApi
    mount API::V1::AppOpenApi
    mount API::V1::HomeApi
    mount API::V1::ScannerDataApi
    mount API::V1::GeneratedQrApi
    mount API::V1::FavouriteApi
    mount API::V1::UserDetails
    mount API::V1::QrDataApi
    mount API::V1::HistoryApi
    mount API::V1::TransactionHistoryApi
    mount API::V1::DefaultUser
    mount API::V1::RewardList
    mount API::V1::RedeemSubmit
  end
end
