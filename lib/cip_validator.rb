require "cip_validator/version"
require "cip_validator/loader"
require "cip_validator/validator"

module CipValidator
  class Runner
    class << self  
      def run(file_names)
        num_valid = 0
        num_invalid = 0
        num_error = 0
        total = 0
        puts "\n"
        statuses = []
        types = []
        categories = []
        layers = []
        file_names.map do |file_name|
          # Disable file check
          # unless file_name.match(/.*cip-\d+.md$/)
          #   puts "Warning: #{file_name} does not match cip file format"
          #   next
          # end
          attributes = Loader.load(file_name)
          total+=1
          begin 
            v = Validator.new(attributes)
            if v.valid?
              num_valid+=1      
            else
              num_invalid+=1
              puts "#{file_name} is NOT valid:\t #{v.errors.messages}"
            end
            statuses.push v.status
            types.push v.type
            categories.push v.category
            layers.push v.layer
          rescue => e
            puts "Warning: #{file_name} \t #{e}"
            num_error+=1
          end
        end
              
        puts "\n\ntotal:#{total}, valid:#{num_valid}, invalid:#{num_invalid}, errors:#{num_error}"
        puts "\tstatuses: #{aggregate(statuses)}"
        puts "\ttypes: #{aggregate(types)}"
        puts "\tcategories: #{aggregate(categories)}"
        puts "\tlayers: #{aggregate(layers)}"
        raise "#{num_invalid} invalid entities" unless num_invalid == 0
      end

      private

      def aggregate(array)
        array.group_by{|k,v| k}.map{|k,v| [k,v.length]}
      end  
    end
  end
end
