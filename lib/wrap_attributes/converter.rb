module WrapAttributes
  def self.convert(parameters, attributes)
    if parameters.is_a?(Symbol) || parameters.is_a?(String)
      parameters
    elsif parameters.is_a?(Hash)
      if attributes.is_a?(Symbol) || attributes.is_a?(String)
        parameters.map { |key, value| key.to_sym == attributes ? [attribute_key(key), value] : [key, value] }.to_h
      elsif attributes.is_a?(Hash)
        parameters.map do |key, params|
          attr = attributes&.[](key.to_sym)
          attr.present? ? [attribute_key(key), convert(params, attr)] : [key, params]
        end.to_h
      elsif attributes.is_a?(Array)
        parameters.map do |key, params|
          attributes.reduce([key, params]) do |pre, cur|
            if cur.is_a?(Symbol) && cur == key.to_sym
              [attribute_key(key), params]
            elsif cur.is_a?(Hash) && cur.keys.include?(key.to_sym)
              [attribute_key(key), convert(params, cur[key.to_sym])]
            else
              pre
            end
          end
        end.to_h
      end
    elsif parameters.is_a?(Array)
      parameters.map do |params|
        convert(params, attributes)
      end
    end
  end

  private


  def self.attribute_key(attribute)
    (+attribute.to_s).concat('_attributes')
  end
end
