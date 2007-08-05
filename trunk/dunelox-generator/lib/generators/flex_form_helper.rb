module Flexolop
  
  class FlexFormHelper
    attr_accessor :formitem_field, :modified_update
    
    #    @typemap[:integer] = 'int'
    #    @typemap[:float] = 'Number'
    #    @typemap[:datetime] = 'Date'
    #    @typemap[:date] = 'Day'
    #    @typemap[:time] = 'Date'
    #    @typemap[:string] = 'String'
    #    @typemap[:text] = 'String'
    #    @typemap[:boolean] = 'Boolean'
    
    def initialize(typemap, model_id,columnspec)
      @typemap = typemap
      @model_id,@column = model_id.to_s, columnspec
      @id = @model_id + '_' + @column.name
      @access = @model_id + '.' + @column.name
      @modified_update = "\n"
      self.send(('init_' + @column.type.to_s).to_sym)
    end
    
    def init_integer
      @formitem_field = "<mx:TextInput id=\"#{@id}\" text=\"{#{@access}}\" />"
      @modified_update = "#{@access}=int(#{@id}.text)\n"
    end
    
    def init_float
      @formitem_field = "<mx:TextInput id=\"#{@id}\" text=\"{#{@access}}\" />"
      @modified_update = "#{@access}=Number(#{@id}.text)\n"
    end
    
    def init_datetime      
      @formitem_field = '<mx:HBox>'
      @formitem_field << "<mx:DateField id=\"#{@id}_date\" change=\"{#{@access} = DateField(event.target).selectedDate}\" selectedDate=\"{#{@access}}\" />"
      @formitem_field << "<xtra:TimeSelector id=\"#{@id}_time\" date=\"{#{@access}}\" />"
      @formitem_field << '</mx:HBox>'
      # @modified_update = "modified.#{@column.name}=#{@id}_date.selectedDate\n"      
      #@modified_update = "modified.#{@column.name}.setHours("
      #@modified_update << "#{@id}_time.hours,"
      #@modified_update << "#{@id}_time.minutes,"
      #@modified_update << "#{@id}_time.seconds)\n"
    end
    
    # maps to Day
    def init_date
      @formitem_field = "<mx:DateField id=\"#{@id}\" change=\"{#{@access}.setDate(DateField(event.target).selectedDate)}\" selectedDate=\"{#{@access}.asDate()}\" />"
      #@modified_update = "modified.#{@column.name}.setDate(#{@id}.selectedDate)\n"
    end    
    
    def init_time
      @formitem_field = "<xtra:TimeSelector id=\"#{@id}\" date=\"{#{@access}}\" />"
      #@modified_update = "modified.#{@column.name}.setHours("
      #@modified_update << "#{@id}.hours,"
      #@modified_update << "#{@id}.minutes,"
      #@modified_update << "#{@id}.seconds)\n"
    end     
    
    def init_string
      @formitem_field = "<mx:TextInput id=\"#{@id}\" text=\"{#{@access}}\" maxChars=\"#{@column.limit || 255}\"/>"
      @modified_update = "#{@access}=String(#{@id}.text)\n"
    end
    
    def init_text
      @formitem_field = "<mx:TextArea id=\"#{@id}\" text=\"{#{@access}}\" maxChars=\"#{@column.limit || 255}\"/>"
      @modified_update = "#{@access}=String(#{@id}.text)\n"
     end     
    
    def init_boolean
      @formitem_field = "<mx:CheckBox id=\"#{@id}\" selected=\"{#{@access}}\"/>"
      @modified_update = "#{@access}=#{@id}.selected\n"
    end    
    
  end
  
end # module