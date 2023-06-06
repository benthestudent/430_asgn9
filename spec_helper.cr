require "spec"
require "./asgn9.cr"
require "./ExprC.cr"

def create_test_object()
    interpretor = Interpretor.new
    interpretor
end

def create_test_numc(val : Int32)
    numC = NumC.new val
    numC
end