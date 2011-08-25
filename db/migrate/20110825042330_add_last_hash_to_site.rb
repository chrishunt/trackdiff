class AddLastHashToSite < ActiveRecord::Migration
  def self.up
    add_column :sites, :last_hash, :string
  end

  def self.down
    remove_column :sites, :last_hash
  end
end
