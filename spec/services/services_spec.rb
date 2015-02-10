require 'rails_helper'

RSpec.describe Service do
  it "should each define a shortname" do
    Service.all.each do |service|
      expect(service.shortname).to be_a_kind_of(Symbol)
    end
  end

  it "should define a longname per service"do
    Service.all.each do |service|
      expect(service.longname).to be_a_kind_of(String)
    end
  end

  it "should define a service url example per service"do
    Service.all.each do |service|
      expect(service.service_url_example).to be_a_kind_of(String)
    end
  end
  
  it "should define urls it handles" do
    Service.all.each do |service|
      expect(service.handles?(URI.parse(service.service_url_example))).to be_truthy
    end
  end

end
