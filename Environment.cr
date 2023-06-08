require "./ExprC"
require "./Value"
# Environment Definition
class Environment
    getter bindings : Hash(Symbol, Val)
    def initialize()
        @bindings = Hash(Symbol, Val).new
        
        # Define some top-level PrimV's

        # addition
        prim_add = PrimV.new(:+, ->(val1 : Val, val2 : Val)
        {if val1.is_a?(NumV) && val2.is_a?(NumV)
            val1 = val1.as(NumV)
            val2 = val2.as(NumV)
            return NumV.new(val1.n + val2.n).as Val
        else 
            raise VVQSError.new("Cannot add non-numbers.")
        end})

        # subtraction
        prim_sub = PrimV.new(:-, ->(val1 : Val, val2 : Val)
        {if val1.is_a?(NumV) && val2.is_a?(NumV)
            val1 = val1.as(NumV)
            val2 = val2.as(NumV)
            return NumV.new(val1.n - val2.n).as Val
        else 
            raise VVQSError.new("Cannot subtract non-numbers.")
        end})

        # multiplication
        prim_mult = PrimV.new(:*, ->(val1 : Val, val2 : Val)
        {if val1.is_a?(NumV) && val2.is_a?(NumV)
            val1 = val1.as(NumV)
            val2 = val2.as(NumV)
            return NumV.new(val1.n * val2.n).as Val
        else 
            raise VVQSError.new("Cannot multiply non-numbers.")
        end})

        # division
        prim_div = PrimV.new(:/, ->(val1 : Val, val2 : Val)
        {if val1.is_a?(NumV) && val2.is_a?(NumV)
            val1 = val1.as(NumV)
            val2 = val2.as(NumV)
            if val2.n != 0
                return NumV.new(val1.n / val2.n).as Val
            else
                raise VVQSError.new("Cannot divide by 0")
            end
        else 
            raise VVQSError.new("Cannot divide non-numbers.")
        end})

        # <=
        prim_lte = PrimV.new(:"<=" , ->(val1 : Val, val2 : Val)
        {if val1.is_a?(NumV) && val2.is_a?(NumV)
            val1 = val1.as(NumV)
            val2 = val2.as(NumV)
            return BoolV.new(val1.n <= val2.n).as Val
        else 
            raise VVQSError.new("Cannot compare non-numbers.")
        end})

        # equal?
        prim_eq = PrimV.new(:"equal?" , ->(val1 : Val, val2 : Val)
        {if val1.is_a?(NumV) && val2.is_a?(NumV)
            val1 = val1.as(NumV)
            val2 = val2.as(NumV) 
            return BoolV.new(val1.n == val2.n).as Val
        elsif val1.is_a?(StrV) && val2.is_a?(StrV)
            val1 = val1.as(StrV)
            val2 = val2.as(StrV)
            return BoolV.new(val1.str == val2.str)
        else
            raise VVQSError.new("Ucomparable values.")
        end})

        # create top-level environment
        @bindings[:+] = prim_add
        @bindings[:-] = prim_sub
        @bindings[:*] = prim_mult
        @bindings[:/] = prim_div
        @bindings[:<=] = prim_lte
        @bindings[:equal?] = prim_eq
    end

    def add_binding(sym, val)
        @bindings[sym] = val
    end

    def get_binding(sym)
        return @bindings[sym]?
    end
end