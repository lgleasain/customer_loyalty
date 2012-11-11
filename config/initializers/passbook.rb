Passbook.configure do |passbook|

  # Path to your wwdc cert file
  passbook.wwdc_cert = 'lib/assets/WWDR.pem'

  # Path to your passkey.pem file
  passbook.p12_key = 'lib/assets/passkey.pem'
  
  # Path to your p12 certificate.pem file
  passbook.p12_certificate = 'lib/assets/passcertificate.pem'
  
  # Password for your certificate
  passbook.p12_password = '12345'
end

