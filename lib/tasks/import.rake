namespace :import do
  desc 'import the legacy db data'
    
  task :dropdowns => :environment do
    puts "importing dropdowns"

    class OldDropdown < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'Dropdown'
      self.primary_key = 'ID'
    end

    puts "total #{OldDropdown.count}"
    OldDropdown.all.each do |u|
      puts "#{u.attributes["ID"]}" if (u.attributes["ID"].to_i % 1000) == 0
      date_created = u.attributes["DateCreated"].to_s.blank? ? '1970-01-01 00:00:00 UTC' : u.attributes["DateCreated"]
      if u.attributes["DateCreated"].to_s.blank?
        puts "#{u.attributes["ID"]} blank date reset to #{date_created.to_s}"
      end
      Dropdown.create(
        dropdown_type: u.attributes["Type"],
        name: u.attributes["Name"],
        desc: u.attributes["Desc"],
        active: u.attributes["Active"],
        current: u.attributes["Current"],
        created_at: Time.parse(date_created.to_s),
        created_by_id: u.attributes["CreatedBy"],
        updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
        updated_by_id: u.attributes["ModifiedBy"]
      )
    end
    puts "imported #{Dropdown.count}"
  end
  
  task :addresses => :environment do    
    puts"importing addresses"
    
    class OldDropdown < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'Dropdown'
      self.primary_key = 'ID'
    end
    
    class OldAddress < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'Address'
      self.primary_key = 'ID'
    end
    
    puts "total #{OldAddress.count}"
    OldAddress.all.each do |u|
      puts "#{u.attributes["ID"]}" if (u.attributes["ID"].to_i % 1000) == 0
      date_created = u.attributes["DateCreated"].to_s.blank? ? '1970-01-01 00:00:00 UTC' : u.attributes["DateCreated"]
      if u.attributes["DateCreated"].to_s.blank?
        puts "#{u.attributes["ID"]} blank date reset to #{date_created.to_s}"
      end
      old_type = OldDropdown.find_by(id: u.attributes["TypeID"])
      old_type = old_type.nil? ? "DeviceShipping" : old_type.attributes["Name"]
      
      Address.create(
        id: u.attributes["ID"],
        attached_to_id: u.attributes["AttachID"],
        attached_to_type: old_type.split(/(?=[A-Z])/)[0],
        address_type: Dropdown.find_by(name: old_type, dropdown_type: 'AddressType'),
        line_1: u.attributes["Add1"],
        line_2: u.attributes["Add2"],
        city: u.attributes["City"],
        state: u.attributes["State"],
        zip: u.attributes["Zip"],
        country: u.attributes["Country"],
        comments: u.attributes["Comments"],
        active: u.attributes["Active"],
        created_at: Time.parse(date_created.to_s),
        created_by_id: u.attributes["CreatedBy"],
        updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
        updated_by_id: u.attributes["ModifiedBy"]
      ).update_column(:id, u.attributes["ID"])
    end
    puts "imported #{Address.count}"
  end
   
  task :customers => :environment do
    puts "importing customers"
    
    class OldDropdown < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'Dropdown'
      self.primary_key = 'ID'
    end
    
    class OldCustomer < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'Customer'
      self.primary_key = 'ID'
    end
    
    puts "total #{OldCustomer.count}"
    OldCustomer.all.each do |u|
      puts "#{u.attributes["ID"]}" if (u.attributes["ID"].to_i % 1000) == 0
      date_created = u.attributes["DateCreated"].to_s.blank? ? '1970-01-01 00:00:00 UTC' : u.attributes["DateCreated"]
      if u.attributes["DateCreated"].to_s.blank?
        puts "#{u.attributes["ID"]} blank date reset to #{date_created.to_s}"
      end
      old_type = OldDropdown.find_by(id: u.attributes["CustomerTypeID"])
      Customer.create(
        id: u.attributes["ID"],
        name: u.attributes["Name"],
        alias: u.attributes["Alias"],
        customer_type: Dropdown.find_by(name: old_type.nil? ? 'nil' : old_type.attributes["Name"], dropdown_type: 'CustomerType'),
        phone: u.attributes["Phone"],
        fax: u.attributes["Fax"],
        web: u.attributes["Web"],
        comments: u.attributes["Comments"],
        show_comments: u.attributes["ShowComments"],
        alert: u.attributes["Alert"],
        show_alert: u.attributes["ShowAlert"],
        active: u.attributes["Active"],
        created_at: Time.parse(date_created.to_s),
        created_by_id: u.attributes["CreatedBy"],
        updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
        updated_by_id: u.attributes["ModifiedBy"]
      ).update_column(:id, u.attributes["ID"])
    end
    puts "imported #{Customer.count}"
  end
   
  task :contacts => :environment do
    puts "importing contacts"
    
    class OldDropdown < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'Dropdown'
      self.primary_key = 'ID'
    end
    
    class OldContact < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'Contact'
      self.primary_key = 'ID'
    end
    
    puts "total #{OldContact.count}"
    OldContact.all.each do |u|
      puts "#{u.attributes["ID"]}" if (u.attributes["ID"].to_i % 1000) == 0
      date_created = u.attributes["DateCreated"].to_s.blank? ? '1970-01-01 00:00:00 UTC' : u.attributes["DateCreated"]
      if u.attributes["DateCreated"].to_s.blank?
        puts "#{u.attributes["ID"]} blank date reset to #{date_created.to_s}"
      end
      old_type = OldDropdown.find_by(id: u.attributes["ContactTypeID"])
      Contact.create(
        id: u.attributes["ID"],
        customer: Customer.find_by(id: u.attributes["CustomerID"]),
        contact_type: Dropdown.find_by(name: old_type.nil? ? 'nil' : old_type.attributes["Name"], dropdown_type: 'ContactType'),
        first_name: u.attributes["FirstName"],
        last_name: u.attributes["LastName"],
        title: u.attributes["Title"],
        department: u.attributes["Dept"],
        phone: u.attributes["Phone"],
        cell: u.attributes["Cell"],
        pager: u.attributes["Pager"],
        fax: u.attributes["Fax"],
        email: u.attributes["Email"],
        comments: u.attributes["Comments"],
        active: u.attributes["Active"],
        created_at: Time.parse(date_created.to_s),
        created_by_id: u.attributes["CreatedBy"],
        updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
        updated_by_id: u.attributes["ModifiedBy"]
      ).update_column(:id, u.attributes["ID"])
    end
    puts "imported #{Contact.count}"
  end
  
  task :devices => :environment do
    puts "importing devices"
    
    class OldDropdown < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'Dropdown'
      self.primary_key = 'ID'
    end
    
    class OldDevice < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'Device'
      self.primary_key = 'ID'
    end
    
    puts "total #{OldDevice.count}"
    OldDevice.all.each do |u|
      puts "#{u.attributes["ID"]}" if (u.attributes["ID"].to_i % 1000) == 0
      date_created = u.attributes["DateCreated"].to_s.blank? ? '1970-01-01 00:00:00 UTC' : u.attributes["DateCreated"]
      if u.attributes["DateCreated"].to_s.blank?
        puts "#{u.attributes["ID"]} blank date reset to #{date_created.to_s}"
      end
      old_contact_type = OldDropdown.find_by(id: u.attributes["ContactTypeID"])
      old_device_type = OldDropdown.find_by(id: u.attributes["ContactTypeID"])
      if Device.find_by(id: u.attributes["ID"]).nil?
        Device.create(
          id: u.attributes["ID"],
          cust_number: u.attributes["CustNumber"],
          customer: Customer.find_by(id: u.attributes["CustomerID"]),
          contact_type: Dropdown.find_by(name: old_contact_type.nil? ? 'nil' : old_contact_type.attributes["Name"], dropdown_type: 'ContactType'),
          device_type: Dropdown.find_by(name: old_device_type.nil? ? 'nil' : old_device_type.attributes["Name"], dropdown_type: 'DeviceType'),
          location: u.attributes["Location"],
          contact: Contact.find_by(id: u.attributes["PrimaryContactID"]),
          trade_old_id: u.attributes["TradeOldID"],
          trade_new_id: u.attributes["TradeNewID"],
          print_head: u.attributes["PrintHeadReplacement"],
          comments: u.attributes["Comments"],
          install_by_id: u.attributes["InstallBy"],
          install_at: u.attributes["InstallDate"].present? ? Time.parse(u.attributes["InstallDate"].to_s) : u.attributes["DateCreated"].to_s,
          twentyfour_seven: u.attributes["24By7"],
          machine_guid: u.attributes["MachineGUID"],
          active: u.attributes["Active"],
          active_cloud: u.attributes["ActiveInCloud"],
          created_at: Time.parse(date_created.to_s),
          created_by_id: u.attributes["CreatedBy"],
          updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
          updated_by_id: u.attributes["ModifiedBy"]
        ).update_column(:id, u.attributes["ID"])
        
        old_robot_type = OldDropdown.find_by(id: u.attributes["RoboticTypeID"])
        old_robot_flash = OldDropdown.find_by(id: u.attributes["RoboticFlashID"])
        old_burner_flash = OldDropdown.find_by(id: u.attributes["BurnerFlashID"])
        old_burner_type = OldDropdown.find_by(id: u.attributes["BurnerTypeID"])
        old_cable_type = OldDropdown.find_by(id: u.attributes["CableTypeID"])
        
        Robotic.create(
          serial: u.attributes["RoboticSN"],
          robotic_type: Dropdown.find_by(name: old_robot_type.nil? ? 'nil' : old_robot_type.attributes["Name"], dropdown_type: 'RoboticType'),
          device_id: u.attributes["ID"],
          robotic_flash: Dropdown.find_by(name: old_robot_flash.nil? ? 'nil' : old_robot_flash.attributes["Name"], dropdown_type: 'RoboticFlash'),
          burner_flash: Dropdown.find_by(name: old_burner_flash.nil? ? 'nil' : old_burner_flash.attributes["Name"], dropdown_type: 'BurnerFlash'),
          burner_type: Dropdown.find_by(name: old_burner_type.nil? ? 'nil' : old_burner_type.attributes["Name"], dropdown_type: 'BurnerType'),
          cable_type: Dropdown.find_by(name: old_cable_type.nil? ? 'nil' : old_cable_type.attributes["Name"], dropdown_type: 'CableType'),
          num_burners: u.attributes["NumBurners"],
          created_at: Time.parse(date_created.to_s),
          created_by_id: u.attributes["CreatedBy"],
          updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
          updated_by_id: u.attributes["ModifiedBy"]
        )
        
        old_printer_type = OldDropdown.find_by(id: u.attributes["PrinterTypeID"])
        old_printer_flash = OldDropdown.find_by(id: u.attributes["PrinterFlashID"])
        
        Printer.create(
          serial: u.attributes["PrinterSN"],
          printer_type: Dropdown.find_by(name: old_printer_type.nil? ? 'nil' : old_printer_type.attributes["Name"], dropdown_type: 'PrinterType'),
          device_id: u.attributes["ID"],
          printer_flash: Dropdown.find_by(name: old_printer_flash.nil? ? 'nil' : old_printer_flash.attributes["Name"], dropdown_type: 'PrinterFlash'),
          created_at: Time.parse(date_created.to_s),
          created_by_id: u.attributes["CreatedBy"],
          updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
          updated_by_id: u.attributes["ModifiedBy"]
        )
        
        old_controller_type = OldDropdown.find_by(id: u.attributes["ControllerTypeID"])
        old_software_ver = OldDropdown.find_by(id: u.attributes["SoftwareVerID"])
        old_rimage_ver = OldDropdown.find_by(id: u.attributes["RimageVerID"])
        old_osver = OldDropdown.find_by(id: u.attributes["OSVerID"])
        
        ControllerPc.create(
          serial: u.attributes["ControllerSN"],
          controller_type: Dropdown.find_by(name: old_controller_type.nil? ? 'nil' : old_controller_type.attributes["Name"], dropdown_type: 'ControllerType'),
          device_id: u.attributes["ID"],
          software_ver: Dropdown.find_by(name: old_software_ver.nil? ? 'nil' : old_software_ver.attributes["Name"], dropdown_type: 'SoftwareVer'),
          rimage_ver: Dropdown.find_by(name: old_rimage_ver.nil? ? 'nil' : old_rimage_ver.attributes["Name"], dropdown_type: 'RimageVer'),
          os_ver: Dropdown.find_by(name: old_osver.nil? ? 'nil' : old_osver.attributes["Name"], dropdown_type: 'OSVer'),
          created_at: Time.parse(date_created.to_s),
          created_by_id: u.attributes["CreatedBy"],
          updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
          updated_by_id: u.attributes["ModifiedBy"]
        )
      end
    end
    puts "imported #{Device.count}"
  end
   
  task :contracts => :environment do
    puts "importing contracts"
    
    class OldDropdown < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'Dropdown'
      self.primary_key = 'ID'
    end
    
    class OldContract < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'Contract'
      self.primary_key = 'ID'
    end
    
    puts "total #{OldContract.count}"
    OldContract.all.each do |u|
      puts "#{u.attributes["ID"]}" if (u.attributes["ID"].to_i % 1000) == 0
      date_created = u.attributes["DateCreated"].to_s.blank? ? '1970-01-01 00:00:00 UTC' : u.attributes["DateCreated"]
      if u.attributes["DateCreated"].to_s.blank?
        puts "#{u.attributes["ID"]} blank date reset to #{date_created.to_s}"
      end
      old_contract_holder = OldDropdown.find_by(id: u.attributes["ContractHolderID"])
      old_contract_type = OldDropdown.find_by(id: u.attributes["ContractTypeID"])
      Contract.create(
        id: u.attributes["ID"],
        device: Device.find_by(id: u.attributes["DeviceID"]),
        contract_holder: Dropdown.find_by(name: old_contract_holder.nil? ? 'nil' : old_contract_holder.attributes["Name"], dropdown_type: 'ContractHolder'),
        contract_type: Dropdown.find_by(name: old_contract_type.nil? ? 'nil' : old_contract_type.attributes["Name"], dropdown_type: 'ContractType'),
        invoice: u.attributes["Invoice"],
        service_exp_at: u.attributes["ServiceExpDate"].present? ? Time.parse(u.attributes["ServiceExpDate"].to_s) : u.attributes["DateCreated"].to_s,
        warranty_exp_at: u.attributes["WarrantyExpDate"].present? ? Time.parse(u.attributes["WarrantyExpDate"].to_s) : u.attributes["DateCreated"].to_s,
        customer_po: u.attributes["CustomerPO"],
        comments: u.attributes["Comments"],
        created_at: Time.parse(date_created.to_s),
        created_by_id: u.attributes["CreatedBy"],
        updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
        updated_by_id: u.attributes["ModifiedBy"]
      ).update_column(:id, u.attributes["ID"])
    end
    puts "imported #{Contract.count}"
  end
   
  task :users => :environment do
    puts "importing users"
    
    class OldDropdown < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'Dropdown'
      self.primary_key = 'ID'
    end
    
    class OldUser < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'User'
      self.primary_key = 'ID'
    end
    
    puts "total: #{OldUser.count}"
    OldUser.all.each do |u|
      puts "#{u.attributes["ID"]}" if (u.attributes["ID"].to_i % 1000) == 0
      date_created = u.attributes["DateCreated"].to_s.blank? ? '1970-01-01 00:00:00 UTC' : u.attributes["DateCreated"]
      if u.attributes["DateCreated"].to_s.blank?
        puts "#{u.attributes["ID"]} blank date reset to #{date_created.to_s}"
      end
      old_dept = OldDropdown.find_by(id: u.attributes["DeptID"])
      name = u.attributes["Email"].split('@')[0].split('.')
      User.create(
        id: u.attributes["ID"],
        username: u.attributes["Email"].split('@')[0],
        email: u.attributes["Email"],
        title: u.attributes["Title"],
        office_ext: u.attributes["OfficeExt"],
        mobile: u.attributes["Mobile"],
        home: u.attributes["Home"],
        direct: u.attributes["DirectPhone"],
        listed: u.attributes["Listed"],
        comments: u.attributes["Comments"],
        anonymous: u.attributes["IsAnonymous"],
        active: u.attributes["Active"],
        first_name: name[0].nil? ? 'Mystery' : name[0].capitalize,
        last_name: name[1].nil? ? 'Man' : name[1].capitalize,
        department: Dropdown.find_by(name: old_dept.nil? ? 'nil' : old_dept.attributes["Name"], dropdown_type: 'UserDept'),
        created_at: Time.parse(date_created.to_s),
        created_by_id: u.attributes["CreatedBy"],
        updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
        updated_by_id: u.attributes["ModifiedBy"],
        password: 'password',
        password_confirmation: 'password'
      ).update_column(:id, u.attributes["ID"])
    end
    puts "imported #{User.count}"
  end
   
  task :device_interfaces => :environment do
    puts "importing device interfaces"
    
    class OldDropdown < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'Dropdown'
      self.primary_key = 'ID'
    end
    
    class OldDeviceInterface < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'DeviceInterface'
      self.primary_key = 'ID'
    end
    
    puts "total: #{OldDeviceInterface.count}"
    OldDeviceInterface.all.each do |u|
      puts "#{u.attributes["ID"]}" if (u.attributes["ID"].to_i % 1000) == 0
      date_created = u.attributes["DateCreated"].to_s.blank? ? '1970-01-01 00:00:00 UTC' : u.attributes["DateCreated"]
      if u.attributes["DateCreated"].to_s.blank?
        puts "#{u.attributes["ID"]} blank date reset to #{date_created.to_s}"
      end
      old_inter_type = OldDropdown.find_by(id: u.attributes["InterfaceTypeID"])
      old_inter_ven = OldDropdown.find_by(id: u.attributes["InterfaceVendorID"])
      old_qr_model = OldDropdown.find_by(id: u.attributes["QRModelID"])
      old_qr_level = OldDropdown.find_by(id: u.attributes["QRLevelID"])
      DeviceInterface.create(
        id: u.attributes["ID"],
        device: Device.find_by(id: u.attributes["DeviceID"]),
        interface_type: Dropdown.find_by(name: old_inter_type.nil? ? 'nil' : old_inter_type.attributes["Name"], dropdown_type: 'InterfaceType'),
        interface_vendor: Dropdown.find_by(name: old_inter_ven.nil? ? 'nil' : old_inter_ven.attributes["Name"], dropdown_type: 'InterfaceVendor'),
        desc: u.attributes["Desc"],
        ip: u.attributes["IP"],
        ae_title: u.attributes["AETitle"],
        port: u.attributes["Port"],
        gateway: u.attributes["Gateway"],
        submask: u.attributes["Submask"],
        dns_1: u.attributes["DNS1"],
        dns_2: u.attributes["DNS2"],
        mac: u.attributes["MAC"],
        wins: u.attributes["Wins"],
        ras_ip_1: u.attributes["RASIP1"],
        ras_ip_2: u.attributes["RASIP2"],
        login: u.attributes["Login"],
        password: u.attributes["Password"],
        qr_model: Dropdown.find_by(name: old_qr_model.nil? ? 'nil' : old_qr_model.attributes["Name"], dropdown_type: 'QRModel'),
        qr_level: Dropdown.find_by(name: old_qr_level.nil? ? 'nil' : old_qr_level.attributes["Name"], dropdown_type: 'QRLevel'),
        comments: u.attributes["Comments"],
        active: u.attributes["Active"],
        created_at: Time.parse(date_created.to_s),
        created_by_id: u.attributes["CreatedBy"],
        updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
        updated_by_id: u.attributes["ModifiedBy"],
      ).update_column(:id, u.attributes["ID"])
    end
    puts "imported #{DeviceInterface.count}"
  end
   
  task :device_licenses => :environment do
    puts "importing device licenses"
    
    class OldDropdown < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'Dropdown'
      self.primary_key = 'ID'
    end
    
    class OldDeviceLicense < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'DeviceLicense'
      self.primary_key = 'ID'
    end
    
    puts "total #{OldDeviceLicense.count}"
    OldDeviceLicense.all.each do |u|
      puts "#{u.attributes["ID"]}" if (u.attributes["ID"].to_i % 1000) == 0
      date_created = u.attributes["DateCreated"].to_s.blank? ? '1970-01-01 00:00:00 UTC' : u.attributes["DateCreated"]
      if u.attributes["DateCreated"].to_s.blank?
        puts "#{u.attributes["ID"]} blank date reset to #{date_created.to_s}"
      end
      old_license_type = OldDropdown.find_by(id: u.attributes["LicenseTypeID"])
      DeviceLicense.create(
        id: u.attributes["ID"],
        device: Device.find_by(id: u.attributes["DeviceID"]),
        license_type: Dropdown.find_by(name: old_license_type.nil? ? 'nil' : old_license_type.attributes["Name"], dropdown_type: 'LicenseType'),
        desc: u.attributes["Desc"],
        value: u.attributes["Value"],
        comments: u.attributes["Comments"],
        active: u.attributes["Active"],
        created_at: Time.parse(date_created.to_s),
        created_by_id: u.attributes["CreatedBy"],
        updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
        updated_by_id: u.attributes["ModifiedBy"],
      ).update_column(:id, u.attributes["ID"])
    end
    puts "imported #{DeviceLicense.count}"
  end
   
  task :inventory => :environment do
    puts "importing inventory"
    
    class OldDropdown < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'Dropdown'
      self.primary_key = 'ID'
    end
    
    class OldInventory < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'Inventory'
      self.primary_key = 'ID'
    end
    
    puts "total #{OldInventory.count}"
    OldInventory.all.each do |u|
      puts "#{u.attributes["ID"]}" if (u.attributes["ID"].to_i % 1000) == 0
      date_created = u.attributes["DateCreated"].to_s.blank? ? '1970-01-01 00:00:00 UTC' : u.attributes["DateCreated"]
      if u.attributes["DateCreated"].to_s.blank?
        puts "#{u.attributes["ID"]} blank date reset to #{date_created.to_s}"
      end
      old_hardware_type = OldDropdown.find_by(id: u.attributes["HWTypeID"])
      hardware_type = Dropdown.find_by(name: old_hardware_type.nil? ? 'Robotic' : old_hardware_type.attributes["Name"], dropdown_type: 'HWType')
      old_model = OldDropdown.find_by(id: u.attributes["ModelID"])
      if hardware_type == 'Robotic'
        hardware = Robotic.find_by(serial: u.attributes["SerialNumber"])
        if hardware.nil?
          Robotic.create(
            serial: u.attributes["Serial"],
            robotic_type: Dropdown.find_by(name: old_model.nil? ? 'nil' : old_model.attributes["Name"], dropdown_type: 'RoboticType'),
            created_at: Time.parse(date_created.to_s),
            created_by_id: u.attributes["CreatedBy"],
            updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
            updated_by_id: u.attributes["ModifiedBy"]
          )
        end
      elsif hardware_type == 'Printer'
        hardware = Printer.find_by(serial: u.attributes["SerialNumber"])
        if hardware.nil?
          Printer.create(
            serial: u.attributes["Serial"],
            printer_type: Dropdown.find_by(name: old_model.nil? ? 'nil' : old_model.attributes["Name"], dropdown_type: 'PrinterType'),
            created_at: Time.parse(date_created.to_s),
            created_by_id: u.attributes["CreatedBy"],
            updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
            updated_by_id: u.attributes["ModifiedBy"]
          )
        end
      elsif hardware_type == 'Controller'
        hardware = ControllerPc.find_by(serial: u.attributes["SerialNumber"])
        if hardware.nil?
          ControllerPc.create(
            serial: u.attributes["Serial"],
            controller_type: Dropdown.find_by(name: old_model.nil? ? 'nil' : old_model.attributes["Name"], dropdown_type: 'ControllerType'),
            created_at: Time.parse(date_created.to_s),
            created_by_id: u.attributes["CreatedBy"],
            updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
            updated_by_id: u.attributes["ModifiedBy"]
          )
        end
      end
    end
    puts "imported into seperate tables"
  end
   
  task :hardware_events => :environment do
    puts "importing inventory notes"
    
    class OldInventoryNote < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'InventoryNote'
      self.primary_key = 'ID'
    end
    
    puts "total #{OldInventoryNote.count}"
    OldInventoryNote.all.each do |u|
      puts "#{u.attributes["ID"]}" if (u.attributes["ID"].to_i % 1000) == 0
      date_created = u.attributes["DateCreated"].to_s.blank? ? '1970-01-01 00:00:00 UTC' : u.attributes["DateCreated"]
      if u.attributes["DateCreated"].to_s.blank?
        puts "#{u.attributes["ID"]} blank date reset to #{date_created.to_s}"
      end
      hardware = Robotic.find_by(serial: u.attributes["SerialNumber"])
      if hardware.nil?
        hardware = Printer.find_by(serial: u.attributes["SerialNumber"])
        if hardware.nil?
          hardware = ControllerPc.find_by(serial: u.attributes["SerialNumber"])
        end
      end
      
      unless hardware.nil?
        HardwareEvent.create(
            hardware: hardware,
            note: u.attributes["Note"],
            created_at: Time.parse(date_created.to_s),
            created_by_id: u.attributes["CreatedBy"],
            updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
            updated_by_id: u.attributes["ModifiedBy"]
        )
      end
    end
    puts "imported #{HardwareEvent.count}"
  end
   
  task :device_connections => :environment do
    puts "importing device connections"
    
    class OldDropdown < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'Dropdown'
      self.primary_key = 'ID'
    end
    
    class OldDeviceConnection < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'DeviceConnection'
      self.primary_key = 'ID'
    end
    
    puts "total #{OldDeviceConnection.count}"
    OldDeviceConnection.all.each do |u|
      puts "#{u.attributes["ID"]}" if (u.attributes["ID"].to_i % 1000) == 0
      date_created = u.attributes["DateCreated"].to_s.blank? ? '1970-01-01 00:00:00 UTC' : u.attributes["DateCreated"]
      if u.attributes["DateCreated"].to_s.blank?
        puts "#{u.attributes["ID"]} blank date reset to #{date_created.to_s}"
      end
      old_type = OldDropdown.find_by(id: u.attributes["ConnectionTypeID"])
      DeviceConnection.create(
        id: u.attributes["ID"],
        device: Device.find_by(id: u.attributes["DeviceID"]),
        connection_type: Dropdown.find_by(name: old_type.nil? ? 'nil' : old_type.attributes["Name"], dropdown_type: 'ConnectionType'),
        phone: u.attributes["Phone"],
        vpn_ip: u.attributes["VPNIP"],
        vpn_login: u.attributes["VPNLogin"],
        vpn_password: u.attributes["VPNPassword"],
        vpn_group_name: u.attributes["VPNGroupName"],
        vpn_group_password: u.attributes["VPNGroupPassword"],
        vpn_domain: u.attributes["VPNDomain"],
        dhcp: u.attributes["DHCP"],
        ip: u.attributes["IP"],
        script: u.attributes["Script"],
        login: u.attributes["Login"],
        password: u.attributes["Password"],
        domain: u.attributes["Domain"],
        pca_login: u.attributes["PCALogin"],
        pca_password: u.attributes["PCAPassword"],
        pca_domain: u.attributes["PCADomain"],
        comments: u.attributes["Comments"],
        active: u.attributes["Active"],
        created_at: Time.parse(date_created.to_s),
        created_by_id: u.attributes["CreatedBy"],
        updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
        updated_by_id: u.attributes["ModifiedBy"],
      ).update_column(:id, u.attributes["ID"])
    end
    puts "imported #{DeviceConnection.count}"
  end
   
  task :inventory_parts => :environment do
    puts "importing inventory parts"
        
    class OldInventoryPart < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'InventoryParts'
      self.primary_key = 'ID'
    end
    
    puts "total #{OldInventoryPart.count}"
    OldInventoryPart.all.each do |u|
      puts "#{u.attributes["ID"]}" if (u.attributes["ID"].to_i % 1000) == 0
      date_created = u.attributes["DateCreated"].to_s.blank? ? '1970-01-01 00:00:00 UTC' : u.attributes["DateCreated"]
      if u.attributes["DateCreated"].to_s.blank?
        puts "#{u.attributes["ID"]} blank date reset to #{date_created.to_s}"
      end
      Inventory.create(
        id: u.attributes["ID"],
        part_number: u.attributes["PartNumber"],
        rack_number: u.attributes["RackNumber"],
        description: u.attributes["Desc"],
        inventory_level: u.attributes["InventoryLevel"],
        reorder_level: u.attributes["ReOrderLevel"],
        warehouse: u.attributes["Warehouse"],
        repair_depot: u.attributes["RepairDepot"],
        active: u.attributes["Active"],
        created_at: Time.parse(date_created.to_s),
        created_by_id: u.attributes["CreatedBy"],
        updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
        updated_by_id: u.attributes["ModifiedBy"],
      ).update_column(:id, u.attributes["ID"])
    end
    puts "imported #{Inventory.count}"
  end
  
  task :tickets => :environment do
    puts "importing tickets"
    
    class OldDropdown < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'Dropdown'
      self.primary_key = 'ID'
    end
    
    class OldTicket < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'Ticket'
      self.primary_key = 'ID'
    end
    
    puts "total #{OldTicket.count}"
    OldTicket.all.each do |u|
      puts "#{u.attributes["ID"]}" if (u.attributes["ID"].to_i % 1000) == 0
      date_created = u.attributes["DateCreated"].to_s.blank? ? '1970-01-01 00:00:00 UTC' : u.attributes["DateCreated"]
      if u.attributes["DateCreated"].to_s.blank?
        puts "#{u.attributes["ID"]} blank date reset to #{date_created.to_s}"
      end
      device = Device.find_by(id: u.attributes["DeviceID"])
      old_status = device.nil? ? OldDropdown.find_by(name: 'Ticket Resolved') : OldDropdown.find_by(id: u.attributes["StatusTypeID"])
      old_category = OldDropdown.find_by(id: u.attributes["CategoryID"])
      
      Ticket.create(
        id: u.attributes["ID"],
        device: device,
        ticket_text: u.attributes["TicketText"],
        status: Dropdown.find_by(name: old_status.nil? ? 'nil' : old_status.attributes["Name"], dropdown_type: 'TicketStatusType'),
        assigned_to_id: u.attributes["AssignedToID"],
        priority: u.attributes["Priority"],
        category: Dropdown.find_by(name: old_category.nil? ? 'nil' : old_category.attributes["Name"], dropdown_type: 'TicketCategory'),
        mdr: u.attributes["MDRID"],
        authorized: u.attributes["Authorized"],
        contact: Contact.find_by(id: u.attributes["ContactID"]),
        created_at: Time.parse(date_created.to_s),
        created_by_id: u.attributes["CreatedBy"],
        updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
        updated_by_id: u.attributes["ModifiedBy"],
      ).update_column(:id, u.attributes["ID"])
    end
    puts "imported #{Ticket.count}"
  end
  
  task :ticket_events => :environment do
    puts "importing ticket events"
    
    class OldDropdown < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'Dropdown'
      self.primary_key = 'ID'
    end
    
    class OldTicketEvent < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'TicketEvent'
      self.primary_key = 'ID'
    end
    
    puts "total #{OldTicketEvent.count}"
    OldTicketEvent.all.each do |u|
      puts "#{u.attributes["ID"]}" if (u.attributes["ID"].to_i % 10000) == 0
      date_created = u.attributes["DateCreated"].to_s.blank? ? '1970-01-01 00:00:00 UTC' : u.attributes["DateCreated"]
      if u.attributes["DateCreated"].to_s.blank?
        puts "#{u.attributes["ID"]} blank date reset to #{date_created.to_s}"
      end
      old_status = OldDropdown.find_by(id: u.attributes["StatusTypeID"])
      ticket_event = TicketEvent.create(
        id: u.attributes["ID"],
        ticket: Ticket.find_by(id: u.attributes["TicketID"]),
        event_text: u.attributes["EventText"],
        status: Dropdown.find_by(name: old_status.nil? ? 'nil' : old_status.attributes["Name"], dropdown_type: 'TicketStatusType'),
        assigned_to_id: u.attributes["AssignedToID"],
        time_spent: u.attributes["TimeSpent"],
        created_at: Time.parse(date_created.to_s),
        created_by_id: u.attributes["CreatedBy"],
        updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
        updated_by_id: u.attributes["ModifiedBy"],
      )
      #puts "old id: #{u.attributes["ID"]}, new id: #{ticket_event.id}"
      #ticket_event.update_column(:id, u.attributes["ID"])
    end
    puts "imported #{TicketEvent.count}"
  end
  
  task :rmas => :environment do
    puts "importing rmas"
    
    class OldDropdown < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'Dropdown'
      self.primary_key = 'ID'
    end
    
    class OldRma < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'RMA'
      self.primary_key = 'ID'
    end
    
    puts "total #{OldRma.count}"
    OldRma.all.each do |u|
      puts "#{u.attributes["ID"]}" if (u.attributes["ID"].to_i % 1000) == 0
      date_created = u.attributes["DateCreated"].to_s.blank? ? '1970-01-01 00:00:00 UTC' : u.attributes["DateCreated"]
      if u.attributes["DateCreated"].to_s.blank?
        puts "#{u.attributes["ID"]} blank date reset to #{date_created.to_s}"
      end
      old_robotic = Robotic.find_by(serial: u.attributes["RoboticOldSN"])
      new_robotic = Robotic.find_by(serial: u.attributes["RoboticNewSN"])
      if old_robotic.nil?
        old_robot_type = OldDropdown.find_by(id: u.attributes["RoboticOldID"])
        old_robotic = Robotic.create(
          serial: u.attributes["RoboticOldSN"],
          robotic_type: Dropdown.find_by(name: old_robot_type.nil? ? 'nil' : old_robot_type.attributes["Name"], dropdown_type: 'RoboticType'),
          created_at: Time.parse(date_created.to_s),
          created_by_id: u.attributes["CreatedBy"],
          updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
          updated_by_id: u.attributes["ModifiedBy"]
        )
      end
      if new_robotic.nil?
        new_robot_type = OldDropdown.find_by(id: u.attributes["RoboticNewID"])
        new_robotic = Robotic.create(
          serial: u.attributes["RoboticNewSN"],
          robotic_type: Dropdown.find_by(name: new_robot_type.nil? ? 'nil' : new_robot_type.attributes["Name"], dropdown_type: 'RoboticType'),
          created_at: Time.parse(date_created.to_s),
          created_by_id: u.attributes["CreatedBy"],
          updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
          updated_by_id: u.attributes["ModifiedBy"]
        )
      end
      
      old_printer = Printer.find_by(serial: u.attributes["PrinterOldSN"])
      new_printer = Printer.find_by(serial: u.attributes["PrinterNewSN"])
      if old_printer.nil?
        old_printer_type = OldDropdown.find_by(id: u.attributes["PrinterOldID"])
        old_printer = Printer.create(
          serial: u.attributes["PrinterOldSN"],
          printer_type: Dropdown.find_by(name: old_printer_type.nil? ? 'nil' : old_printer_type.attributes["Name"], dropdown_type: 'PrinterType'),
          created_at: Time.parse(date_created.to_s),
          created_by_id: u.attributes["CreatedBy"],
          updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
          updated_by_id: u.attributes["ModifiedBy"]
        )
      end
      if new_printer.nil?
        new_printer_type = OldDropdown.find_by(id: u.attributes["PrinterNewID"])
        new_printer = Printer.create(
          serial: u.attributes["PrinterNewSN"],
          printer_type: Dropdown.find_by(name: new_printer_type.nil? ? 'nil' : new_printer_type.attributes["Name"], dropdown_type: 'PrinterType'),
          created_at: Time.parse(date_created.to_s),
          created_by_id: u.attributes["CreatedBy"],
          updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
          updated_by_id: u.attributes["ModifiedBy"]
        )
      end
      
      old_controller_pc = ControllerPc.find_by(serial: u.attributes["ControllerOldSN"])
      new_controller_pc = ControllerPc.find_by(serial: u.attributes["ControllerNewSN"])
      if old_controller_pc.nil?
        old_controller_type = OldDropdown.find_by(id: u.attributes["ControllerOldID"])
        old_controller_pc = ControllerPc.create(
          serial: u.attributes["ControllerOldSN"],
          controller_type: Dropdown.find_by(name: old_controller_type.nil? ? 'nil' : old_controller_type.attributes["Name"], dropdown_type: 'ControllerType'),
          created_at: Time.parse(date_created.to_s),
          created_by_id: u.attributes["CreatedBy"],
          updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
          updated_by_id: u.attributes["ModifiedBy"]
        )
      end
      if new_controller_pc.nil?
        new_controller_type = OldDropdown.find_by(id: u.attributes["ControllerNewID"])
        new_controller_pc = ControllerPc.create(
          serial: u.attributes["ControllerNewSN"],
          controller_type: Dropdown.find_by(name: new_controller_type.nil? ? 'nil' : new_controller_type.attributes["Name"], dropdown_type: 'ControllerType'),
          created_at: Time.parse(date_created.to_s),
          created_by_id: u.attributes["CreatedBy"],
          updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
          updated_by_id: u.attributes["ModifiedBy"]
        )
      end
      
      old_other_type = OldDropdown.find_by(id: u.attributes["OtherOldID"])
      new_other_type = OldDropdown.find_by(id: u.attributes["OtherNewID"])
      old_robot_cond = OldDropdown.find_by(id: u.attributes["RoboticConditionID"])
      old_printer_cond = OldDropdown.find_by(id: u.attributes["PrinterConditionID"])
      old_controller_cond = OldDropdown.find_by(id: u.attributes["ControllerConditionID"])
      old_other_cond = OldDropdown.find_by(id: u.attributes["OtherConditionID"])
      old_dispatch = OldDropdown.find_by(id: u.attributes["DispatchID"])
      old_carrier_out = OldDropdown.find_by(id: u.attributes["CarrierOutboundID"])
      old_carrier_in = OldDropdown.find_by(id: u.attributes["CarrierInboundID"])
      Rma.create(
        id: u.attributes["ID"],
          ticket: Ticket.find_by(id: u.attributes["TicketID"]),
          rma_text: u.attributes["RMAText"],
          priority: u.attributes["Priority"],
          old_robotic: old_robotic,
          new_robotic: new_robotic,
          old_printer: old_printer,
          new_printer: new_printer,
          old_controller_pc: old_controller_pc,
          new_controller_pc: new_controller_pc,
          old_other: Dropdown.find_by(name: old_other_type.nil? ? 'nil' : old_other_type.attributes["Name"], dropdown_type: 'OtherRMAType'),
          new_other: Dropdown.find_by(name: new_other_type.nil? ? 'nil' : new_other_type.attributes["Name"], dropdown_type: 'OtherRMAType'),
          other_desc: u.attributes["OtherDesc"],
          robotic_condition: Dropdown.find_by(name: old_robot_cond.nil? ? 'nil' : old_robot_cond.attributes["Name"], dropdown_type: 'RMACondition'),
          printer_condition: Dropdown.find_by(name: old_printer_cond.nil? ? 'nil' : old_printer_cond.attributes["Name"], dropdown_type: 'RMACondition'),
          controller_condition: Dropdown.find_by(name: old_controller_cond.nil? ? 'nil' : old_controller_cond.attributes["Name"], dropdown_type: 'RMACondition'),
          other_condition: Dropdown.find_by(name: old_other_cond.nil? ? 'nil' : old_other_cond.attributes["Name"], dropdown_type: 'RMACondition'),
          dispatch: Dropdown.find_by(name: old_dispatch.nil? ? 'nil' : old_dispatch.attributes["Name"], dropdown_type: 'DispatchType'),
          contact: Contact.find_by(id: u.attributes["ContactID"]),
          ship_address_id: u.attributes["ShipAddressID"],
          tracking_outbound: u.attributes["TrackingNumberOutbound"],
          tracking_inbound: u.attributes["TrackingNumberInbound"],
          outbound_carrier: Dropdown.find_by(name: old_carrier_out.nil? ? 'nil' : old_carrier_out.attributes["Name"], dropdown_type: 'CarrierType'),
          inbound_carrier: Dropdown.find_by(name: old_carrier_in.nil? ? 'nil' : old_carrier_in.attributes["Name"], dropdown_type: 'CarrierType'),
          assigned_to_id: u.attributes["AssignedToID"],
          decision_one: u.attributes["DecisionOne"],
          shipped_by_id: u.attributes["ShippedBy"],
          return_by_id: u.attributes["ReturnBy"],
          completed_by_id: u.attributes["CompletedBy"],
          created_at: Time.parse(date_created.to_s),
          created_by_id: u.attributes["CreatedBy"],
          updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
          updated_by_id: u.attributes["ModifiedBy"]
      ).update_column(:id, u.attributes["ID"])
    end
    puts "imported #{Rma.count}"
  end
   
  task :rma_events => :environment do
    puts "importing rma events"
    
    class OldRmaEvent < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'RMAEvent'
      self.primary_key = 'ID'
    end
    puts "total #{OldRmaEvent.count}"
    OldRmaEvent.all.each do |u|
      puts "#{u.attributes["ID"]}" if (u.attributes["ID"].to_i % 10000) == 0
      date_created = u.attributes["DateCreated"].to_s.blank? ? '1970-01-01 00:00:00 UTC' : u.attributes["DateCreated"]
      if u.attributes["DateCreated"].to_s.blank?
        puts "#{u.attributes["ID"]} blank date reset to #{date_created.to_s}"
      end
      RmaEvent.create(
        id: u.attributes["ID"],
        rma: Rma.find_by(id: u.attributes["RMAID"]),
        event_text: u.attributes["EventText"],
        change_text: u.attributes["Changes"],
        assigned_to_id: u.attributes["AssignedToID"],
        time_spent: u.attributes["TimeSpent"],
        created_at: Time.parse(date_created.to_s),
        created_by_id: u.attributes["CreatedBy"],
        updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
        updated_by_id: u.attributes["ModifiedBy"],
      ).update_column(:id, u.attributes["ID"])
    end
    puts "imported #{RmaEvent.count}"
  end
     
  task :purchase_orders => :environment do
    puts "importing purchase orders"
    
    class OldPurchaseOrder < ActiveRecord::Base
      establish_connection :legacy_db
      self.table_name = 'PurchaseOrder'
      self.primary_key = 'ID'
    end
    
    puts "total #{OldPurchaseOrder.count}"
    OldPurchaseOrder.all.each do |u|
      puts "#{u.attributes["ID"]}" if (u.attributes["ID"].to_i % 1000) == 0
      date_created = u.attributes["DateCreated"].to_s.blank? ? '1970-01-01 00:00:00 UTC' : u.attributes["DateCreated"]
      if u.attributes["DateCreated"].to_s.blank?
        puts "#{u.attributes["ID"]} blank date reset to #{date_created.to_s}"
      end
      PurchaseOrder.create(
        id: u.attributes["ID"],
        contract: Contract.find_by(id: u.attributes["ContractID"]),
        po_number: u.attributes["PONumber"],
        invoice_number: u.attributes["InvoiceNumber"],
        device: Device.find_by(id: u.attributes["DeviceID"]),
        ticket: Ticket.find_by(id: u.attributes["TicketID"]),
        rma: Rma.find_by(id: u.attributes["RMAID"]),
        software: u.attributes["PacsCubeSoftware"],
        created_at: Time.parse(date_created.to_s),
        created_by_id: u.attributes["CreatedBy"],
        updated_at: u.attributes["DateModified"].present? ? Time.parse(u.attributes["DateModified"].to_s) : u.attributes["DateCreated"].to_s,
        updated_by_id: u.attributes["ModifiedBy"],
      ).update_column(:id, u.attributes["ID"])
    end
    puts "imported #{PurchaseOrder.count}"
  end
  
  task :part1 => [:dropdowns, :addresses, :customers, :contacts, :devices, :contracts, :users, :device_interfaces, :device_licenses] do
    puts "part 1 complete..."
  end
  
  task :part2 => [:inventory, :hardware_events, :device_connections, :inventory_parts] do
    puts "part 2 complete..."
  end
  
  task :part3 => [:tickets, :ticket_events, :rmas, :rma_events, :purchase_orders] do
    puts "part 3 complete..."
  end
  
  task :legacy => [:part1, :part2, :part3] do
    puts "import from legacy tracker complete!"
  end
end