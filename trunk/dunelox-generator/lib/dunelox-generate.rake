require 'dunelox-generator'

namespace :dunelox do

desc "Generates ActionScript classes and Flex MXML Components for models and views by reflecting on activerecords"
task :generate  => :environment do 
  require 'application' # ApplicationController , the superclass of all controllers in my app  
  
  rails_project_root File.expand_path(__FILE__+'/../..') # tell the generator where it can find the root of this Rails project
  flex_project_root File.expand_path(__FILE__+'/../../../../yourproject-flex')
  flex_package_root 'your.package'  

  flex_test_url 'http://localhost:3000'
    
  # generates a model and record class in Flex that represents a ActiveRecord model 
  #
  flex_model :domain_model
  
  # generates a view, form, window and grid in Flex and simple test applications for these views 
  #
  flex_view :domain_model , :test => false

end # flex

end # namespace pocogese