# LonelyPlanet


###System specifications:

* Ruby Verions 2.2.2
* Bundler version 1.10.6
* OS X Yosemite
* rbenv 0.4.0 

###Development notes: 

All gems has theier version in the Gemfile for an easy implementation in new equipments, for any command descripted in this readme use 'bundle exec' to avoid issues with your local environment, gems installed, or any other possible error. That's the beauty of Bundler. 
The philosophy behind this implementation is to use as much as possible from available solutions and focus on a good, maintable, and clean solution. The XML data is imported to a database, in this case MySql and with the help of ActiveRecord handle the data. This is not a Rails Application, this is a pure Ruby solution that uses some gem as mentioned before.

Not all code testing are finished, we can do something else, some improvement, some fix, some change. But we need to see the purpose of the code testing: expose the programmer skills.

For this code testing, some points to finish are:

* Tasks testing: Tasks importer:destinations and destinations:taxonomy needs testing improvements, all the code used by this tasks has tests but not the task code itself.
* Runner test: test/runners/dump_html_spec.rb mocks methods for the class but is not testing the main method of the class "run", this method call HtmlGenerator. HtmlGenerator has the correspondant tests.
* A good improvement is verify if the final html files are valid using w3c validator for example.

### How to execute the code:
This implementation runs under rake tasks. TO see a list of available tasks:

```
bundle exec rake -T
```
The specific tasks for run the code are:

```
rake importer:all           # Import destination.xml and taxonomy.xml (required: XML_DESTINATIONS=path_to_file, 
                            # XML_TAXONOMY=path_to_file)
rake importer:destinations  # Import destinations.xml (required: XML_DESTINATIONS=path_to_file)
rake importer:taxonomy      # Import taxonomy.xml (required: XML_TAXONOMY=path_to_file)
rake runner:all             # Import XML and create HTML files (XML_DESTINATIONS=path_to_file, XML_TAXONOMY=path_to_file,
                            # OUTPUT_PATH=path_to_folder)
rake runner:html            # Run generator (required: OUTPUT_PATH=path)
rake test                   # Run tests
```

All tasks uses system variables, you set any variable before run the task or in the run command directly.

The simplest way to run the application is with:

1. copy config/database.yml.example to config/database.yml
2. setup database.yml configuration values (user, password)
3. bundle exec rake db:create
4. bundle exec rake db:setup
5. bundle exec rake runner:all


IMPORTANT: You need to set XML_DESTINATIONS and XML_TAXONOMY, if you don't have those variables you'll see an error about that problem.

###How is the corde organized:

```
lonelyplanet
	app
		db
			migrate
		exceptions
		generators
		lib
			tasks
		models
		runners
		services
		templates
			css
			html
		test
			benhmarks
			exceptions
			generators
			models
			output
			runners
			services
			tasks
			xml
		xml
```
Folders description:

* app: all the code for the application.
* db: as part of the ActiveRecord gem uses a folder to handle all about db.
* exceptions: exceptions defined for the application.
* generators: clases to generate the final html files or any other generator created for this purpose.
* lib/tasks: part of rake tasks implementation.
* models: models used for the application.
* runners: clases to run the code.
* services: modules used in tasks to parse XML content or checks.
* templates: css and html files used to create the final conetnt.
* test: all tests of the application
* xml: xml files provided for the code test.

### Author:
* Agustin Viñao http://agustinvinao.com
* Mail: agustinvinao@gmail.com
* Github: http://github.com/agustinvinao
* Skype: agustinvinao


