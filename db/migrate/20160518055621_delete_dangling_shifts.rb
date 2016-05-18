class DeleteDanglingShifts < ActiveRecord::Migration
  def change
    Shift.all.each do |shift|
      if shift.event.nil?
        shift.destroy
      end
    end
  end
end
