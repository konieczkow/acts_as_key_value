module ActiveRecord
  module Acts #:nodoc:
    module KeyValue #:nodoc:

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def acts_as_key_value(options = {})
          configuration = {:object => false}
          configuration.merge!(options)

          class_eval <<-EOV
            include ActiveRecord::Acts::KeyValue::InstanceMethods

            def acts_as_key_value_class
            ::#{self.name}
            end
          EOV

          class_eval <<-EOF
            class << self
              def get(key, options = {})
                (key = key.to_s) unless key.kind_of? String
                object = where(:key => key)
                #{if configuration[:object]
                    "options[:value] ? object.first.value : object.first"
                  else
                    "options[:object] ? object.first : object.first.value"
                  end
                }
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
                #{if configuration[:object]
                    "options[:value] ? value : record.first"
                  else
                    "options[:object] ? record.first : value"
                  end
                }
              end
              alias []= :set
            end
          EOF
        end

      end

      module InstanceMethods

        private
      end
    end
  end
end