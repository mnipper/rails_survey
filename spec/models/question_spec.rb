require "spec_helper"

describe Question do
  it { should respond_to(:options) }
  it { should respond_to(:instrument) }
end
