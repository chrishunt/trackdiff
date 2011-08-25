class RemoveHashFromSite < ActiveRecord::Migration
  def self.up
    remove_column :sites, :hash
  end

  def self.down
    add_column :sites, :hash, :string
  end
end
