module ActiveRecord
	module Associations
		class HasManyThroughAssociation < HasManyAssociation
			alias_method :original_delete_records, :delete_records

			def delete_records(records, method)
				method ||= :destroy
				original_delete_records(records, method)
			end
		end
	end
end