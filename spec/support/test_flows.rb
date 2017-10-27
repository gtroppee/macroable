module Macroable
  class TestClass
    include Macroable
    add_macro :states, :decisions

    state :macro1, 'Macro1', 1 do
      nesting do
        subnesting :state1
        subnesting :state2
        subnesting name: :state3
      end

      other_nesting do
        other_subnesting 1
        rule proc { true }
        rule bla: proc { true }
      end
    end

    state do
      nesting do
        subnesting 'fourth'
      end
    end

    state :state2, 'TestResource'
  end

  class EmptyClass
    include Macroable
    add_macro :states, :decisions
  end
end
