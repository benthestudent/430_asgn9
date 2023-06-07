require "./spec_helper"

interp_obj = create_test_object()
expr = IdC.new :z
env = create_test_env()
interp_obj.interp(expr, env)
