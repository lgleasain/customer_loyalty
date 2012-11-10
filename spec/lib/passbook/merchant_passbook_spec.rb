require 'spec_helper'

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
      #subject {merchant_passbook.pkpass}
      #its (:pass) {should eq merchant_passbook.pass.to_json}
      #its (:manifest_files) {should eq merchant_passbook.manifest.values }
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
      #subject {promotion_passbook.pass['barcode']}
      #its(['message']) {should eq promotion.redemption_code}
      #its(['format']) {should eq 'PKBarcodeFormatQR'}
      #its(['messageEncoding']) {should eq 'iso-8859-1'}
    end

    context 'coupon' do
      #subject {promotion_passbook.pass['coupon']['headerFields'].first}
      #its(['key']) {should eq 'header_0'}
      #its(['label']) {should eq promotion.company.name}
      #its(['value']) {should eq promotion.summary}
      #its(['changeMessage']) {should eq 'Pass updated: %@'}
    end

    context 'auxiliary fields' do
      #subject {promotion_passbook.pass['coupon']['auxiliaryFields'].first}
      #its(['key']) {should eq 'auxiliary_0'}
      #its(['value']) {should eq promotion.description}
      #its(['changeMessage']) {should eq 'Pass updated: %@'}
    end

    context 'primary fields' do
      #subject {promotion_passbook.pass['coupon']['primaryFields'].last}
      #its (['key']) {should eq 'name'}
      #its (['label']) {should eq promotion.summary}
      #its (['value']) {should eq promotion.exclamation}
    end

    context 'back fields' do
      let(:back_fields) {promotion_passbook.pass['coupon']['backFields']}

      before do
        back_fields.each do |field|
          case field['key']
          when 'serial-861'
            @serial_861 = field
          when 'created-by-scratchhard'
            @created_by_scratchhard = field
          when 'back_0'
            @back_0 = field
          when 'back_3'
            @back_3 = field
          end
        end
      end

      context 'serial number' do
        subject {@serial_861}
        #its(:)
      end

      context 'scratch hard info' do
        subject {@created_by_scratchhard}
        its (['label']) {should eq 'Created by Scratch Hard'}
        its (['value']) {should eq 'Copyright 2012 Scratch Hard'}
      end

      context 'back_0' do
        subject {@back_0}
        its (['label']) {should eq 'Redemption Code'}
        its (['value']) {should eq promotion.redemption_code}
      end

      context 'back_3' do
        subject {@back_3}
        its (['label']) {should eq 'Terms and Instructions'}
        its (['value']) {should eq "#{promotion.special_instructions} Valid from #{promotion.startDate} to #{promotion.expireDate}."}
      end
    end  
  end

  context 'manifest' do

    subject {promotion_passbook.manifest}

    its(['icon.png']) {should eq 'lib/assets/icon.png'}
    its(['icon@2x.png']) {should eq 'lib/assets/icon@2x.png'}
    its(['logo.png']) {should eq 'lib/assets/logo.png'}
    its(['logo@2x.png']) {should eq 'lib/assets/logo@2x.png'}
  end
end 

