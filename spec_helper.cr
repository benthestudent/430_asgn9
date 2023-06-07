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


