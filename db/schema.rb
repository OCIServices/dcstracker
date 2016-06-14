# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160517221237) do

  create_table "addresses", force: :cascade do |t|
    t.integer  "attached_to_id",   limit: 4
    t.string   "attached_to_type", limit: 255
    t.string   "line_1",           limit: 255
    t.string   "line_2",           limit: 255
    t.string   "city",             limit: 255
    t.string   "state",            limit: 255
    t.string   "zip",              limit: 255
    t.string   "country",          limit: 255
    t.text     "comments",         limit: 65535
    t.boolean  "active"
    t.integer  "created_by_id",    limit: 4
    t.integer  "updated_by_id",    limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "address_type_id",  limit: 4
  end

  add_index "addresses", ["attached_to_type", "attached_to_id"], name: "index_addresses_on_attached_to_type_and_attached_to_id", using: :btree

  create_table "bug_notes", force: :cascade do |t|
    t.integer  "bug_id",        limit: 4
    t.integer  "device_id",     limit: 4
    t.text     "note",          limit: 65535
    t.integer  "created_by_id", limit: 4
    t.integer  "updated_by_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "bug_notes", ["bug_id"], name: "index_bug_notes_on_bug_id", using: :btree
  add_index "bug_notes", ["device_id"], name: "index_bug_notes_on_device_id", using: :btree

  create_table "bugs", force: :cascade do |t|
    t.string   "name",            limit: 255,   null: false
    t.integer  "software_ver_id", limit: 4
    t.integer  "service_id",      limit: 4
    t.text     "issue",           limit: 65535
    t.text     "workaround",      limit: 65535
    t.text     "solution",        limit: 65535
    t.integer  "created_by_id",   limit: 4
    t.integer  "updated_by_id",   limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "build_events", force: :cascade do |t|
    t.integer  "build_id",          limit: 4
    t.text     "event_text",        limit: 65535
    t.integer  "assigned_to_id",    limit: 4
    t.integer  "time_spent",        limit: 4
    t.integer  "created_by_id",     limit: 4
    t.integer  "updated_by_id",     limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size",    limit: 4
    t.datetime "file_updated_at"
    t.integer  "file_category_id",  limit: 4
    t.text     "change_text",       limit: 65535
  end

  add_index "build_events", ["build_id"], name: "index_build_events_on_build_id", using: :btree

  create_table "builds", force: :cascade do |t|
    t.integer  "device_id",           limit: 4
    t.text     "build_text",          limit: 65535
    t.integer  "robotic_id",          limit: 4
    t.integer  "printer_id",          limit: 4
    t.integer  "controller_pc_id",    limit: 4
    t.integer  "category_id",         limit: 4
    t.integer  "dispatch_id",         limit: 4
    t.boolean  "priority"
    t.integer  "contact_id",          limit: 4
    t.integer  "ship_address_id",     limit: 4
    t.string   "tracking_outbound",   limit: 255
    t.string   "tracking_inbound",    limit: 255
    t.integer  "outbound_carrier_id", limit: 4
    t.integer  "inbound_carrier_id",  limit: 4
    t.integer  "assigned_to_id",      limit: 4
    t.string   "decision_one",        limit: 255
    t.integer  "backup_by_id",        limit: 4
    t.datetime "backup_at"
    t.integer  "built_by_id",         limit: 4
    t.datetime "built_at"
    t.integer  "labeled_by_id",       limit: 4
    t.datetime "labeled_at"
    t.integer  "verified_by_id",      limit: 4
    t.datetime "verified_at"
    t.integer  "shipped_by_id",       limit: 4
    t.datetime "shipped_at"
    t.integer  "return_by_id",        limit: 4
    t.datetime "return_at"
    t.integer  "completed_by_id",     limit: 4
    t.datetime "completed_at"
    t.integer  "backup_method_id",    limit: 4
    t.integer  "software_ver_id",     limit: 4
    t.integer  "ship_method_id",      limit: 4
    t.integer  "created_by_id",       limit: 4
    t.integer  "updated_by_id",       limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "file_file_name",      limit: 255
    t.string   "file_content_type",   limit: 255
    t.integer  "file_file_size",      limit: 4
    t.datetime "file_updated_at"
    t.integer  "file_category_id",    limit: 4
    t.integer  "robotic_type_id",     limit: 4
    t.integer  "printer_type_id",     limit: 4
    t.integer  "controller_type_id",  limit: 4
  end

  add_index "builds", ["contact_id"], name: "index_builds_on_contact_id", using: :btree
  add_index "builds", ["controller_pc_id"], name: "index_builds_on_controller_pc_id", using: :btree
  add_index "builds", ["device_id"], name: "index_builds_on_device_id", using: :btree
  add_index "builds", ["printer_id"], name: "index_builds_on_printer_id", using: :btree
  add_index "builds", ["robotic_id"], name: "index_builds_on_robotic_id", using: :btree

  create_table "contact_events", force: :cascade do |t|
    t.integer  "contact_id",    limit: 4
    t.text     "event_text",    limit: 65535
    t.integer  "created_by_id", limit: 4
    t.integer  "updated_by_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "contact_events", ["contact_id"], name: "index_contact_events_on_contact_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.integer  "customer_id",     limit: 4
    t.integer  "contact_type_id", limit: 4
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "title",           limit: 255
    t.string   "department",      limit: 255
    t.string   "phone",           limit: 255
    t.string   "cell",            limit: 255
    t.string   "pager",           limit: 255
    t.string   "fax",             limit: 255
    t.string   "email",           limit: 255
    t.text     "comments",        limit: 65535
    t.boolean  "active"
    t.integer  "created_by_id",   limit: 4
    t.integer  "updated_by_id",   limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "contacts", ["customer_id"], name: "index_contacts_on_customer_id", using: :btree

  create_table "contracts", force: :cascade do |t|
    t.integer  "device_id",          limit: 4
    t.integer  "contract_holder_id", limit: 4
    t.integer  "contract_type_id",   limit: 4
    t.string   "invoice",            limit: 255
    t.datetime "service_exp_at"
    t.datetime "warranty_exp_at"
    t.string   "customer_po",        limit: 255
    t.text     "comments",           limit: 65535
    t.integer  "created_by_id",      limit: 4
    t.integer  "updated_by_id",      limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "contracts", ["device_id"], name: "index_contracts_on_device_id", using: :btree

  create_table "controller_pcs", force: :cascade do |t|
    t.string   "serial",             limit: 255, null: false
    t.integer  "controller_type_id", limit: 4
    t.integer  "device_id",          limit: 4
    t.datetime "dell_end_date"
    t.integer  "software_ver_id",    limit: 4
    t.integer  "rimage_ver_id",      limit: 4
    t.integer  "os_ver_id",          limit: 4
    t.integer  "created_by_id",      limit: 4
    t.integer  "updated_by_id",      limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "controller_pcs", ["device_id"], name: "index_controller_pcs_on_device_id", using: :btree

  create_table "customer_events", force: :cascade do |t|
    t.integer  "customer_id",   limit: 4
    t.text     "event_text",    limit: 65535
    t.integer  "created_by_id", limit: 4
    t.integer  "updated_by_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "customer_events", ["customer_id"], name: "index_customer_events_on_customer_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.integer  "umbrella_id",      limit: 4
    t.string   "name",             limit: 255
    t.text     "alias",            limit: 65535
    t.string   "phone",            limit: 255
    t.string   "fax",              limit: 255
    t.string   "web",              limit: 255
    t.text     "comments",         limit: 65535
    t.boolean  "show_comments"
    t.text     "alert",            limit: 65535
    t.boolean  "show_alert"
    t.boolean  "active"
    t.integer  "created_by_id",    limit: 4
    t.integer  "updated_by_id",    limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "customer_type_id", limit: 4
  end

  add_index "customers", ["umbrella_id"], name: "index_customers_on_umbrella_id", using: :btree

  create_table "device_connections", force: :cascade do |t|
    t.integer  "device_id",          limit: 4
    t.integer  "connection_type_id", limit: 4
    t.string   "phone",              limit: 255
    t.string   "vpn_ip",             limit: 255
    t.string   "vpn_login",          limit: 255
    t.string   "vpn_password",       limit: 255
    t.string   "vpn_group_name",     limit: 255
    t.string   "vpn_group_password", limit: 255
    t.string   "vpn_domain",         limit: 255
    t.boolean  "dhcp"
    t.string   "ip",                 limit: 255
    t.boolean  "script"
    t.string   "login",              limit: 255
    t.string   "password",           limit: 255
    t.string   "domain",             limit: 255
    t.string   "pca_login",          limit: 255
    t.string   "pca_password",       limit: 255
    t.string   "pca_domain",         limit: 255
    t.text     "comments",           limit: 65535
    t.boolean  "active"
    t.integer  "created_by_id",      limit: 4
    t.integer  "updated_by_id",      limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "device_connections", ["device_id"], name: "index_device_connections_on_device_id", using: :btree

  create_table "device_events", force: :cascade do |t|
    t.integer  "device_id",     limit: 4
    t.text     "event_text",    limit: 65535
    t.text     "changes",       limit: 65535
    t.integer  "created_by_id", limit: 4
    t.integer  "updated_by_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "device_events", ["device_id"], name: "index_device_events_on_device_id", using: :btree

  create_table "device_interfaces", force: :cascade do |t|
    t.integer  "device_id",           limit: 4
    t.integer  "interface_type_id",   limit: 4
    t.integer  "interface_vendor_id", limit: 4
    t.string   "desc",                limit: 255
    t.string   "ip",                  limit: 255
    t.string   "ae_title",            limit: 255
    t.string   "port",                limit: 255
    t.string   "gateway",             limit: 255
    t.string   "submask",             limit: 255
    t.string   "dns_1",               limit: 255
    t.string   "dns_2",               limit: 255
    t.string   "mac",                 limit: 255
    t.string   "wins",                limit: 255
    t.string   "ras_ip_1",            limit: 255
    t.string   "ras_ip_2",            limit: 255
    t.string   "login",               limit: 255
    t.string   "password",            limit: 255
    t.integer  "qr_model_id",         limit: 4
    t.integer  "qr_level_id",         limit: 4
    t.text     "comments",            limit: 65535
    t.boolean  "active"
    t.integer  "created_by_id",       limit: 4
    t.integer  "updated_by_id",       limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "device_interfaces", ["device_id"], name: "index_device_interfaces_on_device_id", using: :btree

  create_table "device_licenses", force: :cascade do |t|
    t.integer  "license_type_id", limit: 4
    t.string   "desc",            limit: 255
    t.string   "value",           limit: 255
    t.integer  "device_id",       limit: 4
    t.text     "comments",        limit: 65535
    t.boolean  "active"
    t.integer  "created_by_id",   limit: 4
    t.integer  "updated_by_id",   limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "device_licenses", ["device_id"], name: "index_device_licenses_on_device_id", using: :btree

  create_table "devices", force: :cascade do |t|
    t.string   "cust_number",      limit: 255
    t.integer  "customer_id",      limit: 4
    t.integer  "device_type_id",   limit: 4
    t.integer  "contact_id",       limit: 4
    t.integer  "trade_old_id",     limit: 4
    t.integer  "trade_new_id",     limit: 4
    t.string   "location",         limit: 255
    t.boolean  "print_head"
    t.integer  "install_by_id",    limit: 4
    t.datetime "install_at"
    t.text     "comments",         limit: 65535
    t.boolean  "twentyfour_seven"
    t.string   "machine_guid",     limit: 255
    t.boolean  "active"
    t.boolean  "active_cloud"
    t.integer  "created_by_id",    limit: 4
    t.integer  "updated_by_id",    limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "contact_type_id",  limit: 4
  end

  add_index "devices", ["contact_id"], name: "index_devices_on_contact_id", using: :btree
  add_index "devices", ["customer_id"], name: "index_devices_on_customer_id", using: :btree

  create_table "dropdowns", force: :cascade do |t|
    t.string   "dropdown_type", limit: 255
    t.string   "name",          limit: 255, null: false
    t.string   "desc",          limit: 255
    t.boolean  "active"
    t.boolean  "current"
    t.integer  "created_by_id", limit: 4
    t.integer  "updated_by_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "hardware_events", force: :cascade do |t|
    t.integer  "hardware_id",   limit: 4
    t.string   "hardware_type", limit: 255
    t.integer  "created_by_id", limit: 4
    t.integer  "updated_by_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.text     "note",          limit: 65535
  end

  add_index "hardware_events", ["hardware_type", "hardware_id"], name: "index_hardware_events_on_hardware_type_and_hardware_id", using: :btree

  create_table "inventories", force: :cascade do |t|
    t.string   "part_number",     limit: 255, null: false
    t.string   "rack_number",     limit: 255
    t.string   "description",     limit: 255
    t.integer  "inventory_level", limit: 4
    t.integer  "reorder_level",   limit: 4
    t.integer  "warehouse",       limit: 4
    t.integer  "repair_depot",    limit: 4
    t.integer  "status_id",       limit: 4
    t.boolean  "active"
    t.integer  "created_by_id",   limit: 4
    t.integer  "updated_by_id",   limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "printers", force: :cascade do |t|
    t.string   "serial",           limit: 255, null: false
    t.integer  "printer_type_id",  limit: 4
    t.integer  "device_id",        limit: 4
    t.integer  "printer_flash_id", limit: 4
    t.integer  "created_by_id",    limit: 4
    t.integer  "updated_by_id",    limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "printers", ["device_id"], name: "index_printers_on_device_id", using: :btree

  create_table "purchase_orders", force: :cascade do |t|
    t.integer  "contract_id",    limit: 4
    t.string   "po_number",      limit: 255
    t.string   "invoice_number", limit: 255
    t.integer  "device_id",      limit: 4
    t.integer  "ticket_id",      limit: 4
    t.integer  "rma_id",         limit: 4
    t.boolean  "software"
    t.integer  "created_by_id",  limit: 4
    t.integer  "updated_by_id",  limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "purchase_orders", ["contract_id"], name: "index_purchase_orders_on_contract_id", using: :btree
  add_index "purchase_orders", ["device_id"], name: "index_purchase_orders_on_device_id", using: :btree
  add_index "purchase_orders", ["rma_id"], name: "index_purchase_orders_on_rma_id", using: :btree
  add_index "purchase_orders", ["ticket_id"], name: "index_purchase_orders_on_ticket_id", using: :btree

  create_table "rma_events", force: :cascade do |t|
    t.integer  "rma_id",            limit: 4
    t.text     "event_text",        limit: 65535
    t.integer  "assigned_to_id",    limit: 4
    t.integer  "time_spent",        limit: 4
    t.integer  "created_by_id",     limit: 4
    t.integer  "updated_by_id",     limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.text     "change_text",       limit: 65535
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size",    limit: 4
    t.datetime "file_updated_at"
    t.integer  "file_category_id",  limit: 4
  end

  add_index "rma_events", ["rma_id"], name: "index_rma_events_on_rma_id", using: :btree

  create_table "rmas", force: :cascade do |t|
    t.integer  "ticket_id",               limit: 4
    t.text     "rma_text",                limit: 65535
    t.boolean  "priority"
    t.integer  "old_robotic_id",          limit: 4
    t.integer  "new_robotic_id",          limit: 4
    t.integer  "old_printer_id",          limit: 4
    t.integer  "new_printer_id",          limit: 4
    t.integer  "old_controller_pc_id",    limit: 4
    t.integer  "new_controller_pc_id",    limit: 4
    t.integer  "old_other_id",            limit: 4
    t.integer  "new_other_id",            limit: 4
    t.string   "other_desc",              limit: 255
    t.integer  "robotic_condition_id",    limit: 4
    t.integer  "printer_condition_id",    limit: 4
    t.integer  "controller_condition_id", limit: 4
    t.integer  "other_condition_id",      limit: 4
    t.integer  "dispatch_id",             limit: 4
    t.integer  "contact_id",              limit: 4
    t.integer  "ship_address_id",         limit: 4
    t.string   "tracking_outbound",       limit: 255
    t.string   "tracking_inbound",        limit: 255
    t.integer  "outbound_carrier_id",     limit: 4
    t.integer  "inbound_carrier_id",      limit: 4
    t.integer  "assigned_to_id",          limit: 4
    t.string   "decision_one",            limit: 255
    t.integer  "backup_by_id",            limit: 4
    t.datetime "backup_at"
    t.integer  "built_by_id",             limit: 4
    t.datetime "built_at"
    t.integer  "labeled_by_id",           limit: 4
    t.datetime "labeled_at"
    t.integer  "verified_by_id",          limit: 4
    t.datetime "verified_at"
    t.integer  "shipped_by_id",           limit: 4
    t.datetime "shipped_at"
    t.integer  "return_by_id",            limit: 4
    t.datetime "return_at"
    t.integer  "completed_by_id",         limit: 4
    t.datetime "completed_at"
    t.integer  "backup_method_id",        limit: 4
    t.integer  "software_ver_id",         limit: 4
    t.integer  "ship_method_id",          limit: 4
    t.integer  "created_by_id",           limit: 4
    t.integer  "updated_by_id",           limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "file_file_name",          limit: 255
    t.string   "file_content_type",       limit: 255
    t.integer  "file_file_size",          limit: 4
    t.datetime "file_updated_at"
    t.integer  "file_category_id",        limit: 4
  end

  add_index "rmas", ["contact_id"], name: "index_rmas_on_contact_id", using: :btree
  add_index "rmas", ["ticket_id"], name: "index_rmas_on_ticket_id", using: :btree

  create_table "robotics", force: :cascade do |t|
    t.string   "serial",           limit: 255, null: false
    t.integer  "robotic_type_id",  limit: 4
    t.integer  "device_id",        limit: 4
    t.integer  "robotic_flash_id", limit: 4
    t.integer  "burner_flash_id",  limit: 4
    t.integer  "burner_type_id",   limit: 4
    t.integer  "cable_type_id",    limit: 4
    t.integer  "num_burners",      limit: 4
    t.integer  "created_by_id",    limit: 4
    t.integer  "updated_by_id",    limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "robotics", ["device_id"], name: "index_robotics_on_device_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "ticket_events", force: :cascade do |t|
    t.integer  "ticket_id",         limit: 4
    t.integer  "status_id",         limit: 4
    t.integer  "assigned_to_id",    limit: 4
    t.text     "event_text",        limit: 65535
    t.integer  "time_spent",        limit: 4
    t.integer  "created_by_id",     limit: 4
    t.integer  "updated_by_id",     limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size",    limit: 4
    t.datetime "file_updated_at"
    t.integer  "file_category_id",  limit: 4
  end

  add_index "ticket_events", ["ticket_id"], name: "index_ticket_events_on_ticket_id", using: :btree

  create_table "tickets", force: :cascade do |t|
    t.integer  "device_id",         limit: 4
    t.text     "ticket_text",       limit: 65535
    t.integer  "status_id",         limit: 4
    t.integer  "assigned_to_id",    limit: 4
    t.boolean  "priority"
    t.integer  "category_id",       limit: 4
    t.boolean  "authorized"
    t.integer  "contact_id",        limit: 4
    t.integer  "created_by_id",     limit: 4
    t.integer  "updated_by_id",     limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size",    limit: 4
    t.datetime "file_updated_at"
    t.integer  "file_category_id",  limit: 4
    t.boolean  "mdr"
  end

  add_index "tickets", ["contact_id"], name: "index_tickets_on_contact_id", using: :btree
  add_index "tickets", ["device_id"], name: "index_tickets_on_device_id", using: :btree

  create_table "umbrellas", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "created_by_id", limit: 4
    t.integer  "updated_by_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "active"
  end

  create_table "upgrade_events", force: :cascade do |t|
    t.integer  "upgrade_id",        limit: 4
    t.text     "event_text",        limit: 65535
    t.text     "changes",           limit: 65535
    t.integer  "assigned_to_id",    limit: 4
    t.integer  "time_spent",        limit: 4
    t.integer  "created_by_id",     limit: 4
    t.integer  "updated_by_id",     limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size",    limit: 4
    t.datetime "file_updated_at"
    t.integer  "file_category_id",  limit: 4
  end

  add_index "upgrade_events", ["upgrade_id"], name: "index_upgrade_events_on_upgrade_id", using: :btree

  create_table "upgrades", force: :cascade do |t|
    t.integer  "device_id",               limit: 4
    t.text     "upgrade_text",            limit: 65535
    t.integer  "old_robotic_id",          limit: 4
    t.integer  "new_robotic_id",          limit: 4
    t.integer  "old_printer_id",          limit: 4
    t.integer  "new_printer_id",          limit: 4
    t.integer  "old_controller_pc_id",    limit: 4
    t.integer  "new_controller_pc_id",    limit: 4
    t.integer  "robotic_condition_id",    limit: 4
    t.integer  "printer_condition_id",    limit: 4
    t.integer  "controller_condition_id", limit: 4
    t.integer  "category_id",             limit: 4
    t.integer  "dispatch_id",             limit: 4
    t.boolean  "priority"
    t.integer  "contact_id",              limit: 4
    t.integer  "ship_address_id",         limit: 4
    t.string   "tracking_outbound",       limit: 255
    t.string   "tracking_inbound",        limit: 255
    t.integer  "assigned_to_id",          limit: 4
    t.integer  "outbound_carrier_id",     limit: 4
    t.integer  "inbound_carrier_id",      limit: 4
    t.string   "decision_one",            limit: 255
    t.integer  "backup_by_id",            limit: 4
    t.datetime "backup_at"
    t.integer  "built_by_id",             limit: 4
    t.datetime "built_at"
    t.integer  "labeled_by_id",           limit: 4
    t.datetime "labeled_at"
    t.integer  "verified_by_id",          limit: 4
    t.datetime "verified_at"
    t.integer  "shipped_by_id",           limit: 4
    t.datetime "shipped_at"
    t.integer  "return_by_id",            limit: 4
    t.datetime "return_at"
    t.integer  "completed_by_id",         limit: 4
    t.datetime "completed_at"
    t.integer  "backup_method_id",        limit: 4
    t.integer  "software_ver_id",         limit: 4
    t.integer  "ship_method_id",          limit: 4
    t.integer  "created_by_id",           limit: 4
    t.integer  "updated_by_id",           limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "file_file_name",          limit: 255
    t.string   "file_content_type",       limit: 255
    t.integer  "file_file_size",          limit: 4
    t.datetime "file_updated_at"
    t.integer  "file_category_id",        limit: 4
    t.integer  "robotic_type_id",         limit: 4
    t.integer  "printer_type_id",         limit: 4
    t.integer  "controller_type_id",      limit: 4
  end

  add_index "upgrades", ["contact_id"], name: "index_upgrades_on_contact_id", using: :btree
  add_index "upgrades", ["device_id"], name: "index_upgrades_on_device_id", using: :btree

  create_table "user_notifications", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.text     "note",          limit: 65535
    t.string   "link",          limit: 255
    t.boolean  "read"
    t.boolean  "priority"
    t.integer  "created_by_id", limit: 4
    t.integer  "updated_by_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "user_notifications", ["user_id"], name: "index_user_notifications_on_user_id", using: :btree

  create_table "user_rights", force: :cascade do |t|
    t.string   "group",             limit: 255, null: false
    t.boolean  "view_bug"
    t.boolean  "edit_bug"
    t.boolean  "view_repair"
    t.boolean  "update_repair"
    t.boolean  "view_inventory"
    t.boolean  "update_inventory"
    t.boolean  "view_trub"
    t.boolean  "new_update_tr"
    t.boolean  "new_ub"
    t.boolean  "update_ub"
    t.boolean  "move_ticket"
    t.boolean  "new_cust_device"
    t.boolean  "edit_cust_device"
    t.boolean  "view_cust_device"
    t.boolean  "new_edit_cil"
    t.boolean  "view_cil"
    t.boolean  "new_edit_ca"
    t.boolean  "view_ca"
    t.boolean  "new_edit_contract"
    t.boolean  "view_contract"
    t.boolean  "view_attach"
    t.boolean  "vendor_only"
    t.boolean  "view_user"
    t.boolean  "edit_user"
    t.boolean  "admin"
    t.integer  "created_by_id",     limit: 4
    t.integer  "updated_by_id",     limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "title",                  limit: 255
    t.string   "office_ext",             limit: 255
    t.string   "mobile",                 limit: 255
    t.string   "home",                   limit: 255
    t.string   "direct",                 limit: 255
    t.boolean  "listed"
    t.text     "comments",               limit: 65535
    t.boolean  "anonymous"
    t.integer  "department_id",          limit: 4
    t.boolean  "active"
    t.integer  "created_by_id",          limit: 4
    t.integer  "updated_by_id",          limit: 4
    t.string   "username",               limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "version_notes", force: :cascade do |t|
    t.string   "version",       limit: 255,   null: false
    t.text     "note",          limit: 65535
    t.integer  "created_by_id", limit: 4
    t.integer  "updated_by_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "watches", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "object_id",   limit: 4
    t.string   "object_type", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "watches", ["object_type", "object_id"], name: "index_watches_on_object_type_and_object_id", using: :btree
  add_index "watches", ["user_id"], name: "index_watches_on_user_id", using: :btree

  add_foreign_key "bug_notes", "bugs"
  add_foreign_key "bug_notes", "devices"
  add_foreign_key "build_events", "builds"
  add_foreign_key "builds", "contacts"
  add_foreign_key "builds", "controller_pcs"
  add_foreign_key "builds", "devices"
  add_foreign_key "builds", "printers"
  add_foreign_key "builds", "robotics"
  add_foreign_key "contact_events", "contacts"
  add_foreign_key "contacts", "customers"
  add_foreign_key "contracts", "devices"
  add_foreign_key "controller_pcs", "devices"
  add_foreign_key "customer_events", "customers"
  add_foreign_key "customers", "umbrellas"
  add_foreign_key "device_connections", "devices"
  add_foreign_key "device_events", "devices"
  add_foreign_key "device_interfaces", "devices"
  add_foreign_key "device_licenses", "devices"
  add_foreign_key "devices", "contacts"
  add_foreign_key "devices", "customers"
  add_foreign_key "printers", "devices"
  add_foreign_key "purchase_orders", "contracts"
  add_foreign_key "purchase_orders", "devices"
  add_foreign_key "purchase_orders", "rmas"
  add_foreign_key "purchase_orders", "tickets"
  add_foreign_key "rma_events", "rmas"
  add_foreign_key "rmas", "contacts"
  add_foreign_key "rmas", "tickets"
  add_foreign_key "robotics", "devices"
  add_foreign_key "ticket_events", "tickets"
  add_foreign_key "tickets", "contacts"
  add_foreign_key "tickets", "devices"
  add_foreign_key "upgrade_events", "upgrades"
  add_foreign_key "upgrades", "contacts"
  add_foreign_key "upgrades", "devices"
  add_foreign_key "user_notifications", "users"
  add_foreign_key "watches", "users"
end
