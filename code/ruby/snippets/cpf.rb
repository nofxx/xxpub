
# #codestacker.com
#created by henryhamon — 14 August 2008
class Cpf  
  def check_cpf(cpf=nil)
    return false if cpf.nil?
    value = cpf.scan /[0-9]/
    return false if value.length != 11

    value = value.map{|x| x.to_i}

    # first digit 
    return false if calculate_digit(value, 8, 10) != value[9]
    
    ## second digit 
    return true if calculate_digit(value, 9, 11) == value[10]

    return false 
  end
  
  def calculate_digit(values, how_many, base)
    digit = 0
    0.upto(how_many) { |i| digit+= values[i] * (base-i)}
    digit = digit % 11
    digit = [0,1].include?(digit) ? 0 : 11 - digit
    digit
  end
  
end

module ActiveRecord
  module Validations
    module ClassMethods
      def validates_as_cpf(*attr_names)
        cpf_validator = Cpf.new
        configuration = {
          :message => 'invalido', 
          :on => :save 
        }  
        validates_each(attr_names, configuration) do |record, attr_name,value|
         if !cpf_validator.check_cpf(value)
           record.errors.add(attr_name, configuration[:message])
         end
        end
      end
    end
  end
end