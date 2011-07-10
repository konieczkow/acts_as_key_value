require "acts_as_key_value/version"
require 'acts_as_key_value/active_record/acts/key_value'
ActiveRecord::Base.class_eval { include ActiveRecord::Acts::KeyValue }