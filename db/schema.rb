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

ActiveRecord::Schema.define(version: 20160917225501) do

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

  create_table "campaigns", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "advertiser_id"
    t.string   "name",            null: false
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
    t.index ["advertiser_id"], name: "index_campaigns_on_advertiser_id", using: :btree
  end

  create_table "creative_line_item_assignments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "creatives", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "advertiser_id"
    t.string   "name",           null: false
    t.string   "creative_asset"
    t.integer  "width"
    t.integer  "height"
    t.index ["advertiser_id"], name: "index_creatives_on_advertiser_id", using: :btree
  end

  create_table "dripper_actions", force: :cascade do |t|
    t.string   "mailer",     null: false
    t.string   "action",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dripper_messages", force: :cascade do |t|
    t.string   "drippable_type",    null: false
    t.integer  "drippable_id",      null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "dripper_action_id"
    t.index ["drippable_type", "drippable_id"], name: "index_dripper_messages_on_drippable_type_and_drippable_id", using: :btree
    t.index ["dripper_action_id"], name: "index_dripper_messages_on_dripper_action_id", using: :btree
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
    t.integer  "tax_percent"
    t.index ["guid"], name: "index_payola_subscriptions_on_guid", using: :btree
  end

  create_table "segments", force: :cascade do |t|
    t.integer  "beeswax_id"
    t.string   "segment_name"
    t.boolean  "active"
    t.string   "alternative_id"
    t.integer  "campaign_id"
    t.integer  "segment_count"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "audience"
  end

  create_table "subscription_plans", force: :cascade do |t|
    t.integer  "amount"
    t.string   "interval"
    t.string   "stripe_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "dripper_messages", "dripper_actions"
end
