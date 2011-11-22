class GovEmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, "must be a .gov email" unless value =~ /\A[\w+\-.]+@[a-z\d\-.]+\.gov\z/i
  end
end
