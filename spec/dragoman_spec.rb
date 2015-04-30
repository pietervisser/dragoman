require 'minimal_spec_helper'

describe Dragoman do
  it 'is a module' do
    expect(Dragoman).to be_a(Module)
  end

  it 'is loadable without preloading rails' do
    expect { require 'dragoman' }.not_to raise_error
  end

end