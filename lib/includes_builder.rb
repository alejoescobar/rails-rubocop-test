module SmartForm::IncludesBuilder
  attr_accessor :structure

  def initialize(structure)
    @structure = structure.deep_dup
  end

  def build
    obj = { contact: {} }
    structure.each do |_role, role_structure|
      obj[:contact].deep_merge!(role_structure)
    end
    nested_hash_iterator(obj[:contact])
    obj
  end

  def nested_hash_iterator(hash)
    return if hash.size.zero?

    hash.each do |key, value|
      hash[key] = { related_contact: value } if key.to_sym.in?(Contact.relationship_names)
      nested_hash_iterator(hash[key])
    end
  end
end
