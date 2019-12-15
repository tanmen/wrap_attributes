require_relative 'converter'

module WrapAttributes
  module AttributesWrapper
    extend ActiveSupport::Concern

    included do
      class_attribute :_attribute_options, default: []
    end

    module ClassMethods
      def wrap_attributes(*keys)
        self._attribute_options = keys
      end
    end

    def process_action(*args)
      _perform_attribute_parameter_wrapping
      super
    end

    private

    def _wrap_attribute_parameters(parameters, attributes)
      WrapAttributes::convert(parameters, attributes)
    end

    def _perform_attribute_parameter_wrapping
      wrapped_keys = request.request_parameters.keys
      wrap_attribute_parameters = _wrap_attribute_parameters(request.request_parameters,
                                                             _attribute_options)
      filtered_attribute_parameters = _wrap_attribute_parameters(request.filtered_parameters.slice(*wrapped_keys),
                                                        _attribute_options)

      request.parameters.merge! wrap_attribute_parameters
      request.request_parameters.merge! wrap_attribute_parameters

      request.filtered_parameters.merge! filtered_attribute_parameters
    end
  end
end
