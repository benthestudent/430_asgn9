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
        val = env.get_binding(expr.id)
        # if we can't find it, raise an error
        if (val.nil?)
            raise VVQSError.new("Unbound Identifier")
        else
            return val
        end
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
        case typeof(func)
        when NumV
            # Invalid AppC. Let's bounce
            raise VVQSError.new("Cannot Apply a Number")
        when ErrV
            # raise exception
            raise VVQSError.new("User Error")
        when PrimV
            # apply primitive function
            # interpret parameters
            func = func.as(PrimV)
            params = expr.params.map { |e| interp(e, env).as(Val) }
            # call function with interpreted parameters
            func.func.call(params[0], params[1])
        when CloV
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
    #interp for LamC
    def interp(expr : LamC, env : Environment)
        # make a CloV
        
    end

    #interp for IfC
    def interp(expr : IfC, env : Environment)

    end

end


# Top-interp
