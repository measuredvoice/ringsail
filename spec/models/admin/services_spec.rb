require 'rails_helper'

RSpec.describe Admin::Service do
  it "should each define a shortname" do
    Admin::Service.all.each do |service|
      expect(service.shortname).to be_a_kind_of(Symbol)
    end
  end

  it "should define a longname per service"do
    Admin::Service.all.each do |service|
      expect(service.longname).to be_a_kind_of(String)
    end
  end

  it "should define a service url example per service"do
    Admin::Service.all.each do |service|
      expect(service.service_url_example).to be_a_kind_of(String)
    end
  end

  it "should define urls it handles" do
    Admin::Service.all.each do |service|
      expect(service.handles?(URI.parse(service.service_url_example))).to be_truthy
    end
  end

end
