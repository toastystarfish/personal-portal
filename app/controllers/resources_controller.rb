class ResourcesController < ApplicationController
  DEFAULT_ACTIONS = %i[index show new create edit update destroy]
  # class method used by child controllers to set the model the controller
  # interacts with.
  def self.resource_model klass
    @model = klass
    # @scaffold_actions = DEFAULT_ACTIONS
    # define_actions
    # define_helpers
  end

  # def self.resource resource_model, actions: DEFAULT_ACTIONS
  #   @model = resource_model
  #   @scaffold_actions = actions & DEFAULT_ACTIONS
  #   define_actions
  #   define_helpers
  # end
  #
  # def self.define_actions
  #   @scaffold_actions.each do |action|
  #     send("define_#{action}")
  #   end
  # end
  #
  # def self.define_helpers
  #   define_method "set_#{}"
  # end
  #
  # def self.define_index
  #   define_method(:index) do
  #     instance_exec do
  #       authorize(self.class.resource_model_class)
  #       send("set_#{self.class.plural_resource_name}")
  #     end
  #   end
  # end
  #
  # def self.plural_resource_name
  #
  # end
  # default index action.
  def index
    authorize(resource_class)

    call_set_resources_method
  end

  # set_resource sets the @resource variable to the instance of resource_class
  # with id: params[:id].
  #
  # @resource will also be assigned to the resource name ex: @resource => @user
  #
  # this method is aliased as the default action for show and edit. since we
  # dont want the method called directly it is set to private once we alias it
  # as public
  def set_resource
    @resource = resource_query.send :find, params[:id]

    alias_resource_var
  end

  def set_resources
    @resources = resource_query.index params[:page], sort_params

    alias_plural_resource_var
  end

  def show
    call_set_resource_method
    authorize @resource if Pundit.policy(current_user, @resource)
  end

  def new
    new_resource(permitted_attributes(resource_class))

  end

  def edit
    call_set_resource_method
    authorize @resource if Pundit.policy(current_user, @resource)
  end

  def new_resource attrs={}
    @resource = resource_class.new attrs
    alias_resource_var
  end
  # alias :new :new_resource
  # private :new_resource

  # default create action
  def create
    new_resource(permitted_attributes(resource_class))
    respond_to do |format|
      if @resource.save
        success_str = "#{resource_class.name.humanize} was successfully created."
        format.html { redirect_to @resource, flash: { success: success_str }}
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  # default update action
  def update
    set_resource
    respond_to do |format|
      if @resource.update(permitted_attributes(@resource))
        success_str = "#{resource_class.name.humanize} was successfully updated."
        format.html { redirect_to @resource, flash: { success: success_str }}
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  # default destroy action
  # success redirects to index
  def destroy
    set_resource
    @resource.destroy
    respond_to do |format|
      success_str = "#{resource_class.name.humanize} was successfully destroyed."
      format.html { redirect_to url_for(action: :index), flash: { success: success_str }}
      format.js
    end
  end

  protected
  # 
  # def set_resource_method_name
  #   "set_#{resource_name}"
  # end
  #
  # def set_resources_method_name
  #   "set_#{resource_name.pluralize}"
  # end

  def call_set_resource_method
    send(set_resource_method_name)
  end

  def call_set_resources_method
    send(set_resources_method_name)
  end

  def resource_query
    resource_query_class.new(policy_scope(@resource_model))
  end

  def resource_query_class
    Rails.const_get("#{resource_name.camelize}Query")
  end

  # returns the class provided to resource_model in the child controllers
  def resource_class
    self.class.instance_variable_get('@model')
  end

  # Just underscores the class name provided by resource_class
  # UserManager => 'user_manager'
  def resource_name
    resource_class.name.underscore
  end

  # calls the params method defined in the child class
  # ex: will call user_params for the users_controller
  def resource_params
    self.send "#{resource_name}_params"
  end

  # copies the value of @resource into the resource_name for this controller
  # ex: @resource => @user_manager
  def alias_resource_var
    instance_variable_set :"@#{resource_name}", @resource
  end

  def alias_plural_resource_var
    instance_variable_set :"@#{resource_name.pluralize}", @resources
  end

  def sort_params
    params.fetch(:sort, {}).permit(*resource_class.column_names).to_h
  end
end
