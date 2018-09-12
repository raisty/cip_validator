RSpec.describe CipValidator do
  it "has a version number" do
    expect(CipValidator::VERSION).not_to be nil
  end

  it "raises exception if it includes invalid cips" do
    expect{
      CipValidator::Runner.run Dir["spec/fixtures/valid/*md"]
    }.not_to raise_error
  end

  it "raises exception if it includes invalid cips" do
    expect{
      CipValidator::Runner.run Dir["spec/fixtures/invalid/*md"]
    }.to raise_error
  end
end
