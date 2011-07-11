module ActiveRecord
  module Acts #:nodoc:
    module KeyValue #:nodoc:
      def self.included(base)
        base.extend(ClassMethods)
      end

      
      module ClassMethods


        def acts_as_key_value(options = {})

          configuration = { :unique_keys => true }
          configuration.update(options)

          class_eval <<-EOV
include ActiveRecord::Acts::KeyValue::InstanceMethods

def acts_as_key_value_class
::#{self.name}
end

EOV
        end

        def get(key)
          (key = key.to_s) unless key.kind_of? String
          where(:key => key).first
        end
        alias [], :get

        def set(key, value)
          (key   = key.to_s)   unless key.kind_of? String
          (value = value.to_s) unless value.kind_of? String
          record = where(:key => key)
          if record.blank?
            create(:key => key, :value => value)
          else
            record.first.update_attributes(:value => value)
          end
        end
        alias []=, :set
        
      end

      module InstanceMethods

        private
      end
    end
  end
end