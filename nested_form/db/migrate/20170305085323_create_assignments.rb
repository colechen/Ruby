class CreateAssignments < ActiveRecord::Migration[5.0]
  def change
    create_table :assignments do |t|
      t.integer     :user_id
      t.integer     :project_id
      t.integer     :role_id
      t.date        :start_date
      t.date        :end_date
      t.decimal     :workload,    :precision => 3, :scale => 2
      t.timestamps
    end
  end
end
