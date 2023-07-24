class HelloWorld
  def say_hello 
    "Hello World!"
  end 
end

describe HelloWorld do     
  it "same or not " do
    hw = HelloWorld.new 
    message = hw.say_hello 
    expect(message).to eq "Hello World!"   
  end
end

describe "Testing matchers" do
  it "This will shows about the equality matchers" do
    a = "test string"
    b = a
    puts a 
    puts b
    expect(a).to eql b
    expect(a).to equal b
    expect(a).to be b
  end

  it "this is about comparison matchers" do
    a = 1
    b = 2
    c = 3
    d = 'test string'

    expect(a).to be < b
    expect(b).to be > a
    expect(c).to be >= c
    expect(c).to be_between(1,3).inclusive
    expect(b).to be_between(1,3).exclusive
    expect(d).to match /TEST/i 
  end

  it "this is about class/type matchers" do
    x = 1 
    y = 3.14 
    z = 'test string' 
    
    # The following Expectations will all pass 
    expect(y).to be_kind_of Numeric 
    expect(z).to respond_to(:length) 
  end

  it "should show how the true/false/nil Matchers work" do
    x = true 
    y = false 
    z = nil 
    a = "test string" 
    
    # The following Expectations will all pass
    expect(x).to be true 
    expect(y).to be false 
    expect(a).to be_truthy 
    expect(z).to be_falsey 
    expect(z).to be_nil 
  end 
end

describe "An example of the error Matchers" do 
  it "should show how the error Matchers work" do    
    # The following Expectations will all pass 
    expect { 1/0 }.to raise_error(ZeroDivisionError)
    expect { 1/0 }.to raise_error("divided by 0") 
    expect { 1/0 }.to raise_error("divided by 0", ZeroDivisionError) 
  end 
end


