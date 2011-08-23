require 'spec_helper'

describe Site do
  it 'saves url' do
    Site.create!(:url => "http://google.com")
    Site.last.url.should == "http://google.com"
  end

  it 'requires url' do
    site = Site.create()
    site.save.should == false
  end
end
