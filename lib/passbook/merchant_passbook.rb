module Passbook
  class MerchantPassbook
    attr_accessor :pass

    def initialize customer_id, merchant_id
      @customer_passbook = CustomerPassbook.new(:customer_id => customer_id, 
                                                :merchant_id => merchant_id)
      @customer_passbook.save!
      @pass = {'logoText' => '', 
               'formatVersion' => 1,
               'labelColor' => 'rgb(255,255,255)',
               'foregroundColor' => 'rgb(252,252,252)',
               'backgroundColor' => 'rgb(87,5,168)',
               'description' => '',
               'serialNumber' => @customer_passbook.serial_number,
               'teamIdentifier' => CustomerLoyalty::Application.config.passbook.team_identifier,    
               'organizationName' => CustomerLoyalty::Application.config.passbook.organization_name,
               'passTypeIdentifier' => CustomerLoyalty::Application.config.passbook.pass_type_identifier}
    end
  end
end

