module ValidateMaxLengthAuto
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def validate_max_length_auto(*args)
      args.each do |method|
        max_length = 255
        if table_exists?
          column = columns_hash[method.to_s]
          max_length = column && column.text? ? column.limit : nil
        end
        validates method, length: { maximum: max_length } if max_length
      end
    end

  end
end

class ActiveRecord::Base
  include ValidateMaxLengthAuto
end