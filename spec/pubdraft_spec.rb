require 'spec_no_rails_helper'
require 'pubdraft'

class CreateTestData < ActiveRecord::Migration
  unless table_exists?('fake_things')
    create_table :fake_things do |t|
      t.string :state
    end
  end
end

class FakeThing < ActiveRecord::Base
  pubdraft
end

describe Pubdraft do
  before { @class = FakeThing }

  it "defaults to published state" do
    obj = @class.create!

    obj.should be_published
  end

  it "changes states" do
    obj = @class.create!

    obj.draft!
    obj.should be_drafted

    obj.publish!
    obj.should be_published
  end

  it "has scopes" do
    published = @class.create!
    drafted   = @class.create!(:state => 'drafted')

    @class.published.should == [published]
    @class.drafted.should   == [drafted]
  end
end
