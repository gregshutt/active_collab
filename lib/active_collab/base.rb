module ActiveCollab

  # A base class for ActiveCollab's model objects, automatically generating attribute and predicate methods.
  class Base

    attr_reader :attributes

    class << self

      def attr_reader(*attrs)
        attrs.each do |attr|
          define_attribute_method(attr)
          define_predicate_method(attr)
        end
      end

      def attr_accessor(*attrs)
        attrs.each do |attr|
          define_attribute_method(attr)
          define_predicate_method(attr)
          define_writer_method(attr)
        end
      end

      private

      def define_attribute_method(method)
        define_method(method) do
          memoize(method) do
            @attributes[method]
          end
        end
      end

      def define_predicate_method(method)
        define_method(:"#{method}?") do
          !!@attributes[method]
        end
      end

      def define_writer_method(method)
        define_method(:"#{method}=") do |val|
          @attributes[method] = val
        end
      end

    end

    def initialize(client, attributes = {})
      @attributes = attributes || {}
      @attributes[:client] = client
    end

    def [](method)
      send(method.to_sym)
    rescue NoMethodError
      nil
    end

    def client
      @attributes[:client]
    end

    def field_attributes
      # delete unnecessary keys
      field_attrs = @attributes.dup
      field_attrs.delete(:client)
      field_attrs
    end

    private

    def memoize(key, &block)
      ivar = :"@#{key}"
      return instance_variable_get(ivar) if instance_variable_defined?(ivar)

      result = block.call
      instance_variable_set(ivar, result)
    end

  end
end