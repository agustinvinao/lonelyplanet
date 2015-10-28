Rake::TestTask.new do |t|
  t.libs.push 'test'
  t.pattern = 'test/**/*_spec.rb'
  t.warning = true
  t.verbose = true
end