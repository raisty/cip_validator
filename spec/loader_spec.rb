require 'spec_helper'

RSpec.describe "CipValidator::Loader"  do
  let(:category) { 'Core' }
  let(:type) { 'Standards Track' }
  let(:status) { 'Final' }
  let(:cip){
    {
      "cip" => 145,
      "title" => 'Bitwise shifting instructions in EVM',
      "author" => 'Alex Beregszaszi, Paweł Bylica',
      "type" => type,
      "category" => category,
      "status" =>   status,
      "created" =>  Date.parse('2017-02-13')
    }
  }
  let(:file_name) {
   'spec/fixtures/valid/cip-145.md'
  }

  subject(:loader){ CipValidator::Loader.load(file_name)}

  describe "valid" do
    it "should have required fields" do
      expect(loader).to eq(cip)
    end
  end
end