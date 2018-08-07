class CreateStatusMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :status_messages do |t|
      t.text :description

      t.timestamps
    end
  end
end
