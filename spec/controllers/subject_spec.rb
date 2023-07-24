class Person 
  attr_reader :first_name, :last_name 
  
  def initialize(first_name, last_name) 
     @first_name = first_name 
     @last_name = last_name 
  end 
end 

describe Person do
  it 'create a person with a first and last name' do
    person = Person.new 'John' , 'Smith'
    expect(person).to have_attributes(first_name: 'John') 
    expect(person).to have_attributes(last_name: 'Smith') 
  end
end

describe Person.new 'John', 'Smith' do 
  it { is_expected.to have_attributes(first_name: 'John') } 
  it { is_expected.to have_attributes(last_name: 'Smith') }
end
