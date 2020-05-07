require 'spec_helper'

RSpec.describe "CipValidator::Loader"  do
  let(:category) { 'Core' }
  let(:type) { 'Standards Track' }
  let(:status) { 'Final' }
  let(:cip){
    {
      "cip" => 1,
      "title" => 'Test CVM',
      "author" => 'Raisty',
      "type" => type,
      "category" => category,
      "status" =>   status,
      "created" =>  Date.parse('2020-01-01')
    }
  }
  let(:file_name) {
   'spec/fixtures/valid/cip-1.md'
  }

  subject(:loader){ CipValidator::Loader.load(file_name)}

  describe "valid" do
    it "should have required fields" do
      expect(loader).to eq(cip)
    end
  end
end
