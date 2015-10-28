require 'test_helper'

describe "App::ImporterTasksTest" do
  before do
    ENV['XML_DESTINATIONS'] = File.join(App.root, "/test/xml/destinations.xml")
    load File.join(App.root, "/lib/tasks/importer.rake")
  end
  let :run_taxonomy_task do
    Rake::Task["importer:taxonomy"].reenable
    Rake.application.invoke_task "importer:taxonomy"
  end
  let :run_destinations_task do
    Rake::Task["importer:destinations"].reenable
    Rake.application.invoke_task "importer:destinations"
  end
  let :run_all_task do
    Rake::Task["importer:all"].reenable
    Rake.application.invoke_task "importer:all"
  end
  it "creates all destinations" do
    Rake::Task["importer:destinations"].reenable
    Rake::Task["importer:destinations"].invoke
    Destination.count.must_be :==, 1
  end
end