class User < ActiveRecord::Base
    self.table_name = 'User'
    self.primary_key = :userId

    belongs_to :employee, :class_name => 'Employee', :foreign_key => :EmployeeId
end
