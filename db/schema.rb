# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170110073123) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "advertisers", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "subscription_plan_id"
    t.string   "alternative_id"
    t.integer  "conversion_method_id"
    t.string   "default_click_url"
    t.string   "notes"
    t.integer  "beeswax_id"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_advertisers_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_advertisers_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_advertisers_on_reset_password_token", unique: true, using: :btree
  end

  create_table "ahoy_messages", force: :cascade do |t|
    t.string   "token"
    t.text     "to"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "mailer"
    t.text     "subject"
    t.datetime "sent_at"
    t.datetime "opened_at"
    t.datetime "clicked_at"
    t.index ["token"], name: "index_ahoy_messages_on_token", using: :btree
    t.index ["user_id", "user_type"], name: "index_ahoy_messages_on_user_id_and_user_type", using: :btree
  end

  create_table "campaign_impression_records", force: :cascade do |t|
    t.integer  "campaign_id"
    t.integer  "beeswax_campaign_id"
    t.datetime "day"
    t.integer  "impressions"
    t.integer  "clicks"
    t.float    "cpm"
    t.float    "ctr"
    t.float    "spend"
    t.float    "cost_per_conv"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "campaigns", force: :cascade do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "advertiser_id"
    t.string   "name",             null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "alternative_id"
    t.float    "campaign_budget"
    t.float    "daily_budget"
    t.integer  "budget_type"
    t.integer  "revenue_type"
    t.float    "revenue_amount"
    t.integer  "pacing"
    t.string   "notes"
    t.boolean  "active"
    t.integer  "beeswax_id"
    t.integer  "website_id"
    t.string   "clickthrough_url"
    t.index ["advertiser_id"], name: "index_campaigns_on_advertiser_id", using: :btree
  end

  create_table "creative_assets", force: :cascade do |t|
    t.integer  "advertiser_id"
    t.string   "name"
    t.integer  "width"
    t.integer  "height"
    t.string   "mounted_asset"
    t.integer  "beeswax_asset_id"
    t.string   "beeswax_alternative_id"
    t.string   "notes"
    t.boolean  "active"
    t.integer  "size_bytes"
    t.string   "beeswax_asset_path"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "creatives", force: :cascade do |t|
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "name",                  null: false
    t.integer  "width"
    t.integer  "height"
    t.integer  "beeswax_creative_id"
    t.string   "beeswax_preview_url"
    t.string   "beeswax_preview_token"
    t.integer  "creative_asset_id"
    t.integer  "campaign_id"
    t.index ["campaign_id"], name: "index_creatives_on_campaign_id", using: :btree
  end

  create_table "line_items", force: :cascade do |t|
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "inventory_source",      null: false
    t.integer  "campaign_id",           null: false
    t.string   "name"
    t.integer  "beeswax_id"
    t.string   "alternative_id"
    t.integer  "line_item_type_id"
    t.integer  "targeting_template_id"
    t.float    "line_item_budget"
    t.float    "daily_budget"
    t.integer  "budget_type"
    t.string   "notes"
    t.boolean  "active"
  end

  create_table "mailkick_opt_outs", force: :cascade do |t|
    t.string   "email"
    t.integer  "user_id"
    t.string   "user_type"
    t.boolean  "active",     default: true, null: false
    t.string   "reason"
    t.string   "list"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_mailkick_opt_outs_on_email", using: :btree
    t.index ["user_id", "user_type"], name: "index_mailkick_opt_outs_on_user_id_and_user_type", using: :btree
  end

  create_table "payola_affiliates", force: :cascade do |t|
    t.string   "code"
    t.string   "email"
    t.integer  "percent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payola_coupons", force: :cascade do |t|
    t.string   "code"
    t.integer  "percent_off"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",      default: true
  end

  create_table "payola_sales", force: :cascade do |t|
    t.string   "email"
    t.string   "guid"
    t.integer  "product_id"
    t.string   "product_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.string   "stripe_id"
    t.string   "stripe_token"
    t.string   "card_last4"
    t.date     "card_expiration"
    t.string   "card_type"
    t.text     "error"
    t.integer  "amount"
    t.integer  "fee_amount"
    t.integer  "coupon_id"
    t.boolean  "opt_in"
    t.integer  "download_count"
    t.integer  "affiliate_id"
    t.text     "customer_address"
    t.text     "business_address"
    t.string   "stripe_customer_id"
    t.string   "currency"
    t.text     "signed_custom_fields"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.index ["coupon_id"], name: "index_payola_sales_on_coupon_id", using: :btree
    t.index ["email"], name: "index_payola_sales_on_email", using: :btree
    t.index ["guid"], name: "index_payola_sales_on_guid", using: :btree
    t.index ["owner_id", "owner_type"], name: "index_payola_sales_on_owner_id_and_owner_type", using: :btree
    t.index ["product_id", "product_type"], name: "index_payola_sales_on_product", using: :btree
    t.index ["stripe_customer_id"], name: "index_payola_sales_on_stripe_customer_id", using: :btree
  end

  create_table "payola_stripe_webhooks", force: :cascade do |t|
    t.string   "stripe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payola_subscriptions", force: :cascade do |t|
    t.string   "plan_type"
    t.integer  "plan_id"
    t.datetime "start"
    t.string   "status"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.string   "stripe_customer_id"
    t.boolean  "cancel_at_period_end"
    t.datetime "current_period_start"
    t.datetime "current_period_end"
    t.datetime "ended_at"
    t.datetime "trial_start"
    t.datetime "trial_end"
    t.datetime "canceled_at"
    t.integer  "quantity"
    t.string   "stripe_id"
    t.string   "stripe_token"
    t.string   "card_last4"
    t.date     "card_expiration"
    t.string   "card_type"
    t.text     "error"
    t.string   "state"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "currency"
    t.integer  "amount"
    t.string   "guid"
    t.string   "stripe_status"
    t.integer  "affiliate_id"
    t.string   "coupon"
    t.text     "signed_custom_fields"
    t.text     "customer_address"
    t.text     "business_address"
    t.integer  "setup_fee"
    t.decimal  "tax_percent",          precision: 4, scale: 2
    t.index ["guid"], name: "index_payola_subscriptions_on_guid", using: :btree
  end

  create_table "segments", force: :cascade do |t|
    t.integer  "beeswax_id"
    t.string   "segment_name"
    t.boolean  "active"
    t.string   "alternative_id"
    t.integer  "campaign_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "audience_type"
    t.string   "manual_image_src"
    t.json     "audience_history"
  end

  create_table "subscription_plans", force: :cascade do |t|
    t.integer  "amount"
    t.string   "interval"
    t.string   "stripe_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  end

  create_table "websites", force: :cascade do |t|
    t.string   "name"
    t.string   "domain_name"
    t.integer  "provider"
    t.json     "pages"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "hosting_provider"
    t.string   "notes"
    t.integer  "advertiser_id"
  end

end
