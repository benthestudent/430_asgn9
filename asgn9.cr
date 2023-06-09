require "./ExprC.cr"
require "./Environment"

class VVQSError < Exception
end

class Interpretor

    # the interp functions take an ExprC and return a Val

    # we will use overloading instead of match patterns, so that
    # Crystal will do the work of switching for us.

    # generic method that routes to proper type of ExprC
    def interp(expr : ExprC, env : Environment)
        if(expr.is_a?(IdC))
            return interp(expr.as(IdC), env)
        elsif(expr.is_a?(AppC))
            return interp(expr.as(AppC), env)
        elsif(expr.is_a?(LamC))
            return interp(expr.as(LamC), env)
        elsif(expr.is_a?(NumC))
            return interp(expr.as(NumC), env)
        elsif(expr.is_a?(StrC))
            return interp(expr.as(StrC), env)
        elsif(expr.is_a?(IfC))
            return interp(expr.as(IfC), env)
        end
    end


    #interp for NumC, return a NumV with the same number as the NumC
    def interp(expr : NumC, env : Environment)
        num = NumV.new expr.num
        num
    end

    #interp for IdC
    def interp(expr : IdC, env : Environment)
        # look for identifier in environment
        puts "here"
        val = env.get_binding(expr.id)
        if val
            return val
        end
        raise VVQSError.new("Unbound Identifier")

    end

    #interp for StrC and return a StrV with the same string value as the StrC
    def interp(expr : StrC, env : Environment)
        str = StrV.new expr.str
        str
    end

    #interp for AppC
    def interp(expr : AppC, env : Environment)
        # Remember an AppC contains func (ExprC) and params (Array(ExprC))
        func = interp(expr.func, env)
        case func.class
            when NumV.class
                # Invalid AppC. Let's bounce
                raise VVQSError.new("Cannot Apply a Number")
            when ErrV.class
                # raise exception
                raise VVQSError.new("User Error")
            when PrimV.class
                # apply primitive function
                # interpret parameters
                func = func.as(PrimV)
                params = expr.params.map { |e| interp(e, env).as(Val) }
                # call function with interpreted parameters
                func.func.call(params[0], params[1])
            when CloV.class
                # Remeber a CloV has args (Array(Symbol)), body (ExprC), and an env
                func = func.as(CloV)
                # check to make sure number of arguments match
                if expr.params.size != func.args.size
                    raise VVQSError.new("Invalid Number of Arguments")
                end
                # loop through args and params, creating new bindings in a copy of func.env
                params = expr.params.map { |e| interp(e, env).as(Val) }
                extended_env = func.env.copy()
                func.args.each.with_index do |val, ind|
                    extended_env.add_binding(val, params[ind])
                end

                # interp func.body with extended env
                interp(func.body, extended_env)
            end
        
    end
    def interp(expr : LamC, env : Environment)
        # A LamC represents a function definition. It does not do anything
        # immediately, so it just gets converted into a CloV with its current environment.
        CloV.new(expr.args, expr.body, env)
    end
    

    #interp for IfC
    def interp(expr : IfC, env : Environment)
        # An IfC is an if conditional. First, it evaluates its condition.
        cond = interp(expr.cond, env)
    
        # If the condition is not a BoolV, it's an error
        unless cond.is_a?(BoolV)
            raise VVQSError.new("If condition must be a boolean")
        end
    
        # Depending on the condition value, it then evaluates either the true branch or the false branch.
        if cond.val
            interp(expr.ifT, env)
        else
            interp(expr.otherwise, env)
        end
    end
    

end



def top_interp(sexp)
    top_env = Environment.new

    top_env.add_binding(:+, PrimV.new(:+) do |a, b|
        raise "Expected numbers" unless a.is_a?(NumV) && b.is_a?(NumV)
        NumV.new(a.as(NumV).n + b.as(NumV).n) 
    end)

    top_env.add_binding(:-, PrimV.new(:-) do |a , b |
        raise "Expected numbers" unless a.is_a?(NumV) && b.is_a?(NumV)
        NumV.new(a.as(NumV).n - b.as(NumV).n) 
    end)

    top_env.add_binding(:*, PrimV.new(:*) do |a , b |
        raise "Expected numbers" unless a.is_a?(NumV) && b.is_a?(NumV)
        NumV.new(a.as(NumV).n * b.as(NumV).n) 
    end)

    top_env.add_binding(:/, PrimV.new(:/) do |a , b |
        raise "Expected numbers" unless a.is_a?(NumV) && b.is_a?(NumV)
        raise "Divide by zero" if b.as(NumV).n == 0.0
        NumV.new(a.as(NumV).n / b.as(NumV).n) 
    end)

    top_env.add_binding(:<=, PrimV.new(:<=) do |a , b |
        raise "Expected numbers" unless a.is_a?(NumV) && b.is_a?(NumV)
        BoolV.new(a.as(NumV).n <= b.as(NumV).n) 
    end)

    #top_env.add_binding(:'equal?', PrimV.new(:'equal?') do |a , b |
    #    BoolV.new(false) if a.class != b.class || a.is_a?(PrimV) || a.is_a?(CloV)
    #    BoolV.new(a == b)
    #end)

    #top_env.add_binding(:'error', PrimV.new(:'error') do |v |
    #    raise "User-error: #{v.serialize}"
    #end)

    #top_env.add_binding(:'true', BoolV.new(true))
    #top_env.add_binding(:'false', BoolV.new(false))

    # Parse the S-expression into an ExprC
    expr = parse(sexp)
    # Interpret the ExprC
    val = interp(expr, top_env)
    # Serialize the result
    val.serialize
end
