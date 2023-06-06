require "./spec_helper"

describe "Interpretor::Object" do
    pending "is created" do
        interp_obj = create_test_object()
        interp_obj.should_not be_nil
    end
end

describe "NumC::Object" do
    it "is created" do
        numC = create_test_numc(1)
        numC.num == 1
    end
end