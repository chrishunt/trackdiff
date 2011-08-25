class ChangeLastHashInSite < ActiveRecord::Migration
  def self.up
    change_column :sites, :last_hash, :integer
  end

  def self.down
    change_column :sites, :last_hash, :string
  end
end
