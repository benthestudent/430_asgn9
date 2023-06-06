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
        @bindings.fetch(sym, ErrV.new "Binding not found")
    end
end