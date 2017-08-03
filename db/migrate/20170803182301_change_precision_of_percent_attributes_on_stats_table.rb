class ChangePrecisionOfPercentAttributesOnStatsTable < ActiveRecord::Migration[5.1]
  def change
  	change_column :stats, :field_goal_percent, :decimal, precision: 4, scale: 3
  	change_column :stats, :three_point_percent, :decimal, precision: 4, scale: 3
  	change_column :stats, :free_throw_percent, :decimal, precision: 4, scale: 3
  end
end
