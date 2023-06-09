require "./ExprC.cr"

class Parser

    def parse(expr)

        if(expr.is_a? Number)
            return NumC(expr)
        elsif(expr.is_a? String)
            return StrC expr
        elsif(expr.is_a? Symbol)
            return IdC expr
        end
        
        if not(expr.is_a? Array)
            raise VVQSError.new("Expr is not a primitive and not a array")
        if(expr[1] == "=>" &&
            expr[0].is_a?(Array))
            return LamC(expr[0], parse(expr[2]))
        elsif(expr[1] == "if" && expr[3] == "else")
            return IfC(parse(expr[0]), parse(expr[2]), parse(expr[4]))
        # elsif(expr[1] == "where" && expr[2].is_a?(Array))

        #     argument = []


        #     return AppC()
        else
            raise VVQSError.new("Syntax doesn't match any known forms")
        end
end

