require 'rails_helper'
require 'pubdraft'

class CreateTestData < ActiveRecord::Migration
  unless data_source_exists?('default_things')
    create_table :default_things do |t|
      t.string :state
    end
  end

  unless data_source_exists?('custom_things')
    create_table :custom_things do |t|
      t.string :publication_status
    end
  end
end

class DefaultThing < ActiveRecord::Base
  pubdraft
end

class CustomThing < ActiveRecord::Base
  pubdraft states: { drafted: :draft, in_review: :mark_for_review }, field: :publication_status, default: :in_review
end


describe Pubdraft do
  context 'defaults' do
    let(:klass) { DefaultThing }

    it "defaults to published state" do
      obj = klass.create!

      expect(obj).to be_published
    end

    it "changes states" do
      obj = klass.create!

      obj.draft!
      expect(obj).to be_drafted

      obj.publish!
      expect(obj).to be_published
    end

    it "has scopes" do
      published = klass.create!
      drafted   = klass.create!(:state => 'drafted')

      expect(klass.published).to match_array([published])
      expect(klass.drafted).to match_array([drafted])
    end
  end

  context 'customized' do
    let(:klass) { CustomThing }

    it "can retrieve its custom states later" do
      expect(klass.pubdraft_states).to_not be_empty
    end

    it "defaults to in review state" do
      obj = klass.create!

      expect(obj).to be_in_review
    end

    it "changes states" do
      obj = klass.create!

      obj.draft!
      expect(obj.publication_status).to eq('drafted')
      expect(obj.reload).to be_drafted

      obj.mark_for_review!
      expect(obj.publication_status).to eq('in_review')
      expect(obj.reload).to be_in_review
    end

    it "has scopes" do
      in_review = klass.create!
      drafted   = klass.create!(:publication_status => 'drafted')

      expect(klass.in_review).to match_array([in_review])
      expect(klass.drafted).to match_array([drafted])
    end
  end
end
