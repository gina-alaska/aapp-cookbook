task default: :accept

desc 'Run all acceptance tests'
task accept: [:lint, :unit]

desc 'Run all lint tests'
task lint: [:foodcritic, :rubocop]

desc 'Run linting tools -- foodcritic and rubocop'
task :foodcritic do
  sh 'foodcritic -X spec .'
end

task :rubocop do
  sh 'rubocop'
end

desc 'Run unit tests with ChefSpec'
task :unit do
  sh 'chef exec rspec --color -fd'
end

desc 'Run functional tests with Serverspec'
task :functional do
  sh 'kitchen test'
end
