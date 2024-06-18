class CreateTrafficRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :traffic_requests do |t|
      t.string :request_ip

      t.timestamps
    end
  end
end
