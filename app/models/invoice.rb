class Invoice < ActiveRecord::Base
    self.table_name = 'Invoice'
    self.primary_key = :InvoiceId

    belongs_to :customer, :class_name => 'Customer', :foreign_key => :CustomerId
    has_many :invoicelines, :class_name => 'InvoiceLine', :foreign_key => :InvoiceId
end
