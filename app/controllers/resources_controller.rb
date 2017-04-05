class ResourcesController < ApplicationController
  # class method used by child controllers to set the model the controller
  # interacts with.
  def self.resource_model klass
    @model = klass
  end

  # default index action.
  def index
    @resources = resource_query.index params[:page], sort_params
    instance_variable_set :"@#{resource_name.pluralize}", @resources
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
    # authorize the user if a policy exists
    authorize @resource if Pundit.policy(current_user, @resource)
    alias_resource_var
  end
  alias :show :set_resource
  alias :edit :set_resource
  private :set_resource

  # new_resource calls the new action on the resource_class and passes attrs to
  # that method
  #
  # @resource will also be assigned to the resource name ex: @resource => @user
  #
  # this method is aliased as the default action for show and edit. since we
  # dont want the method called directly it is set to private once we alias it
  # as public
  def new_resource attrs={}
    @resource = resource_class.new attrs
    alias_resource_var
  end
  alias :new :new_resource
  private :new_resource

  # default create action
  def create
    new_resource resource_params
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
      if @resource.update(resource_params)
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

  def resource_query
    @resource_query ||= Rails.const_get "#{params[:controller].camelize}Query"
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

  def sort_params
    params.fetch(:sort, {}).permit(*resource_class.column_names).to_h
  end
end
