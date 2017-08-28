class Admin::TagsController < Admin::BaseController
  before_filter :find_tag_and_category, only: [:remove_category, :set_category]
  before_action :set_tag, only: [:edit, :update, :destroy, :find_tag_and_category]

  def new
  end

  def show
  end

  def edit
  end

  def update
    # binding.pry
    if params[:languages].present? || params[:tag].blank?
      update_tag_languages(@tag, params[:languages])
      redirect_to categorization_admin_tags_path(page: params[:page], q: params[:q], uncategorized: params[:uncategorized], no_language: params[:no_language], category_id: params[:category_id], filter_languages: params[:filter_languages]), notice: ("'#{@tag.name}' was updated.")
    else
      # ToDo change cases into methods "change language"
      if params[:tag].present? && params[:tag][:name].present? && (existing_tag = ActsAsTaggableOn::Tag.where(name: params[:tag][:name]).first)
        existing_tag.merge(@tag)
        redirect_to categorization_admin_tags_path(page: params[:page]), notice: ("'#{@tag.name}' was merged with the tag '#{existing_tag.name}'.")
      elsif @tag.update_attributes(tag_params)
        redirect_to categorization_admin_tags_path(page: params[:page]), notice: ("'#{@tag.name}' was updated.")
      else
        render action: 'edit'
      end
    end
  end

  def destroy
    @tag.destroy
    redirect_to categorization_admin_tags_path, notice: ("'#{@tag.name}' was destroyed.")
  end

  def remove_category
    @tag.categories.delete @category
    redirect_to categorization_admin_tags_path(page: params[:page], q: params[:q], uncategorized: params[:uncategorized]), alert: ("The tag '#{@tag.name}' is deleted from the category '#{@category.name}'.")
  end

  def set_category
    @tag.categories << @category
    redirect_to categorization_admin_tags_path(page: params[:page], q: params[:q], uncategorized: params[:uncategorized]), notice: ("Just added the tag '#{@tag.name}' to the category '#{@category.name}'.")
  end

  def categorization
    @tags_count = ActsAsTaggableOn::Tag.count
    @tags = TagFilter.new(ActsAsTaggableOn::Tag.all, filter_params)
      .filter
      .order('tags.name ASC')
      .page(params[:page])
      .per(20)
    @categories = Category.all
  end

  private

  def find_tag_and_category
    set_tag
    @category = Category.find(params[:category_id])
  end

  def set_tag
    @tag      = ActsAsTaggableOn::Tag.find(params[:id])
  end

  def update_tag_languages(tag, languages)
    # probably this is easier to accomplish, refactoring? -> also put in model
    tag.tag_languages.each(&:destroy)
    if languages.present?
      languages.each { |l| tag.tag_languages.create!(language: l) }
    end
  end

  def filter_params
     @filter_params = {
      category_id: params[:category_id],
      q: params[:q],
      uncategorized: params[:uncategorized],
      filter_languages: params[:filter_languages],
      no_language: params[:no_language],
      page: params[:page]
      }
  end

  def tag_params
    params.require(:tag).permit(
      :id,
      :tag,
      :name,
      :languages,
      tag_languages: [:id, :tag_id, :language, :_destroy])
  end
end
