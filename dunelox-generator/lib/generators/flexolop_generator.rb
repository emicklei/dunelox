require 'fileutils'

# add current path so relative requires work
$LOAD_PATH << File.expand_path(File.dirname(__FILE__))
require 'flex_model_generator'

require 'flex_view_generator'

module Flexolop
# Class FlexGenerator is a development tool to generate ActionScript class and Flex components 
# using meta information available and provided by the script that invokes the generator
# Database connection is required because it reflects on Rails Controllers
# 
# Author: ernest.micklei@philemonworks.com, 2007
# License: Apache 2.0
# 
class FlexGenerator
  attr_accessor :source, :target , :test_base_url, :package_root
  
  # Data Transfer Object and Model generation
  def model(model_sym,options)
    FlexModelGenerator.new(@source,@target,@package_root || '').model(model_sym,options)
  end
  
  # Form, DetailsView, ListView and Window generation
  def view(model_sym,options)
    FlexViewGenerator.new(@source,@target,(@package_root || '') ,@test_base_url).view(model_sym,options)
  end  
  
end # class

end #module

# DSL globals
@@flexgen = Flexolop::FlexGenerator.new

# DSL functions
def rails_project_root(path)
  @@flexgen.source = path
end

def flex_project_root(path)
  @@flexgen.target = path
end

def flex_package_root(dottedName)
  @@flexgen.package_root = dottedName
end


def flex_model(model_sym,options = {})
  @@flexgen.model(model_sym,options = {})
end

def flex_view(model_sym,options = {})
  @@flexgen.view(model_sym,options = {})
end

def flex_test_url(server_url)
  @@flexgen.test_base_url = server_url
end
