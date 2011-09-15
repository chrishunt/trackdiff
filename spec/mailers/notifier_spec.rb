require "spec_helper"

describe Notifier do
  it 'sends site updated email when passed a site' do
    site = Factory(:site)
    Notifier.site_updated(site).should_not == nil
  end
end
