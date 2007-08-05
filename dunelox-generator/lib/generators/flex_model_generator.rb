require 'template_processor'

module Dunelox

class FlexModelGenerator < TemplateProcessor

  # Data Transfer Object and Model generation
  def model(model_name,options)
    self.setup_for_model(model_name)
        
    cls = self.to_class(model_name)
    
    log "#{model_name} model"
    map ={}
    map['package'] = @package_root + '.models'
    map['class'] = model_name.to_s.camelize
    self.generate("#{map['class']}.as", 'model', map)
    
    log "#{model_name} record"
    map['class'] = model_name.to_s.camelize + 'Record'
    map['model'] = model_name.to_s
    map['attributes'] = self.compose_attributes(cls.columns)
    map['functions'] = ''
    map['data2vars'] = self.compose_data2vars(cls.columns)
    map['vars2data'] = self.compose_vars2data(cls.columns)
    map['tostring'] = self.compose_tostring(cls.columns)
    self.generate("#{map['class']}.as", 'record', map)
  end
  
  def compose_attributes(columns)
    buffer = ''
    columns.each do |col|
      buffer << "\t\tpublic var #{col.name}:#{self.flex_type_from(col.type)} = #{self.flex_default_from(col.type)};\n"
    end
    buffer
  end
  
  def compose_data2vars(columns)
    buffer = ''
    columns.each do |col|
      buffer << "\t\t\t\tthis.#{col.name} = "
      tag = col.name.gsub(/_/,'-')
      if [:string,:text].include?(col.type)
        buffer << "data['#{tag}'];\n"
      else
        buffer << "XMLHelper.stringTo#{self.flex_type_from(col.type)}(data['#{tag}']);\n"
      end
    end
    buffer
  end
  
    def compose_vars2data(columns)
    buffer = ''
    columns.each do |col|
      buffer << "\t\t\t\txml.appendChild("
      tag = col.name.gsub(/_/,'-')
      buffer << "<#{tag}>"
        if [:string,:text].include?(col.type)
        buffer << "{this.#{col.name}}"
        else
        buffer << "{XMLHelper.#{self.flex_type_from(col.type).downcase}ToString(this.#{col.name})}"
        end
       buffer << "</#{tag}>)\n"
    end # each
    buffer
   end
  
  def compose_tostring(columns)
    buffer = "\"#{@tmap['class']}["
    columns.each_with_index do |col,index|
      buffer << ' + ",' unless index == 0
      buffer << "#{col.name}=\""
      buffer << " + String(#{col.name})"
    end
    buffer << '+ "]"'   
  end
  
end # class

end # module