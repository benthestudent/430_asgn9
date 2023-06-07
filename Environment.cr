require "./ExprC"
require "./Value"
# Environment Definition
class Environment
    getter bindings : Hash(Symbol, Val)
    def initialize()
        @bindings = {} of Symbol => Val
    end

    def add_binding(sym, val)
        @bindings[sym] = val
    end

    def get_binding(sym)
        @bindings.fetch(sym, nil)
    end

    # the class method copy, returns a new object of the environment that is a copy of it
    def copy()
        copy = Environment.new
        @bindings.each do |key, value|
            copy.add_binding(key, value)
        end
        copy
    end
end