require 'test_helper'

describe "App::RunnerTasksTest" do
  before do
    load File.join(App.root, "/lib/tasks/importer.rake")
    load File.join(App.root, "/lib/tasks/runner.rake")
    ENV['XML_DESTINATIONS'] = File.join(App.root, "/test/xml/destinations.xml")
    ENV['XML_TAXONOMY'] = File.join(App.root, "/test/xml/taxonomy.xml")
    ENV['OVERVIEW'] = 'true'
    ENV['OUTPUT_PATH'] = File.join(App.root, "../../output")
    Rake::Task['runner:all'].invoke
  end
  it "true" do
    assert true
  end
end