module Macroable
  class Base
    include Macroable
    add_macro :macros, :other_macros
  end

  class TestClass < Base
    macro :macro_1, 'Macro1', 1 do
      nested_macro do
        subnested_macro :subnested_macro_1
        subnested_macro :subnested_macro_2
        subnested_macro name: :subnested_macro_3
      end

      other_nested_macro do
        other_subnested_macro 1
        another_subnested_macro proc { true }
        another_subnested_macro options: proc { true }
      end
    end

    other_macro do
      nested_macro do
        subnested_macro 'Test'
      end
    end

    macro :macro_3, 'Test'
  end

  class EmptyClass < Base
  end
end
