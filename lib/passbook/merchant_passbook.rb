module Passbook
  class MerchantPassbook
    attr_accessor :pass, :manifest, :pkpass

    def initialize customer_id, merchant_id
      @customer_passbook = CustomerPassbook.new(:customer_id => customer_id, 
                                                :merchant_id => merchant_id)
      @customer_passbook.save!
      merchant = Merchant.find_by_id merchant_id
      customer = Customer.find_by_id customer_id
      @pass = {'logoText' => '', 
        'formatVersion' => 1,
        'labelColor' => 'rgb(255,255,255)',
        'foregroundColor' => 'rgb(252,252,252)',
        'backgroundColor' => 'rgb(87,5,168)',
        'description' => '',
        'serialNumber' => @customer_passbook.serial_number,
        'teamIdentifier' => CustomerLoyalty::Application.config.passbook.team_identifier,    
        'organizationName' => CustomerLoyalty::Application.config.passbook.organization_name,
        'passTypeIdentifier' => CustomerLoyalty::Application.config.passbook.pass_type_identifier,
        'barcode' => {
        'message' => loyalty_scan_url(customer_id),
        'format' => 'PKBarcodeFormatQR',
        'messageEncoding' => 'iso-8859-1'},
        'storeCard' => {
        'headerFields' => [{
        'key' => 'balance',
        'label' => 'Local Loyalty',
        'value' => ''}],
        'primaryFields' => [{
        'key' => 'name',
        'label' => merchant.reward_program_name,
        'value' => customer.user.name}],
        'backFields' => [{
          'key' => 'reward',
          'label' => 'Your Reward',
          'value' => merchant.reward_description}],
        'secondaryFields' => [{
        'key' => 'donuts',
        'label' => merchant.earn_type,
        'value' => @customer_passbook.balance},
        {'key' => 'secondary_3',
          'label' => 'Rewards Available',
          'value' => '',
          'changeMessage' => 'Pass updated: %@',
          'textAlignment' => 'PKTextAlignmentRight'} ]}}

      @manifest = {
        'icon.png' => 'lib/assets/icon.png',
        'icon@2x.png' => 'lib/assets/icon@2x.png',
        'strip.png' => 'lib/assets/strip.png',
        'strip@2x.png' => 'lib/assets/strip@2x.png'
      }

      @pkpass = Passbook::PKPass.new @pass.to_json
      @pkpass.manifest_files = @manifest.values
    end

    def stream
      self.pkpass.stream
    end

    def file
      self.pkpass.file
    end
  end
end
#       subject {store_card['primaryFields'].first}
#       its(['key']) {should eq 'name'}
#       its(['label']) {should eq merchant.loyalty_program_name}
#       its(['value']) {should eq customer.name}

