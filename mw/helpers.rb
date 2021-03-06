module Helpers
  #call erb from places that don't have access to Sinatra's top level. 
  def zerb(*args, &block)
    # we need a Sinatra Application instance in order to call 'erb' from within Modules.
    # see 
    @rendering_app ||= Sinatra::Application.new.instance_variable_get :@instance
    @rendering_app.erb(*args, &block)
  end
end

def slugify(str)
  str.to_s.to_slug.normalize.to_s.slice(0,200)
end

def cu_logo
	type = "child"
	type = "store-alt" if is_seller 
	return "<i class='fal fa-#{type}' style='margin-right:10px'></i> "
end