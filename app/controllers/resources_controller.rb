# When inheriting from this class your child class will inherit behavior like
# this:
# @example PostsController
# class PostsController
#   before_action :set_posts, only: :index
#   before_action :set_post, only: %i[show edit update destroy]
#
#   def index
#     authorize(Post)
#   end
#
#   def show
#     authorize(@post)
#   end
#
#   def new
#     @post = Post.new
#     authorize(@post)
#   end
#
#   def create
#     @post = Post.new(permitted_attributes(Post))
#     authorize(@post)
#
#     respond_to do |format|
#       if @post.save
#         success_str = "Post was successfully created."
#         format.html { redirect_to @post, flash: { success: success_str }}
#         format.js
#       else
#         format.html { render :new }
#         format.js
#       end
#     end
#   end
#
#   def edit
#     authorize(@post)
#   end
#
#   # default update action
#   def update
#     authorize(@post)
#     respond_to do |format|
#       if @post.update(permitted_attributes(@post))
#         success_str = "Post was successfully updated."
#         format.html { redirect_to resource, flash: { success: success_str }}
#         format.js
#       else
#         format.html { render :edit }
#         format.js
#       end
#     end
#   end
#
#   # default destroy action
#   # success redirects to index
#   def destroy
#     authorize(@post)
#     resource.destroy
#     respond_to do |format|
#       success_str = "Post was successfully destroyed."
#       format.html { redirect_to url_for(action: :index), flash: { success: success_str }}
#       format.js
#     end
#   end
#
#   private
#
#   def set_posts
#     @posts = resource_query.index(params[:page], sort_params)
#   end
#
#   def set_post
#     @post = resource_query.find(params[:id])
#   end
#
#   def resource_query
#     PostsQuery.new(scope: policy_scope(resource_class))
#   end
# end

class ResourcesController < ApplicationController
  def self.resource_model klass
    @model = klass

    define_resource_helper
    define_resources_helper
  end

  def self.define_resource_helper
    define_method "set_#{resource_name}" do
      instance_exec { self.resource = resource_query.find(params[:id]) }
    end

    private :"set_#{resource_name}"
    before_action(:"set_#{resource_name}", only: %i[show edit update destroy])
  end

  def self.define_resources_helper
    define_method "set_#{resource_name.pluralize}" do
      instance_exec do
        self.resources = resource_query.index(params[:page], sort_params)
      end
    end

    private :"set_#{resource_name.pluralize}"
    before_action(:"set_#{resource_name.pluralize}", only: %i[index])
  end

  # default index action.
  def index
    authorize(resource_class)
  end

  def show
    authorize(resource)
  end

  def new
    self.resource = resource_class.new
    authorize(resource)
  end

  def create
    self.resource = resource_class.new(permitted_attributes(resource_class))
    authorize(resource)

    respond_to do |format|
      if resource.save
        success_str = "#{resource_class.name.humanize} was successfully created."
        format.html { redirect_to resource, flash: { success: success_str }}
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  def edit
    authorize(resource)
  end

  # default update action
  def update
    authorize(resource)
    respond_to do |format|
      if resource.update(permitted_attributes(resource))
        success_str = "#{resource_class.name.humanize} was successfully updated."
        format.html { redirect_to resource, flash: { success: success_str }}
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
    authorize(resource)
    resource.destroy
    respond_to do |format|
      success_str = "#{resource_class.name.humanize} was successfully destroyed."
      format.html { redirect_to url_for(action: :index), flash: { success: success_str }}
      format.js
    end
  end

  protected

  def self.resource_query_class
    Rails.const_get("#{resource_name.pluralize.camelize}Query")
  end

  def self.resource_class
    @model
  end

  def self.resource_name
    resource_class.name.underscore
  end

  def resource_query_class
    self.class.resource_query_class
  end

  def resource_query
    resource_query_class.new(scope: policy_scope(resource_class))
  end

  # returns the class provided to resource_model in the child controllers
  def resource_class
    self.class.resource_class
  end

  # Just underscores the class name provided by resource_class
  # UserManager => 'user_manager'
  def resource_name
    self.class.resource_name
  end

  # calls the params method defined in the child class
  # ex: will call user_params for the users_controller
  def resource_params
    self.send "#{resource_name}_params"
  end

  def resources
    get_ivar(resource_name.pluralize)
  end

  def resources=(value)
    set_ivar(resource_name.pluralize, value)
  end

  def resource
    get_ivar(resource_name)
  end

  def resource=(value)
    set_ivar(resource_name, value)
  end

  def set_ivar(name, value)
    instance_variable_set(:"@#{name}", value)
  end

  def get_ivar(name)
    instance_variable_get(:"@#{name}")
  end

  def sort_params
    params.fetch(:sort, {}).permit(*resource_class.column_names).to_h
  end
end
