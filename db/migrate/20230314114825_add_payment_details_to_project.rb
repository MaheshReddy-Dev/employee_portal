class AddPaymentDetailsToProject < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :is_paid, :boolean, :default => false
  end
end
