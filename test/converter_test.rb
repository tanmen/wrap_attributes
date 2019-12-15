require 'test_helper'
require 'wrap_attributes/converter'

class ConverterTest < ActiveSupport::TestCase
  def test_convert_symbol
    params = WrapAttributes.convert({"test" => "test"}, :test)

    expected = {"test_attributes" => "test"}

    assert_equal expected, params
  end

  def test_convert_array
    params = WrapAttributes.convert({"test" => "test", "test2" => "test2"}, [:test, :test2])

    expected = {"test_attributes" => "test", "test2_attributes" => "test2"}

    assert_equal expected, params
  end

  def test_convert_hash
    params = WrapAttributes.convert({"test" => {"test2" => "test2"}}, {test: :test2})

    expected = {"test_attributes" => {"test2_attributes" => "test2"}}

    assert_equal expected, params
  end

  def test_convert_hash_in_array
    params = WrapAttributes.convert(
      {"test" => {"test2" => "test2", "test3" => "test3"}},
      {test: [:test2, :test3]})

    expected = {"test_attributes" => {"test2_attributes" => "test2", "test3_attributes" => "test3"}}

    assert_equal expected, params
  end

  def test_convert_array_in_hash
    params = WrapAttributes.convert(
      {"test" => {"test2" => "test2", "test3" => "test3"}},
      [{test: [:test2, :test3]}])

    expected = {"test_attributes" => {"test2_attributes" => "test2", "test3_attributes" => "test3"}}

    assert_equal expected, params
  end

  def test_convert_hash_in_array_in_hash_in_array
    params = WrapAttributes.convert(
      {"test" => {"test2" => {"test3" => "test3"}}},
      {test: [test2: [:test3]]})

    expected = {"test_attributes" =>
                  {"test2_attributes" => {"test3_attributes" => "test3"}}
    }

    assert_equal expected, params
  end

  def test_convert_params_array
    params = WrapAttributes.convert(
      {"test" => [{"test2" => [{"test3" => "test3"}]}]},
      {test: [test2: [:test3]]})

    expected = {
      "test_attributes" =>
        [{"test2_attributes" => [{"test3_attributes" => "test3"}]}]
    }

    assert_equal expected, params
  end

  def test_convert_params_nest_attr
    params = WrapAttributes.convert(
      {"test" => [{"test2" => [{"test3" => {"id" => 1}}]}]},
      {test: [test2: [:test3]]})

    expected = {
      "test_attributes" =>
        [{"test2_attributes" => [{"test3_attributes" => {"id" => 1}}]}]
    }

    assert_equal expected, params
  end

  def test_convert_params_nest_attr_val
    params = WrapAttributes.convert(
      {"test" => [{"test2" => [{"test3" => {"id" => 1}, "value" => "test"}]}]},
      {test: [test2: [:test3]]})

    expected = {
      "test_attributes" =>
        [{"test2_attributes" => [{"test3_attributes" => {"id" => 1}, "value" => "test"}]}]
    }

    assert_equal expected, params
  end
end
