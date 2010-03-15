class ShouldaGirlScaffoldGenerator < Rails::Generator::NamedBase
  def manifest
    unless name
      usage_message
    else
      record do |m|
        m.template "controller.rb.erb",
          "app/controllers/#{File.join(class_path)}/#{plural_name}_controller.rb"
        m.template "controller_test.rb.erb",
          "test/functional/#{File.join(class_path)}/#{plural_name}_controller_test.rb"
        m.template "factory.rb.erb",
          "test/factories/#{singular_name}_factory.rb"
        m.directory "app/views/#{File.join(class_path)}/#{plural_name}"
        %w(index show edit new _fields).each do |v|
          m.template "#{v}.html.haml.erb",
            "app/views/#{File.join(class_path)}/#{plural_name}/#{v}.html.haml"
        end
        m.route_resources plural_name.to_sym
      end
    end
  end


end

class Rails::Generator::Commands::Create
  def index_path
    (class_path + [plural_name, "path"]).join("_")
  end

  def show_path
    (class_path + [singular_name, "path"]).join("_")
  end

end
