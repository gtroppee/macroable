require 'spec_helper'

module Macroable
  describe TestClass do
    subject { TestClass.new }

    layout = [
      { chain: 'states.first', size: 3 },
      { chain: 'states.first.nestings.first', size: 1 },
      { chain: 'states.first.nestings.first.subnestings.first', size: 3 }
    ]

    describe 'registering' do
      layout.each do |hash|
        its(hash[:chain]) { is_expected.to be_a(Node) }
      end
    end

    describe 'overall structure' do
      layout.each do |hash|
        # its("#{hash[:chain]}.size") { is_expected.to eq(hash[:size]) }
      end
    end

    describe 'arguments' do
      its('states.first.args') { [:macro1, "Macro1", 1] }
    end
  end

  describe EmptyClass do
    subject { EmptyClass.new }

    its(:states)    { is_expected.to eq([]) }
    its(:decisions) { is_expected.to eq([]) }

    it 'raises an error when the macro has not been defined' do
      expect{ subject.unknown }.to raise_error(NoMethodError)
    end
  end
end

