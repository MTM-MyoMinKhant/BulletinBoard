require 'string_analyzer'

describe StringAnalyzer do
  context "With valid input" do
    it "Should detect when a string contains vowels" do
      sa = StringAnalyzer.new
      test_string = "uuu"
      expect(sa.has_vowels? test_string).to be true
    end
    
    it "Should detect when a string doesn't contains vowels" do
      sa = StringAnalyzer.new 
      test_string = "kkbb"
      expect(sa.has_vowels? test_string).to be false
    end
  end
end

describe "An example of the equality Matchers" do 

  it "should show how the equality Matchers work" do 
     a = "test string" 
     b = a 
     c = "nomi war naru"
     # The following Expectations will all pass 
     expect(a).to eq "test string" 
     expect(a).to eql "test string" 
     expect(a).to be b 
     expect(a).to equal b 
     puts c
  end
  
end
