desc "Refresh has for all sites and email user if it's changed"
task :rehash => :environment do
  Site.all.each do |site|
    site.refresh_hash!
  end
end
