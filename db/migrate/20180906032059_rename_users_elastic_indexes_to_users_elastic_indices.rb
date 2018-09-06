class RenameUsersElasticIndexesToUsersElasticIndices < ActiveRecord::Migration[5.1]
  def change
    rename_table :users_elastic_indexes, :users_elastic_indices
  end
end
