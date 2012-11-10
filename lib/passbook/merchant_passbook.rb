module Passbook
  class MerchantPassbook
    attr_accessor :pass

    def initialize user_id, merchant_id
      @pass = {'logoText' => '', 
               'formatVersion' => 1,
               'labelColor' => 'rgb(255,255,255)',
               'foregroundColor' => 'rgb(252,252,252)',
               'backgroundColor' => 'rgb(87,5,168)',
               'description' => ''}
    end
  end
end

