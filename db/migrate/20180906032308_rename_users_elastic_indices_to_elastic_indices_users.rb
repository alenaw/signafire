class RenameUsersElasticIndicesToElasticIndicesUsers < ActiveRecord::Migration[5.1]
  def change
    rename_table :users_elastic_indices, :elastic_indices_users
  end
end
