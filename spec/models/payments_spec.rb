  require 'rails_helper'

describe Payment do

  describe 'Payment Associations' do
    it { should have_many :orders }
  end


end









