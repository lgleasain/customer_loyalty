require 'spec_helper'
include Rails.application.routes.url_helpers
default_url_options[:host] = 'www.loyalty.com'

describe 'MerchantPassbook' do

  let (:customer) {FactoryGirl.create :customer}
  let (:merchant) {FactoryGirl.create :merchant}
  let (:merchant_passbook) {Passbook::MerchantPassbook.new customer.id, merchant.id}
  let (:customer_passbook) {CustomerPassbook.find_by_customer_id_and_merchant_id customer.id, merchant.id}

  context 'new passbook' do

    context 'customer_passbook' do
      before {merchant_passbook}
      subject {customer_passbook}
      it {should_not eq nil}
    end

    context 'pkpass' do
      subject {merchant_passbook.pkpass}
      its (:pass) {should eq merchant_passbook.pass.to_json}
      its (:manifest_files) {should eq merchant_passbook.manifest.values }
    end

    context 'main fields' do
      subject {merchant_passbook.pass}
      its(['logoText']) {should eq ''}
      its(['formatVersion']) {should eq 1}
      its(['labelColor']) {should eq 'rgb(255,255,255)'}
      its(['foregroundColor']) {should eq 'rgb(252,252,252)'}
      its(['backgroundColor']) {should eq 'rgb(87,5,168)'}    
      its(['serialNumber']) {should eq "#{customer.id}-#{merchant.id}"}    
      its(['teamIdentifier']) {should eq CustomerLoyalty::Application.config.passbook.team_identifier}    
      its(['organizationName']) {should eq CustomerLoyalty::Application.config.passbook.organization_name}
      its(['passTypeIdentifier']) {should eq CustomerLoyalty::Application.config.passbook.pass_type_identifier}
      its(['description']) {should eq ''}
    end

    context 'barcode' do
      subject {merchant_passbook.pass['barcode']}
      its(['message']) {should eq loyalty_scan_url(customer.id)}
      its(['format']) {should eq 'PKBarcodeFormatQR'}
      its(['messageEncoding']) {should eq 'iso-8859-1'}
    end

    context 'storeCard' do
      let(:store_card) {merchant_passbook.pass['storeCard']}

      context 'header fields' do
        subject {store_card['headerFields'].first}
        its(['key']) {should eq 'balance'}
        its(['label']) {should eq 'Local Loyalty'}
        its(['value']) {should eq ''}
      end

      context 'primary fields' do
        subject {store_card['primaryFields'].first}
        its(['key']) {should eq 'name'}
        its(['label']) {should eq merchant.reward_program_name}
        its(['value']) {should eq customer.user.name}
      end

      context 'secondary fields' do

        let(:secondary_fields) {store_card['secondaryFields']}

        before do
          secondary_fields.each do |field|
            case field['key']
            when 'donuts'
              @donuts = field
            when 'secondary_3'
              @secondary_3 = field
            end
          end
        end

        context 'donuts' do
          subject {@donuts}
          its(['key']) {should eq 'donuts'}
          its(['label']) {should eq merchant.earn_type}
          its(['value']) {should eq customer_passbook.balance}
        end

        context 'secondary_3' do
          subject {@secondary_3}
          its(['key']) {should eq 'secondary_3'}
          its(['label']) {should eq 'Rewards Available'}
          its(['value']) {should eq '' }
          its(['changeMessage']) {should eq "Pass updated: %@"}
          its(['textAlignment']) {should eq "PKTextAlignmentRight"}
        end
      end

      context 'back fields' do
        let(:back_fields) {store_card['backFields']}

        before do
          back_fields.each do |field|
            case field['key']
            when 'reward'
              @reward = field
            end
          end
        end

        context 'reward' do
          subject {@reward}
          its(['label']) {should eq 'Your Reward'}
          its(['value']) {should eq merchant.reward_description}
        end
      end

    end  
  end

  context 'manifest' do

    subject {merchant_passbook.manifest}

    its(['icon.png']) {should eq 'lib/assets/icon.png'}
    its(['icon@2x.png']) {should eq 'lib/assets/icon@2x.png'}
    its(['strip.png']) {should eq 'lib/assets/strip.png'}
    its(['strip@2x.png']) {should eq 'lib/assets/strip@2x.png'}
  end
end 

