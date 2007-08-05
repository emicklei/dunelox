require 'template_processor'
require 'flex_form_helper'

module Flexolop
# Class FlexViewGenerator is 
#
# * view :model
# * form :model
# * window :model
# * grid :model
#
class FlexViewGenerator < TemplateProcessor
  @@hidden_fields = [ 'id' , 'created_at', 'updated_at' , 'lock_version' ]
  
  def is_hidden?(field)
    @@hidden_fields.include?(field) || field =~ /_id$/
  end

  # generates a read-only view
  def view(model_name,options)
    self.setup_for_model(model_name)
    self.form(model_name) unless options[:form] == false
    self.testform(model_name) unless options[:test] == false
    self.window(model_name) unless options[:window] == false
    self.grid(model_name) unless options[:grid] == false
    #self.testgrid(model_name) unless options[:test] == false
    #self.grideditor(model_name) unless options[:test] == false
    self.basictasks unless options[:basictasks] == false    
    
    # TODO make separate DSL function
    self.necod unless options[:necod] == false
  end  
  
  def necod
    log "#{@tmap['model']} crud usecase"  
    
    @tmap['package'] = @package_root + '.usecases'
    self.generate("NewEditCopyDestroy#{@tmap['class']}.as", 'necod', @tmap)
  end
  
  def basictasks
    log "#{@tmap['model']} basic tasks"  
    
    @tmap['package'] = @package_root + '.views'
    self.generate("#{@tmap['class']}BasicTasks.mxml", 'basictasks', @tmap)
  end
  
  # generates a edit view
  def form(model_name)
    log "#{model_name} form"    
    cls = self.to_class(model_name)    

    @tmap['package'] = @package_root + '.views'
    @tmap['controllerinterface'] = @tmap['class'] + 'Controller' # TODO
    @tmap['formitems'] = self.compose_formitems(model_name.to_s ,cls.columns)
    @tmap['fields2vars'] = self.compose_fields2vars(model_name.to_s,cls.columns)
    @tmap['fieldformatters'] = ''
    @tmap['fieldvalidators'] = ''
    self.generate("#{@tmap['class']}Form.mxml", 'form', @tmap)
  end
  
  def compose_formitems(model, columns)
    buffer = ''
    map ={'model' => model}
    columns.each do |col|
        if (!self.is_hidden?(col.name))
          map['fieldlabel'] = col.name.capitalize
          map['fieldnls'] = col.name.downcase
          map['field']=col.name
          map['maxChars']= (col.limit || 255).to_s
          helper = FlexFormHelper.new(@typemap,model,col)
          map['formitem_field'] = helper.formitem_field
          buffer << self.process_template('formitem' , map)
        end
     end
     buffer
  end
  
  def compose_fields2vars(model_id, columns)
    buffer = ''
    columns.each do |col|
        if (!self.is_hidden?(col.name))
          helper = FlexFormHelper.new(@typemap,model_id,col)
          buffer << "\t\t\t\t"
          buffer << helper.modified_update
        end      
    end
    buffer
  end
  
  def testform(model_name)
    log "#{model_name} form test"
    @tmap['testbaseurl'] = @test_base_url
    self.generate("Test#{@tmap['class']}Form.mxml", 'testform', @tmap)
  end
  
  def testgrid(model_name)
    log "#{model_name} grid test"
    @tmap['models'] = model_name.to_s.pluralize
    @tmap['controller'] = model_name.to_s
    @tmap['testbaseurl'] = @test_base_url
    self.generate("Test#{@tmap['class']}Grid.mxml", 'testgrid', @tmap)
  end
  
  # generates a window for both a read-only view and an edit view
  def window(model_name)
    log "#{model_name} title window"
    
    @tmap['package'] = @package_root + '.views'
    self.generate("#{@tmap['class']}TitleWindow.mxml", 'window', @tmap)
  end  
  
  # generates a grid view that supports paging and global sorting
  def grid(model_name)
    log "#{model_name} grid"  
    cls = self.to_class(model_name)

    @tmap['package'] = @package_root + '.views'
    @tmap['columns'] = self.compose_columns(cls.columns)
    @tmap['models'] = model_name.to_s.pluralize
    @tmap['modeltag'] = model_name.to_s.gsub('_','-')  # tag is used in XML serialized form
    @tmap['controller'] = model_name.to_s
    self.generate("#{@tmap['class']}Grid.mxml", 'grid', @tmap)    
  end
  
  def compose_columns(columns)
    buffer = ''    
    columns.each_with_index do |col,i|
      # no columns for hidden fields
        if (!self.is_hidden?(col.name))
        tag = col.name.gsub(/_/,'-')
        buffer << "\n"
			  buffer << "\t\t\t<mx:DataGridColumn headerText=\"{NLS.text('#{col.name.downcase}','#{col.name}')}\" dataField=\"#{tag}\" />"      
        end  
    end
    buffer
  end
  
  # generates a grid editor that has the basic CRUD functionality
  def grideditor(model_name)
    log "#{model_name} grideditor"
    @tmap['package'] = @package_root + '.views'
    self.generate("#{@tmap['class']}GridEditor.mxml", 'grideditor', @tmap)    
  end
  
end # class

end # module