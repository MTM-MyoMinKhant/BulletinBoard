class SimpleClass
  attr_accessor :message

  def initialize()
    puts "\nCreating a new instance of the SimpleClass class"
    @message = 'howdy'
  end

  def update_message(new_message)
    @message = new_message
  end
end

describe SimpleClass do
  before(:each) do
    @simple_class = SimpleClass.new
  end

  it 'should have an initial message' do
    expect(@simple_class).not_to be_nil
    @simple_class.message = 'Something else ...'
  end

  it 'should be able to change its message' do
    expect(@simple_class.message).not_to be 'howdy'
    puts @simple_class.message
  end
end

describe "Before and after hooks" do 
  before(:each) do 
     puts "Runs before each Example" 
  end 
  
  after(:each) do 
     puts "Runs after each Example" 
  end 
  
  before(:all) do 
     puts "Runs before all Examples" 
  end 
  
  after(:all) do 
     puts "Runs after all Examples"
  end 
  
  it 'is the first Example in this spec file' do 
     puts 'Running the first Example' 
  end 
  
  it 'is the second Example in this spec file' do 
     puts 'Running the second Example' 
  end 
end
