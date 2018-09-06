class CreateUsersAndElasticIndexes < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.timestamps
    end

    create_table :elastic_indexes do |t|
      t.string :name
      t.timestamps
    end

    create_table :users_elastic_indexes, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :elastic_index, index: true
    end
  end
end
