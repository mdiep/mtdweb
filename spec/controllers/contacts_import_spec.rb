require File.dirname(__FILE__) + '/../spec_helper'
require 'FasterCSV'
describe ContactsImportController do


  it "parse a csv file" do
    csv_import("Test")
  end

  def csv_import(filename)
    n = 0
    FasterCSV.foreach('/Users/kmeister/Desktop/mtd-sample.csv', :headers => true) do |row|
      c = Contact.new
      c.first_name = row["First Name"]
      c.last_name  = row["Last Name"]
      if c.save
        n = n + 1
        GC.start if n % 50 == 0
      else
        return false
      end
    end
    puts "total number: " + n.to_s
  end

end