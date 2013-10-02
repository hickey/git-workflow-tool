


module GWT
  module Error
    
    module_function
    def die(message, code=nil)
      puts message.color(:red)
      if not code.nil?
        exit(code)
      end
    end
  end
end
