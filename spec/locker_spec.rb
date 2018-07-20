require_relative '../lib/locker.rb'

RSpec.describe Locker do

  let(:protected_object)  { double :protected_object, foo: 'bar' }

  describe '#method_missing' do
    context 'when locked' do
      let(:subject)           { described_class.new(protected_object, locked: true) }

      it 'does not delegate to the protected object' do
        expect(protected_object).not_to receive(:foo)
        subject.foo
      end
    end

    context 'when unlocked' do
      let(:subject)           { described_class.new(protected_object, locked: false) }

      it 'delegates to the protected object' do
        expect(protected_object).to receive(:foo)
        subject.foo
      end
    end
  end
end
