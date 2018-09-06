class RenameElasticIndexesToElasticIndices < ActiveRecord::Migration[5.1]
  def change
    rename_table :elastic_indexes, :elastic_indices
  end
end
