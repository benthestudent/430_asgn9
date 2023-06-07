require "spec"
require "./asgn9.cr"
require "./ExprC.cr"
require "./Value"
require "./Environment"

def create_test_object()
    interpretor = Interpretor.new
    interpretor
end

def create_test_env()
    env = Environment.new
    env
end

def create_plus_primV()
    plusOp = ->(x : Val, y : Val) {NumV.new(x.as(NumV).n + y.as(NumV).n).as(Val)}
    PrimV.new(:+, plusOp)
end


