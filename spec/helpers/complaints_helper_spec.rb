require 'spec_helper'

describe ComplaintsHelper do
  describe "errors" do
    it "should responde error chain" do
      field = :title
      errors = { field => [ "title is blank", "title too long" ] }
      complaint = double( :complaint, :errors => errors)

      expect( display_status_for(complaint, field) )
        .to eq( errors[field].join(" ").strip )
    end
  end

  describe "no errors" do
    it "should responde emtpy string" do
      complaint = double( :complaint, :errors => {})

      expect( display_status_for(complaint, :body ) )
        .to eq("")
    end
  end

end
