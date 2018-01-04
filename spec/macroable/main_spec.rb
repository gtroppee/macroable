require 'spec_helper'

module Macroable
  describe TestClass do
    subject { TestClass.new }

    describe 'fewr' do
      it 'dfewrge' do
        expect(subject.macros.first.args).to eq([:macro_1, "Macro1", 1])

        expect(subject.macros.first.nested_macros.first.subnested_macros.size).to eq(3)

        expect(subject.macros.first.nested_macros.first.subnested_macros.first.args).to eq([:subnested_macro_1])
        expect(subject.macros.first.nested_macros.first.subnested_macros.second.args).to eq([:subnested_macro_2])
        expect(subject.macros.first.nested_macros.first.subnested_macros.last.args).to eq([{ name: :subnested_macro_3 }])
        expect(subject.macros.first.nested_macros.first.subnested_macros.last.name).to eq(:subnested_macro_3)

        expect(subject.macros.first.other_nested_macros.first.other_subnested_macros.first.args).to eq([1])
        expect(subject.macros.first.other_nested_macros.first.another_subnested_macros.first.args.first).to be_a(Proc)
        expect(instance_eval &subject.macros.first.other_nested_macros.first.another_subnested_macros.first.args.first).to eq(true)
        expect(instance_eval &subject.macros.first.other_nested_macros.first.another_subnested_macros.last.options).to eq(true)
      
        expect(subject.other_macros.first.nested_macros.first.subnested_macros.first.args).to eq(['Test'])
        expect(subject.macros.last.args).to eq([:macro_3, 'Test'])
      end
    end

    it 'raises an error when the macro has not been defined' do
      expect{ subject.unknown }.to raise_error(NoMethodError)
    end
  end

  describe EmptyClass, :skip do
    subject { EmptyClass.new }

    its(:macros)       { is_expected.to eq([]) }
    its(:other_macros) { is_expected.to eq([]) }

    it 'raises an error when the macro has not been defined' do
      expect{ subject.unknown }.to raise_error(NoMethodError)
    end
  end
end

