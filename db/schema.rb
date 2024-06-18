# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_18_075908) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "app_banners", force: :cascade do |t|
    t.string "imgUrl"
    t.string "actionUrl"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status", default: false
  end

  create_table "app_opens", force: :cascade do |t|
    t.string "deviceId"
    t.string "versionName"
    t.string "versionCode"
    t.string "securityToken"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "app_url"
    t.string "socialName"
    t.string "socialEmail"
    t.string "socialImgUrl"
    t.string "forceUpdate", default: "false"
  end

  create_table "device_details", force: :cascade do |t|
    t.string "deviceId"
    t.string "deviceType"
    t.string "deviceName"
    t.string "advertisingId"
    t.string "versionName"
    t.string "versionCode"
    t.string "utmSource"
    t.string "utmMedium"
    t.string "utmTerm"
    t.string "utmContent"
    t.string "utmCampaign"
    t.string "referrerUrl"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "security_token"
    t.string "user_detail_id", default: ""
  end

  create_table "device_details_user_details", id: false, force: :cascade do |t|
    t.integer "device_detail_id", null: false
    t.integer "user_detail_id", null: false
  end

  create_table "favourites", force: :cascade do |t|
    t.string "device_detail_id"
    t.string "versionName"
    t.string "versionCode"
    t.string "deviceId"
    t.string "qr_code_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "qr_name"
  end

  create_table "generated_qrs", force: :cascade do |t|
    t.string "codeData"
    t.string "deviceId"
    t.string "securityToken"
    t.string "device_detail_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "versionName"
    t.string "versionCode"
    t.string "qr_name"
  end

  create_table "managers", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "qr_data", force: :cascade do |t|
    t.string "device_detail_id"
    t.string "securityToken"
    t.string "versionName"
    t.string "versionCode"
    t.string "codeData"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "qr_name"
  end

  create_table "recently_addeds", force: :cascade do |t|
    t.string "title"
    t.string "subtitle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "device_detail_id"
    t.string "qrType"
    t.string "qr_name"
  end

  create_table "redeems", force: :cascade do |t|
    t.string "user_detail_id"
    t.string "mobileNumber"
    t.string "payCoins"
    t.string "payAmount"
    t.string "payType"
    t.string "versionName"
    t.string "versionCode"
    t.string "status", default: "PENDING"
    t.string "payVendor"
    t.string "transVendor"
    t.string "payId"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "traffic_requests", force: :cascade do |t|
    t.string "request_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transaction_histories", force: :cascade do |t|
    t.string "title"
    t.string "subtitle"
    t.string "coins"
    t.string "user_detail_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_details", force: :cascade do |t|
    t.string "deviceType"
    t.string "deviceId"
    t.string "deviceName"
    t.string "socialType"
    t.string "socialId"
    t.text "socialToken"
    t.string "socialEmail"
    t.string "socialName"
    t.string "socialImgUrl"
    t.string "advertisingId"
    t.string "versionName"
    t.string "versionCode"
    t.string "utmSource"
    t.string "utmMedium"
    t.string "utmTerm"
    t.string "utmContent"
    t.string "utmCampaign"
    t.string "referrerUrl"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "device_detail_id"
    t.string "securityToken"
    t.string "refCode"
    t.integer "wallet_balance", default: 0
    t.string "source_ip"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
