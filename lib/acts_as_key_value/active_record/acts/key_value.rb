module ActiveRecord
  module Acts #:nodoc:
    module KeyValue #:nodoc:
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def acts_as_key_value(options = {})
          class_eval <<-EOV
            include ActiveRecord::Acts::KeyValue::InstanceMethods

            def acts_as_key_value_class
            ::#{self.name}
            end
          EOV
        end

        def get(key, options = {})
          (key = key.to_s) unless key.kind_of? String
          object = where(:key => key)
          options[:object] ? object.first : object.first.value
        end

        alias [] :get

        def set(key, value, options = {})
          (key = key.to_s) unless key.kind_of? String
          (value = value.to_s) unless value.kind_of? String
          record = where(:key => key)
          if record.blank?
            create(:key => key, :value => value)
          else
            record.first.update_attributes(:value => value)
          end
          options[:object] ? record.first : value
        end

        alias []= :set

      end

      module InstanceMethods

        private
      end
    end
  end
end